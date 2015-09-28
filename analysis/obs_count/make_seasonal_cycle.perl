#!/usr/bin/perl

use strict;
use warnings;

my @Seasonal;

# Read in monthly data
while (<>) {
    my @Fields = split;
    $Fields[0] =~ /(\d\d\d\d)\/(\d\d)/;
    my $Decade = int( ( $1 - 1790 ) / 10 );
    my $Month = $2;
    $Seasonal[$Month][$Decade] += $Fields[1];
}

for ( my $i = 1 ; $i <= 12 ; $i++ ) {
    printf "%02d", $i;
    for ( my $j = 0 ; $j < 6 ; $j++ ) {
        printf " %7d", $Seasonal[$i][$j];
    }
    print "\n";
}

