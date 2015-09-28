#!/usr/bin/perl

# Process the EIC temperature anomalies to make a mean-temperature time-series.

use strict;
use warnings;
use Numeric::median;
use List::Util qw(sum);

my %ByYear;
while (<>) {
    unless ( $_ =~ /^1/ ) { next; }
    my @Fields = split;
    my $Date   = shift(@Fields);
    unless ( $Date =~ /(\d\d\d\d)/ ) { die "Bad date format $Date"; }
    $Date = $1;    # Discard days and months
    foreach (@Fields) {
        if ( $_ =~ /NA/ ) { next; }
        push @{ $ByYear{$Date} }, $_;
    }
}

my $Lastblank = 0;
for ( my $Year = 1750 ; $Year <= 1850 ; $Year++ ) {
    my $Date = sprintf "%04d", $Year;
    unless ( defined( $ByYear{$Date} ) ) {
        unless ( $Lastblank == 1 ) { print "\n"; }
        $Lastblank = 1;    # Only one blank line for consecutive missing months
        next;
    }
    my $Tm  = trimmed_mean( @{ $ByYear{$Date} } );
    my $Wsd = winsorized_sd( @{ $ByYear{$Date} } );
    unless ( defined($Tm) && defined($Wsd) ) {
        unless ( $Lastblank == 1 ) { print "\n"; }
        $Lastblank = 1;    # Only one blank line for consecutive missing months
        next;
    }
    $Wsd = sqrt(($Wsd**2)/(0.36*scalar(@{ $ByYear{$Date} })));
    printf "%4s %5.2f %5.2f %5.2f\n", $Date, $Tm, $Tm - 2 * $Wsd,
      $Tm + 2 * $Wsd;
    $Lastblank = 0;
}

# Robust statistical restimators
sub trimmed_mean {
    my @Data = sort { $a <=> $b } @_;
    if ( scalar(@Data) < 1 ) { return; }
    my $Trim_count = int( scalar(@Data) * .2 );
    my @D2;
    for ( my $i = $Trim_count ; $i < scalar(@Data) - $Trim_count ; $i++ ) {
        push @D2, $Data[$i];
    }
    return sum(@D2) / scalar(@D2);
}

sub winsorized_sd {
    my @Data = sort { $a <=> $b } @_;
    if ( scalar(@Data) < 2 ) { return; }
    my $Trim_count = int( scalar(@Data) * .2 );
    my @D2;
    for ( my $i = 0 ; $i < scalar(@Data) ; $i++ ) {
        if ( $i < $Trim_count ) {
            push @D2, $Data[$Trim_count];
        }
        elsif ( $i > scalar(@Data) - $Trim_count - 1 ) {
            push @D2, $Data[ scalar(@Data) - $Trim_count - 1 ];
        }
        else {
            push @D2, $Data[$i];
        }
    }
    my $Mean = sum(@D2) / scalar(@D2);
    my $sd   = 0;
    foreach (@D2) { $sd += ( $_ - $Mean )**2; }
    return sqrt( $sd / ( scalar(@D2) - 1 ) );
}

