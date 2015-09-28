#!/usr/bin/perl

# Make Pseudo-obs output from a GCM run

use strict;
use warnings;
use IMMA;
use PP;
use FindBin;

# Simple optimisation
my $FirstYear;
my $LastYear;

# Find dates and positions for all AT observations
my %Obs;
foreach (@ARGV) {
    open( DIN, $_ ) or die "Can't open $_;";
    while ( my $Ob = imma_read( \*DIN ) ) {
        if (   defined( $Ob->{LAT} )
            && defined( $Ob->{LON} )
            && defined( $Ob->{YR} )
            && defined( $Ob->{MO} )
            && defined( $Ob->{AT} ) )
        {
            push @{ $Obs{ sprintf "%04d/%02d", $Ob->{YR}, $Ob->{MO} } },
              sprintf "%5.1f %6.1f", $Ob->{LAT}, $Ob->{LON};
            if ( !defined($FirstYear) || $Ob->{YR} < $FirstYear ) {
                $FirstYear = $Ob->{YR};
            }
            if ( !defined($LastYear) || $Ob->{YR} > $LastYear ) {
                $LastYear = $Ob->{YR};
            }
        }
    }
    close(DIN);
}

# Extract equivalent anomalies from the GCM dataset
my %Pseudo_obs;
my $Maxlen=0;
#open( DIN,
#    "/home/h03/hadpb/tasks/soap/simons_runs/variables/air_temperature/all/monthly/anomaly.pp"
#) or die "Can't get GCM data";
open( DIN,
    "/data/local/hadpb/soap_runs/all/airtemp/anomaly.pp"
) or die "Can't get GCM data";
while ( my $pp = pp_read( \*DIN ) ) {
    if ( $pp->{lbyr} < $FirstYear ) { next; }
    if ( $pp->{lbyr} > $LastYear )  { last; }
    my $Dstring = sprintf "%04d/%02d", $pp->{lbyr}, $pp->{lbmon};
    unless ( defined( $Obs{$Dstring}[0] ) ) { next; }
    foreach my $Ll ( @{ $Obs{$Dstring} } ) {
        push @{ $Pseudo_obs{$Dstring} }, get_pseudo( $Ll, $pp );
    }
    if ( scalar( @{ $Pseudo_obs{$Dstring} } ) > $Maxlen ) {
        $Maxlen = scalar( @{ $Pseudo_obs{$Dstring} } );
    }
}

# Print out the  pseudo-obs
my $Lastblank = 0;
for ( my $Year = $FirstYear ; $Year <= $LastYear ; $Year++ ) {
    for ( my $Month = 1 ; $Month <= 12 ; $Month++ ) {
        my $Dstring = sprintf "%04d/%02d", $Year, $Month;
        unless ( defined( $Pseudo_obs{$Dstring}[0] ) ) {
            unless ( $Lastblank == 1 ) { print "\n"; }
            $Lastblank = 1; # Only one blank line for consecutive missing months
            next;
        }
        print "$Dstring";
        for ( my $i = 0 ; $i < $Maxlen ; $i++ ) {
            if ( defined( $Pseudo_obs{$Dstring}[$i] ) ) {
                printf " %5.1f", $Pseudo_obs{$Dstring}[$i];
            }
            else {
                print "    NA";
            }
        }
        print "\n";
        $Lastblank = 0;
    }
}

# Get the grid-box value containing the ob position
sub get_pseudo {
    my $Llstring = shift;
    my $pp       = shift;
    $Llstring =~ /(\S+)\s+(\S+)/ or die "Bad Llstring $Llstring";
    my $Lat = $1;
    my $Lat_i = int( ( ( $Lat - $pp->{bzy} ) / $pp->{bdy} ) - 0.5 );
    if ( $Lat_i < 0 || $Lat_i > $pp->{lbrow} - 1 ) {
        warn "Bad Latitude $Lat $Lat_i $pp->{bzy} $pp->{bdy}";
        return;
    }
    my $Lon = $2;
    my $Lon_i = int( ( ( $Lon - $pp->{bzx} ) / $pp->{bdx} ) - 0.5 );
    if ( $Lon_i < 0 ) { $Lon_i += $pp->{lbnpt}; }
    if ( $Lon_i >= $pp->{lbuser} ) { $Lon_i -= $pp->{lbnpt}; }
    return $pp->{data}->[$Lat_i][$Lon_i];
}
