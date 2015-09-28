#!/usr/bin/perl 

# Make a table of lat long and year_day from the IMMA records

use strict;
use IMMA;
use Date::Calc qw(Day_of_Year);

my @Obs;
while ( my $Ob = imma_read( \*ARGV ) ) {
    unless ( defined( $Ob->{LAT} )
        && defined( $Ob->{YR} )
        && defined( $Ob->{MO} )
        && defined( $Ob->{DY} )
        && defined( $Ob->{LON} ) )
    {
        next;
    }
    my $Jday = Day_of_Year( $Ob->{YR}, $Ob->{MO}, $Ob->{DY} );
    printf "%04d/%02d/%02d %3d %3d %6.1f %5.1f\n", $Ob->{YR}, $Ob->{MO}, $Ob->{DY},
      $Jday, int($Ob->{YR}/10), $Ob->{LON}, $Ob->{LAT};
}
