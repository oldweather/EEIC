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
    {
        $Ob->write( \*STDOUT );
    }
}
