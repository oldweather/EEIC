#!/usr/bin/perl

# Read in a batch of IMMA files, Wherever there is a AT record
#  output year, month, lat and long

use strict;
use warnings;
use IMMA;

while ( my $Ob = imma_read( \*ARGV ) ) {
    if (   defined( $Ob->{YR} )
        && defined( $Ob->{MO} )
        && defined( $Ob->{LAT} )
        && defined( $Ob->{LON} )
        && defined( $Ob->{AT} ) )
    {
        print "$Ob->{YR} $Ob->{MO} $Ob->{LAT} $Ob->{LON}\n";
    }
}
