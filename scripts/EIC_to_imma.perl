#!/usr/bin/perl

# Process the digitised EIC logbook data from NCDC into
#  IMMA records.

use strict;
use warnings;
use Carp;
use Date::Calc qw(check_date Delta_Days);

use IMMA;

use MarineOb::lmrlib
  qw(rxltut ixdtnd rxnddt fxtftc fxtrtc fxmmmb fxeimb fwbptc fwbpgv fxbfms);
use MarineOb::lmrlib_extra qw(wind_direction_in_degrees direction_average);
use MarineOb::declination qw(magnetic_to_true);

use WindsEIC;
use PatchEIC;
use TruncateNames;

# Decimal longitudes of non-standard meridians
my %Meridians = (
    'Mumbai'    => 72.82,
    'Cape Town' => 22.37,
    'Hong Kong' => 114.2,
    'Calcutta'  => 88.4,
);

my ( $Last_lat_f, $Last_lon_f, $Last_lon, $Last_lat, $Last_at );
$Last_lat_f = 'N';
$Last_lon_f = 'W';

my @Records;
while ( my $Line = <STDIN> ) {
    my @Fields =
      unpack
      "a24a7a4a4a2a2a8a1a1a9a1a1a5a10a3a1a5a1a1a4a10a2a6a2a100a100a5a1a4a1",
      $Line;
    @Fields = PatchEIC::correct(@Fields);    # Apply known corrections
    unless ( defined( $Fields[0] ) ) { next; }   # Discard uncorrectable entries
    for my $Field (@Fields) {
        if ( defined($Field) && $Field =~ /\~/ ) {
            $Field =~ s/\S/ /g;
        }                                        # Discard dubious data
        if ( defined($Field) && $Field =~ /#/ ) {
            $Field =~ s/\S/ /g;
        }                                        # Discard dubious data
    }
    my $Ob = new IMMA;
    $Ob->clear();
    push @{ $Ob->{attachments} }, 0;

    # Name
    $Ob->{ID} = TruncateNames::short_from_long( $Fields[0] );

    # Date
    if ( $Fields[3] =~ /\d/ ) { $Ob->{YR} = $Fields[3]; }
    if ( $Fields[4] =~ /\d/ ) { $Ob->{MO} = $Fields[4]; }
    if ( $Fields[5] =~ /\d/ ) { $Ob->{DY} = $Fields[5]; }

    # Latitude
    if ( $Fields[6] =~ /^\s*\.(.*)/ ) { $Fields[6] = "00." . $1; }
    if ( $Fields[6] =~ /(\d+)\.*(\d*)\.*(\d*)/ ) {
        $Ob->{LAT} = $1;
        my ( $m, $s ) = ( $2, $3 );
        if ( defined($m) && $m =~ /\d/ ) { $Ob->{LAT} += $m / 60; }
        if ( defined($s) && $s =~ /\d/ ) { $Ob->{LAT} += $s / 3600; }
        if ( $Fields[7] =~ /[NS]/ ) { $Last_lat_f = $Fields[7]; }
        if (   defined( $Ob->{LAT} )
            && defined($Last_lat_f)
            && $Last_lat_f eq 'S' )
        {
            $Ob->{LAT} *= -1;
        }
        $Last_lat = $Ob->{LAT};
    }

    # Longitude
    if ( $Fields[9] =~ /^\s*\.(.*)/ ) { $Fields[9] = "00." . $1; }
    if ( $Fields[9] =~ /(\d+)\.*(\d*)\.*(\d*)/ ) {
        $Ob->{LON} = $1;
        my ( $m, $s ) = ( $2, $3 );
        if ( defined($m) && $m =~ /\d/ ) { $Ob->{LON} += $m / 60; }
        if ( defined($s) && $s =~ /\d/ ) { $Ob->{LON} += $s / 3600; }
        if ( $Fields[10] =~ /[EW]/ ) { $Last_lon_f = $Fields[10]; }
        if (   defined( $Ob->{LON} )
            && defined($Last_lon_f)
            && $Last_lon_f eq 'W' )
        {
            $Ob->{LON} *= -1;
        }

        # Correct for non-standard meridian if necessary
        if ( defined( $Fields[40] ) ) {
            unless ( defined( $Meridians{ $Fields[40] } ) ) {
                die "Unknown meridian $Fields[40]";
            }
            $Ob->{LON} += $Meridians{ $Fields[40] };
        }

        $Last_lon = $Ob->{LON};
    }
    if ( defined( $Ob->{LAT} ) || defined( $Ob->{LON} ) ) { $Ob->{LI} = 5; }

    # Assumed to be a noon ob
    $Ob->{HR} = 12;

    # Convert ob date and time to UTC
    if (   defined($Last_lon)
        && defined( $Ob->{HR} )
        && defined( $Ob->{DY} )
        && defined( $Ob->{MO} )
        && defined( $Ob->{YR} ) )
    {
        my $elon = $Last_lon;
        if ( $elon < 0 ) { $elon += 360; }
        my $ix = ixdtnd( $Ob->{DY}, $Ob->{MO}, $Ob->{YR} );
        if ( defined($ix) ) {
            my ( $uhr, $udy ) = rxltut( $Ob->{HR} * 100, $ix, $elon * 100 );
            $Ob->{HR} = $uhr / 100;
            ( $Ob->{DY}, $Ob->{MO}, $Ob->{YR} ) = rxnddt($udy);
        }
        else {
            warn "Illegal date $Ob->{YR}/$Ob->{MO}/$Ob->{DY}";
            $Ob->{HR} = undef;
        }
    }
    else { $Ob->{HR} = undef; }

    # Air temperature
    if ( $Fields[19] =~ /\d/ ) {

        # Correct, where appropriate, for fractional temperatures in minutes
        if ( $Fields[19] =~ /(\d\d)15/ ) {
            $Fields[19] = $1 . "25";
        }
        if ( $Fields[19] =~ /(\d\d)45/ ) {
            $Fields[19] = $1 . "75";
        }
        if ( $Fields[19] =~ /(\d\d)30/ ) {
            $Fields[19] = $1 . "50";
        }
        $Ob->{AT} = $Fields[19] / 100;
        if ( $Fields[17] ne '2' && $Fields[17] ne '3' ) {    # Farenheit
            $Ob->{AT} = fxtftc( $Ob->{AT} );
        }
        elsif ( $Fields[17] == 3 ) { # Reamur  (2 is Centigrade - no conversion)
            $Ob->{AT} = fxtrtc( $Ob->{AT} );
        }
        if ( $Fields[18] eq '-' ) { $Ob->{AT} *= -1; }
        $Last_at = $Ob->{AT};
    }

    # Pressure
    if ( $Fields[16] =~ /\d/ ) {
        $Ob->{SLP} = $Fields[16] / 1000;
        if ( $Fields[15] eq '2' ) {    # mm
            $Ob->{SLP} = fxmmmb( $Ob->{SLP} );
        }
        else {                         # inches
            $Ob->{SLP} = fxeimb( $Ob->{SLP} );
        }

        # Temperature correction
        if ( defined( $Ob->{SLP} ) && defined($Last_at) ) {
            $Ob->{SLP} += fwbptc( $Ob->{SLP}, $Last_at );
        }
        else { $Ob->{SLP} = undef; }

        # Gravity correction
        if ( defined( $Ob->{SLP} ) && defined($Last_lat) ) {
            $Ob->{SLP} += fwbpgv( $Ob->{SLP}, $Last_lat, 2 );
        }
        else { $Ob->{SLP} = undef; }
    }

    # Wind direction - corected to true north
    if ( $Fields[20] =~ /\S/ ) {
        $Ob->{D} = decode_direction( $Fields[20] );
        if (   defined( $Ob->{D} )
            && $Ob->{D}<=360
            && defined( $Ob->{YR} )
            && defined($Last_lat)
            && defined($Last_lon) )
        {

            $Ob->{D} =
              magnetic_to_true( $Ob->{D}, $Last_lat, $Last_lon, $Ob->{YR} );
            if ( $Ob->{D} < 1.0 ) {
                if ( $Ob->{D} < 0.5 ) {
                    $Ob->{D} = 360;
                }
                else {
                    $Ob->{D} = 1;
                }
            }    # IMMA stores at 1 degree resolution (1-360)
            $Ob->{DI} = undef;    # No flag for 64/128 point compass
        }
        else {
            $Ob->{D}  = undef;
            $Ob->{DI} = undef;
        }

    }

    # Wind speed
    if ( $Fields[22] =~ /\S/ ) {
        my @Numbers;
        $Fields[22] =~ /(...)(...)/;
        my $Force = WindsEIC::ncdc_to_beaufort( $1, $2 );
        if ( defined($Force) ) {
            if ( $Force == -1 ) {
                warn "Unknown wind force numbers $Fields[22]";
            }
            else {
                $Ob->{W}  = fxbfms($Force);    # Beaufort -> m/s
                $Ob->{WI} = 5;                 # Beaufort force
            }
        }
    }

    # SST
    if ( $Fields[28] =~ /\d/ ) {

        # Correct, where appropriate, for fractional temperatures in minutes
        if ( $Fields[28] =~ /(\d\d)15/ ) {
            $Fields[28] = $1 . "25";
        }
        if ( $Fields[28] =~ /(\d\d)45/ ) {
            $Fields[28] = $1 . "75";
        }
        if ( $Fields[28] =~ /(\d\d)30/ ) {
            $Fields[28] = $1 . "50";
        }
        $Ob->{SST} = $Fields[28] / 100;
        if ( $Fields[27] !~ /\d/ || $Fields[27] < 2 || $Fields[27] > 3 )
        {    # Farenheit
            $Ob->{SST} = fxtftc( $Ob->{SST} );
        }
        elsif ( $Fields[27] == 3 ) { # Reamur  (2 is Centigrade - no conversion)
            $Ob->{SST} = fxtrtc( $Ob->{SST} );
        }
    }

    $Ob->{IM}   = 0;                 #
    $Ob->{ATTC} = 1;                 # Supplemental
    $Ob->{TI}   = 0;                 # Nearest hour time precision
    $Ob->{DS}   = undef;             # Unknown course
    $Ob->{VS}   = undef;             # Unknown speed
    $Ob->{NID}  = 3;                 #
    $Ob->{II}   = 10;                #

    # Add the original record as a supplemental attachment
    push @{ $Ob->{attachments} }, 99;
    $Ob->{ATTE} = undef;
    chomp($Line);
    $Ob->{SUPD} = $Line;

    push @Records, $Ob;

}

