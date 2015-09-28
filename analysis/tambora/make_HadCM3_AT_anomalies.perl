#!/usr/bin/perl

# Extract the GCM anomaly from ST's HadCM3 ALL run at each observation location
# This will give a GCM equivalent of the observational dataset

use strict;
use warnings;
use PP;
use IMMA;
use Date::Calc qw(Delta_Days Add_Delta_Days);

my $HadCM3 = get_HadCM3();

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
    foreach my $Name ( sort keys %Observations ) {
        if (   exists( $Observations{$Name}{$Dstring} )
            && defined( $Observations{$Name}{$Dstring}->{AT} )
            && defined( $Observations{$Name}{$Dstring}->{LON} )
            && defined( $Observations{$Name}{$Dstring}->{LAT} ) )
        {
            my $Nm = get_hadcm3_point(
                $HadCM3,
                $Observations{$Name}{$Dstring}->{LON},
                $Observations{$Name}{$Dstring}->{LAT},
                $Year, $Month
            );
            if ( defined($Nm) ) {
                printf " %20.1f", $Nm;
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

sub get_HadCM3 {
    my $Filename = "/data/local/hadpb/soap_runs/all/airtemp/anomaly.pp";
    my %HadCM3;
    open( DIN_N, "$Filename" ) or die "Unable to open normals file $Filename";
    while ( my $pp = pp_read( \*DIN_N ) ) {
        if ( $pp->{lbyr} < 1785 ) { next; }
        if ( $pp->{lbyr} > 1835 ) { last; }
        $HadCM3{ sprintf "%04d%02d", $pp->{lbyr}, $pp->{lbmon} } = $pp;
    }
    close(DIN_N);
    return \%HadCM3;
}

# Return the HadCM3 value for a given lat, lon, year and month
sub get_hadcm3_point {
    my ( $HadCM3, $longitude, $latitude, $Year, $Month ) = @_;
    my $Dstring = sprintf( "%04d%02d", $Year, $Month );
    if ( $HadCM3->{$Dstring}
        ->{data}[ lat_index($latitude) ][ lon_index($longitude) ] ==
        $HadCM3->{$Dstring}->{bmdi} )
    {
        return;
    }
    return $HadCM3->{$Dstring}
      ->{data}[ lat_index($latitude) ][ lon_index($longitude) ];
}

# Convert a longitude into an index for HadCM3 AT data
sub lon_index {
    my $longitude  = shift;
    my $long_local = $longitude;
    if ( $long_local == -180 ) { $long_local += 0.01; }
    if ( $long_local == 180 ) { $long_local -= 0.01; }
    if ( $long_local < 0 ) { $long_local += 360; }
    my $Index = int( ( $long_local + 3.75 ) / 3.75 -1);
    return ($Index);
}

# Convert a latitude into an index for normal data
sub lat_index {
    my $latitude  = shift;
    my $lat_local = $latitude;
    if ( $lat_local == -90 ) { $lat_local += 0.01; }
    if ( $lat_local == 90 ) { $lat_local -= 0.01; }
    my $Index = int( ( $lat_local - 92.5 ) / -2.5 -1);
    return ($Index);
}
