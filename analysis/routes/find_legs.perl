#!/usr/bin/perl 

# Make a list of the legs between stops.
#  assume a stop is missing data for at least 1 week.
#  If possible, find the (named) location of the stop.

use strict;
use IMMA;
use Date::Calc qw(Delta_Days check_date);
use MarineOb::immalibPB qw(Sort_ByDate);

# Specify a set of named places, each with a lat, long and radius
my %Places = (
    UK        => [ -4,  50,  6 ],
    Madeira   => [ -16, 33,  5 ],
    Rio       => [ -41, -24, 5 ],
    St_Helena => [ -4,  -17, 5 ],
    The_Cape  => [ 19,  -34, 5 ],
    Hong_Kong => [ 115, 21,  5 ],
    Kolkata   => [ 88,  20,  5 ],
    Chennai   => [ 81,  12,  5 ],
    Mumbai    => [ 72,  18,  5 ],
);
my @Obs;
foreach my $Fn (@ARGV) {
    @Obs = ();
    open( DIN, $Fn ) or die "Can't open $Fn";
    while ( my $Ob = imma_read( \*DIN ) ) {
        unless ( defined( $Ob->{ID} )
            && defined( $Ob->{YR} )
            && defined( $Ob->{MO} )
            && defined( $Ob->{DY} ) )
        {
            next;
        }
        push @Obs, $Ob;
    }
    close(DIN);
    if ( scalar(@Obs) < 10 ) { die "Bad file $Fn"; }
    @Obs = Sort_ByDate(@Obs);

    # Find the legs
    my @Legs;
    my $Current_leg = set_start(0);
    for ( my $i = 1 ; $i < scalar(@Obs) - 1 ; $i++ ) {

        unless ( check_date( $Obs[$i]->{YR}, $Obs[$i]->{MO}, $Obs[$i]->{DY} ) )
        {
            warn sprintf "Bad date: %s %04d/%02d/%02d\n", $Fn,
              $Obs[$i]->{YR}, $Obs[$i]->{MO}, $Obs[$i]->{DY};
            next;
        }
        unless (
            check_date(
                $Obs[ $i + 1 ]->{YR},
                $Obs[ $i + 1 ]->{MO},
                $Obs[ $i + 1 ]->{DY}
            )
          )
        {
            next;
        }

        # Mising data for at least 10 days
        if (
            abs(
                Delta_Days(
                    $Obs[$i]->{YR},       $Obs[$i]->{MO},
                    $Obs[$i]->{DY},       $Obs[ $i + 1 ]->{YR},
                    $Obs[ $i + 1 ]->{MO}, $Obs[ $i + 1 ]->{DY}
                )
            ) > 10
          )
        {
            set_end( $Current_leg, $i );
            push @Legs, $Current_leg;
            $Current_leg = set_start( $i + 1 );
            next;
        }
    }
    set_end( $Current_leg, $#Obs );
    push @Legs, $Current_leg;    # Last ob always a stop

    # Output each leg
    foreach my $Leg (@Legs) {
        printf "%9s ",  $Leg->{Ship};
        printf "%9s ",  $Leg->{StartPlace};
        printf "%10s ", $Leg->{StartDate};
        printf "%9s ",  $Leg->{EndPlace};
        printf "%10s ", $Leg->{EndDate};
        $Leg->{StartDate} =~ /(\d\d\d\d).(\d\d).(\d\d)/;
        my ( $y, $m, $d ) = ( $1, $2, $3 );
        $Leg->{EndDate} =~ /(\d\d\d\d).(\d\d).(\d\d)/;
        my ( $y2, $m2, $d2 ) = ( $1, $2, $3 );
        printf "%3d", Delta_Days( $y, $m, $d, $y2, $m2, $d2 );
        print "\n";
    }
}    # End of File loop

sub set_start {
    my $Nob = shift;
    my %Result;
    $Result{Ship} = $Obs[$Nob]->{ID};
    $Result{Ship} =~ s/\s/_/g;
    $Result{StartDate} = sprintf "%04d/%02d/%02d", $Obs[$Nob]->{YR},
      $Obs[$Nob]->{MO}, $Obs[$Nob]->{DY};
    $Result{StartPlace} = where_is( find_next_ll($Nob) );
    return \%Result;
}

sub set_end {
    my $Leg = shift;
    my $Nob = shift;
    $Leg->{EndDate} = sprintf "%04d/%02d/%02d", $Obs[$Nob]->{YR},
      $Obs[$Nob]->{MO}, $Obs[$Nob]->{DY};
    $Leg->{EndPlace} = where_is( find_last_ll($Nob) );
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

# Find a recent previous ob with good lat and long
sub find_last_ll {
    my $Nob = shift;    # Index of ob in (date sorted) array
    for ( my $i = $Nob ; $i > $Nob - 10 ; $i-- ) {
        if($i<0) { last; }
        if ( defined( $Obs[$i]->{LAT} ) && defined( $Obs[$i]->{LON} ) ) {
            return ( $Obs[$i]->{LAT}, $Obs[$i]->{LON} );
        }
    }
    return ( undef, undef );
}

# Same but looking forward
sub find_next_ll {
    my $Nob = shift;    # Index of ob in (date sorted) array
    for ( my $i = $Nob ; $i < $Nob + 10 ; $i++ ) {
        if($i>=scalar(@Obs)) { last; }
        if ( defined( $Obs[$i]->{LAT} ) && defined( $Obs[$i]->{LON} ) ) {
            return ( $Obs[$i]->{LAT}, $Obs[$i]->{LON} );
        }
    }
    return ( undef, undef );
}

# Is a location sufficiently close to one of the defined places
sub where_is {
    my $Lat = shift;
    my $Lon = shift;
    if ( defined($Lat) && defined($Lon) ) {
        foreach ( keys(%Places) ) {
            if (
                sqrt(
                    ( $Lon - $Places{$_}[0] )**2 + ( $Lat - $Places{$_}[1] )**2
                ) <= $Places{$_}[2]
              )
            {
                return $_;
            }
        }
    }
    return 'Unknown';
}