# Sort and output the records;
@Records = sort by_date @Records;

#foreach (@Records) {
#    $_->write( \*STDOUT );
#}

# Do basic QC on their positions
#for(my $i=1;$i<scalar(@Records)-1;$i++) {
#if(defined($Records[$i]->{LAT}) &&
#   defined($Records[$i+1]->{LAT}) &&
#   defined($Records[$i-1]->{LAT}) &&
#   $Records[$i]->{LAT}*$Records[$i+1]->{LAT}<0 &&
#   $Records[$i]->{LAT}*$Records[$i-1]->{LAT}<0) {
#   $Records[$i]->{LAT}*=-1;
#   }
#if(defined($Records[$i]->{LON}) &&
#   defined($Records[$i+1]->{LON}) &&
#   defined($Records[$i-1]->{LON}) &&
#   $Records[$i]->{LON}*$Records[$i+1]->{LON}<0 &&
#   $Records[$i]->{LON}*$Records[$i-1]->{LON}<0) {
#   $Records[$i]->{LON}*=-1;
#   }
#}
for ( my $i = 1 ; $i < scalar(@Records) - 1 ; $i++ ) {
    unless (
           defined( $Records[$i]->{YR} )
        && defined( $Records[$i]->{MO} )
        && defined( $Records[$i]->{DY} )
        && check_date(
            $Records[$i]->{YR}, $Records[$i]->{MO}, $Records[$i]->{DY}
        )
      )
    {
        next;
    }
    unless (
           defined( $Records[ $i - 1 ]->{YR} )
        && defined( $Records[ $i - 1 ]->{MO} )
        && defined( $Records[ $i - 1 ]->{DY} )
        && check_date(
            $Records[ $i - 1 ]->{YR},
            $Records[ $i - 1 ]->{MO},
            $Records[ $i - 1 ]->{DY}
        )
      )
    {
        next;
    }
    my $Dd = abs(
        Delta_Days(
            $Records[ $i - 1 ]->{YR}, $Records[ $i - 1 ]->{MO},
            $Records[ $i - 1 ]->{DY}, $Records[$i]->{YR},
            $Records[$i]->{MO},       $Records[$i]->{DY}
        )
    );
    if ( $Dd <= 0 ) { $Dd = 1; }

    # Latitude first
    if (   defined( $Records[$i]->{LAT} )
        && defined( $Records[ $i - 1 ]->{LAT} )
        && abs( $Records[$i]->{LAT} - $Records[ $i - 1 ]->{LAT} ) / $Dd > 3 )
    {

        # Impossibly fast - something is wrong
        # Have we switched hemisphere?
        if ( $Records[$i]->{LAT} * $Records[ $i - 1 ]->{LAT} < 0 ) {

            # Might be in error - look for a switch back in the near future
            my $Switch = -1;
            for ( my $j = 1 ; $j < 10 ; $j++ ) {
                unless (
                       defined( $Records[ $i + $j ]->{LAT} )
                    && defined( $Records[ $i + $j ]->{YR} )
                    && defined( $Records[ $i + $j ]->{MO} )
                    && defined( $Records[ $i + $j ]->{DY} )
                    && check_date(
                        $Records[ $i + $j ]->{YR},
                        $Records[ $i + $j ]->{MO},
                        $Records[ $i + $j ]->{DY}
                    )
                    && Delta_Days(
                        $Records[$i]->{YR},        $Records[$i]->{MO},
                        $Records[$i]->{DY},        $Records[ $i + $j ]->{YR},
                        $Records[ $i + $j ]->{MO}, $Records[ $i + $j ]->{DY}
                    ) < 10
                  )
                {
                    last;
                }
                if ( $Records[$i]->{LAT} * $Records[ $i + $j ]->{LAT} < 0
                    && abs( $Records[$i]->{LAT} - $Records[ $i + $j ]->{LAT} ) >
                    3 )
                {    # switch back found $j days ahead
                    $Switch = $j;
                    last;
                }
            }
            if ( $Switch >= 0 ) {

                for ( my $j = $i ; $j <= $i + $Switch - 1 ; $j++ ) {
                    $Records[$j]->{LAT} *= -1;
                }    # Switch hemisphere back
            }

        }
    }

    # Same with longitude, but compicated by wraparound
    if (   defined( $Records[$i]->{LON} )
        && defined( $Records[ $i - 1 ]->{LON} )
        && abs( $Records[$i]->{LON} - $Records[ $i - 1 ]->{LON} ) / $Dd > 10
        && abs( $Records[$i]->{LON} + 360 - $Records[ $i - 1 ]->{LON} ) / $Dd >
        10
        && abs( $Records[$i]->{LON} - 360 - $Records[ $i - 1 ]->{LON} ) / $Dd >
        10 )
    {

        # Impossibly fast - something is wrong
        # Have we switched hemisphere?
        if ( $Records[$i]->{LON} * $Records[ $i - 1 ]->{LON} < 0 ) {

            # Might be in error - look for a switch back in the near future
            my $Switch = -1;
            for ( my $j = 1 ; $j < 10 ; $j++ ) {
                unless (
                       defined( $Records[ $i + $j ]->{LON} )
                    && defined( $Records[ $i + $j ]->{YR} )
                    && defined( $Records[ $i + $j ]->{MO} )
                    && defined( $Records[ $i + $j ]->{DY} )
                    && check_date(
                        $Records[ $i + $j ]->{YR},
                        $Records[ $i + $j ]->{MO},
                        $Records[ $i + $j ]->{DY}
                    )
                    && Delta_Days(
                        $Records[$i]->{YR},        $Records[$i]->{MO},
                        $Records[$i]->{DY},        $Records[ $i + $j ]->{YR},
                        $Records[ $i + $j ]->{MO}, $Records[ $i + $j ]->{DY}
                    ) < 10
                  )
                {
                    last;
                }
                if ( $Records[$i]->{LON} * $Records[ $i + $j ]->{LON} < 0
                    && abs( $Records[$i]->{LON} - $Records[ $i + $j ]->{LON} ) >
                    3 )
                {    # switch back found $j days ahead
                    $Switch = $j;
                    last;
                }
            }
            if ( $Switch >= 0 ) {
                for ( my $j = $i ; $j <= $i + $Switch - 1 ; $j++ ) {
                    $Records[$j]->{LON} *= -1;
                }    # Switch hemisphere back
            }

        }
    }

}

