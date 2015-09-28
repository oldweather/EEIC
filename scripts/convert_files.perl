#!/usr/bin/perl

# Convert a batch of files - making appropriately named IMMA and KML
#  files.

use strict;
use warnings;
use FindBin;
use lib "$FindBin::Bin";
use TruncateNames;
use IMMA;

my %Name_counts;
my $Colour = 11;

foreach my $File (@ARGV) {

    unless ( $File =~ /.*\/Archive_(\S+)\/[^\/]+\.txt/ ) {
        die "Irregular filename $File";
    }
    my $Group = $1;
    unless ( -d "$FindBin::Bin/../imma/$Group" ) {
        `mkdir $FindBin::Bin/../imma/$Group`;
    }
    unless ( -d "$FindBin::Bin/../kml/$Group" ) {
        `mkdir $FindBin::Bin/../kml/$Group`;
    }

    # Get the ship name from the file
    open( DIN, $File ) or die "Can't open $File";
    my $Line = <DIN>;
    unless ( $Line =~ /\w/ ) { next; }
    close(DIN);
    my $Long = substr( $Line, 0, 24 );
    my $Formatted = TruncateNames::formatted_from_long($Long);
    unless ( defined($Formatted) ) {
        warn "No translations for name: $Long - skipped";
        next;
    }
    $Formatted =~ s/\s/_/g;
    if ( defined( $Name_counts{$Formatted} ) ) {
        $Name_counts{$Formatted}++;
    }
    else {
        $Name_counts{$Formatted} = 1;
    }

    warn sprintf "\nConverting %s.%d (%s)\n", $Formatted,
      $Name_counts{$Formatted}, $File;

    # Do the conversion to IMMA
    `$FindBin::Bin/EIC_to_imma.perl < \"$File\" > convtemp.imma`;
    my @Date_range = get_date_range("convtemp.imma");
    my $IFile = sprintf "%s/../imma/%s/%s.%s.%s.imma", $FindBin::Bin, $Group,
      $Formatted, @Date_range;
    `imma_interpolate.perl < convtemp.imma > $IFile`;
    unlink "convtemp.imma";

    # Make the KML file
    my $KFile = sprintf "%s/../kml/%s/%s.%s.%s.kml", $FindBin::Bin, $Group,
      $Formatted, @Date_range;
    `../../scripts/imma_to_kml.perl --startcolour=$Colour --title="$Formatted $Date_range[0] to $Date_range[1]" < $IFile > $KFile`;
    $Colour++;
    if ( $Colour > 11 ) { $Colour = 0; }
}

# Get the date range from an IMMA file
sub get_date_range {
    my $File = shift;
    open( DIN, $File ) or die "Can't open $File";
    my ( $Start_date, $End_date );
    while ( my $ob = imma_read( \*DIN ) ) {
        unless ( defined( $ob->{YR} )
            && defined( $ob->{MO} )
            && defined( $ob->{DY} ) )
        {
            next;
        }
        my $Date = sprintf "%04d-%02d-%02d", $ob->{YR}, $ob->{MO}, $ob->{DY};
        if ( !defined($Start_date) || ( $Start_date cmp $Date ) > 0 ) {
            $Start_date = $Date;
        }
        if ( !defined($End_date) || ( $Date cmp $End_date ) > 0 ) {
            $End_date = $Date;
        }

    }
    close(DIN);
    return ( $Start_date, $End_date );
}

