#!/usr/bin/perl

# Find obs that near the Lady Melvile Hurricane

use strict;
use warnings;
use IMMA;

while ( my $Ob = imma_read( \*ARGV ) ) {
    if(defined($Ob->{W}) && $Ob->{W} > 30) {
#    if (   defined( $Ob->{YR} )
#        && $Ob->{YR} == 1827
#        && defined( $Ob->{MO} )
#        && $Ob->{MO} == 4
#        && defined( $Ob->{DY} )
#        && $Ob->{DY} > 16
#        && $Ob->{DY} < 29 
#        && defined( $Ob->{LAT} )
#        && $Ob->{LAT} > -30
#        && $Ob->{LAT} < -10
#        && defined( $Ob->{LON} )
#        && $Ob->{LON} > 40
#        && $Ob->{LON} < 60 )
#    {
        printf "%9s %04d/%02d/%02d %6.1f %6.1f", $Ob->{ID}, $Ob->{YR},
          $Ob->{MO}, $Ob->{DY}, $Ob->{LAT}, $Ob->{LON};
        if ( defined( $Ob->{SLP} ) ) { printf " %5.1f", $Ob->{SLP}; }
        else                         { print "    NA"; }
        if ( defined( $Ob->{W} ) ) { printf " %5.2f", $Ob->{W}; }
        else                       { print "    NA"; }
        print "\n";
    }
}
