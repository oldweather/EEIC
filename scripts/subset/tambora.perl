#!/usr/bin/perl

# Find obs dating from the Tambora eruption period

use strict;
use warnings;
use IMMA;

while ( my $Ob = imma_read( \*ARGV ) ) {
    if (   defined( $Ob->{YR} )
        && $Ob->{YR} == 1815
        && defined( $Ob->{MO} )
        && $Ob->{MO} == 4 )

      #        && defined( $Ob->{DY} )
      #        && $Ob->{DY} > 16
      #        && $Ob->{DY} < 29
      #        && defined( $Ob->{LAT} )
      #        && $Ob->{LAT} > -30
      #        && $Ob->{LAT} < -10
      #        && defined( $Ob->{LON} )
      #        && $Ob->{LON} > 40
      #        && $Ob->{LON} < 60 )
    {
        if ( defined( $Ob->{ID} ) ) { printf "%9s", $Ob->{ID}; }
        else                        { print "       NA"; }
        if ( defined( $Ob->{YR} ) ) { printf " %04d", $Ob->{YR}; }
        else                        { print "   NA"; }
        if ( defined( $Ob->{MO} ) ) { printf " %02d", $Ob->{MO}; }
        else                        { print " NA"; }
        if ( defined( $Ob->{DY} ) ) { printf " %02d", $Ob->{DY}; }
        else                        { print " NA"; }
        if ( defined( $Ob->{LAT} ) ) { printf " %6.1f", $Ob->{LAT}; }
        else                         { print "     NA"; }
        if ( defined( $Ob->{LON} ) ) { printf " %6.1f", $Ob->{LON}; }
        else                         { print "     NA"; }
        if ( defined( $Ob->{SLP} ) ) { printf " %5.1f", $Ob->{SLP}; }
        else                         { print "    NA"; }
        if ( defined( $Ob->{W} ) ) { printf " %5.2f", $Ob->{W}; }
        else                       { print "    NA"; }
        print "\n";
    }
}
