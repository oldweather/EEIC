#!/usr/bin/perl

use strict;
use warnings;
use IMMA;
use Date::Calc qw(Delta_Days Add_Delta_Days);

# Use the MDS functions to make normals for the data
use lib "$ENV{MDS2}/libraries/normals/source";
use Normals;
use lib "$ENV{MDS2}/libraries/pentads/source";
use Pentads;

my $Normal = get_normals('SST');

my %Observations;
my ( $Syear, $Smonth, $Sday );
my ( $Eyear, $Emonth, $Eday );
foreach my $Input (@ARGV) {
    open( DIN, $Input ) or die "Can't open $Input";
    $Input =~ /.*\/([^\.]+)\.(\S+)\.imma/ or die;
    my $Name = $1;
    $Name = join( '_', map( ucfirst, split /_/, $Name ) );
#    $Name .= "." . $2;
    while ( my $Ob = imma_read( \*DIN ) ) {
        if (   defined( $Ob->{YR} )
            && defined( $Ob->{MO} )
            && defined( $Ob->{DY} )
            && defined( $Ob->{LON} )
            && defined( $Ob->{LAT} ) )
        {
            $Observations{$Name}{ sprintf "%04d/%02d/%02d", $Ob->{YR},
                $Ob->{MO}, $Ob->{DY} } = $Ob;
            if (
                !defined($Syear)
                || (   $Syear <=> $Ob->{YR}
                    || $Smonth <=> $Ob->{MO}
                    || $Sday <=> $Ob->{DY} ) > 0
              )
            {
                $Syear  = $Ob->{YR};
                $Smonth = $Ob->{MO};
                $Sday   = $Ob->{DY};
            }
            if (
                !defined($Eyear)
                || (   $Ob->{YR} <=> $Eyear
                    || $Ob->{MO} <=> $Emonth
                    || $Ob->{DY} <=> $Eday ) > 0
              )
            {
                $Eyear  = $Ob->{YR};
                $Emonth = $Ob->{MO};
                $Eday   = $Ob->{DY};
            }
        }
    }
    close(DIN);
}

# Print out the data for all ships
printf "      Date";
foreach my $Name ( sort keys %Observations ) {
    printf " %20s", $Name;
}
print "\n";
my $Year  = $Syear;
my $Month = $Smonth;
my $Day   = $Sday;
while ( Delta_Days( $Year, $Month, $Day, $Eyear, $Emonth, $Eday ) >= 0 ) {
    my $Dstring = sprintf "%04d/%02d/%02d", $Year, $Month, $Day;
    print "$Dstring";
    my $Pentad = pentad_from_date( sprintf( "%02d/%02d", $Month, $Day ) );
    my $Penday = penday_from_date( sprintf( "%02d/%02d", $Month, $Day ) );
    foreach my $Name ( sort keys %Observations ) {
        if ( exists( $Observations{$Name}{$Dstring} )
            && defined( $Observations{$Name}{$Dstring}->{SST} ) )
        {
            my $Nm = daily_normal(
                $Normal,
                $Observations{$Name}{$Dstring}->{LON},
                $Observations{$Name}{$Dstring}->{LAT},
                $Pentad, $Penday
            );
            if ( defined($Nm) ) {
                printf " %20.1f", $Observations{$Name}{$Dstring}->{SST} - $Nm;
            }
            else {
                print "                   NA";
            }
        }
        else {
            print "                   NA";
        }
    }
    print "\n";
    ( $Year, $Month, $Day ) = Add_Delta_Days( $Year, $Month, $Day, 1 );
}
