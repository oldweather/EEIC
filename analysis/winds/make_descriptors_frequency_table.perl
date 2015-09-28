#!/usr/bin/perl

# Make a frequency list of wind terms

use strict;
use warnings;

my %Counts;
my %Beaufort;
my $Total;
while (<>) {
    my @Fields = split;
    $Beaufort{ $Fields[5] } = $Fields[4]; 
    $Counts{ $Fields[5] }++;
    $Total++;
}

foreach my $Key ( sort { $Counts{$b} <=> $Counts{$a} } keys(%Counts) ) {
#    unless ( $Counts{$Key} >9 ) { next; }
    printf "%20s %6d %6.4f %2s\n", $Key, $Counts{$Key}, $Counts{$Key} / $Total,
      $Beaufort{$Key};
}
