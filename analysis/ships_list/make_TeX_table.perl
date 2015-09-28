#!/usr/bin/perl

# make a TeX table listing the ships with their years of operation

use strict;
use warnings;

my %Ships;
my $Line = <>;
my @Names = split( /\s+/, $Line );
shift(@Names);

while (<>) {
    my @Line = split;
    my $Year = shift(@Line);
    for ( my $i = 0 ; $i < scalar(@Line) ; $i++ ) {
        if ( $Line[$i] == 1 ) { push @{ $Ships{ $Names[$i] } }, $Year; }
    }
}

foreach my $Ship ( sort { $Ships{$a}[0] <=> $Ships{$b}[0] } keys(%Ships) ) {
    print "\\hline\n";
    printf "%s &",  fName($Ship);
    printf " %s", list_years($Ship);
    print "\\\\\n";
}

sub fName {
    my $Name = shift;
    $Name =~ s/_/ /g;
    $Name =~ s/(\d+)/\($1\)/;
    return $Name;
}

sub list_years {
    my $Ship  = shift;
    my @Years = @{ $Ships{$Ship} };
    my $Result;
    for ( my $i = 0 ; $i < scalar(@Years) ; $i++ ) {
        $Result .= sprintf "%4d", $Years[$i];
        my $Start = $i;
        while ( defined( $Years[ $i + 1 ] )
            && $Years[ $i + 1 ] == $Years[$i] + 1 )
        {
            $i++;
        }
        if ( $i != $Start ) { $Result .= sprintf "--%04d", $Years[$i]; }
        if ( $i < scalar(@Years) - 1 ) { $Result .= ","; }
    }
    return $Result;
}

