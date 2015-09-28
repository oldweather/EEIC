#!/usr/bin/perl

use strict;
use warnings;
use IMMA;

my %Observations;
my ( $Syear, $Smonth, $Sday );
my ( $Eyear, $Emonth, $Eday );
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
            $Observations{$Name}[ $Ob->{YR} ] = 1;
        }
    }
    close(DIN);
}

# Print out the data for all ships
printf "Year ";
foreach my $Name ( sort by_start_date keys %Observations ) {
    printf " %20s", $Name;
}
print "\n";
my $Year  = $Syear;
my $Month = $Smonth;
my $Day   = $Sday;
foreach my $Year ( 1785 .. 1840 ) {
    printf "%04d ", $Year;
    foreach my $Name ( sort by_start_date keys %Observations ) {
        if ( defined( $Observations{$Name}[$Year] ) ) {
            print "                    1";
        }
        else {
            print "                    0";
        }
    }
    print "\n";
}

# Sort the ships by first year of operation
sub by_start_date {
    for ( my $i = 1785 ; $i <= 1840 ; $i++ ) {
        if ( defined( $Observations{$a}[$i] ) ) {
            if ( defined( $Observations{$b}[$i] ) ) {
                return 0;
            }
            else {
                return -1;
            }
        }
        else {
            if ( defined( $Observations{$b}[$i] ) ) {
                return 1;
            }
        }
    }
    return 0;
}

