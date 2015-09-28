#!/usr/bin/perl 

# Make a 2x2 degree Nobs PP field from the EIC data.

use strict;
use IMMA;
use PP;

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

my @Counts;

# Read in the IMMA records
while ( my $Ob = imma_read( \*ARGV ) ) {
    if (   defined( $Ob->{YR} )
        && defined( $Ob->{MO} )
        && defined( $Ob->{DY} )
        && defined( $Ob->{LON} )
        && defined( $Ob->{LAT} ))
    {
        my ( $Lat_i, $Lon_i ) = i_from_ll( $Ob->{LAT}, $Ob->{LON}, $pp_grid );
        $Counts[$Lat_i][$Lon_i]++;
    }
}

for ( my $i = 0 ; $i < $pp_grid->{lbrow} ; $i++ ) {
    for ( my $j = 0 ; $j < $pp_grid->{lbnpt} ; $j++ ) {
        if ( defined( $Counts[$i][$j] ) ) {
            $pp_grid->{data}->[$i][$j] = $Counts[$i][$j];
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
    my $Lat_i = int( ( ( $Lat - $pp->{bzy} ) / $pp->{bdy} ) )-1;
    my $DiffL = ( $Lon - $pp->{bzx} );
    if ( $DiffL > 360 ) { $DiffL -= 360; }
    if ( $DiffL < -360 ) { $DiffL += 360; }
    my $Lon_i = int( ( $DiffL / $pp->{bdx} ))-1;
    return ( $Lat_i, $Lon_i );
}

