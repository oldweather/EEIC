#!/usr/bin/perl 

# Find date and longitude of Northward equatorial crossings
#  in the Indian Ocean

use strict;
use IMMA;
use Date::Calc qw(Day_of_Year);

my $Last_ob;
while ( my $Ob = imma_read( \*ARGV ) ) {
    unless ( defined( $Ob->{LAT} )
        && defined( $Ob->{YR} )
        && defined( $Ob->{MO} )
        && defined( $Ob->{DY} )
        && defined( $Ob->{LON} ) )
    {
        next;
    }
    $Ob->{ID} =~ s/\s/_/g;
    if (   defined($Last_ob)
        && $Last_ob->{ID} eq $Ob->{ID}
        && $Ob->{LON} > 30
        && $Ob->{LON} < 100
        && $Ob->{LAT} > 0
        && $Last_ob->{LAT} < 0 )
    {
        my $Jday = Day_of_Year( $Ob->{YR}, $Ob->{MO}, $Ob->{DY} );
        printf "%04d/%02d/%02d %3d %3d %6.1f %9s\n", $Ob->{YR}, $Ob->{MO},
          $Ob->{DY}, $Jday, int( $Ob->{YR} / 10 ), $Ob->{LON}, $Ob->{ID};
    }
    $Last_ob = $Ob;
}
