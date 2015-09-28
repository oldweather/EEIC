#!/usr/bin/perl

# Get paired pressure and sympiesometer reradings

use strict;
use warnings;
use IMMA;

use MarineOb::lmrlib qw(fxmmmb fxeimb fwbpgv);

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
            my @Fields =
              unpack
              "a24a7a4a4a2a2a8a1a1a9a1a1a5a10a3a1a5a1a1a4a10a2a6a2a100a100a5a1a4a1",
              $Ob->{SUPD};

            # Get the sympiesometer reading if possible
            if ( $Fields[26] =~ /\d/ ) {
                $Ob->{SYMP} = $Fields[26] / 1000;
                if ( $Fields[15] eq '2' ) {    # mm
                    $Ob->{SYMP} = fxmmmb( $Ob->{SYMP} );
                }
                else {                         # inches
                    $Ob->{SYMP} = fxeimb( $Ob->{SYMP} );
                }
            }
            else { next; }
            if ( defined( $Ob->{SLP} ) ) {
                $Ob->{ID} =~ s/\s/_/g;
                printf "%9s %04d-%02d-%02d %6.1f %6.1f\n", $Ob->{ID}, $Ob->{YR},
                  $Ob->{MO}, $Ob->{DY}, $Ob->{SLP}, $Ob->{SYMP};

            }
        }
    }
}
