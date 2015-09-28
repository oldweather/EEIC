#!/usr/bin/perl

# Find ships in the south pacific

use strict;
use warnings;
use IMMA;

while ( my $Ob = imma_read( \*ARGV ) ) {
    if (  defined( $Ob->{LAT} )
              && $Ob->{LAT} <0
              && defined( $Ob->{LON} )
              && $Ob->{LON} > 140 )
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
