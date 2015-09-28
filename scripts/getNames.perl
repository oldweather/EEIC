#!/usr/bin/perl

# Extract all the ship names from the digitised obs files
#   and make a first guess at a 9-character version of the name.

use strict;
use warnings;

my %Names;
while ( my $Line = <> ) {
    my $Long_name = substr( $Line, 0, 24 );
    unless ( $Long_name =~ /(\w.*)/ ) { next; }
    if ( exists( $Names{$Long_name} ) ) { next; }
    my $Short_name = substr( $1, 0, 9 );
    $Names{$Long_name} = $Short_name;
}

foreach my $Name ( sort sort_no_blanks ( keys(%Names) ) ) {
    printf "'%24s' => '%9s',\n", $Name, $Names{$Name};
}

sub sort_no_blanks {
    $a =~ /(\w.*)/; my $a2 = $1;
    $b =~ /(\w.*)/; my $b2 = $1;
    return $a2 cmp $b2;
}
