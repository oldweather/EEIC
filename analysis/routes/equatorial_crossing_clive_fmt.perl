#!/usr/bin/perl 

# Find date and longitude of Northward equatorial crossings
#  in the Indian Ocean

use strict;
use IMMA;
use Date::Calc qw(Day_of_Year);
use lib "../../scripts/";
use TruncateNames qw(long_from_short formatted_from_long);

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
        && $Ob->{LAT} >= 0
        && $Last_ob->{LAT} < 0 )
    {
        my $Jday = Day_of_Year( $Ob->{YR}, $Ob->{MO}, $Ob->{DY} );
        $Ob->{ID} =~ s/_/ /g;
        my $Fname = formatted_from_long(long_from_short($Ob->{ID}));
        unless(defined($Fname)) { die "No name for $Ob->{ID}"; }
        printf "%-26s, %04d, %2d, %2d, %6.1f, %6.1f, %6.1f, %6.1f\n",
	  $Fname,
          $Ob->{YR}, $Ob->{MO}, $Ob->{DY}, $Ob->{LON}, $Ob->{LAT},
          $Last_ob->{LON}, $Last_ob->{LAT};
    }
    $Last_ob = $Ob;
}