foreach (@Records) {
    $_->write( \*STDOUT );
}

sub decode_direction {
    my $Dir_c = lc(shift);
    $Dir_c =~ s/b/x/;
    $Dir_c =~ s/\W//g;    # Strip spaces
    if ( $Dir_c =~ /^v/ )     { $Dir_c = 'v'; }
    if ( $Dir_c =~ /(.+)v$/ ) { $Dir_c = $1; }
    if ( $Dir_c eq 'c' ) { return 361; }    # IMMA code for Calm
    if ( $Dir_c eq 'v' ) { return 362; }    # IMMA code for Variable
    if ( $Dir_c =~ /(.+)[Tt](.+)/ ) {
        my $D1 = wind_direction_in_degrees($1);
        my $D2 = wind_direction_in_degrees($2);
        if ( defined($D1) && defined($D2) ) {
            return direction_average( $D1, $D2 );
        }
        else {
            carp "Unknown wind direction $Dir_c";
            return;
        }
    }
    my $D1 = wind_direction_in_degrees($Dir_c);
    if ( defined($D1) ) {
        return $D1;
    }
    else {
        warn "Unknown wind direction $Dir_c";
        return;
    }
}

# Sort IMMA records by date
sub by_date {
    my $aYR = $a->{YR};
    unless ( defined($aYR) ) { $aYR = 0; }
    my $aMO = $a->{MO};
    unless ( defined($aMO) ) { $aMO = 0; }
    my $aDY = $a->{DY};
    unless ( defined($aDY) ) { $aDY = 0; }
    my $aHR = $a->{HR};
    unless ( defined($aHR) ) { $aHR = 0; }
    my $bYR = $b->{YR};
    unless ( defined($bYR) ) { $bYR = 0; }
    my $bMO = $b->{MO};
    unless ( defined($bMO) ) { $bMO = 0; }
    my $bDY = $b->{DY};
    unless ( defined($bDY) ) { $bDY = 0; }
    my $bHR = $b->{HR};
    unless ( defined($bHR) ) { $bHR = 0; }

    #    return $aYR <=> $bYR
    #      or $aMO <=> $bMO
    #      or $aDY <=> $bDY
    #      or $aHR <=> $bHR; # Why doesn't this work
    if ( ( $aYR <=> $bYR ) != 0 ) { return $aYR <=> $bYR; }
    if ( ( $aMO <=> $bMO ) != 0 ) { return $aMO <=> $bMO; }
    if ( ( $aDY <=> $bDY ) != 0 ) { return $aDY <=> $bDY; }
    return $aHR <=> $bHR;
}
