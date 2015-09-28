#!/usr/bin/perl

# Make a section of HTML for ship selection

use strict;
use warnings;
use IMMA;
use FindBin;
use Date::Calc qw(Add_Delta_Days);
use TruncateNames;

my @Files = glob("$FindBin::Bin/../imma/*.imma");

my %Dates;
my %Sname;
foreach my $File (@Files) {
    $File =~ /.*\/(.+)\.\d+\.imma/ or die;
    my $Name = $1;
    $Name = join( ' ', map( ucfirst, split /_/, $Name ) );
    open( DIN, $File ) or die "Can't open $File";
    my ( $Start_date, $End_date );
    while ( my $ob = imma_read( \*DIN ) ) {
        unless ( defined( $ob->{YR} )
            && defined( $ob->{MO} )
            && defined( $ob->{DY} ) )
        {
            next;
        }
        if ( defined( $ob->{ID} ) ) {
            $Sname{$Name} = $ob->{ID};
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
    push @{ $Dates{$Name} }, [ $Start_date, $End_date ];
}

for my $Ship ( sort( keys(%Dates) ) ) {
    printf "                <li>%s\n	              <ul>\n", $Ship;
    my $Id = $Sname{$Ship};
    @{ $Dates{$Ship} } = sort { $a->[0] cmp $b->[0] } @{ $Dates{$Ship} };
    for my $Sdates ( @{ $Dates{$Ship} } ) {
        my $Sd = $Sdates->[0];
        $Sd =~ /(\d\d\d\d).(\d\d).(\d\d)/ or die "Bad date $Sd";
        my ( $year, $month, $day ) = Add_Delta_Days( $1, $2, $3, -1 );
        $Sd = sprintf "%04d,%02d,%02d", $year, $month, $day;
        my $Ed = $Sdates->[1];
        $Ed =~ /(\d\d\d\d).(\d\d).(\d\d)/ or die "Bad date $Sd";
        ( $year, $month, $day ) = Add_Delta_Days( $1, $2, $3, 1 );
        $Ed = sprintf "%04d,%02d,%02d", $year, $month, $day;
        printf
          "<li><a href=\"javascript:loadIMMA('where=WHERE ID=\\\'%9s\\\' AND datetime > datetime(%10s) AND datetime < datetime(%10s)','%s %10s to %10s')\">%10s to %10s</a></li>\n",
          $Id, $Sd, $Ed, $Ship, $Sdates->[0], $Sdates->[1], $Sdates->[0],
          $Sdates->[1];
    }
    print "	              </ul></li>\n";
}
