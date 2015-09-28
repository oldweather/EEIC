#!/usr/bin/perl 

# How long did it take a ship to traverse the doldrums in the Atlantic
#  (15S-15N), & at what longitude and date did they cross the equator.
# Going South.

use strict;
use IMMA;
use Date::Calc qw(Day_of_Year Delta_Days);

my $Last_ob;
my ( $ECday, $EClon, %NDate, %SDate );
while ( my $Ob = imma_read( \*ARGV ) ) {
    unless ( defined( $Ob->{LAT} )
        && defined( $Ob->{YR} )
        && defined( $Ob->{MO} )
        && defined( $Ob->{DY} )
        && defined( $Ob->{LON} ) )
    {
        next;
    }
    $Ob->{ID} =~ s/\s/_/g;
    unless ( defined($Last_ob)
        && $Last_ob->{ID} eq $Ob->{ID}
        && $Ob->{LON} < 20
        && $Ob->{LON} > -60 )
    {
        $Last_ob = $Ob;
        undef($ECday);
        undef($EClon);
        undef( $NDate{year} );
        undef( $SDate{year} );
        next;
    }

    # Equatorial crossing
    if (   $Ob->{LAT} <= 0
        && $Last_ob->{LAT} > 0 )
    {
        $ECday = Day_of_Year( $Ob->{YR}, $Ob->{MO}, $Ob->{DY} );    #
        $EClon = $Ob->{LON};
    }

    # Date of crossing 15N
    if (   $Ob->{LAT} <= 15
        && $Last_ob->{LAT} > 15 )
    {
        $NDate{year}  = $Ob->{YR};
        $NDate{month} = $Ob->{MO};
        $NDate{day}   = $Ob->{DY};
    }

    # Date of crossing 15S
    if (   $Ob->{LAT} <= -15
        && $Last_ob->{LAT} > -15 )
    {
        $SDate{year}  = $Ob->{YR};
        $SDate{month} = $Ob->{MO};
        $SDate{day}   = $Ob->{DY};
    }
    if (   defined($ECday)
        && defined($EClon)
        && defined( $NDate{year} )
        && defined( $SDate{year} ) )
    {
        my $Duration = Delta_Days(
            $NDate{year}, $NDate{month}, $NDate{day},
            $SDate{year}, $SDate{month}, $SDate{day}
        );
        printf "%04d/%02d/%02d %3d %3d %3d %6.1f %9s\n", $NDate{year},
          $NDate{month}, $NDate{day}, $ECday, $Duration,
          int( $Ob->{YR} / 10 ), $EClon, $Ob->{ID};
        undef($ECday);
        undef($EClon);
        undef( $NDate{year} );
        undef( $SDate{year} );
    }
    $Last_ob = $Ob;
}
