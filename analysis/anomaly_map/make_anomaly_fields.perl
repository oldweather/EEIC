#!/usr/bin/perl 

# Make a 2x2 degree Nobs PP field from the EIC data.

use strict;
use IMMA;
use PP;
use List::Util qw(sum);

# Use the MDS functions to make normals for the data
use lib "../utility_scripts";
use Normals2;
use lib "$ENV{MDS2}/libraries/pentads/source";
use Pentads;

my %Normals;
$Normals{'NAT'} = get_normals('NAT');
$Normals{'SST'} = get_normals('SST');
$Normals{'PRE'} = get_normals('PRE');
$Normals{'WS'}  = get_normals('WS');

# Make the PP field
my $pp_grid = pp_create(
    lbyr   => 1790,
    lbmon  => 1,
    lbdat  => 1,
    lbyrd  => 1835,
    lbmond => 12,
    lbdatd => 31,
    lbnpt  => 180,
    lbrow  => 90,
    lbcode => 2,
    lbrel  => 2,
    lbfc   => 16,
    bgor   => 0,
    bplat  => 90.0,
    bplon  => 0.0,
    lbtim  => 21,
    bzy    => -91,
    bdy    => 2,
    bzx    => -181,
    bdx    => 2,
    bmdi   => -1.0e30,
    lblrec => 180 * 90,
    bmks   => 1,
);

my %Obs;

# Read in the IMMA records
while ( my $Ob = imma_read( \*ARGV ) ) {
    if (   defined( $Ob->{YR} )
        && defined( $Ob->{MO} )
        && defined( $Ob->{DY} )
        && defined( $Ob->{LON} )
        && defined( $Ob->{LAT} ) )
    {
        my ( $Lat_i, $Lon_i ) = i_from_ll( $Ob->{LAT}, $Ob->{LON}, $pp_grid );
        my $Pentad =
          pentad_from_date( sprintf( "%02d/%02d", $Ob->{MO}, $Ob->{DY} ) );
        my $Penday =
          penday_from_date( sprintf( "%02d/%02d", $Ob->{MO}, $Ob->{DY} ) );

        # AT
        my $Nm =
          daily_normal( $Normals{NAT}, $Ob->{LON}, $Ob->{LAT}, $Pentad,
            $Penday );
        if ( defined($Nm) && defined( $Ob->{AT} ) ) {
            push @{ $Obs{NAT}[$Lat_i][$Lon_i] }, $Ob->{AT} - $Nm;
        }
        $Nm =
          daily_normal( $Normals{SST}, $Ob->{LON}, $Ob->{LAT}, $Pentad,
            $Penday );
        if ( defined($Nm) && defined( $Ob->{SST} ) ) {
            push @{ $Obs{SST}[$Lat_i][$Lon_i] }, $Ob->{SST} - $Nm;
        }
        $Nm =
          daily_normal( $Normals{PRE}, $Ob->{LON}, $Ob->{LAT}, $Pentad,
            $Penday );
        if ( defined($Nm) && defined( $Ob->{SLP} ) ) {
            push @{ $Obs{PRE}[$Lat_i][$Lon_i] }, $Ob->{SLP} - $Nm;
        }
        $Nm =
          daily_normal( $Normals{WS}, $Ob->{LON}, $Ob->{LAT}, $Pentad,
            $Penday );
        if ( defined($Nm) && defined( $Ob->{W} ) ) {
            push @{ $Obs{WS}[$Lat_i][$Lon_i] }, $Ob->{W} - $Nm;
        }
    }
}

# Output NAT file
for ( my $i = 0 ; $i < $pp_grid->{lbrow} ; $i++ ) {
    for ( my $j = 0 ; $j < $pp_grid->{lbnpt} ; $j++ ) {
        if ( defined( $Obs{NAT}[$i][$j][0] ) ) {
            $pp_grid->{data}->[$i][$j] = trimmed_mean( @{ $Obs{NAT}[$i][$j] } );
        }
        else {
            $pp_grid->{data}->[$i][$j] = $pp_grid->{bmdi};
        }
    }
}
$pp_grid->write_to_file( \*STDOUT );

# Output SST file
for ( my $i = 0 ; $i < $pp_grid->{lbrow} ; $i++ ) {
    for ( my $j = 0 ; $j < $pp_grid->{lbnpt} ; $j++ ) {
        if ( defined( $Obs{SST}[$i][$j][0] ) ) {
            $pp_grid->{data}->[$i][$j] = trimmed_mean( @{ $Obs{SST}[$i][$j] } );
        }
        else {
            $pp_grid->{data}->[$i][$j] = $pp_grid->{bmdi};
        }
    }
}
$pp_grid->write_to_file( \*STDOUT );

# Output PRE file
for ( my $i = 0 ; $i < $pp_grid->{lbrow} ; $i++ ) {
    for ( my $j = 0 ; $j < $pp_grid->{lbnpt} ; $j++ ) {
        if ( defined( $Obs{PRE}[$i][$j][0] ) ) {
            $pp_grid->{data}->[$i][$j] = mean( @{ $Obs{PRE}[$i][$j] } );
        }
        else {
            $pp_grid->{data}->[$i][$j] = $pp_grid->{bmdi};
        }
    }
}
$pp_grid->write_to_file( \*STDOUT );

# Output WS file
for ( my $i = 0 ; $i < $pp_grid->{lbrow} ; $i++ ) {
    for ( my $j = 0 ; $j < $pp_grid->{lbnpt} ; $j++ ) {
        if ( defined( $Obs{WS}[$i][$j][0] ) ) {
            $pp_grid->{data}->[$i][$j] = trimmed_mean( @{ $Obs{WS}[$i][$j] } );
        }
        else {
            $pp_grid->{data}->[$i][$j] = $pp_grid->{bmdi};
        }
    }
}
$pp_grid->write_to_file( \*STDOUT );

# Gat an index location in the PP grid from a lat/lon pair
sub i_from_ll {
    my ( $Lat, $Lon, $pp ) = @_;
    my $Lat_i = int( ( ( $Lat - $pp->{bzy} ) / $pp->{bdy} ) ) - 1;
    my $DiffL = ( $Lon - $pp->{bzx} );
    if ( $DiffL > 360 ) { $DiffL -= 360; }
    if ( $DiffL < -360 ) { $DiffL += 360; }
    my $Lon_i = int( ( $DiffL / $pp->{bdx} ) ) - 1;
    return ( $Lat_i, $Lon_i );
}

sub mean {
    return sum(@_) / scalar(@_);
}

# Robust statistical estimator
sub trimmed_mean {
    my @Data = sort { $a <=> $b } @_;
    if ( scalar(@Data) < 1 ) { return; }
    my $Trim_count = int( scalar(@Data) * .2 );
    my @D2;
    for ( my $i = $Trim_count ; $i < scalar(@Data) - $Trim_count ; $i++ ) {
        push @D2, $Data[$i];
    }
    return sum(@D2) / scalar(@D2);
}

