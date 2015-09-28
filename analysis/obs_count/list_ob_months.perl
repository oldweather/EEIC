#!/usr/bin/perl

use strict;
use warnings;
use IMMA;

my %Observations;
foreach my $Input (@ARGV) {
    open( DIN, $Input ) or die "Can't open $Input";
    $Input =~ /.*\/([^\.]+)\.(\S+)\.imma/ or die;
    my $Name = $1;
    $Name = join( '_', map( ucfirst, split /_/, $Name ) );
    while ( my $Ob = imma_read( \*DIN ) ) {
        if (   defined( $Ob->{YR} )
            && defined( $Ob->{MO} )
            && defined( $Ob->{DY} )
            && defined( $Ob->{LON} )
            && defined( $Ob->{LAT} ) )
        {
            my $Date = sprintf "%04d/%02d", $Ob->{YR}, $Ob->{MO};
            if ( defined( $Ob->{AT} ) ) {
                $Observations{AT}{$Date} += 1;
            }
            if ( defined( $Ob->{SST} ) ) {
                $Observations{SST}{$Date} += 1;
            }
            if ( defined( $Ob->{SLP} ) ) {
                $Observations{SLP}{$Date} += 1;
            }
        }
    }
    close(DIN);
}

foreach my $Year ( 1785 .. 1840 ) {
    foreach my $Month ( 1 .. 12 ) {
        my $Date = sprintf "%04d/%02d", $Year, $Month;

        print "$Date ";
        foreach my $Var (qw(AT SST SLP)) {
            if ( !defined( $Observations{$Var}{$Date} ) ) {
                $Observations{$Var}{$Date} = 0;
            }
            printf "%6d", $Observations{$Var}{$Date};
        }
        print "\n";
    }
}

