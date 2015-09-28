#!/usr/bin/perl

use strict;
use warnings;
use FindBin;
use File::Basename;

my @dirs = qw(p 1-4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20);

my %Wd;
foreach my $Dir (@dirs) {
    foreach ( glob("$FindBin::Bin/../as_digitised/$Dir/*.txt") ) {
        $Wd{ basename($_) } = dirname($_);
    }
}
foreach (
    glob("$FindBin::Bin/../as_digitised/fix_dates/EIC_DatesCorrected/*.txt") )
{
    my $ToDir = $Wd{ basename($_) };
    `cp $_ $ToDir`;
}
