#!/usr/bin/perl

# Get wind speed anomaly and descriptor for each ob.

use strict;
use warnings;
use IMMA;
use FindBin;
use lib "$FindBin::Bin/../../scripts";
use WindsEIC;

# Use the MDS functions to make normals for the data
use lib "../utility_scripts";
use Normals2;
use lib "$ENV{MDS2}/libraries/pentads/source";
use Pentads;

my $Normal = get_normals('WS');

while ( my $Ob = imma_read( \*ARGV ) ) {
    if (   defined( $Ob->{YR} )
        && defined( $Ob->{MO} )
        && defined( $Ob->{DY} )
        && defined( $Ob->{LON} )
        && defined( $Ob->{LAT} )
        && defined( $Ob->{ID} )
        && defined( $Ob->{SUPD} ) )
    {
        my @Fields =
          unpack
          "a24a7a4a4a2a2a8a1a1a9a1a1a5a10a3a1a5a1a1a4a10a2a6a2a100a100a5a1a4a1",
          $Ob->{SUPD};

        my $Winds;
        my $Beaufort;
        if ( $Fields[22] =~ /\S/ ) {
            $Fields[22] =~ /(...)(...)/;
            my ( $W1, $W2 ) = ( $1, $2 );
            foreach my $Word ( WindsEIC::ncdc_to_words( $W1, $W2 ) ) {
                if ( defined($Winds) ) { $Winds .= "_"; }
                $Winds .= ucfirst($Word);
            }
            if ( $Winds eq 'Breeze_Pleasant' ) { $Winds = 'Pleasant_Breeze'; }
            if ( $Winds eq 'Wind_Light' )      { $Winds = 'Light_Wind'; }
        }
        if ( defined( $Ob->{W} ) ) {
            $Winds = sprintf "(%02d)_%s", speed_to_beaufort( $Ob->{W} ), $Winds;
            my $Nm = daily_normal(
                $Normal,
                $Ob->{LON},
                $Ob->{LAT},
                pentad_from_date(
                    sprintf( "%02d/%02d", $Ob->{MO}, $Ob->{DY} )
                ),
                penday_from_date(
                    sprintf( "%02d/%02d", $Ob->{MO}, $Ob->{DY} )
                )
            );
            if ( defined($Nm) ) {
                printf "%s %4.1f\n", $Winds, $Nm;
            }
        }

    }
}

sub speed_to_beaufort {
    my $Speed = shift;
    my @Speeds =
      ( 0., 1., 2.6, 4.6, 6.7, 9.3, 12.3, 15.4, 19., 22.6, 26.8, 30.9, 35. );
    for ( my $i = 0 ; $i <= 12 ; $i++ ) {
        if ( abs( $Speed - $Speeds[$i] ) < 0.01 ) { return $i; }
    }
    return;
}
