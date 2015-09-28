#!/usr/bin/perl

# Get the tropical (30S-30N) mean AT from a HadCM3 run.

use strict;
use warnings;
use PP;
use List::Util qw(sum);

my @Years;
my $Filename = "/data/local/hadpb/soap_runs/all/airtemp/anomaly.pp";
open( DIN_N, "$Filename" ) or die "Unable to open normals file $Filename";
while ( my $pp = pp_read( \*DIN_N ) ) {
    if ( $pp->{lbyr} < 1785 ) { next; }
    if ( $pp->{lbyr} > 1835 ) { last; }
    my $W_tot=0;
    my $A_tot=0;
    for ( my $i = 0 ; $i < $pp->{lbrow} ; $i++ ) {
        my $Lat = $pp->{bzy} + ( $i + 1 ) * $pp->{bdy};
        if ( $Lat > 30 || $Lat < -30 ) { next; }
        my $Weight = cos( $Lat * 3.141592 / 180 );
        for ( my $j = 0 ; $j < $pp->{lbnpt} ; $j++ ) {
            if ( $pp->{data}->[$i][$j] == $pp->{bmdi} ) { next; }
            $W_tot += $Weight;
            $A_tot += $pp->{data}->[$i][$j] * $Weight;
        }
    }
    push @{ $Years[ $pp->{lbyr} ] }, $A_tot / $W_tot;

}
close(DIN_N);

for ( my $Year = 1785 ; $Year <= 1835 ; $Year++ ) {

    printf "%04d %g\n", $Year,
      sum( @{ $Years[$Year] } ) / scalar( @{ $Years[$Year] } );
}
