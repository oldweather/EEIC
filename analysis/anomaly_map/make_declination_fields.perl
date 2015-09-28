#!/usr/bin/perl 

# Make a 2x2 degree Nobs PP field from the EIC data.

use strict;
use IMMA;
use PP;
use List::Util qw(sum);
use lib "../../scripts/declination";
use Declination;

my @Corrections = Declination::Load('../../scripts/declination/declination.pp');

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

my @Obs;

# Read in the IMMA records
while ( my $Ob = imma_read( \*ARGV ) ) {
    unless ( defined( $Ob->{LAT} )
        && defined( $Ob->{LON} )
        && defined( $Ob->{YR} )
        && defined( $Ob->{D} ) )
    {
        next;
    }
    if ( $Ob->{D} < 360 ) {    # Skip calm and variable specials
        my ( $Lat_i, $Lon_i ) = i_from_ll( $Ob->{LAT}, $Ob->{LON}, $pp_grid );
        my $New =
          Declination::magnetic_to_true( $Ob->{D}, $Ob->{LAT}, $Ob->{LON},
            $Ob->{YR}, \@Corrections );
        my $Diff = $New - $Ob->{D};
        if ( abs( $Diff - 360 ) < abs($Diff) ) { $Diff -= 360; }
        if ( abs( $Diff + 360 ) < abs($Diff) ) { $Diff += 360; }
        push @{ $Obs[$Lat_i][$Lon_i] }, $Diff;
    }
}

# Output Declination file
for ( my $i = 0 ; $i < $pp_grid->{lbrow} ; $i++ ) {
    for ( my $j = 0 ; $j < $pp_grid->{lbnpt} ; $j++ ) {
        if ( defined( $Obs[$i][$j][0] ) ) {
            $pp_grid->{data}->[$i][$j] = mean( @{ $Obs[$i][$j] } );
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

