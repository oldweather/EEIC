#!/usr/bin/perl

# Extract a list of the wind force indicators

use strict;
use warnings;
use IMMA;
use FindBin;
use lib "$FindBin::Bin/../../scripts";
use WindsEIC;

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
        my ( $W1, $W2 );
        my $Beaufort;
        if ( $Fields[22] =~ /\S/ ) {
            $Fields[22] =~ /(...)(...)/;
            ( $W1, $W2 ) = ( $1, $2 );
            foreach my $Word ( WindsEIC::ncdc_to_words( $W1, $W2 ) ) {
                if ( defined($Winds) ) { $Winds .= "_"; }
                $Winds .= ucfirst($Word);
            }
            $Beaufort = WindsEIC::ncdc_to_beaufort( $W1, $W2 );
            if ( defined($Beaufort) && $Beaufort == -1 ) {
                warn "Unknown wind force numbers $Fields[22]";
                $Beaufort = undef;
            }
        }
        if ( !defined($Beaufort) ) { $Beaufort = "NA"; }

        if ( defined($Winds) ) {
            $Ob->{ID} =~ s/\s/_/g;
            $Ob->{ID} =~ s/_+$//;
            $Ob->{ID} =~ s/^_+//;
            printf "%04d-%02d-%02d %9s %5.1f %6.1f %2s %s\n", $Ob->{YR},
              $Ob->{MO}, $Ob->{DY}, $Ob->{ID}, $Ob->{LAT}, $Ob->{LON},
              $Beaufort, $Winds;
        }
    }
}

