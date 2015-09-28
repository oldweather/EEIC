#!/usr/bin/perl

# Calculate the fraction of digitised wind force terms that are translatable

use strict;
use warnings;

my %Counts;
my %Beaufort;
my $Total;
while (<>) {
    my @Fields = split;
    $Counts{ $Fields[4] }++;
    $Total++;
}
my $Fraction=($Total-$Counts{NA})/$Total;

print "$Fraction\n";
