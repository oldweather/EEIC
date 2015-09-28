#!/usr/bin/perl 

# Make a list of the points the ships stop at.
#  assume a stop is missing data for at least 1 week
#  and then the end of the file or new data < 3 degrees away

use strict;
use IMMA;
use Date::Calc qw(Delta_Days);
use MarineOb::immalibPB qw(Sort_ByDate);

my @Obs;
while ( my $Ob = imma_read( \*ARGV ) ) {
    unless ( defined( $Ob->{LAT} )
        && defined( $Ob->{YR} )
        && defined( $Ob->{MO} )
        && defined( $Ob->{DY} )
        && defined( $Ob->{LON} ) )
    {
        next;
    }
    push @Obs, $Ob;
}
@Obs = Sort_ByDate(@Obs);

# Find obs corresponding to stopping places
my @Stopping;
push @Stopping,$Obs[0]; # First Ob always a stop
for ( my $i = 1 ; $i < scalar(@Obs) - 1 ; $i++ ) {
    unless ( defined( $Obs[$i]->{ID} )
        && defined( $Obs[$i]->{YR} )
        && defined( $Obs[$i]->{MO} )
        && defined( $Obs[$i]->{DY} )
        && defined( $Obs[$i]->{LAT} )
        && defined( $Obs[$i]->{LON} ) )
    {
        next;
    }

    # Last ob for each ship
    # And first ob for next ship
    if ( defined( $Obs[ $i + 1 ]->{ID} )
        && $Obs[ $i + 1 ]->{ID} ne $Obs[$i]->{ID} )
    {
        push @Stopping, $Obs[$i];
        push @Stopping, $Obs[$i+1];
        next;
    }

    # Mising data for at least a week
    # And a nearby next ob
    if (
           defined( $Obs[ $i + 1 ]->{YR} )
        && defined( $Obs[ $i + 1 ]->{MO} )
        && defined( $Obs[ $i + 1 ]->{DY} )
        && abs(
            Delta_Days(
                $Obs[$i]->{YR},       $Obs[$i]->{MO},
                $Obs[$i]->{DY},       $Obs[ $i + 1 ]->{YR},
                $Obs[ $i + 1 ]->{MO}, $Obs[ $i + 1 ]->{DY}
            )
        ) > 7
        && defined( $Obs[ $i + 1 ]->{LAT} )
        && defined( $Obs[ $i + 1 ]->{LON} )
        && is_close( $Obs[$i], $Obs[ $i + 1 ] )
      )
    {
        push @Stopping, $Obs[$i];
        push @Stopping, $Obs[$i+1];
        next;
    }
}
push @Stopping, $Obs[$#Obs];    # Last ob always a stop

# Output details of all the stopping obs
foreach my $Ob (@Stopping) {
    $Ob->{ID} =~ s/\s/_/g;
    printf "%9s %04d/%02d/%02d %5.1f %6.1f\n", $Ob->{ID}, $Ob->{YR}, $Ob->{MO},
      $Ob->{DY}, $Ob->{LAT}, $Ob->{LON};
}

# Are two obs close together?
# No EIC in the centralPacific, so ignore the lon wraparound problem
sub is_close {
    my $O1 = shift;
    my $O2 = shift;
    if ( abs( $O1->{LON} - $O2->{LON} ) > 10 ) { return; }
    if ( abs( $O1->{LAT} - $O2->{LAT} ) > 10 ) { return; }
    return 1;
}

