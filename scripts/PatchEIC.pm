# Apply patches to the digitised EIC data
# These are corrections to the as-digitised files which fix processing
#  problems - generally addition of hemisphere flags.

package PatchEIC;

use strict;
use warnings;
use Date::Calc qw(Delta_Days);

sub correct {
    my @Fields = (@_);
    if ( defined( $Fields[3] ) && $Fields[3] > 1900 ) {
        $Fields[3] -= 100;
    }    # Bad dates

    if (   $Fields[0] eq '          CASTLE HUNTLEY'
        && $Fields[3] == 1813
        && $Fields[4] == 7
        && $Fields[5] > 5 )
    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '          CASTLE HUNTLEY'
        && $Fields[3] == 1830
        && $Fields[4] == 9
        && $Fields[5] == 23 )
    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '          CASTLE HUNTLEY'
        && $Fields[3] == 1813
        && $Fields[4] == 4
        && $Fields[5] == 21 )
    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '          CASTLE HUNTLEY'
        && $Fields[3] == 1813
        && $Fields[4] == 5
        && $Fields[5] == 11 )
    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '          CASTLE HUNTLEY'
        && $Fields[3] == 1813
        && $Fields[4] == 5
        && $Fields[5] == 31 )
    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '          CASTLE HUNTLEY'
        && $Fields[3] == 1813
        && $Fields[4] == 7
        && $Fields[5] == 16 )
    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '          CASTLE HUNTLEY'
        && $Fields[3] == 1828
        && $Fields[4] == 9
        && $Fields[5] == 3 )
    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '          CASTLE HUNTLEY'
        && $Fields[3] == 1818
        && $Fields[4] == 10
        && $Fields[5] == 4 )
    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '          CASTLE HUNTLEY'
        && $Fields[3] == 1818
        && $Fields[4] == 10
        && $Fields[5] == 5 )
    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '          CASTLE HUNTLEY'
        && $Fields[15] eq '2' )
    {
        $Fields[15] = '1';
    }    # Pressure incorrectly flagged as mm

    if (   $Fields[0] eq '               HARRIET 3'
        && $Fields[3] == 1804
        && $Fields[4] == 2
        && $Fields[5] == 14 )
    {
        $Fields[7] = 'S';
    }

    if (   $Fields[0] eq '               HARRIET 3'
        && $Fields[3] == 1803
        && $Fields[4] == 2
        && $Fields[5] == 19 )
    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '               HARRIET 3'
        && $Fields[3] == 1803
        && $Fields[4] == 11
        && $Fields[5] == 14 )
    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '               LONDON 14'
        && $Fields[3] == 1828
        && $Fields[4] == 5
        && $Fields[5] == 15 )
    {
        $Fields[7] = 'N';
    }

    if (   $Fields[0] eq '               LONDON 14'
        && $Fields[3] == 1831
        && $Fields[4] == 2
        && $Fields[5] == 20 )
    {
        $Fields[10] = 'W';
    }

    if (   $Fields[0] eq '             DORSETSHIRE'
        && $Fields[3] == 1801
        && $Fields[4] == 11
        && $Fields[5] >= 8 )
    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '             DORSETSHIRE'
        && $Fields[3] == 1803
        && $Fields[4] == 7
        && $Fields[5] == 13 )
    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '             DORSETSHIRE'
        && $Fields[3] == 1820
        && $Fields[4] == 4
        && $Fields[5] == 18 )
    {
        $Fields[7] = 'S';
    }

    if (   $Fields[0] eq '             DORSETSHIRE'
        && $Fields[3] == 1820
        && $Fields[4] == 7
        && $Fields[5] == 13 )
    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '             DORSETSHIRE'
        && $Fields[3] == 1822
        && $Fields[4] == 8
        && $Fields[5] == 16 )
    {
        $Fields[7] = 'S';
    }

    if (   $Fields[0] eq '             DORSETSHIRE'
        && $Fields[3] == 1822
        && $Fields[4] == 8
        && $Fields[5] == 21 )
    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '             DORSETSHIRE'
        && $Fields[3] == 1822
        && $Fields[4] == 10
        && $Fields[5] == 4 )
    {
        $Fields[7] = 'N';
    }

    if (   $Fields[0] eq '             DORSETSHIRE'
        && $Fields[3] == 1823
        && $Fields[4] == 3
        && $Fields[5] == 4 )
    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '             DORSETSHIRE'
        && $Fields[3] == 1800
        && $Fields[4] == 7
        && $Fields[5] == 20 )
    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '             DORSETSHIRE'
        && $Fields[3] == 1817
        && $Fields[4] == 9
        && $Fields[5] == 4 )
    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '             DORSETSHIRE'
        && $Fields[3] == 1801
        && $Fields[4] == 8
        && $Fields[5] == 27 )
    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '             DORSETSHIRE'
        && $Fields[3] == 1806
        && $Fields[4] == 8
        && $Fields[5] == 12 )
    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '             DORSETSHIRE'
        && $Fields[3] == 1814
        && $Fields[4] == 4
        && $Fields[5] == 27 )
    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '             DORSETSHIRE'
        && $Fields[3] == 1817
        && $Fields[4] == 6
        && $Fields[5] == 19 )
    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '             DORSETSHIRE'
        && $Fields[3] == 1817
        && $Fields[4] == 8
        && $Fields[5] == 19 )
    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '             DORSETSHIRE'
        && $Fields[3] == 1821
        && $Fields[4] == 5
        && $Fields[5] == 25 )
    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '             DORSETSHIRE'
        && $Fields[3] == 1820
        && $Fields[4] == 7
        && $Fields[5] == 8 )
    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '             DORSETSHIRE'
        && $Fields[3] == 1820
        && $Fields[4] == 3
        && $Fields[5] == 23 )
    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '             DORSETSHIRE'
        && $Fields[3] == 1821
        && $Fields[4] == 6
        && $Fields[5] == 26 )
    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '             DORSETSHIRE'
        && $Fields[3] == 1822
        && $Fields[4] == 7
        && $Fields[5] == 7 )
    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '             DORSETSHIRE'
        && $Fields[3] == 1817
        && $Fields[4] == 4
        && $Fields[5] == 27 )
    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '              CARMARTHEN'
        && $Fields[3] == 1807
        && $Fields[4] == 4
        && $Fields[5] == 2 )
    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '              CARMARTHEN'
        && $Fields[3] == 1808
        && $Fields[4] == 6
        && $Fields[5] == 20 )
    {
        $Fields[10] = 'W';
    }

    if (   $Fields[0] eq '              CARMARTHEN'
        && $Fields[3] == 1808
        && $Fields[4] == 9
        && $Fields[5] == 5 )
    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '              CARMARTHEN'
        && $Fields[3] == 1810
        && $Fields[4] == 6
        && $Fields[5] == 11 )
    {
        $Fields[7] = 'N';
    }

    if (   $Fields[0] eq '              CARMARTHEN'
        && $Fields[3] == 1810
        && $Fields[4] == 8
        && $Fields[5] == 6 )
    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '              CARMARTHEN'
        && $Fields[3] == 1811
        && $Fields[4] == 11
        && $Fields[5] == 2 )
    {
        $Fields[10] = 'W';
    }

    if (   $Fields[0] eq '              CARMARTHEN'
        && $Fields[3] == 1814
        && $Fields[4] == 2
        && $Fields[5] == 21 )
    {
        $Fields[10] = 'W';
    }

    if (   $Fields[0] eq '              CARMARTHEN'
        && $Fields[3] == 1805
        && $Fields[4] == 5
        && $Fields[5] == 28 )
    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '              CARMARTHEN'
        && $Fields[3] == 1817
        && $Fields[4] == 7
        && $Fields[5] >= 30 )
    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '              CARMARTHEN'
        && $Fields[3] == 1803
        && $Fields[4] == 6
        && $Fields[5] == 21 )
    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '              CARMARTHEN'
        && $Fields[3] == 1803
        && $Fields[4] == 4
        && ( $Fields[5] == 6 || $Fields[5] == 7 ) )
    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '              CARMARTHEN'
        && $Fields[3] == 1807
        && $Fields[4] == 10
        && $Fields[5] == 17 )
    {
        $Fields[16] = '30070';
    }
    if (   $Fields[0] eq '              CARMARTHEN'
        && $Fields[3] == 1809
        && $Fields[4] == 5
        && $Fields[5] == 27 )
    {
        $Fields[16] = '29580';
    }
    if (   $Fields[0] eq '              CARMARTHEN'
        && $Fields[3] == 1813
        && $Fields[4] == 11
        && $Fields[5] == 1 )
    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '              CARMARTHEN'
        && $Fields[3] == 1812
        && $Fields[4] == 12
        && $Fields[5] == 7 )
    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '              CARMARTHEN'
        && $Fields[3] == 1818
        && $Fields[4] == 3
        && $Fields[5] >= 17 )
    {
        $Fields[10] = 'W';
    }

    if (   $Fields[0] eq '             BRITANNIA 4'
        && $Fields[3] == 1804
        && $Fields[4] == 8
        && $Fields[5] >= 4
        && $Fields[5] <= 13 )
    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '             BRITANNIA 4'
        && $Fields[3] == 1802
        && $Fields[4] == 11
        && $Fields[5] == 10 )
    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '          WILLIAM PITT 3'
        && $Fields[3] == 1811
        && $Fields[4] == 8
        && $Fields[5] == 3 )
    {
        $Fields[7] = 'S';
    }

    if (   $Fields[0] eq '     SIR WILLIAM PULTNEY'
        && $Fields[3] == 1816
        && $Fields[4] == 5
        && $Fields[5] == 23 )
    {
        $Fields[7] = 'N';
    }

    if (   $Fields[0] eq '     SIR WILLIAM PULTNEY'
        && $Fields[3] == 1816
        && $Fields[4] == 5
        && $Fields[5] == 5 )
    {
        $Fields[10] = 'W';
    }

    if (   $Fields[0] eq '     SIR WILLIAM PULTNEY'
        && $Fields[3] == 1815
        && $Fields[4] == 6
        && $Fields[5] == 25 )
    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '            VANSITTART 4'
        && $Fields[3] == 1823
        && $Fields[4] == 9
        && $Fields[5] == 11 )
    {
        $Fields[7] = 'N';
    }

    if (   $Fields[0] eq '                THAMES 5'
        && $Fields[3] == 1834
        && $Fields[4] == 2
        && $Fields[5] >= 19
        && $Fields[5] <= 24 )
    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '                THAMES 5'
        && $Fields[3] == 1834
        && $Fields[4] == 3
        && $Fields[5] == 22 )
    {
        $Fields[16] = '30150';
    }

    if (   $Fields[0] eq '          DUKE OF YORK 2'
        && $Fields[3] == 1822
        && $Fields[4] == 3
        && $Fields[5] == 1 )
    {
        $Fields[10] = 'W';
    }

    if (   $Fields[0] eq '          DUKE OF YORK 2'
        && $Fields[3] == 1822
        && $Fields[4] == 3
        && $Fields[5] == 6 )
    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '          DUKE OF YORK 2'
        && $Fields[3] == 1823
        && $Fields[4] == 3
        && $Fields[5] == 21 )
    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '          DUKE OF YORK 2'
        && $Fields[3] == 1823
        && $Fields[4] == 3
        && $Fields[5] == 12 )
    {
        $Fields[9] = '28.42';    # Not 38
    }

    if (   $Fields[0] eq '          TAUNTON CASTLE'
        && $Fields[3] == 1794
        && $Fields[4] == 7
        && ( $Fields[5] == 20 || $Fields[5] == 31 ) )
    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '          TAUNTON CASTLE'
        && $Fields[3] == 1800
        && $Fields[4] == 2
        && $Fields[5] == 5 )
    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '          TAUNTON CASTLE'
        && $Fields[3] == 1805
        && $Fields[4] == 4
        && $Fields[5] == 14 )
    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '          TAUNTON CASTLE'
        && $Fields[3] == 1805
        && $Fields[4] == 8
        && $Fields[5] == 28 )
    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '          TAUNTON CASTLE'
        && $Fields[3] == 1794
        && $Fields[4] == 5
        && $Fields[5] == 24 )
    {
        $Fields[9] = '19.22';    # Not 29
    }
    if (   $Fields[0] eq '          TAUNTON CASTLE'
        && $Fields[3] == 1795
        && $Fields[4] == 5
        && $Fields[5] == 22 )
    {
        $Fields[6] = ' 8.55';    # Not 18
    }
    if (   $Fields[0] eq '          TAUNTON CASTLE'
        && $Fields[3] == 1799
        && $Fields[4] == 1
        && $Fields[5] == 1 )
    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '          TAUNTON CASTLE'
        && $Fields[3] == 1794
        && $Fields[4] == 9
        && $Fields[5] == 19 )
    {
        $Fields[9] = '111.00';    # Not 101
    }
    if (   $Fields[0] eq '          TAUNTON CASTLE'
        && $Fields[3] == 1795
        && $Fields[4] == 3
        && $Fields[5] == 28 )
    {
        $Fields[6] = '36.55';     # Not 26
    }
    if (   $Fields[0] eq '          TAUNTON CASTLE'
        && $Fields[3] == 1809
        && $Fields[4] == 5
        && $Fields[5] == 20 )
    {
        $Fields[7] = 'N';
    }

    if (   $Fields[0] eq '        THOMAS GRENVILLE'
        && $Fields[3] == 1818
        && $Fields[4] == 3
        && $Fields[5] == 25 )
    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '        THOMAS GRENVILLE'
        && $Fields[3] == 1818
        && $Fields[4] == 3
        && $Fields[5] == 3 )
    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '        THOMAS GRENVILLE'
        && $Fields[3] == 1817
        && $Fields[4] == 6
        && $Fields[5] == 30 )
    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '        THOMAS GRENVILLE'
        && $Fields[3] == 1818
        && $Fields[4] == 1
        && $Fields[5] == 22 )
    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '        THOMAS GRENVILLE'
        && $Fields[3] == 1817
        && $Fields[4] == 8
        && ( $Fields[5] == 1 || $Fields[5] == 5 ) )
    {
        $Fields[7] = 'S';
    }
    if (   $Fields[0] eq '        THOMAS GRENVILLE'
        && $Fields[3] == 1824
        && $Fields[4] == 1
        && ( $Fields[5] == 22 || $Fields[5] == 23 ) )
    {
        $Fields[7] = 'S';
    }
    if (   $Fields[0] eq '        THOMAS GRENVILLE'
        && $Fields[3] == 1828
        && $Fields[4] == 7
        && $Fields[5] == 12 )
    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '        THOMAS GRENVILLE'
        && $Fields[3] == 1828
        && $Fields[4] == 4
        && $Fields[5] == 14 )
    {
        $Fields[7] = 'S';
    }
    if (   $Fields[0] eq '        THOMAS GRENVILLE'
        && $Fields[3] == 1811
        && $Fields[4] == 8
        && $Fields[5] == 1 )
    {
        $Fields[16] = '29600';
    }
    if (   $Fields[0] eq '        THOMAS GRENVILLE'
        && $Fields[3] == 1815
        && $Fields[4] == 1
        && $Fields[5] == 22 )
    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '        THOMAS GRENVILLE'
        && $Fields[3] == 1810
        && $Fields[4] == 11
        && $Fields[5] == 30 )
    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '        THOMAS GRENVILLE'
        && $Fields[3] == 1809
        && $Fields[4] == 3
        && $Fields[5] == 8 )
    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '        THOMAS GRENVILLE'
        && $Fields[3] == 1827
        && $Fields[4] == 10
        && $Fields[5] == 28 )
    {
        $Fields[6] = '20.23';    # Not 30
    }
    if (   $Fields[0] eq '        THOMAS GRENVILLE'
        && $Fields[3] == 1819
        && $Fields[4] == 7
        && $Fields[5] == 11 )
    {
        $Fields[6] = '37.24';    # Not 27
    }
    if (   $Fields[0] eq '        THOMAS GRENVILLE'
        && $Fields[3] == 1819
        && $Fields[4] == 6
        && $Fields[5] == 26 )
    {
        $Fields[6] = '36.51';    # Not 30
    }
    if (   $Fields[0] eq '        THOMAS GRENVILLE'
        && $Fields[3] == 1819
        && $Fields[4] == 5
        && $Fields[5] == 30 )
    {
        $Fields[6] = '1.31';     # Not 15
    }
    if (   $Fields[0] eq '        THOMAS GRENVILLE'
        && $Fields[3] == 1820
        && $Fields[4] == 4
        && $Fields[5] == 26 )
    {
        $Fields[9] = '0.15';     # Not 6
    }

    if (   $Fields[0] eq '                 UNION 4'
        && $Fields[3] == 1803
        && $Fields[4] == 6
        && $Fields[5] == 22 )
    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '                 UNION 4'
        && $Fields[3] == 1804
        && $Fields[4] == 3
        && $Fields[5] == 16 )
    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '                 UNION 4'
        && $Fields[3] == 1808
        && $Fields[4] == 10 )
    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '                 UNION 4'
        && $Fields[3] == 1808
        && $Fields[4] == 10
        && $Fields[5] == 18 )
    {
        $Fields[9] = '';    # Not 74
    }
    if (   $Fields[0] eq '                 UNION 4'
        && $Fields[3] == 1804
        && $Fields[4] == 2
        && $Fields[5] == 16 )
    {
        $Fields[6] = '8.13';    # Not 18
    }
    if (   $Fields[0] eq '                 UNION 4'
        && $Fields[3] == 1808
        && $Fields[4] == 11
        && $Fields[5] == 14 )
    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '                 UNION 4'
        && $Fields[3] == 1811
        && $Fields[4] == 3
        && $Fields[5] == 17 )
    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '                 UNION 5'
        && $Fields[3] == 1814
        && $Fields[4] == 6
        && $Fields[5] == 13 )
    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '                 UNION 5'
        && $Fields[3] == 1807
        && $Fields[4] == 12
        && $Fields[5] == 23 )
    {
        $Fields[6] = '38.50';    # Not 30
    }
    if (   $Fields[0] eq '                 UNION 5'
        && $Fields[3] == 1807
        && $Fields[4] == 11
        && $Fields[5] == 5 )
    {
        $Fields[9] = '30.50';    # Not 38
    }
    if (   $Fields[0] eq '                 UNION 5'
        && $Fields[3] == 1807
        && $Fields[4] == 11
        && $Fields[5] == 19 )
    {
        $Fields[6] = '28.18';    # Not 20
    }
    if (   $Fields[0] eq '         WILLIAM FAIRLIE'
        && $Fields[3] == 1825
        && $Fields[4] == 3
        && $Fields[5] == 10 )
    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '         WILLIAM FAIRLIE'
        && $Fields[3] == 1824
        && $Fields[4] == 9
        && $Fields[5] == 20 )
    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '         WILLIAM FAIRLIE'
        && $Fields[3] == 1825
        && $Fields[4] == 2
        && $Fields[5] == 6 )
    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '               WINDHAM 2'
        && $Fields[3] == 1817
        && $Fields[4] == 3
        && $Fields[5] == 12 )
    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '            EXPERIMENT 4'
        && $Fields[3] == 1803
        && $Fields[4] == 4
        && $Fields[5] == 14 )
    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '            EXPERIMENT 4'
        && $Fields[3] == 1803
        && $Fields[4] == 3
        && $Fields[5] == 24 )
    {
        $Fields[7] = 'S';
    }
    if (   $Fields[0] eq '            EXPERIMENT 4'
        && $Fields[3] == 1805
        && $Fields[4] == 7
        && $Fields[5] == 24 )
    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '            EXPERIMENT 4'
        && $Fields[3] == 1804
        && $Fields[4] == 10
        && $Fields[5] == 26 )
    {
        $Fields[7] = 'S';
    }
    if (   $Fields[0] eq '            EXPERIMENT 4'
        && $Fields[3] == 1805
        && $Fields[4] == 9
        && $Fields[5] == 8 )
    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '            EXPERIMENT 4'
        && $Fields[3] == 1804
        && $Fields[4] == 10
        && $Fields[5] == 16 )
    {
        $Fields[6] = '22.42';    # Not 32
    }

    if (   $Fields[0] eq '                EXETER 2'
        && $Fields[3] == 1811
        && $Fields[4] == 4
        && $Fields[5] == 13 )
    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '                EXETER 2'
        && $Fields[3] == 1811
        && $Fields[4] == 5
        && $Fields[5] == 27 )
    {
        $Fields[10] = 'W';
    }

    if (   $Fields[0] eq '                EXETER 2'
        && $Fields[3] == 1793
        && ( $Fields[4] == 9 || $Fields[4] == 10 ) )
    {    # Weird case - change in zero meridian to Bombay?
        if ( $Fields[9] =~ /(\d+)\.*(\d*)\.*(\d*)/ ) {
            my ( $Deg, $Min, $Sec ) = ( $1, $2, $3 );
            $Deg += 72;
            $Min += 51;    # Mumbai is at 72 51 E
            if ( $Min > 60 ) {
                $Deg++;
                $Min -= 60;
            }
            unless ( defined($Sec) && $Sec =~ /\d/ ) { $Sec = 0; }
            unless ( defined($Min) && $Min =~ /\d/ ) { $Min = 0; }
            $Fields[9] = sprintf "%d.%d.%d", $Deg, $Min, $Sec;
        }
    }

    if (   $Fields[0] eq '        NORTHUMBERLAND 5'
        && $Fields[3] == 1810
        && $Fields[4] == 3
        && $Fields[5] == 17 )
    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '        NORTHUMBERLAND 5'
        && $Fields[3] == 1810
        && $Fields[4] == 5
        && $Fields[5] == 12 )
    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '        NORTHUMBERLAND 5'
        && $Fields[3] == 1814
        && $Fields[4] == 5
        && $Fields[5] == 17 )
    {
        $Fields[10] = 'W';
    }

    if (   $Fields[0] eq '           HEREFORDSHIRE'
        && $Fields[3] == 1822
        && $Fields[4] == 2
        && $Fields[5] == 15 )
    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '           HEREFORDSHIRE'
        && $Fields[3] == 1822
        && $Fields[4] == 3
        && $Fields[5] == 12 )
    {
        $Fields[9] = '41.00';    # Not 4.1
    }

    if (   $Fields[0] eq '                SURREY 2'
        && $Fields[3] == 1815
        && $Fields[4] == 6
        && $Fields[5] == 30 )
    {
        $Fields[7] = 'S';
    }
    if (   $Fields[0] eq '                SURREY 2'
        && $Fields[3] == 1815
        && $Fields[4] == 3
        && $Fields[5] == 16 )
    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '                 FAIRLIE'
        && $Fields[3] == 1818
        && $Fields[4] == 4
        && $Fields[5] == 3 )
    {
        $Fields[16] = '30300';
    }
    if (   $Fields[0] eq '                 FAIRLIE'
        && $Fields[3] == 1819
        && $Fields[4] == 2
        && $Fields[5] == 21 )
    {
        $Fields[16] = '29900';
    }

    if (   $Fields[0] eq '               EARL HOWE'
        && $Fields[3] == 1803
        && $Fields[4] == 5
        && $Fields[5] == 27 )
    {
        $Fields[16] = '30100';
    }
    if (   $Fields[0] eq '               EARL HOWE'
        && $Fields[3] == 1803
        && $Fields[4] == 7
        && $Fields[5] == 16 )
    {
        $Fields[6] = '37.22';    # Not 32
    }

    if (   $Fields[0] eq '                 ATLAS 4'
        && $Fields[3] == 1815
        && $Fields[4] == 5
        && $Fields[5] == 22 )
    {
        $Fields[16] = '29400';
    }
    if (   $Fields[0] eq '                 ATLAS 4'
        && $Fields[3] == 1815
        && $Fields[4] == 6
        && $Fields[5] == 10 )
    {
        $Fields[16] = '29950';
    }
    if (   $Fields[0] eq '                 ATLAS 4'
        && $Fields[3] == 1815
        && $Fields[4] == 10
        && $Fields[5] == 1 )
    {
        $Fields[16] = '29830';
    }
    if (   $Fields[0] eq '                 ATLAS 4'
        && $Fields[3] == 1816
        && $Fields[4] == 1
        && $Fields[5] == 22 )
    {
        $Fields[16] = '30800';
    }
    if (   $Fields[0] eq '                 ATLAS 4'
        && $Fields[3] == 1816
        && $Fields[4] == 4
        && $Fields[5] == 28 )
    {
        $Fields[16] = '30280';
    }
    if (   $Fields[0] eq '                 ATLAS 4'
        && $Fields[3] == 1816
        && $Fields[4] == 5
        && $Fields[5] == 7 )
    {
        $Fields[16] = '30000';

    }
    if (   $Fields[0] eq '                 ATLAS 4'
        && $Fields[3] == 1813
        && $Fields[4] == 4
        && $Fields[5] == 28 )
    {
        $Fields[10] = 'E';

    }
    if (   $Fields[0] eq '                 ATLAS 4'
        && $Fields[3] == 1814
        && $Fields[4] == 4
        && $Fields[5] == 26 )
    {
        $Fields[9] = '';

    }
    if (   $Fields[0] eq '                 ATLAS 4'
        && $Fields[3] == 1822
        && $Fields[4] == 8
        && $Fields[5] == 5 )
    {
        $Fields[6] = '';

    }
    if (   $Fields[0] eq '                 ATLAS 4'
        && $Fields[3] == 1825
        && $Fields[4] == 5
        && $Fields[5] == 18 )
    {
        $Fields[9] = '';

    }
    if (   $Fields[0] eq '                 ATLAS 4'
        && $Fields[3] == 1825
        && $Fields[4] == 5
        && $Fields[5] == 27 )
    {
        $Fields[9] = '';

    }
    if (   $Fields[0] eq '                 ATLAS 4'
        && $Fields[3] == 1827
        && $Fields[4] == 6
        && $Fields[5] == 6 )
    {
        $Fields[9] = '';

    }
    if (   $Fields[0] eq '                 ATLAS 4'
        && $Fields[3] == 1828
        && $Fields[4] == 2
        && $Fields[5] == 28 )
    {
        $Fields[9] = '';

    }

    if (   $Fields[0] eq '               WINDSOR 2'
        && $Fields[3] == 1833
        && $Fields[4] == 1
        && $Fields[5] == 27 )
    {
        $Fields[16] = '30000';
    }
    if (   $Fields[0] eq '               WINDSOR 2'
        && $Fields[3] == 1833
        && $Fields[4] == 5
        && $Fields[5] == 14 )
    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '          GENERAL HARRIS'
        && $Fields[3] == 1816
        && $Fields[4] == 1
        && $Fields[5] == 28 )
    {
        $Fields[16] = '29900';
    }
    if (   $Fields[0] eq '          GENERAL HARRIS'
        && $Fields[3] == 1830
        && $Fields[4] == 3
        && ( $Fields[5] == 21 || $Fields[5] == 23 ) )
    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '          GENERAL HARRIS'
        && $Fields[3] == 1831
        && $Fields[4] == 2
        && $Fields[5] == 12 )
    {
        $Fields[10] = 'W';
    }

    if (   $Fields[0] eq 'PRINCESS CHARLOTTE OF WA'
        && $Fields[3] == 1817
        && $Fields[4] == 4
        && $Fields[5] == 6 )
    {
        $Fields[16] = '30500';
    }

    if (   $Fields[0] eq '          MARQUIS CAMDEN'
        && $Fields[3] == 1824
        && $Fields[4] == 9
        && $Fields[5] == 8 )
    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '          MARQUIS CAMDEN'
        && $Fields[3] == 1824
        && $Fields[4] == 4
        && $Fields[5] == 28 )
    {
        $Fields[16] = '30200';
    }

    if (   $Fields[0] eq '    ABERCROMBIE ROBINSON'
        && $Fields[3] == 1829
        && $Fields[4] == 4
        && $Fields[5] == 7 )
    {
        $Fields[16] = '30500';
    }

    if (   $Fields[0] eq '                  ASTELL'
        && $Fields[3] == 1812
        && $Fields[4] == 3
        && $Fields[5] == 27 )
    {
        $Fields[16] = '30200';
    }
    if (   $Fields[0] eq '                  ASTELL'
        && $Fields[3] == 1812
        && $Fields[4] == 12
        && $Fields[5] == 1 )
    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '              CARNATIC 3'
        && $Fields[3] == 1811
        && $Fields[4] == 5
        && $Fields[5] == 30 )
    {
        $Fields[16] = '29700';
    }

    if (   $Fields[0] eq '                MACQUEEN'
        && $Fields[3] == 1832
        && $Fields[4] == 5
        && $Fields[5] == 8 )
    {
        $Fields[16] = '29450';
    }

    if (   $Fields[0] eq '                ARNISTON'
        && $Fields[3] == 1806
        && $Fields[4] == 7
        && $Fields[5] == 19 )
    {
        $Fields[7] = 'S';
    }

    if (   $Fields[0] eq '          CITY OF LONDON'
        && $Fields[3] == 1803
        && $Fields[4] == 5
        && $Fields[5] == 13 )
    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '          CITY OF LONDON'
        && $Fields[3] == 1803
        && $Fields[4] == 7
        && $Fields[5] == 5 )
    {
        $Fields[7] = 'N';
    }

    if (   $Fields[0] eq '          CITY OF LONDON'
        && $Fields[3] == 1804
        && $Fields[4] == 8
        && $Fields[5] == 24 )
    {
        $Fields[7] = 'N';
    }

    if (   $Fields[0] eq '          CITY OF LONDON'
        && $Fields[3] == 1807
        && $Fields[4] == 7
        && $Fields[5] == 5 )
    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '          CITY OF LONDON'
        && $Fields[3] == 1803
        && $Fields[4] == 6
        && $Fields[5] == 8 )
    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '                 CABALVA'
        && $Fields[3] == 1813
        && $Fields[4] == 5
        && $Fields[5] == 3 )
    {
        $Fields[7] = 'N';
    }

    if (   $Fields[0] eq '                 CABALVA'
        && $Fields[3] == 1813
        && $Fields[4] == 3
        && $Fields[5] == 22 )
    {
        $Fields[10] = 'W';
    }

    if (   $Fields[0] eq '             GEORGIANA 1'
        && $Fields[3] == 1805
        && $Fields[4] == 6
        && $Fields[5] == 21 )
    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '      HENRY ADDINGTON  2'
        && $Fields[3] == 1801
        && $Fields[4] == 8
        && ( $Fields[5] >= 14 && $Fields[5] <= 23 ) )
    {    # Change in zero meridian to Bombay?
        if ( $Fields[9] =~ /(\d+)\.*(\d*)\.*(\d*)/ ) {
            my ( $Deg, $Min, $Sec ) = ( $1, $2, $3 );
            $Deg += 72;
            $Min += 51;    # Mumbai is at 72 51 E
            if ( $Min > 60 ) {
                $Deg++;
                $Min -= 60;
            }
            unless ( defined($Sec) && $Sec =~ /\d/ ) { $Sec = 0; }
            unless ( defined($Min) && $Min =~ /\d/ ) { $Min = 0; }
            $Fields[9] = sprintf "%d.%d.%d", $Deg, $Min, $Sec;
        }
    }

    if (   $Fields[0] eq '      HENRY ADDINGTON  2'
        && $Fields[3] == 1812
        && $Fields[4] == 3
        && ( $Fields[5] >= 1 && $Fields[5] <= 5 ) )

    {
        $Fields[10] = 'E';
        $Fields[7]  = 'S';
    }

    if (   $Fields[0] eq '      HENRY ADDINGTON  2'
        && $Fields[3] == 1815
        && $Fields[4] == 4
        && $Fields[5] == 8 )

    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '            PROVIDENCE 1'
        && $Fields[3] == 1817
        && $Fields[4] == 5
        && $Fields[5] == 26 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '            PROVIDENCE 1'
        && $Fields[3] == 1816
        && $Fields[4] == 4
        && $Fields[5] == 15 )

    {
        $Fields[7] = 'N';
    }

    if (   $Fields[0] eq '                THAMES 5'
        && $Fields[3] == 1814
        && $Fields[4] == 2
        && $Fields[5] == 7 )

    {
        $Fields[3] = 1834;
    }
    if (   $Fields[0] eq '                THAMES 5'
        && $Fields[3] == 1833
        && $Fields[4] == 4
        && $Fields[5] == 17 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '                THAMES 5'
        && $Fields[3] == 1833
        && $Fields[4] == 4
        && $Fields[5] == 18 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '                THAMES 5'
        && $Fields[3] == 1834
        && $Fields[4] == 2
        && $Fields[5] == 7 )

    {
        $Fields[6] = '';
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '         WILLIAM FAIRLIE'
        && $Fields[3] == 1814
        && $Fields[4] == 9
        && $Fields[5] == 4 )

    {
        $Fields[3] = 1824;
    }

    if (   $Fields[0] eq '               LONDON 14'
        && $Fields[3] == 1824
        && $Fields[4] == 1
        && $Fields[5] == 24 )

    {
        $Fields[3] = 1827;
    }
    if (   $Fields[0] eq '               LONDON 14'
        && $Fields[3] == 1821
        && $Fields[4] == 1
        && $Fields[5] == 9 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '               LONDON 14'
        && $Fields[3] == 1832
        && $Fields[4] == 12
        && $Fields[5] == 13 )

    {
        $Fields[9] = '109.40';    # Not 119
    }
    if (   $Fields[0] eq '               LONDON 14'
        && $Fields[3] == 1826
        && $Fields[4] == 7
        && $Fields[5] == 3 )

    {
        $Fields[9] = '38.10';     # Not 28
    }
    if (   $Fields[0] eq '               LONDON 14'
        && $Fields[3] == 1832
        && $Fields[4] == 5
        && $Fields[5] == 2 )

    {
        $Fields[9] = '32.07';     # Not 3
    }

    if (   $Fields[0] eq '                MACQUEEN'
        && $Fields[3] == 1814
        && $Fields[4] == 8
        && $Fields[5] == 28 )

    {
        $Fields[3] = '    ';
    }
    if (   $Fields[0] eq '                MACQUEEN'
        && $Fields[3] == 1831
        && $Fields[4] == 2
        && $Fields[5] == 8 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '                MACQUEEN'
        && $Fields[3] == 1831
        && $Fields[4] == 3
        && $Fields[5] == 17 )

    {
        $Fields[6] = '43.45';
    }
    if (   $Fields[0] eq '                MACQUEEN'
        && $Fields[3] == 1830
        && $Fields[4] == 12
        && $Fields[5] == 11 )

    {
        $Fields[6] = '00.53';    # Not 53
    }
    if (   $Fields[0] eq '                RELIANCE'
        && $Fields[3] == 1833
        && $Fields[4] == 5
        && $Fields[5] == 24 )

    {
        $Fields[6] = '27.37';    # Not 37
    }
    if (   $Fields[0] eq '            ROCKINGHAM 1'
        && $Fields[3] == 1800
        && $Fields[4] == 11
        && $Fields[5] == 16 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '            ROCKINGHAM 1'
        && $Fields[3] == 1802
        && $Fields[4] == 4
        && $Fields[5] == 18 )

    {
        $Fields[9] = '18.56';    # Not 28
    }
    if (   $Fields[0] eq '            ROCKINGHAM 1'
        && $Fields[3] == 1800
        && $Fields[4] == 8
        && $Fields[5] == 27 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '            ROCKINGHAM 1'
        && $Fields[3] == 1800
        && $Fields[4] == 9
        && $Fields[5] == 4 )

    {
        $Fields[9] = '';    # Not 40
    }

    if (   $Fields[0] eq '              CARMARTHEN'
        && $Fields[3] == 1807
        && $Fields[4] == 5
        && $Fields[5] == 2 )

    {
        $Fields[6] = '    ';
    }
    if (   $Fields[0] eq '              CARMARTHEN'
        && $Fields[3] == 1808
        && $Fields[4] == 8
        && $Fields[5] == 3 )

    {
        $Fields[6] = '    ';
    }
    if (   $Fields[0] eq '              CARMARTHEN'
        && $Fields[3] == 1809
        && $Fields[4] == 8
        && $Fields[5] == 9 )

    {
        $Fields[9] = '    ';
    }
    if (   $Fields[0] eq '              CARMARTHEN'
        && $Fields[3] == 1809
        && $Fields[4] == 7
        && $Fields[5] == 18 )

    {
        $Fields[7] = 'S';
    }
    if (   $Fields[0] eq '              CARMARTHEN'
        && $Fields[3] == 1809
        && $Fields[4] == 7
        && $Fields[5] == 7 )

    {
        $Fields[9] = '    ';
    }
    if (   $Fields[0] eq '              CARMARTHEN'
        && $Fields[3] == 1807
        && $Fields[4] == 7
        && $Fields[5] == 18 )

    {
        $Fields[3] = '    ';
    }
    if (   $Fields[0] eq '              CARMARTHEN'
        && $Fields[3] == 1811
        && $Fields[4] == 4
        && $Fields[5] == 28 )

    {
        $Fields[6] = '    ';
    }
    if (   $Fields[0] eq '              CARMARTHEN'
        && $Fields[3] == 1811
        && $Fields[4] == 4
        && $Fields[5] == 8 )

    {
        $Fields[6] = '    ';
    }
    if (   $Fields[0] eq '              CARMARTHEN'
        && $Fields[3] == 1811
        && $Fields[4] == 4
        && $Fields[5] == 4 )

    {
        $Fields[7]  = 'S';
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '              CARMARTHEN'
        && $Fields[3] == 1814
        && $Fields[4] == 2
        && $Fields[5] == 14 )

    {
        $Fields[7]  = 'S';
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '              CARMARTHEN'
        && $Fields[3] == 1817
        && $Fields[4] == 8
        && $Fields[5] == 23 )

    {
        $Fields[6] = '    ';
    }

    if (   $Fields[0] eq '               MINERVA 7'
        && $Fields[3] == 1814
        && $Fields[4] == 4
        && $Fields[5] == 12 )

    {
        $Fields[3] = '1818';
    }
    if (   $Fields[0] eq '               MINERVA 7'
        && $Fields[3] == 1818
        && $Fields[4] == 4
        && $Fields[5] == 22 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '          CITY OF LONDON'
        && $Fields[3] == 1792
        && $Fields[4] == 4
        && $Fields[5] == 3 )

    {
        $Fields[3] = '    ';
    }

    if (   $Fields[0] eq '             GENERAL KYD'
        && $Fields[3] == 1809
        && $Fields[4] == 3
        && $Fields[5] == 1 )

    {
        $Fields[3] = '    ';
    }
    if (   $Fields[0] eq '             GENERAL KYD'
        && $Fields[3] == 1819
        && $Fields[4] == 4
        && $Fields[5] == 9 )

    {
        $Fields[3] = '1829';
    }
    if (   $Fields[0] eq '             GENERAL KYD'
        && $Fields[3] == 1830
        && $Fields[4] == 6
        && $Fields[5] == 29 )

    {
        $Fields[10] = 'W';
    }

    if (   $Fields[0] eq '                  BENGAL'
        && $Fields[3] == 1806
        && $Fields[4] == 6
        && $Fields[5] == 16 )

    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '             ALEXANDER 3'
        && $Fields[3] == 1807
        && $Fields[4] == 3 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '                  COUTTS'
        && $Fields[3] == 1809
        && $Fields[4] == 5
        && $Fields[5] == 20 )

    {
        $Fields[7]  = 'S';
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '                  COUTTS'
        && $Fields[3] == 1813
        && $Fields[4] == 1
        && $Fields[5] == 6 )

    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '               CUFFNELLS'
        && $Fields[3] == 1802
        && $Fields[4] == 5
        && $Fields[5] == 2 )

    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '               CUFFNELLS'
        && $Fields[3] == 1804
        && $Fields[4] == 9
        && $Fields[5] == 17 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '               CUFFNELLS'
        && $Fields[3] == 1805
        && $Fields[4] == 6
        && $Fields[5] == 28 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '         LADY CARRINGTON'
        && $Fields[3] == 1873 )

    {
        $Fields[3] = '1813';
    }
    if (   $Fields[0] eq '         LADY CARRINGTON'
        && $Fields[3] == 1817
        && $Fields[4] == 2
        && $Fields[5] == 25 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '         LADY CARRINGTON'
        && $Fields[3] == 1812
        && $Fields[4] == 9
        && $Fields[5] == 15 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '         LADY CARRINGTON'
        && $Fields[3] == 1814
        && $Fields[4] == 11
        && $Fields[5] == 4 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '         LADY CARRINGTON'
        && $Fields[3] == 1817
        && $Fields[4] == 5
        && $Fields[5] == 27 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '         LADY CARRINGTON'
        && $Fields[3] == 1817
        && $Fields[4] == 6
        && $Fields[5] == 12 )

    {
        $Fields[7]  = 'S';
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '         LADY CARRINGTON'
        && $Fields[3] == 1810
        && $Fields[4] == 1
        && $Fields[5] == 20 )

    {
        $Fields[7] = 'S';
    }
    if (   $Fields[0] eq '         LADY CARRINGTON'
        && $Fields[3] == 1810
        && $Fields[4] == 9
        && $Fields[5] == 27 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '               PHOENIX 3'
        && $Fields[3] == 1795
        && $Fields[4] == 1
        && $Fields[5] == 7 )

    {
        $Fields[7] = 'S';
    }
    if (   $Fields[0] eq '               PHOENIX 5'
        && $Fields[3] == 1808
        && $Fields[4] == 3
        && $Fields[5] == 13 )

    {
        $Fields[6] = '7.19';     # -= 10
        $Fields[9] = '16.52';    # +=10
    }
    if (   $Fields[0] eq '               PHOENIX 5'
        && $Fields[3] == 1815
        && $Fields[4] == 6
        && $Fields[5] == 7 )

    {
        $Fields[6] = '  ';
    }
    if (   $Fields[0] eq '               PHOENIX 5'
        && $Fields[3] == 1807
        && $Fields[4] == 3
        && $Fields[5] == 13 )

    {
        $Fields[6] = '  ';
    }
    if (   $Fields[0] eq '               PHOENIX 5'
        && $Fields[3] == 1818
        && $Fields[4] == 8
        && $Fields[5] == 22 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '               PHOENIX 5'
        && $Fields[3] == 1819
        && $Fields[4] == 2
        && $Fields[5] == 27 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '               PHOENIX 5'
        && $Fields[3] == 1815
        && $Fields[4] == 6
        && $Fields[5] == 7 )

    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '                SURREY 1'
        && $Fields[3] == 1809
        && $Fields[4] == 12
        && $Fields[5] == 28 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '                SURREY 1'
        && $Fields[3] == 1810
        && $Fields[4] == 5
        && $Fields[5] == 3 )

    {
        $Fields[7]  = 'S';
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '                SURREY 1'
        && $Fields[3] == 1809
        && $Fields[4] == 12
        && $Fields[5] == 28 )

    {
        $Fields[6]  = '';
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '           WALMER CASTLE'
        && $Fields[3] == 1796
        && $Fields[4] == 10
        && $Fields[5] == 28 )

    {
        $Fields[7] = 'S';
    }
    if (   $Fields[0] eq '                WARLEY 1'
        && $Fields[3] == 1794
        && $Fields[4] == 7
        && $Fields[5] == 2 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '                WARLEY 2'
        && $Fields[3] == 1813
        && $Fields[4] == 10
        && $Fields[5] == 17 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '                WARLEY 2'
        && $Fields[3] == 1809
        && $Fields[4] == 4
        && $Fields[5] == 7 )

    {
        $Fields[9] = '105.39';    # += 100
    }
    if (   $Fields[0] eq '         BUCKINGHAMSHIRE'
        && $Fields[3] == 1820
        && $Fields[4] == 7
        && $Fields[5] == 20 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '         BUCKINGHAMSHIRE'
        && $Fields[3] == 1821
        && $Fields[4] == 4
        && $Fields[5] == 5 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '         BUCKINGHAMSHIRE'
        && $Fields[3] == 1824
        && $Fields[4] == 5
        && $Fields[5] == 28 )

    {
        $Fields[9] = '40.15';    # *=10
    }
    if (   $Fields[0] eq '           DAVID SCOTT 2'
        && $Fields[3] == 1807
        && $Fields[4] == 4
        && $Fields[5] == 15 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '                  BENGAL'
        && $Fields[3] == 1806
        && $Fields[4] == 5
        && $Fields[5] == 12 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '               GLATTON 4'
        && $Fields[3] == 1807
        && $Fields[4] == 9
        && $Fields[5] == 14 )

    {
        $Fields[9] = '24.54';    # not 84
    }
    if (   $Fields[0] eq '               GLATTON 4'
        && $Fields[3] == 1807
        && $Fields[4] == 11
        && $Fields[5] == 6 )

    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '               GLATTON 4'
        && $Fields[3] == 1814
        && $Fields[4] == 7
        && $Fields[5] == 17 )

    {
        $Fields[6] = '37.05';    # not 27
    }
    if (   $Fields[0] eq '               GLATTON 4'
        && $Fields[3] == 1807
        && $Fields[4] == 12
        && $Fields[5] == 27 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '               GLATTON 4'
        && $Fields[3] == 1806
        && $Fields[4] == 12
        && $Fields[5] == 6 )

    {
        $Fields[9] = '108.05';    # not 48
    }
    if (   $Fields[0] eq '               GLATTON 4'
        && $Fields[3] == 1807
        && $Fields[4] == 12
        && $Fields[5] == 27 )

    {
        $Fields[9] = '';    
    }
    if (   $Fields[0] eq '               GLATTON 4'
        && $Fields[3] == 1807
        && $Fields[4] == 12
        && $Fields[5] == 20 )

    {
        $Fields[6] = '';    
    }
    if (   $Fields[0] eq '               GLATTON 4'
        && $Fields[3] == 1807
        && $Fields[4] == 12
        && $Fields[5] == 21 )

    {
        $Fields[6] = '';    
    }
    if (   $Fields[0] eq '               GLATTON 4'
        && $Fields[3] == 1807
        && $Fields[4] == 12
        && $Fields[5] == 24 )

    {
        $Fields[6] = '';    
    }
    
    if (   $Fields[0] eq '                  HOPE 2'
        && $Fields[3] == 1798
        && $Fields[4] == 8
        && $Fields[5] >= 4 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '                  HOPE 2'
        && $Fields[3] == 1802
        && $Fields[4] == 1
        && $Fields[5] == 22 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '                  HOPE 2'
        && $Fields[3] == 1801
        && $Fields[4] == 4
        && $Fields[5] == 3 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '          ROYAL GEORGE 4'
        && $Fields[3] == 1817
        && $Fields[4] == 8
        && $Fields[5] == 28 )

    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '          ROYAL GEORGE 5'
        && $Fields[3] == 1823
        && $Fields[4] == 1
        && $Fields[5] == 13 )

    {
        $Fields[7] = 'S';
    }
    if (   $Fields[0] eq '                 WEXFORD'
        && $Fields[3] == 1808
        && $Fields[4] == 4
        && $Fields[5] == 25 )

    {
        $Fields[7] = 'N';
        $Fields[9] = '72.25';    # not 12
    }
    if (   $Fields[0] eq '                 WEXFORD'
        && $Fields[3] == 1808
        && $Fields[4] == 8
        && $Fields[5] == 26 )

    {
        $Fields[7] = 'N';
        $Fields[9] = '72.50';    # not 12
    }
    if (   $Fields[0] eq '   MARCHIONESS OF EXETER'
        && $Fields[3] == 1813
        && $Fields[4] == 11
        && $Fields[5] == 21 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '   MARCHIONESS OF EXETER'
        && $Fields[3] == 1811
        && $Fields[4] == 9
        && $Fields[5] == 15 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '   MARCHIONESS OF EXETER'
        && $Fields[3] == 1813
        && $Fields[4] == 4
        && $Fields[5] == 15 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '   MARCHIONESS OF EXETER'
        && $Fields[3] == 1813
        && $Fields[4] == 4
        && $Fields[5] == 17 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '                ARNISTON'
        && $Fields[3] == 1810
        && $Fields[4] == 1
        && $Fields[5] == 23 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '                ARNISTON'
        && $Fields[3] == 1811
        && $Fields[4] == 2
        && $Fields[5] == 15 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '                ARNISTON'
        && $Fields[3] == 1805
        && $Fields[4] == 9
        && $Fields[5] == 5 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '                ARNISTON'
        && $Fields[3] == 1805
        && $Fields[4] == 4
        && $Fields[5] == 22 )

    {
        $Fields[6] = '00.16';    # Minutes not degrees
    }
    if (   $Fields[0] eq '                ARNISTON'
        && $Fields[3] == 1811
        && $Fields[4] == 2
        && $Fields[5] == 27 )

    {
        $Fields[6] = '00.15';    # Minutes not degrees
    }
    if (   $Fields[0] eq '                 CABALVA'
        && $Fields[3] == 1813
        && $Fields[4] == 2
        && $Fields[5] == 4 )

    {
        $Fields[7] = 'S';
    }
    if (   $Fields[0] eq '                 CABALVA'
        && $Fields[3] == 1816
        && $Fields[4] == 12
        && $Fields[5] == 23 )
    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '                 CABALVA'
        && $Fields[3] == 1817
        && $Fields[4] == 3
        && $Fields[5] == 7 )
    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '              CARNATIC 2'
        && $Fields[3] == 1794
        && $Fields[4] == 9
        && $Fields[5] == 14 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '              CARNATIC 2'
        && $Fields[3] == 1794
        && $Fields[4] == 7
        && $Fields[5] == 1 )

    {
        $Fields[9] = '27.20';    # Not 77
    }
    if (   $Fields[0] eq '              CARNATIC 3'
        && $Fields[3] == 1817
        && $Fields[4] == 8
        && $Fields[5] == 20 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '              CARNATIC 3'
        && $Fields[3] == 1818
        && $Fields[4] == 4
        && $Fields[5] == 5 )

    {
        $Fields[7] = 'S';
    }
    if (   $Fields[0] eq '              CARNATIC 3'
        && $Fields[3] == 1815
        && $Fields[4] == 7
        && $Fields[5] == 28 )

    {
        $Fields[6] = '37.34';    # Not 31
    }
    if (   $Fields[0] eq '              CARNATIC 3'
        && $Fields[3] == 1811
        && $Fields[4] == 6
        && $Fields[5] == 3 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '              CARNATIC 3'
        && $Fields[3] == 1812
        && $Fields[4] == 2
        && $Fields[5] == 18 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '              CARNATIC 3'
        && $Fields[3] == 1812
        && $Fields[4] == 2
        && $Fields[5] == 29 )

    {
        $Fields[10] = 'W';
    }

    if (   $Fields[0] eq '          CITY OF LONDON'
        && $Fields[3] == 1813
        && $Fields[4] == 4
        && $Fields[5] == 1 )

    {
        $Fields[6] = '00.46';    # Minutes not Degrees
    }
    if (   $Fields[0] eq '          CITY OF LONDON'
        && $Fields[3] == 1808
        && $Fields[4] == 3
        && $Fields[5] == 17 )

    {
        $Fields[9] = '81.50';    # Not 71
    }
    if (   $Fields[0] eq '          CITY OF LONDON'
        && $Fields[3] == 1808
        && $Fields[4] == 6
        && $Fields[5] == 5 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '          CITY OF LONDON'
        && $Fields[3] == 1808
        && $Fields[4] == 6
        && $Fields[5] == 8 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '          CITY OF LONDON'
        && $Fields[3] == 1801
        && $Fields[4] == 8
        && $Fields[5] == 4 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '          CITY OF LONDON'
        && $Fields[3] == 1801
        && $Fields[4] == 10
        && $Fields[5] == 7 )

    {
        $Fields[9] = '33.50';    # Not 23
    }
    if (   $Fields[0] eq '       HENRY ADDINGTON 1'
        && $Fields[3] == 1796
        && $Fields[4] == 11
        && $Fields[5] == 4 )

    {
        $Fields[7] = 'S';
        $Fields[9] = '17.01';    # Not 87
    }
    if (   $Fields[0] eq '       HENRY ADDINGTON 1'
        && $Fields[3] == 1796
        && $Fields[4] == 9
        && $Fields[5] == 14 )

    {
        $Fields[6] = '35.00';    # Not 25
    }
    if (   $Fields[0] eq '       HENRY ADDINGTON 1'
        && $Fields[3] == 1796
        && $Fields[4] == 9
        && $Fields[5] == 15 )

    {
        $Fields[6] = '34.51';    # Not 24
    }
    if (   $Fields[0] eq '      HENRY ADDINGTON  2'
        && $Fields[3] == 1802
        && $Fields[4] == 1
        && $Fields[5] == 30 )

    {
        $Fields[9] = '102.39';    # +=100
    }
    if (   $Fields[0] eq '      HENRY ADDINGTON  2'
        && $Fields[3] == 1815
        && $Fields[4] == 3
        && $Fields[5] == 10 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '      HENRY ADDINGTON  2'
        && $Fields[3] == 1805
        && $Fields[4] == 9
        && $Fields[5] == 3 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '            PROVIDENCE 1'
        && $Fields[3] == 1816
        && $Fields[4] == 10
        && $Fields[5] == 30 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '            PROVIDENCE 1'
        && $Fields[3] == 1816
        && $Fields[4] == 11
        && $Fields[5] == 11 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '       ROYAL CHARLOTTE 5'
        && $Fields[3] == 1796
        && $Fields[4] == 11
        && $Fields[5] == 4 )

    {
        $Fields[9] = '00.39';    # Minutes, not degrees
    }
    if (   $Fields[0] eq '       ROYAL CHARLOTTE 5'
        && $Fields[3] == 1806
        && $Fields[4] == 9
        && $Fields[5] == 3 )

    {
        $Fields[6] = '';         #
    }
    if (   $Fields[0] eq '       ROYAL CHARLOTTE 5'
        && $Fields[3] == 1810
        && $Fields[4] == 7
        && ( $Fields[5] == 15 || $Fields[5] == 16 ) )

    {
        $Fields[6] = '';
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '           THOMAS COUTTS'
        && $Fields[3] == 1829
        && $Fields[4] == 2
        && $Fields[5] == 17 )

    {
        $Fields[6] = '21.10';    # Not 31
    }
    if (   $Fields[0] eq '           THOMAS COUTTS'
        && $Fields[3] == 1824
        && $Fields[4] == 12
        && $Fields[5] == 19 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '           THOMAS COUTTS'
        && $Fields[3] == 1824
        && $Fields[4] == 4
        && $Fields[5] == 24 )

    {
        $Fields[9] = '';    #
    }
    if (   $Fields[0] eq '           THOMAS COUTTS'
        && $Fields[3] == 1832
        && $Fields[4] == 3
        && $Fields[5] == 27 )

    {
        $Fields[9] = '';    #
    }
    if (   $Fields[0] eq '                ALFRED 2'
        && $Fields[3] == 1807
        && $Fields[4] == 10
        && $Fields[5] == 22 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '                ALFRED 2'
        && $Fields[3] == 1810
        && $Fields[4] == 6
        && $Fields[5] == 5 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '              CARMARTHEN'
        && $Fields[3] == 1801
        && $Fields[4] == 7
        && $Fields[5] == 18 )

    {
        $Fields[7] = 'S';
    }
    if (   $Fields[0] eq '              CARMARTHEN'
        && $Fields[3] == 1803
        && $Fields[4] == 6
        && $Fields[5] == 4 )

    {
        $Fields[7] = 'S';
    }
    if (   $Fields[0] eq '              CARMARTHEN'
        && $Fields[3] == 1804
        && $Fields[4] == 3
        && $Fields[5] == 9 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '              CARMARTHEN'
        && $Fields[3] == 1803
        && $Fields[4] == 12
        && $Fields[5] == 29 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '              CARMARTHEN'
        && $Fields[3] == 1811
        && $Fields[4] == 4
        && $Fields[5] == 4 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '              CARMARTHEN'
        && $Fields[3] == 1809
        && $Fields[4] == 5
        && $Fields[5] == 21 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '              CARMARTHEN'
        && $Fields[3] == 1811
        && $Fields[4] == 9
        && $Fields[5] == 26 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '              CARMARTHEN'
        && $Fields[3] == 1803
        && $Fields[4] == 2
        && $Fields[5] == 10 )

    {
        $Fields[7]  = 'N';
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '              CARMARTHEN'
        && $Fields[3] == 1813
        && $Fields[4] == 10
        && $Fields[5] == 27 )

    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '              CARMARTHEN'
        && $Fields[3] == 1814
        && $Fields[4] == 2
        && $Fields[5] == 14 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '             DORSETSHIRE'
        && $Fields[3] == 1815
        && $Fields[4] == 6
        && $Fields[5] == 20 )

    {
        $Fields[6] = '49.36';    # Not 19
    }
    if (   $Fields[0] eq '     DUKE OF BUCCLEUGH 2'
        && $Fields[3] == 1832
        && $Fields[4] == 3
        && $Fields[5] == 29 )

    {
        $Fields[6] = '18.05';    # Not 10
    }
    if (   $Fields[0] eq '                EXETER 2'
        && $Fields[3] == 1801
        && $Fields[4] == 9
        && $Fields[5] == 18 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '                EXETER 2'
        && $Fields[3] == 1804
        && $Fields[4] == 6
        && $Fields[5] == 7 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '                EXETER 2'
        && $Fields[3] == 1794
        && $Fields[4] == 5
        && $Fields[5] == 18 )

    {
        $Fields[6] = '33.28';
    }
    if (   $Fields[0] eq '         LORD MELVILLE 1'
        && $Fields[3] == 1804
        && $Fields[4] == 10
        && $Fields[5] == 21 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '              LORD ELDON'
        && $Fields[3] == 1806
        && $Fields[4] == 8
        && $Fields[5] == 14 )

    {
        $Fields[9] = '29.28';    # Not 39
    }
    if (   $Fields[0] eq '              LORD ELDON'
        && $Fields[3] == 1810
        && $Fields[4] == 5
        && $Fields[5] == 12 )

    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '              LORD ELDON'
        && $Fields[3] == 1813
        && $Fields[4] == 6
        && $Fields[5] == 13 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '              LORD ELDON'
        && $Fields[3] == 1813
        && $Fields[4] == 7
        && $Fields[5] == 29 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '               MINERVA 1'
        && $Fields[3] == 1794
        && $Fields[4] == 7
        && $Fields[5] == 19 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '               MINERVA 1'
        && $Fields[3] == 1793
        && $Fields[4] == 8
        && $Fields[5] == 21 )

    {
        $Fields[9] = '106.00';
    }
    if (   $Fields[0] eq '               MINERVA 1'
        && $Fields[3] == 1793
        && $Fields[4] == 6
        && $Fields[5] == 6 )

    {
        $Fields[9] = '27.51';    # Not 17
    }
    if (   $Fields[0] eq '               MINERVA 7'
        && $Fields[3] == 1825
        && $Fields[4] == 8
        && $Fields[5] == 19 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '               MINERVA 7'
        && $Fields[3] == 1827
        && $Fields[4] == 5
        && $Fields[5] == 16 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '               MINERVA 7'
        && $Fields[3] == 1818
        && $Fields[4] == 2
        && $Fields[5] == 25 )

    {
        $Fields[9] = '78.50';    # Not 7
    }
    if (   $Fields[0] eq '               MINERVA 7'
        && $Fields[3] == 1821
        && $Fields[4] == 7
        && $Fields[5] == 21 )

    {
        $Fields[9] = '90.46';    # Not 80
    }
    if (   $Fields[0] eq '               MINERVA 7'
        && $Fields[3] == 1818
        && $Fields[4] == 4
        && $Fields[5] == 22 )

    {
        $Fields[9] = '';
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '               MINERVA 7'
        && $Fields[3] == 1818
        && $Fields[4] == 4
        && $Fields[5] == 22 )

    {
        $Fields[9] = '22.20';    # Not 32
    }
    if (   $Fields[0] eq '               MINERVA 7'
        && $Fields[3] == 1831
        && $Fields[4] == 7
        && $Fields[5] == 7 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '        NORTHUMBERLAND 5'
        && $Fields[3] == 1809
        && $Fields[4] == 2
        && $Fields[5] == 16 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '        NORTHUMBERLAND 5'
        && $Fields[3] == 1808
        && $Fields[4] == 5
        && $Fields[5] == 21 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '        NORTHUMBERLAND 5'
        && $Fields[3] == 1815
        && $Fields[4] == 4
        && $Fields[5] == 8 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '        NORTHUMBERLAND 5'
        && $Fields[3] == 1817
        && $Fields[4] == 5
        && $Fields[5] == 8 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '        NORTHUMBERLAND 5'
        && $Fields[3] == 1818
        && $Fields[4] == 4
        && $Fields[5] == 17 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '        NORTHUMBERLAND 5'
        && $Fields[3] == 1815
        && $Fields[4] == 8
        && $Fields[5] == 28 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '        NORTHUMBERLAND 5'
        && $Fields[3] == 1818
        && $Fields[4] == 1
        && $Fields[5] == 24 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '        NORTHUMBERLAND 5'
        && $Fields[3] == 1805
        && $Fields[4] == 8
        && $Fields[5] == 23 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '        NORTHUMBERLAND 5'
        && $Fields[3] == 1810
        && $Fields[4] == 3
        && $Fields[5] == 15 )

    {
        $Fields[10] = 'W';
        $Fields[7]  = 'N';
    }
    if (   $Fields[0] eq '        NORTHUMBERLAND 5'
        && $Fields[3] == 1810
        && $Fields[4] == 6
        && $Fields[5] == 14 )

    {
        $Fields[9] = '52.25';    # Not 32
    }
    if (   $Fields[0] eq '        NORTHUMBERLAND 5'
        && $Fields[3] == 1809
        && $Fields[4] == 5
        && $Fields[5] == 10 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '        NORTHUMBERLAND 5'
        && $Fields[3] == 1816
        && $Fields[4] == 5
        && $Fields[5] == 17 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '             SHERBORNE 2'
        && $Fields[3] == 1834
        && $Fields[4] == 8
        && $Fields[5] == 2 )

    {
        $Fields[9] = ' 3.20';    # Not 34
    }
    if (   $Fields[0] eq '           BOMBAY CASTLE'
        && $Fields[3] == 1806
        && $Fields[4] == 3
        && $Fields[5] == 15 )

    {
        $Fields[9] = '103.51';    # Not 113
        $Fields[6] = ' 3.00';     # Not 20
    }
    if (   $Fields[0] eq '           BRIDGEWATER 5'
        && $Fields[3] == 1820
        && $Fields[4] == 3
        && $Fields[5] == 23 )

    {
        $Fields[9] = '';          # Not 0.67
    }
    if (   $Fields[0] eq '                 CANNING'
        && $Fields[3] == 1824
        && $Fields[4] == 2
        && $Fields[5] == 18 )

    {
        $Fields[6] = '27.26';     # Not 21
    }
    if (   $Fields[0] eq '           CHARLES GRANT'
        && $Fields[3] == 1819
        && $Fields[4] == 7
        && $Fields[5] == 25 )

    {
        $Fields[9] = '100.00';    # Not 0
    }
    if (   $Fields[0] eq '           CHARLES GRANT'
        && $Fields[3] == 1819
        && $Fields[4] == 1
        && $Fields[5] == 30 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '                 FAIRLIE'
        && $Fields[3] == 1814
        && $Fields[4] == 1
        && $Fields[5] == 12 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '                 FAIRLIE'
        && $Fields[3] == 1814
        && $Fields[4] == 3
        && $Fields[5] == 27 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '                 FAIRLIE'
        && $Fields[3] == 1812
        && $Fields[4] == 6
        && $Fields[5] == 7 )

    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '                 FAIRLIE'
        && $Fields[3] == 1818
        && $Fields[4] == 8
        && $Fields[5] == 3 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '             FARQUHARSON'
        && $Fields[3] == 1822
        && $Fields[4] == 4
        && $Fields[5] == 3 )

    {
        $Fields[7] = 'S';
    }
    if (   $Fields[0] eq '          GENERAL HARRIS'
        && $Fields[6] =~ /00\.00/ )
    {
        $Fields[6] = '';    # Spurious zero latitudes
    }
    if (   $Fields[0] eq '          GENERAL HARRIS'
        && $Fields[3] == 1815
        && $Fields[4] == 8
        && $Fields[5] == 3 )

    {
        $Fields[9] = '86.15';    # Not 6
    }
    if (   $Fields[0] eq '          GENERAL HARRIS'
        && $Fields[3] == 1815
        && $Fields[4] == 7
        && $Fields[5] == 2 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '          GENERAL HARRIS'
        && $Fields[3] == 1815
        && $Fields[4] == 7
        && $Fields[5] == 5 )

    {
        $Fields[9] = '';    # Not 58
    }
    if (   $Fields[0] eq '          GENERAL HARRIS'
        && $Fields[3] == 1815
        && $Fields[4] == 5
        && $Fields[5] == 7 )

    {
        $Fields[9] = '';    # Not 58
    }
    if (   $Fields[0] eq 'GEORGE THE FOURTH (GEORG'
        && $Fields[3] == 1832
        && $Fields[4] == 7
        && $Fields[5] == 29 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '            LORD LOWTHER'
        && $Fields[3] == 1831
        && $Fields[4] == 3
        && $Fields[5] == 28 )

    {
        $Fields[9] = '18.51';    # Not 81
    }
    if (   $Fields[0] eq '            LORD LOWTHER'
        && $Fields[3] == 1831
        && $Fields[4] == 2
        && $Fields[5] == 23 )

    {
        $Fields[6] = '30.58';    # Not 38
    }
    if (   $Fields[0] eq '            LORD LOWTHER'
        && $Fields[3] == 1831
        && $Fields[4] == 2
        && $Fields[5] == 20 )

    {
        $Fields[9] = '48.16';    # Not 58
    }
    if (   $Fields[0] eq '          LOWTHER CASTLE'
        && $Fields[3] == 1813
        && $Fields[4] == 4
        && $Fields[5] == 15 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '          LOWTHER CASTLE'
        && $Fields[3] == 1813
        && $Fields[4] == 7
        && $Fields[5] == 30 )

    {
        $Fields[9] = '103:00';
    }
    if (   $Fields[0] eq '          LOWTHER CASTLE'
        && $Fields[3] == 1813
        && $Fields[4] == 8
        && $Fields[5] == 23 )

    {
        $Fields[9] = '105:00';    # Not 115
    }
    if (   $Fields[0] eq '      MARCHIONESS OF ELY'
        && $Fields[3] == 1826
        && $Fields[4] == 8
        && $Fields[5] == 17 )

    {
        $Fields[9] = '82.33';     # Not 8
    }
    if (   $Fields[0] eq '       PRINCESS AMELIA 4'
        && $Fields[3] == 1815
        && $Fields[4] == 9
        && $Fields[5] == 7 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '       PRINCESS AMELIA 4'
        && $Fields[3] == 1815
        && $Fields[4] == 7
        && $Fields[5] == 14 )

    {
        $Fields[9] = '';    # Not 88
    }
    if (   $Fields[0] eq '       PRINCESS AMELIA 4'
        && $Fields[3] == 1816
        && $Fields[4] == 2
        && $Fields[5] == 8 )

    {
        $Fields[6] = '30.31';    # Not 20
    }
    if (   $Fields[0] eq '       PRINCESS AMELIA 4'
        && $Fields[3] == 1816
        && $Fields[4] == 5
        && $Fields[5] == 1 )

    {
        $Fields[6] = '';    
    }
    if (   $Fields[0] eq '     SIR WILLIAM PULTNEY'
        && $Fields[3] == 1816
        && $Fields[4] == 3
        && $Fields[5] == 6 )

    {
        $Fields[7] = 'S';
    }
    if (   $Fields[0] eq '     SIR WILLIAM PULTNEY'
        && $Fields[3] == 1815
        && $Fields[4] == 8
        && $Fields[5] == 13 )

    {
        $Fields[7] = 'N';
    }

    if (   $Fields[0] eq '        DUCHESS OF ATHOL'
        && $Fields[3] == 1832
        && $Fields[4] == 30
        && $Fields[5] == 31 )

    {
        $Fields[4] = 10;
    }
    if (   $Fields[0] eq '        DUCHESS OF ATHOL'
        && $Fields[3] == 1850
        && $Fields[4] == 1
        && $Fields[5] == 6 )

    {
        $Fields[3] = 1830;
    }

    if (   $Fields[0] eq '          ALNWICK CASTLE'
        && $Fields[3] == 1813
        && $Fields[4] == 3
        && $Fields[5] == 22 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '          ALNWICK CASTLE'
        && $Fields[3] == 1816
        && $Fields[4] == 3
        && $Fields[5] == 23 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '               BARKWORTH'
        && $Fields[3] == 1818
        && $Fields[4] == 6
        && $Fields[5] == 22 )

    {
        $Fields[7] = 'N';
    }

    if (   $Fields[0] eq '        DUCHESS OF ATHOL'
        && $Fields[3] == 1828
        && $Fields[4] == 7
        && $Fields[5] == 28 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '        DUCHESS OF ATHOL'
        && $Fields[3] == 1830
        && $Fields[4] == 7
        && $Fields[5] == 3 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '        DUCHESS OF ATHOL'
        && $Fields[3] == 1823
        && $Fields[4] == 2
        && $Fields[5] == 6 )

    {
        $Fields[7] = 'N';
    }

    if (   $Fields[0] eq '              LORD KEITH'
        && $Fields[3] == 1816
        && $Fields[4] == 8
        && $Fields[5] == 20 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '              LORD KEITH'
        && $Fields[3] == 1814
        && $Fields[4] == 10
        && $Fields[5] == 13 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '              LORD KEITH'
        && $Fields[3] == 1811
        && $Fields[4] == 7
        && $Fields[5] == 23 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '              LORD KEITH'
        && $Fields[3] == 1815
        && $Fields[4] == 4
        && $Fields[5] == 21 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '              LORD KEITH'
        && $Fields[3] == 1817
        && $Fields[4] == 4
        && $Fields[5] == 21 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '              LORD KEITH'
        && $Fields[3] == 1817
        && $Fields[4] == 5
        && $Fields[5] == 6 )

    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '              LORD KEITH'
        && $Fields[3] == 1815
        && $Fields[4] == 3
        && $Fields[5] == 15 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '              LORD KEITH'
        && $Fields[3] == 1814
        && $Fields[4] == 10
        && $Fields[5] == 7 )

    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '              LORD KEITH'
        && $Fields[3] == 1811
        && $Fields[4] == 5
        && $Fields[5] == 21 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '          MARQUIS OF ELY'
        && $Fields[3] == 1814
        && $Fields[4] == 3
        && $Fields[5] == 2 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '          MARQUIS OF ELY'
        && $Fields[3] == 1819
        && $Fields[4] == 8
        && $Fields[5] == 3 )

    {
        $Fields[6] = '';
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '             SOVEREIGN 2'
        && $Fields[3] == 1817
        && $Fields[4] == 7
        && $Fields[5] == 31 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '             SOVEREIGN 2'
        && $Fields[3] == 1816
        && $Fields[4] == 11
        && $Fields[5] == 11 )

    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '             STREATHAM 4'
        && $Fields[3] == 1814
        && $Fields[4] == 3
        && $Fields[5] == 7 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '             STREATHAM 4'
        && $Fields[3] == 1808
        && $Fields[4] == 10
        && $Fields[5] == 2 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '             STREATHAM 4'
        && $Fields[3] == 1810
        && $Fields[4] == 6
        && $Fields[5] == 24 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '               TOTTENHAM'
        && $Fields[3] == 1810
        && $Fields[4] == 1
        && $Fields[5] == 13 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '               TOTTENHAM'
        && $Fields[3] == 1803
        && $Fields[4] == 12
        && $Fields[5] == 8 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '               TOTTENHAM'
        && $Fields[3] == 1803
        && $Fields[4] == 5
        && $Fields[5] == 26 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '               TOTTENHAM'
        && $Fields[3] == 1808
        && $Fields[4] == 3
        && $Fields[5] == 3 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '               TOTTENHAM'
        && $Fields[3] == 1808
        && $Fields[4] == 10
        && $Fields[5] == 5 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '               TOTTENHAM'
        && $Fields[3] == 1806
        && $Fields[4] == 9
        && $Fields[5] == 17 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '          WILLIAM PITT 2'
        && $Fields[3] == 1806
        && $Fields[4] == 11
        && $Fields[5] == 3 )

    {
        $Fields[7] = 'S';
    }
    if (   $Fields[0] eq '          WILLIAM PITT 2'
        && $Fields[3] == 1812
        && $Fields[4] == 3
        && $Fields[5] == 25 )

    {
        $Fields[7] = 'S';
    }

    if (   $Fields[0] eq '              CUMBERLAND'
        && $Fields[3] == 1809
        && $Fields[4] == 4
        && $Fields[5] == 25 )

    {
        $Fields[6] = '';
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '              CUMBERLAND'
        && $Fields[3] == 1810
        && $Fields[4] == 5
        && ( $Fields[5] == 14 || $Fields[5] == 15 ) )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '              CUMBERLAND'
        && $Fields[3] == 1809
        && $Fields[4] == 5
        && $Fields[5] == 14 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '              CUMBERLAND'
        && $Fields[3] == 1809
        && $Fields[4] == 5
        && $Fields[5] == 20 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '              CUMBERLAND'
        && $Fields[3] == 1803
        && $Fields[4] == 4
        && $Fields[5] == 24 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '              CUMBERLAND'
        && $Fields[3] == 1809
        && $Fields[4] == 3
        && $Fields[5] == 30 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '              CUMBERLAND'
        && $Fields[3] == 1809
        && $Fields[4] == 3
        && ( $Fields[5] >= 21 && $Fields[5] <= 26 ) )

    {
        $Fields[6] = '';
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '               EARL HOWE'
        && $Fields[3] == 1807
        && $Fields[4] == 7
        && $Fields[5] == 12 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '               EARL HOWE'
        && $Fields[3] == 1802
        && $Fields[4] == 7
        && $Fields[5] == 1 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '               EARL HOWE'
        && $Fields[3] == 1806
        && $Fields[4] == 8
        && $Fields[5] == 14 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '               EARL HOWE'
        && $Fields[3] == 1802
        && $Fields[4] == 7
        && $Fields[5] == 11 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '               EARL HOWE'
        && $Fields[3] == 1806
        && $Fields[4] == 8
        && $Fields[5] == 21 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '               EARL HOWE'
        && $Fields[3] == 1808
        && $Fields[4] == 7
        && $Fields[5] == 27 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '               EARL HOWE'
        && $Fields[3] == 1798
        && $Fields[4] == 3
        && $Fields[5] == 2 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '               EARL HOWE'
        && $Fields[3] == 1805
        && $Fields[4] == 8
        && $Fields[5] == 13 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '               EARL HOWE'
        && $Fields[3] == 1800
        && $Fields[4] == 5
        && $Fields[5] == 21 )

    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '      EARL ST. VINCENT 1'
        && $Fields[3] == 1809
        && $Fields[4] == 6
        && $Fields[5] == 22 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '      EARL ST. VINCENT 1'
        && $Fields[3] == 1800
        && $Fields[4] == 4
        && $Fields[5] == 4 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '      EARL ST. VINCENT 1'
        && $Fields[3] == 1813
        && $Fields[4] == 1
        && $Fields[5] == 21 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '      EARL ST. VINCENT 1'
        && $Fields[3] == 1809
        && $Fields[4] == 3
        && $Fields[5] == 15 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '      EARL ST. VINCENT 1'
        && $Fields[3] == 1811
        && $Fields[4] == 3
        && $Fields[5] == 25 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '      EARL ST. VINCENT 1'
        && $Fields[3] == 1810
        && $Fields[4] == 10
        && $Fields[5] == 12 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '      EARL ST. VINCENT 1'
        && $Fields[3] == 1800
        && $Fields[4] == 8
        && $Fields[5] == 27 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '             ELPHINSTONE'
        && $Fields[3] == 1809
        && $Fields[4] == 3
        && $Fields[5] == 8 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '             ELPHINSTONE'
        && $Fields[3] == 1803
        && $Fields[4] == 5
        && $Fields[5] == 28 )

    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '        LADY CASTLEREAGH'
        && $Fields[3] == 1809
        && $Fields[4] == 2
        && $Fields[5] == 25 )

    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '        LADY CASTLEREAGH'
        && $Fields[3] == 1812
        && $Fields[4] == 12
        && $Fields[5] == 25 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '        LADY CASTLEREAGH'
        && $Fields[3] == 1812
        && $Fields[4] == 5
        && $Fields[5] == 11 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '        LADY CASTLEREAGH'
        && $Fields[3] == 1807
        && $Fields[4] == 7
        && $Fields[5] == 6 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '        LADY CASTLEREAGH'
        && $Fields[3] == 1813
        && $Fields[4] == 4
        && $Fields[5] == 6 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '        LADY CASTLEREAGH'
        && $Fields[3] == 1814
        && $Fields[4] == 10
        && $Fields[5] == 27 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '        LADY CASTLEREAGH'
        && $Fields[3] == 1814
        && $Fields[4] == 11
        && ( $Fields[5] == 4 || $Fields[5] == 5 ) )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '           NORTHAMPTON 2'
        && $Fields[3] == 1804
        && $Fields[4] == 8
        && $Fields[5] == 29 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '           NORTHAMPTON 2'
        && $Fields[3] == 1808
        && $Fields[4] == 11
        && $Fields[5] == 13 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '           NORTHAMPTON 2'
        && $Fields[3] == 1807
        && $Fields[4] == 10
        && $Fields[5] == 15 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '           NORTHAMPTON 2'
        && $Fields[3] == 1804
        && $Fields[4] == 12
        && $Fields[5] == 3 )

    {
        $Fields[7] = 'S';
    }

    if (   $Fields[0] eq '                  ORWELL'
        && $Fields[3] == 1822
        && $Fields[4] == 6
        && $Fields[5] == 7 )

    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '                  ORWELL'
        && $Fields[3] == 1827
        && $Fields[4] == 1
        && $Fields[5] == 22 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '                  ORWELL'
        && $Fields[3] == 1825
        && $Fields[4] == 4
        && $Fields[5] == 3 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '                  ORWELL'
        && $Fields[3] == 1826
        && $Fields[4] == 8
        && $Fields[5] == 19 )

    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '                  ORWELL'
        && $Fields[3] == 1826
        && $Fields[4] == 9
        && $Fields[5] == 7 )

    {
        $Fields[7] = 'N';
    }

    if (   $Fields[0] eq '             WALTHAMSTOW'
        && $Fields[3] == 1804
        && $Fields[4] == 10
        && $Fields[5] == 2 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '             WALTHAMSTOW'
        && $Fields[3] == 1801
        && $Fields[4] == 1
        && $Fields[5] == 20 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '             WALTHAMSTOW'
        && $Fields[3] == 1801
        && $Fields[4] == 3
        && $Fields[5] == 21 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '             WALTHAMSTOW'
        && $Fields[3] == 1810
        && $Fields[4] == 1
        && $Fields[5] == 24 )

    {
        $Fields[7] = 'N';
    }

    if (   $Fields[0] eq '                   ANN 1'
        && $Fields[3] == 1805
        && $Fields[4] == 9
        && $Fields[5] == 7 )

    {
        $Fields[6] = '48.11';
    }
    if (   $Fields[0] eq '                   ANN 1'
        && $Fields[3] == 1808
        && $Fields[4] == 3
        && $Fields[5] == 7 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '                   ANN 1'
        && $Fields[3] == 1807
        && $Fields[4] == 10
        && $Fields[5] == 28 )
    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '                 CERES 4'
        && $Fields[3] == 18 )

    {
        $Fields[3] = '1802';
    }
    if (   $Fields[0] eq '                 CERES 4'
        && $Fields[3] == 1809
        && $Fields[4] == 7
        && $Fields[5] == 5 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '                 CERES 4'
        && $Fields[3] == 1802
        && $Fields[4] == 5
        && $Fields[5] == 3 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '                 CERES 4'
        && $Fields[3] == 1808
        && $Fields[4] == 8
        && $Fields[5] == 3 )

    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '                 CERES 2'
        && $Fields[3] == 1793
        && $Fields[4] == 8
        && $Fields[5] == 24 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '                 CERES 2'
        && $Fields[3] == 1794
        && $Fields[4] == 5
        && $Fields[5] == 11 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '                  DUNIRA'
        && $Fields[3] == 1832
        && $Fields[4] == 6
        && $Fields[5] == 2 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '                  DUNIRA'
        && $Fields[3] == 1833
        && $Fields[4] == 2
        && $Fields[5] == 21 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '                  DUNIRA'
        && $Fields[3] == 1823
        && $Fields[4] == 3
        && $Fields[5] == 8 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '                  DUNIRA'
        && $Fields[3] == 1832
        && $Fields[4] == 6
        && $Fields[5] == 2 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '                  DUNIRA'
        && $Fields[3] == 1823
        && $Fields[4] == 3
        && $Fields[5] == 10 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '                  DUNIRA'
        && $Fields[3] == 1832
        && $Fields[4] == 5
        && $Fields[5] == 1 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '                 HUDDART'
        && $Fields[3] == 1816
        && $Fields[4] == 2
        && $Fields[5] == 18 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '                 HUDDART'
        && $Fields[3] == 1809
        && $Fields[4] == 4
        && $Fields[5] == 12 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '                 HUDDART'
        && $Fields[3] == 1804
        && $Fields[4] == 12
        && $Fields[5] == 11 )

    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '             HUGH INGLIS'
        && $Fields[3] == 1801
        && $Fields[4] == 9
        && $Fields[5] == 20 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '             HUGH INGLIS'
        && $Fields[3] == 1811
        && $Fields[4] == 1
        && $Fields[5] == 29 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '             HUGH INGLIS'
        && $Fields[3] == 1801
        && $Fields[4] == 9
        && $Fields[5] == 12 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '         LADY LUSHINGTON'
        && $Fields[3] == 1811
        && $Fields[4] == 10
        && ( $Fields[5] == 3 || $Fields[5] == 6 || $Fields[5] == 10 ) )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '             LORD DUNCAN'
        && $Fields[3] == 1804
        && $Fields[4] == 2
        && $Fields[5] > 10 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '             LORD DUNCAN'
        && $Fields[3] == 1801
        && $Fields[4] == 7
        && $Fields[5] == 25 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '             LORD DUNCAN'
        && $Fields[3] == 1800
        && $Fields[4] == 5
        && $Fields[5] == 29 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '             LORD DUNCAN'
        && $Fields[3] == 1803
        && $Fields[4] == 4
        && $Fields[5] == 5 )

    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '             LORD DUNCAN'
        && $Fields[3] == 1803
        && $Fields[4] == 12
        && $Fields[5] == 5 )

    {
        $Fields[7] = 'S';
    }
    if (   $Fields[0] eq '             LORD DUNCAN'
        && $Fields[3] == 1803
        && $Fields[4] == 5
        && $Fields[5] == 7 )

    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '       MARQUIS WELLESLEY'
        && $Fields[3] == 1806
        && $Fields[4] == 7
        && $Fields[5] == 21 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '       MARQUIS WELLESLEY'
        && $Fields[3] == 1807
        && $Fields[4] == 6
        && $Fields[5] == 12 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '       MARQUIS WELLESLEY'
        && $Fields[3] == 1802
        && $Fields[4] == 4
        && $Fields[5] == 4 )

    {
        $Fields[7] = 'S';
    }

    if (   $Fields[0] eq '          SURAT CASTLE 2'
        && $Fields[3] == 1814
        && $Fields[4] == 2
        && $Fields[5] == 25 )

    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '          SURAT CASTLE 2'
        && $Fields[3] == 1812
        && $Fields[4] == 3
        && $Fields[5] == 2 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '          SURAT CASTLE 2'
        && $Fields[3] == 1815
        && $Fields[4] == 4
        && $Fields[5] == 8 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '                TIGRIS 2'
        && $Fields[3] == 1812
        && $Fields[4] == 6
        && $Fields[5] == 12 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '                TIGRIS 2'
        && $Fields[3] == 1818
        && $Fields[4] == 11
        && $Fields[5] == 11 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '                TIGRIS 2'
        && $Fields[3] == 1810
        && $Fields[4] == 11
        && $Fields[5] == 11 )

    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '          GENERAL STUART'
        && $Fields[3] == 1804
        && $Fields[4] == 9
        && $Fields[5] == 15 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '           LADY MELVILLE'
        && $Fields[3] == 1827
        && $Fields[4] == 7
        && $Fields[5] == 16 )

    {
        $Fields[16] = '30260';
    }

    if (   $Fields[0] eq '                DEVAYNES'
        && $Fields[3] == 1805
        && $Fields[4] == 9
        && $Fields[5] == 11 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '                DEVAYNES'
        && $Fields[3] == 1804
        && $Fields[4] == 10
        && $Fields[5] == 5 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '                DEVAYNES'
        && $Fields[3] == 1802
        && $Fields[4] == 9
        && $Fields[5] == 27 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '                DEVAYNES'
        && $Fields[3] == 1808
        && $Fields[4] == 1
        && $Fields[5] == 23 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '          EARL SPENCER 2'
        && $Fields[3] == 1801
        && $Fields[4] == 4
        && $Fields[5] == 12 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '          EARL SPENCER 2'
        && $Fields[3] == 1807
        && $Fields[4] == 11
        && $Fields[5] == 23 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '          EARL SPENCER 2'
        && $Fields[3] == 1801
        && $Fields[4] == 9
        && $Fields[5] == 13 )

    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '          EARL SPENCER 2'
        && $Fields[3] == 1800
        && $Fields[4] == 12
        && $Fields[5] > 5 )

    {
        $Fields[9] = '';    # Using Calcutta meridian?
    }
    if (   $Fields[0] eq '          EARL SPENCER 2'
        && $Fields[3] == 1800
        && $Fields[4] == 11
        && $Fields[5] == 27 )

    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '          EARL SPENCER 2'
        && $Fields[3] == 1801
        && $Fields[4] == 6
        && $Fields[5] == 7 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '          EARL SPENCER 2'
        && $Fields[3] == 1809
        && $Fields[4] == 5
        && $Fields[5] == 7 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '          EARL SPENCER 2'
        && $Fields[3] == 1803
        && $Fields[4] == 7
        && $Fields[5] == 5 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '          EARL SPENCER 2'
        && $Fields[3] == 1803
        && $Fields[4] == 7
        && $Fields[5] == 3 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '                 ESSEX 4'
        && $Fields[3] == 1796
        && $Fields[4] == 6
        && $Fields[5] == 13 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '                 ESSEX 4'
        && $Fields[3] == 1796
        && $Fields[4] == 11
        && $Fields[5] == 16 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '                 ESSEX 5'
        && $Fields[3] == 1804
        && $Fields[4] == 8
        && $Fields[5] == 17 )

    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '                   INDUS'
        && $Fields[3] == 1805
        && $Fields[4] == 10
        && $Fields[5] == 13 )

    {
        $Fields[7]  = 'N';
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '                   INDUS'
        && $Fields[3] == 1815
        && $Fields[4] == 1
        && $Fields[5] == 24 )

    {
        $Fields[7] = 'N';
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '           LADY MELVILLE'
        && $Fields[3] == 1820
        && $Fields[4] == 4
        && $Fields[5] == 4 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '           LADY MELVILLE'
        && $Fields[3] == 1832
        && $Fields[4] == 3
        && $Fields[5] == 14 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '           LADY MELVILLE'
        && $Fields[3] == 1820
        && $Fields[4] == 8
        && $Fields[5] == 24 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '           LADY MELVILLE'
        && $Fields[3] == 1814
        && $Fields[4] == 7
        && $Fields[5] == 19 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '           LADY MELVILLE'
        && $Fields[3] == 1831
        && $Fields[4] == 11
        && $Fields[5] == 18 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '           LADY MELVILLE'
        && $Fields[3] == 1821
        && $Fields[4] == 4
        && $Fields[5] == 28 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '           LADY MELVILLE'
        && $Fields[3] == 1818
        && $Fields[4] == 8
        && $Fields[5] == 22 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '           LADY MELVILLE'
        && $Fields[3] == 1818
        && $Fields[4] == 12
        && $Fields[5] == 24 )

    {
        $Fields[7]  = 'N';
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '           LADY MELVILLE'
        && $Fields[3] == 1818
        && $Fields[4] == 6
        && $Fields[5] == 16 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '           LADY MELVILLE'
        && $Fields[3] == 1819
        && $Fields[4] == 4
        && $Fields[5] == 6 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '           LADY MELVILLE'
        && $Fields[3] == 1819
        && $Fields[4] == 2
        && $Fields[5] == 26 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '           LADY MELVILLE'
        && $Fields[3] == 1834
        && $Fields[4] == 2
        && $Fields[5] == 8 )

    {
        $Fields[10] = 'W';
    }

    if (   $Fields[0] eq '                 OCEAN 3'
        && $Fields[3] == 1800
        && $Fields[4] == 1
        && $Fields[5] == 24 )

    {
        $Fields[10] = 'W';
    }

    if (   $Fields[0] eq '                 OCEAN 4'
        && $Fields[3] == 1806
        && $Fields[4] == 3
        && $Fields[5] == 5 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '                 OCEAN 4'
        && $Fields[3] == 1806
        && $Fields[4] == 3
        && $Fields[5] == 31 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '                 OCEAN 4'
        && $Fields[3] == 1806
        && $Fields[4] == 7
        && $Fields[5] == 2 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '                 OCEAN 4'
        && $Fields[3] == 1806
        && $Fields[4] == 7
        && $Fields[5] == 10 )

    {
        $Fields[7]  = 'S';
        $Fields[10] = 'W';
    }
    
    if (   $Fields[0] eq '                 OCEAN 5'
        && $Fields[3] == 1805
        && $Fields[4] == 6
        && $Fields[5] == 4 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '                 OCEAN 6'
        && $Fields[3] == 1814
        && $Fields[4] == 5
        && $Fields[5] == 5 )

    {
        $Fields[9] = '';
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '                 OCEAN 6'
        && $Fields[3] == 1807
        && $Fields[4] == 6
        && $Fields[5] == 2 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '                 ASIA 10'
        && $Fields[3] == 1829
        && $Fields[4] == 6
        && $Fields[5] == 21 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '                 ASIA 10'
        && $Fields[3] == 1829
        && $Fields[4] == 7
        && $Fields[5] == 23 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '                 ASIA 10'
        && $Fields[3] == 1829
        && $Fields[4] == 10
        && $Fields[5] == 18 )

    {
        $Fields[7] = 'N';
    }

    if (   $Fields[0] eq '                  ASIA 4'
        && $Fields[3] == 1801
        && $Fields[4] == 6
        && $Fields[5] == 6 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '                  ASIA 4'
        && $Fields[3] == 1802
        && $Fields[4] == 9
        && $Fields[5] == 6 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '                  ASIA 4'
        && $Fields[3] == 1800
        && $Fields[4] == 2
        && $Fields[5] == 25 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '                  ASIA 4'
        && $Fields[3] == 1801
        && $Fields[4] == 12
        && $Fields[5] == 11 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '                  ASIA 4'
        && $Fields[3] == 1803
        && $Fields[4] == 6
        && $Fields[5] == 2 )

    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '                  ASIA 4'
        && $Fields[3] == 1803
        && $Fields[4] == 6
        && $Fields[5] == 13 )

    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '                  ASIA 4'
        && $Fields[3] == 1801
        && $Fields[4] == 5
        && $Fields[5] == 2 )

    {
        $Fields[7] = 'S';
    }
    if (   $Fields[0] eq '                  ASIA 4'
        && $Fields[3] == 1799
        && $Fields[4] == 10
        && $Fields[5] == 31 )

    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '                  ASIA 4'
        && $Fields[3] == 1800
        && $Fields[4] == 5
        && $Fields[5] == 5 )

    {
        $Fields[7] = 'S';
    }
    if (   $Fields[0] eq '                  ASIA 4'
        && $Fields[3] == 1800
        && $Fields[4] == 3
        && $Fields[5] == 4 )

    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '                  ASIA 4'
        && $Fields[3] == 1799
        && $Fields[4] == 6
        && $Fields[5] == 23 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '                  ASIA 4'
        && $Fields[3] == 1802
        && $Fields[4] == 9
        && $Fields[5] == 6 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '                  ASIA 6'
        && $Fields[3] == 1814
        && $Fields[4] == 12
        && $Fields[5] == 18 )

    {
        $Fields[7] = 'S';
    }

    if (   $Fields[0] eq '                 CANNING'
        && $Fields[3] == 1818
        && $Fields[4] == 6
        && $Fields[5] == 8 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '                 CANNING'
        && $Fields[3] == 1818
        && $Fields[4] == 7
        && $Fields[5] == 20 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '                 CANNING'
        && $Fields[3] == 1821
        && $Fields[4] == 2
        && $Fields[5] == 17 )

    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '                 CANNING'
        && $Fields[3] == 1822
        && $Fields[4] == 7
        && $Fields[5] == 1 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '               EUPHRATES'
        && $Fields[3] == 1804
        && $Fields[4] == 2
        && $Fields[5] == 18 )

    {
        $Fields[7] = 'N';
    }

    if (   $Fields[0] eq '             JOHN PALMER'
        && $Fields[3] == 1811
        && $Fields[4] == 3
        && $Fields[5] == 13 )

    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '                 MATILDA'
        && $Fields[3] == 1819
        && $Fields[4] == 11
        && $Fields[5] == 26 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '                 MATILDA'
        && $Fields[3] == 1819
        && $Fields[4] == 6
        && $Fields[5] == 27 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '                   MIDAS'
        && $Fields[3] == 1810
        && $Fields[4] == 9
        && $Fields[5] == 19 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '           PRINCE REGENT'
        && $Fields[3] == 1828
        && $Fields[4] == 9
        && $Fields[5] == 24 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '           PRINCE REGENT'
        && $Fields[3] == 1826
        && $Fields[4] == 9
        && $Fields[5] == 14 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '           PRINCE REGENT'
        && $Fields[3] == 1818
        && $Fields[4] == 5
        && $Fields[5] == 25 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '           PRINCE REGENT'
        && $Fields[3] == 1834
        && $Fields[4] == 2
        && $Fields[5] == 13 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '           PRINCE REGENT'
        && $Fields[3] == 1821
        && $Fields[4] == 3
        && $Fields[5] == 24 )

    {
        $Fields[7] = 'S';
    }
    if (   $Fields[0] eq '           PRINCE REGENT'
        && $Fields[3] == 1815
        && $Fields[4] == 7
        && $Fields[5] == 27 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '           PRINCE REGENT'
        && $Fields[3] == 1819
        && $Fields[4] == 2
        && $Fields[5] == 18 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '           PRINCE REGENT'
        && $Fields[3] == 1815
        && $Fields[4] == 4
        && $Fields[5] == 1 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '           PRINCE REGENT'
        && $Fields[3] == 1815
        && $Fields[4] == 3
        && $Fields[5] == 6 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '           PRINCE REGENT'
        && $Fields[3] == 1814
        && $Fields[4] == 10
        && $Fields[5] == 19 )

    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '     SIR WILLIAM BENSLEY'
        && $Fields[3] == 1804
        && $Fields[4] == 7
        && $Fields[5] == 4 )

    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '               WINDHAM 2'
        && $Fields[3] == 1806
        && $Fields[4] == 3
        && $Fields[5] == 5 )

    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '         ADMIRAL GARDNER'
        && $Fields[3] == 1807
        && $Fields[4] == 3
        && $Fields[5] == 11 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '         ADMIRAL GARDNER'
        && $Fields[3] == 1807
        && $Fields[4] == 6
        && $Fields[5] == 27 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '         ADMIRAL GARDNER'
        && $Fields[3] == 1808
        && $Fields[4] == 1
        && $Fields[5] == 11 )

    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '                 ATLAS 4'
        && $Fields[3] == 1890
        && $Fields[4] == 2
        && $Fields[5] == 18 )

    {
        $Fields[3] = '1820';
    }
    if (   $Fields[0] eq '                 ATLAS 4'
        && $Fields[3] == 1820
        && $Fields[4] == 5
        && $Fields[5] == 5 )

    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '                 ATLAS 4'
        && $Fields[3] == 1820
        && $Fields[4] == 3
        && $Fields[5] == 1 )

    {
        $Fields[7] = 'S';
    }
    if (   $Fields[0] eq '                 ATLAS 4'
        && $Fields[3] == 1820
        && $Fields[4] == 4
        && $Fields[5] == 24 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '                 ATLAS 4'
        && $Fields[3] == 1822
        && $Fields[4] == 7
        && $Fields[5] == 4 )

    {
        $Fields[7]  = 'S';
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '                 ATLAS 4'
        && $Fields[3] == 1823
        && $Fields[4] == 3
        && $Fields[5] == 29 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '                 ATLAS 4'
        && $Fields[3] == 1824
        && $Fields[4] == 4
        && $Fields[5] == 8 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '                 CANNING'
        && $Fields[3] == 1825
        && $Fields[4] == 4
        && $Fields[5] == 6 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '                 CANNING'
        && $Fields[3] == 1830
        && $Fields[4] == 3
        && $Fields[5] == 23 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '                 CANNING'
        && $Fields[3] == 1825
        && $Fields[4] == 2
        && $Fields[5] == 15 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '               HARRIET 3'
        && $Fields[3] == 1805
        && $Fields[4] == 7
        && $Fields[5] == 2 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '               HARRIET 3'
        && $Fields[3] == 1805
        && $Fields[4] == 10
        && $Fields[5] == 16 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '               HARRIET 3'
        && $Fields[3] == 1815
        && $Fields[4] == 6
        && $Fields[5] == 1 )

    {
        $Fields[3] = '1810';
    }
    if (   $Fields[0] eq '               HARRIET 3'
        && $Fields[3] == 1815
        && $Fields[4] == 6
        && $Fields[5] == 2 )

    {
        $Fields[3] = '1810';
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '               HARRIET 3'
        && $Fields[3] == 1808
        && $Fields[4] == 7
        && $Fields[5] == 27 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '               HARRIET 3'
        && $Fields[3] == 1811
        && $Fields[4] == 2
        && $Fields[5] == 3 )

    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '             HINDOSTAN 2'
        && $Fields[3] == 1799
        && $Fields[4] == 10
        && $Fields[5] == 21 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '             HINDOSTAN 2'
        && $Fields[3] == 1800
        && $Fields[4] == 3
        && $Fields[5] == 31 )

    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '         MELVILLE CASTLE'
        && $Fields[3] == 1800
        && $Fields[4] == 8
        && $Fields[5] == 19 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '  SIR STEPHEN LUSHINGTON'
        && $Fields[3] == 1806
        && $Fields[4] == 11
        && $Fields[5] == 5 )

    {
        $Fields[6] = '';
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '  SIR STEPHEN LUSHINGTON'
        && $Fields[3] == 1806
        && $Fields[4] == 10
        && $Fields[5] == 25 )

    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '  SIR STEPHEN LUSHINGTON'
        && $Fields[3] == 1806
        && $Fields[4] == 10
        && $Fields[5] == 27 )

    {
        $Fields[7] = 'S';
    }
    if (   $Fields[0] eq '  SIR STEPHEN LUSHINGTON'
        && $Fields[3] == 1808
        && $Fields[4] == 1
        && $Fields[5] == 14 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '  SIR STEPHEN LUSHINGTON'
        && $Fields[3] == 1808
        && $Fields[4] == 11
        && $Fields[5] == 1 )

    {
        $Fields[7] = 'S';
    }

    if (   $Fields[0] eq '          UNITED KINGDOM'
        && $Fields[3] == 1804
        && $Fields[4] == 11
        && $Fields[5] == 13 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '          UNITED KINGDOM'
        && $Fields[3] == 1804
        && $Fields[4] == 11
        && $Fields[5] == 26 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '         MELVILLE CASTLE'
        && $Fields[3] == 1797
        && $Fields[4] == 5
        && $Fields[5] == 17 )

    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '         MELVILLE CASTLE'
        && $Fields[3] == 1801
        && $Fields[4] == 11
        && $Fields[5] == 27 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '               WINDSOR 2'
        && $Fields[3] == 1825
        && $Fields[4] == 7
        && $Fields[5] == 16 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '               WINDSOR 2'
        && $Fields[3] == 1825
        && $Fields[4] == 1
        && $Fields[5] == 17 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '               WINDSOR 2'
        && $Fields[3] == 1820
        && $Fields[4] == 2
        && $Fields[5] == 3 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '               WINDSOR 2'
        && $Fields[3] == 1827
        && $Fields[4] == 6
        && $Fields[5] == 4 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '               WINDSOR 2'
        && $Fields[3] == 1828
        && $Fields[4] == 3
        && $Fields[5] == 3 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '               WINDSOR 2'
        && $Fields[3] == 1825
        && $Fields[4] == 3
        && $Fields[5] == 9 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '               WINDSOR 2'
        && $Fields[3] == 1825
        && $Fields[4] == 2
        && $Fields[5] == 7 )

    {
        $Fields[7] = 'S';
    }
    if (   $Fields[0] eq '               WINDSOR 2'
        && $Fields[3] == 1825
        && $Fields[4] == 1
        && $Fields[5] == 17 )

    {
        $Fields[9]  = '';
        $Fields[7]  = 'N';
        $Fields[10] = 'W';
    }

    if (   $Fields[0] eq '              WOODFORD 1'
        && $Fields[3] == 1794
        && $Fields[4] == 7
        && $Fields[5] == 18 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '              WOODFORD 1'
        && $Fields[3] == 1796
        && $Fields[4] == 7
        && $Fields[5] == 26 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '              WOODFORD 1'
        && $Fields[3] == 1797
        && $Fields[4] == 8
        && $Fields[5] == 25 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '              WOODFORD 1'
        && $Fields[3] == 1797
        && $Fields[4] == 9
        && $Fields[5] == 7 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '              WOODFORD 1'
        && $Fields[3] == 1808
        && $Fields[4] == 4
        && $Fields[5] == 14 )

    {
        $Fields[9] = '';
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '             BRITANNIA 4'
        && $Fields[3] == 1798
        && $Fields[4] == 9
        && $Fields[5] == 15 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '             BRITANNIA 4'
        && $Fields[3] == 1801
        && $Fields[4] == 9
        && $Fields[5] == 14 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '              CALCUTTA 4'
        && $Fields[3] == 1801
        && $Fields[4] == 7
        && $Fields[5] == 18 )

    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '              CALCUTTA 4'
        && $Fields[3] == 1802
        && $Fields[4] == 5
        && $Fields[5] == 14 )

    {
        $Fields[7] = 'S';
    }
    if (   $Fields[0] eq '              CALCUTTA 4'
        && $Fields[3] == 1803
        && $Fields[4] == 6
        && $Fields[5] == 19 )

    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '                  CANTON'
        && $Fields[3] == 1809
        && $Fields[4] == 7
        && $Fields[5] == 10 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '          CASTLE HUNTLEY'
        && $Fields[3] == 1810
        && $Fields[4] == 10
        && ( $Fields[5] == 04 || $Fields[5] == 05 ) )

    {
        return;
    }
    if (   $Fields[0] eq '          CASTLE HUNTLEY'
        && $Fields[3] == 1810
        && $Fields[4] == 07
        && $Fields[5] == 29 )

    {
        return;
    }
    if (   $Fields[0] eq '          CASTLE HUNTLEY'
        && $Fields[3] == 1811
        && $Fields[4] == 11
        && $Fields[5] == 15 )

    {
        return;
    }
    if (   $Fields[0] eq '          CASTLE HUNTLEY'
        && $Fields[3] == 1824
        && $Fields[4] == 6
        && $Fields[5] == 20 )

    {
        return;
    }
    if (   $Fields[0] eq '          CASTLE HUNTLEY'
        && $Fields[3] == 1820
        && $Fields[4] == 3
        && $Fields[5] == 22 )

    {
        return;
    }
    if (   $Fields[0] eq '          CASTLE HUNTLEY'
        && $Fields[3] == 1820
        && $Fields[4] == 6
        && $Fields[5] == 26 )

    {
        return;
    }
    if (   $Fields[0] eq '          CASTLE HUNTLEY'
        && $Fields[3] == 1824
        && $Fields[4] == 8
        && $Fields[5] == 23 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '          CASTLE HUNTLEY'
        && $Fields[3] == 1829
        && $Fields[4] == 7
        && $Fields[5] == 20 )

    {
        $Fields[4] = 6;
    }
    if (   $Fields[0] eq '          CASTLE HUNTLEY'
        && $Fields[3] == 1828
        && $Fields[4] == 6
        && $Fields[5] == 26 )

    {
        $Fields[10] = 'E';
        $Fields[7] = 'S';
    }

    if (   $Fields[0] eq '                CHARLTON'
        && $Fields[3] == 1803
        && $Fields[4] == 6
        && $Fields[5] == 26 )

    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '                CHARLTON'
        && $Fields[3] == 1801
        && $Fields[4] == 7
        && $Fields[5] == 25 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '                CHARLTON'
        && $Fields[3] == 1802
        && $Fields[4] == 1
        && $Fields[5] == 11 )

    {
        $Fields[9] = '';
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '                CHARLTON'
        && $Fields[3] == 1801
        && $Fields[4] == 4
        && $Fields[5] == 15 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '                CHARLTON'
        && $Fields[3] == 1800
        && $Fields[4] == 7
        && $Fields[5] == 7 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '                CHARLTON'
        && $Fields[3] == 1799
        && $Fields[4] == 7
        && $Fields[5] == 18 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '                CHARLTON'
        && $Fields[3] == 1799
        && $Fields[4] == 6
        && $Fields[5] == 23 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '                CHARLTON'
        && $Fields[3] == 1800
        && $Fields[4] == 1
        && $Fields[5] == 10 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '                CHARLTON'
        && $Fields[3] == 1801
        && $Fields[4] == 8
        && $Fields[5] == 13 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '                CHARLTON'
        && $Fields[3] == 1806
        && $Fields[4] == 1
        && $Fields[5] == 10 )

    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '                  INGLIS'
        && $Fields[3] == 1829
        && $Fields[4] == 9
        && $Fields[5] == 13 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '                  INGLIS'
        && $Fields[3] == 1823
        && $Fields[4] == 12
        && $Fields[5] == 15 )

    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '                  INGLIS'
        && $Fields[3] == 1823
        && $Fields[4] == 8
        && $Fields[5] == 1 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '                  INGLIS'
        && $Fields[3] == 1819
        && $Fields[4] == 3
        && $Fields[5] == 2 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '                  INGLIS'
        && $Fields[3] == 1830
        && $Fields[4] == 6
        && $Fields[5] == 9 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '        LADY JANE DUNDAS'
        && $Fields[3] == 1807
        && $Fields[4] == 9
        && $Fields[5] == 4 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '        LADY JANE DUNDAS'
        && $Fields[3] == 1805
        && $Fields[4] == 9
        && $Fields[5] == 1 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '        LADY JANE DUNDAS'
        && $Fields[3] == 1806
        && $Fields[4] == 5
        && $Fields[5] == 15 )

    {
        $Fields[6] = '';
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '        LADY JANE DUNDAS'
        && $Fields[3] == 1806
        && $Fields[4] == 5
        && $Fields[5] == 14 )

    {
        $Fields[6] = '';
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '        LADY JANE DUNDAS'
        && $Fields[3] == 1806
        && $Fields[4] == 6
        && $Fields[5] == 27 )

    {
        $Fields[6] = '';
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '        LADY JANE DUNDAS'
        && $Fields[3] == 1806
        && $Fields[4] == 6
        && $Fields[5] == 3 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '        LADY JANE DUNDAS'
        && $Fields[3] == 1807
        && $Fields[4] == 9
        && $Fields[5] == 5 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '                 PRESTON'
        && $Fields[3] == 1800
        && $Fields[4] == 7
        && $Fields[5] == 1 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '           TRUE BRITON 4'
        && $Fields[3] == 1796
        && $Fields[4] == 11
        && $Fields[5] == 4 )

    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '               WALPOLE 4'
        && $Fields[3] == 1795
        && $Fields[4] == 7
        && $Fields[5] == 19 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '            AIRLY CASTLE'
        && $Fields[3] == 1797
        && $Fields[4] == 4
        && $Fields[5] == 17 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '            AIRLY CASTLE'
        && $Fields[3] == 1797
        && $Fields[4] == 1
        && $Fields[5] == 9 )

    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '               BELVEDERE'
        && $Fields[3] == 1791
        && $Fields[4] == 8
        && $Fields[5] == 19 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '               BELVEDERE'
        && $Fields[3] == 1791
        && $Fields[4] == 5
        && $Fields[5] == 20 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '               BELVEDERE'
        && $Fields[3] == 1790
        && $Fields[4] == 9
        && $Fields[5] == 15 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '            BERWICKSHIRE'
        && $Fields[3] == 1833
        && $Fields[4] == 3
        && $Fields[5] == 14 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '            BERWICKSHIRE'
        && $Fields[3] == 1833
        && $Fields[4] == 3
        && $Fields[5] == 1 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '            BERWICKSHIRE'
        && $Fields[3] == 1831
        && $Fields[4] == 1
        && $Fields[5] == 4 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '            BERWICKSHIRE'
        && $Fields[3] == 1824
        && $Fields[4] == 4
        && $Fields[5] == 16 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '          GENERAL HARRIS'
        && $Fields[3] == 1826
        && $Fields[4] == 7
        && $Fields[5] == 29 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '          GENERAL HARRIS'
        && $Fields[3] == 1814
        && $Fields[4] == 3
        && $Fields[5] == 2 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '          GENERAL HARRIS'
        && $Fields[3] == 1817
        && $Fields[4] == 3
        && $Fields[5] == 29 )

    {
        $Fields[6] = '';
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '          GENERAL HARRIS'
        && $Fields[3] == 1825
        && $Fields[4] == 3
        && $Fields[5] == 30 )

    {
        $Fields[7] = 'S';
    }
    if (   $Fields[0] eq '          GENERAL HARRIS'
        && $Fields[3] == 1815
        && $Fields[4] == 3
        && $Fields[5] == 18 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '          GENERAL HEWETT'
        && $Fields[3] == 1823
        && $Fields[4] == 5
        && $Fields[5] == 29 )

    {
        $Fields[6] = '';
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '          GENERAL HEWETT'
        && $Fields[3] == 1824
        && $Fields[4] == 10
        && $Fields[5] == 17 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '          GENERAL HEWETT'
        && $Fields[3] == 1821
        && $Fields[4] == 3
        && $Fields[5] == 23 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '          GENERAL HEWETT'
        && $Fields[3] == 1822
        && $Fields[4] == 11
        && $Fields[5] == 10 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '               HERCULEAN'
        && $Fields[3] == 1801
        && $Fields[4] == 8
        && $Fields[5] == 20 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '               HERCULEAN'
        && $Fields[3] == 1800
        && $Fields[4] == 12
        && ( $Fields[5] == 27 || $Fields[5] == 28 ) )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '               HERCULEAN'
        && $Fields[3] == 1801
        && $Fields[4] == 7
        && $Fields[5] == 14 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '         LORD HAWKESBURY'
        && $Fields[3] == 1805
        && $Fields[4] == 9
        && $Fields[5] == 11 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '         LORD HAWKESBURY'
        && $Fields[3] == 1805
        && $Fields[4] == 3
        && $Fields[5] == 9 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '         LORD HAWKESBURY'
        && $Fields[3] == 1805
        && $Fields[4] == 4
        && $Fields[5] == 10 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '         LORD HAWKESBURY'
        && $Fields[3] == 1794
        && $Fields[4] == 9
        && $Fields[5] == 28 )

    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '         LORD HAWKESBURY'
        && $Fields[3] == 1795
        && $Fields[4] == 8
        && $Fields[5] == 30 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '         LORD HAWKESBURY'
        && $Fields[3] == 1797
        && $Fields[4] == 8
        && $Fields[5] == 20 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '         LORD HAWKESBURY'
        && $Fields[3] == 1797
        && $Fields[4] == 10
        && $Fields[5] == 9 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '         LORD HAWKESBURY'
        && $Fields[3] == 1797
        && $Fields[4] == 9
        && $Fields[5] >= 26 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '         LORD HAWKESBURY'
        && $Fields[3] == 1799
        && $Fields[4] == 10
        && $Fields[5] == 13 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '         LORD HAWKESBURY'
        && $Fields[3] == 1799
        && $Fields[4] == 10
        && $Fields[5] == 25 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '         LORD HAWKESBURY'
        && $Fields[3] == 1804
        && $Fields[4] == 9
        && $Fields[5] == 15 )

    {
        $Fields[6] = '';
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '         LORD HAWKESBURY'
        && $Fields[3] == 1805
        && $Fields[4] == 9
        && $Fields[5] == 29 )

    {
        $Fields[7] = 'S';
    }
    if (   $Fields[0] eq '         LORD HAWKESBURY'
        && $Fields[3] == 1795
        && $Fields[4] == 8
        && $Fields[5] == 31 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '             LADY BURGES'
        && $Fields[3] == 1801
        && $Fields[4] == 4 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '             LADY BURGES'
        && $Fields[3] == 1801
        && $Fields[4] == 5
        && $Fields[5] <= 16 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '             LADY BURGES'
        && $Fields[3] == 1803
        && $Fields[4] == 4
        && $Fields[5] == 10 )

    {
        $Fields[7] = 'S';
    }
    if (   $Fields[0] eq '             LADY BURGES'
        && $Fields[3] == 1804
        && $Fields[4] == 10
        && $Fields[5] == 16 )

    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '             LADY BURGES'
        && $Fields[3] == 1805
        && $Fields[4] == 7
        && $Fields[5] == 12 )

    {
        $Fields[10] = 'W';
    }

    if (   $Fields[0] eq '            LORD THURLOW'
        && $Fields[3] == 1793
        && $Fields[4] == 12
        && $Fields[5] == 7 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '            LORD THURLOW'
        && $Fields[3] == 1797
        && $Fields[4] == 5
        && $Fields[5] == 28 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '            LORD THURLOW'
        && $Fields[3] == 1799
        && $Fields[4] == 6
        && $Fields[5] == 23 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '            LORD THURLOW'
        && $Fields[3] == 1800
        && $Fields[4] == 7
        && $Fields[5] == 22 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '    MARQUIS CORNWALLIS 2'
        && $Fields[3] == 1803
        && Delta_Days( 1803, 2, 6, $Fields[3], $Fields[4], $Fields[5] ) >= 0
        && Delta_Days( $Fields[3], $Fields[4], $Fields[5], 1803, 4, 20 ) >= 0 )
    {
        $Fields[40] = 'Mumbai';    # Non-Greenwich longitude
    }
    if (   $Fields[0] eq '    MARQUIS CORNWALLIS 2'
        && $Fields[3] == 1803
        && Delta_Days( 1803, 4, 20, $Fields[3], $Fields[4], $Fields[5] ) > 0
        && Delta_Days( $Fields[3], $Fields[4], $Fields[5], 1803, 5, 12 ) >= 0 )
    {
        $Fields[40] = 'Cape Town';
    }
    if (   $Fields[0] eq '    MARQUIS CORNWALLIS 2'
        && $Fields[3] == 1803
        && $Fields[4] == 4
        && $Fields[5] == 21 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '    MARQUIS CORNWALLIS 2'
        && $Fields[3] == 1803
        && $Fields[4] == 2
        && $Fields[5] == 9 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '    MARQUIS CORNWALLIS 2'
        && $Fields[3] == 1803
        && $Fields[4] == 5
        && $Fields[5] == 5 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '         ROYAL ADMIRAL 1'
        && $Fields[3] == 1792
        && $Fields[4] == 12
        && $Fields[5] == 24 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '         SIR DAVID SCOTT'
        && $Fields[3] == 1832
        && $Fields[4] == 7
        && $Fields[5] == 14 )

    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '                 BELLONA'
        && $Fields[3] == 1797
        && $Fields[4] == 5
        && $Fields[5] == 18 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '                 BELLONA'
        && $Fields[3] == 1797
        && $Fields[4] == 3
        && $Fields[5] == 9 )

    {
        $Fields[9]  = '';
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '                 BELLONA'
        && $Fields[3] == 1797
        && $Fields[4] == 8
        && $Fields[5] == 18 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '                 BELLONA'
        && $Fields[3] == 1796
        && $Fields[4] == 10
        && $Fields[5] == 21 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '                  BODDAM'
        && $Fields[3] == 1799
        && $Fields[4] == 8
        && $Fields[5] == 5 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '                  BODDAM'
        && $Fields[3] == 1797
        && $Fields[4] == 4
        && $Fields[5] == 2 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '       EARL OF BALCARRAS'
        && $Fields[3] == 1879 )

    {
        $Fields[3] = '1829';
    }
    if (   $Fields[0] eq '       EARL OF BALCARRAS'
        && $Fields[3] == 1817
        && $Fields[4] == 5
        && $Fields[5] == 4 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '       EARL OF BALCARRAS'
        && $Fields[3] == 1829
        && $Fields[4] == 3
        && $Fields[5] == 23 )

    {
        $Fields[10] = 'E';
        $Fields[7]  = 'S';
    }
    if (   $Fields[0] eq '       EARL OF BALCARRAS'
        && $Fields[3] == 1820
        && $Fields[4] == 4
        && $Fields[5] == 1 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '       EARL OF BALCARRAS'
        && $Fields[3] == 1833
        && $Fields[4] == 1
        && $Fields[5] == 29 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '       EARL OF BALCARRAS'
        && $Fields[3] == 1822
        && $Fields[4] == 10
        && $Fields[5] == 7 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '       EARL OF BALCARRAS'
        && $Fields[3] == 1818
        && $Fields[4] == 11
        && $Fields[5] == 19 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '       EARL OF BALCARRAS'
        && $Fields[3] == 1833
        && $Fields[4] == 1
        && ( $Fields[5] == 21 || $Fields[5] == 22 ) )

    {
        $Fields[10] = 'E';
        $Fields[9]  = '';
    }
    if (   $Fields[0] eq '       EARL OF BALCARRAS'
        && $Fields[3] == 1829
        && $Fields[4] == 2
        && $Fields[5] == 2 )

    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '         LORD WALSINGHAM'
        && $Fields[3] == 1794
        && $Fields[4] == 7
        && $Fields[5] == 2 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '         LORD WALSINGHAM'
        && $Fields[3] == 1798
        && $Fields[4] == 11
        && $Fields[5] == 5 )

    {
        $Fields[10] = 'E';
        $Fields[7]  = 'S';
    }

    if (   $Fields[0] eq '               MANSHIP 1'
        && $Fields[3] == 1796
        && $Fields[4] == 12
        && $Fields[5] == 30 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '               MANSHIP 1'
        && $Fields[3] == 1797
        && $Fields[4] == 8
        && $Fields[5] == 10 )

    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '               MANSHIP 2'
        && $Fields[3] == 1801
        && $Fields[4] == 10
        && $Fields[5] == 31 )

    {
        $Fields[7] = 'S';
    }

    if (   $Fields[0] eq '          SCALEBY CASTLE'
        && $Fields[3] == 1833
        && $Fields[4] == 1
        && $Fields[5] == 4 )

    {
        $Fields[3] = '1834';
    }
    if (   $Fields[0] eq '          SCALEBY CASTLE'
        && $Fields[3] == 1825
        && $Fields[4] == 1
        && $Fields[5] == 21 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '          SCALEBY CASTLE'
        && $Fields[3] == 1821
        && $Fields[4] == 12
        && $Fields[5] == 10 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '          SCALEBY CASTLE'
        && $Fields[3] == 1825
        && $Fields[4] == 9
        && $Fields[5] == 13 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '          SCALEBY CASTLE'
        && $Fields[3] == 1817
        && $Fields[4] == 6
        && $Fields[5] == 25 )

    {
        $Fields[4] = '1';
    }
    if (   $Fields[0] eq '          SCALEBY CASTLE'
        && $Fields[3] == 1825
        && $Fields[4] == 9
        && $Fields[5] == 13 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '       SIR EDWARD HUGHES'
        && $Fields[3] == 1800
        && $Fields[4] == 11
        && $Fields[5] == 18 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '       SIR EDWARD HUGHES'
        && $Fields[3] == 1797
        && $Fields[4] == 5
        && $Fields[5] == 4 )

    {
        $Fields[7] = 'S';
    }

    if (   $Fields[0] eq '             TELLICHERRY'
        && $Fields[3] == 1799
        && $Fields[4] == 5
        && $Fields[5] == 18 )

    {
        $Fields[6] = '';
    }

    if ( $Fields[0] eq '          CHARLES GRANTV' )

    {
        $Fields[0] = '           CHARLES GRANT';
    }

    if (   $Fields[0] eq '           CHARLES GRANT'
        && $Fields[3] == '183' )

    {
        $Fields[3] = '1830';
    }
    if (   $Fields[0] eq '           CHARLES GRANT'
        && $Fields[3] == 1813
        && $Fields[4] == 7
        && $Fields[5] == 1 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '           CHARLES GRANT'
        && $Fields[3] == 1832
        && $Fields[4] == 8
        && $Fields[5] == 30 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '           CHARLES GRANT'
        && $Fields[3] == 1833
        && $Fields[4] == 2
        && $Fields[5] == 27 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '           CHARLES GRANT'
        && $Fields[3] == 1833
        && $Fields[4] == 3
        && $Fields[5] == 10 )

    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '           CHARLES GRANT'
        && $Fields[3] == 1823
        && $Fields[4] == 4
        && ( $Fields[5] >= 5 && $Fields[5] <= 7 ) )

    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '           CHARLES GRANT'
        && $Fields[3] == 1811
        && $Fields[4] == 7
        && $Fields[5] == 25 )

    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '            CALEDONIAN 2'
        && $Fields[3] == 1812 )

    {
        $Fields[3]  = '1802';
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '            CALEDONIAN 2'
        && $Fields[3] == 1802
        && $Fields[4] == 12
        && $Fields[5] == 17 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '            CALEDONIAN 2'
        && $Fields[3] == 1802
        && $Fields[4] == 10
        && $Fields[5] == 4 )

    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '           CHARLES GRANT'
        && $Fields[3] == 1825
        && $Fields[4] == 7
        && $Fields[5] == 24 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '           CHARLES GRANT'
        && $Fields[3] == 1829
        && $Fields[4] == 6
        && $Fields[5] == 5 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '           CHARLES GRANT'
        && $Fields[3] == 1832
        && $Fields[4] == 12
        && $Fields[5] == 22 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '           CHARLES GRANT'
        && $Fields[3] == 1813
        && $Fields[4] == 8
        && $Fields[5] == 17 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '             GOOD HOPE 3'
        && $Fields[3] == 1798
        && $Fields[4] == 10
        && $Fields[5] == 17 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '             GOOD HOPE 3'
        && $Fields[3] == 1797
        && $Fields[4] == 8
        && $Fields[5] == 22 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '             GOOD HOPE 3'
        && $Fields[3] == 1796
        && $Fields[4] == 7
        && $Fields[5] == 4 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '             GOOD HOPE 3'
        && $Fields[3] == 1798
        && $Fields[4] == 5
        && $Fields[5] == 22 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '             GOOD HOPE 3'
        && $Fields[3] == 1796
        && $Fields[4] == 8
        && $Fields[5] == 18 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '               LASCELLES'
        && $Fields[3] == 1798
        && $Fields[4] == 10
        && $Fields[5] == 17 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '               LASCELLES'
        && $Fields[3] == 1792
        && $Fields[4] == 12
        && $Fields[5] <= 24 )

    {
        $Fields[40] = 'Calcutta';    # Very dubious best guess
    }
    if (   $Fields[0] eq '               LASCELLES'
        && $Fields[3] == 1792
        && $Fields[4] == 8
        && $Fields[5] >= 10 )

    {
        $Fields[40] = 'Calcutta';    # Very dubious
    }
    if (   $Fields[0] eq '               LASCELLES'
        && $Fields[3] == 1795
        && $Fields[4] == 12
        && $Fields[5] == 3 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '     MARQUIS OF LANSDOWN'
        && $Fields[3] == 1799
        && $Fields[4] == 8
        && $Fields[5] == 22 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '     MARQUIS OF LANSDOWN'
        && $Fields[3] == 1798
        && $Fields[4] == 7
        && $Fields[5] == 3 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '                 ORPHEUS'
        && $Fields[3] == 1799
        && $Fields[4] == 1
        && $Fields[5] == 14 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '                 ORPHEUS'
        && $Fields[3] == 1799
        && $Fields[4] == 2
        && $Fields[5] == 27 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '                 ORPHEUS'
        && $Fields[3] == 1800
        && $Fields[4] == 4
        && $Fields[5] == 9 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '              OSTERLEY 3'
        && $Fields[3] == 1800
        && $Fields[4] == 5
        && $Fields[5] == 8 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '              OSTERLEY 3'
        && $Fields[3] == 1800
        && $Fields[4] == 1
        && $Fields[5] == 21 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '       PRINCESS AMELIA 3'
        && $Fields[3] == 1794
        && $Fields[4] == 1
        && $Fields[5] == 18 )

    {
        $Fields[6] = '';
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '       PRINCESS AMELIA 3'
        && $Fields[3] == 1793
        && $Fields[4] == 12
        && $Fields[5] == 10 )

    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '       PRINCESS AMELIA 3'
        && $Fields[3] == 1793
        && $Fields[4] == 8
        && $Fields[5] == 5 )

    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '       PRINCESS AMELIA 3'
        && $Fields[3] == 1794
        && $Fields[4] == 3
        && $Fields[5] == 17 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '       PRINCESS AMELIA 3'
        && $Fields[3] == 1795
        && $Fields[4] == 7
        && $Fields[5] == 17 )

    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '       PRINCESS AMELIA 4'
        && $Fields[3] == 1819
        && $Fields[4] == 4
        && $Fields[5] == 14 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '       PRINCESS AMELIA 4'
        && $Fields[3] == 1817
        && $Fields[4] == 1
        && $Fields[5] == 15 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '       PRINCESS AMELIA 4'
        && $Fields[3] == 1818
        && $Fields[4] == 5
        && $Fields[5] == 29 )

    {
        $Fields[9] = '';
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '       PRINCESS AMELIA 4'
        && $Fields[3] == 1813
        && $Fields[4] == 5
        && ( $Fields[5] == 13 || $Fields[5] == 14 ) )

    {
        $Fields[9] = '';
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '       PRINCESS AMELIA 4'
        && $Fields[3] == 1816
        && $Fields[4] == 11
        && $Fields[5] == 1 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '       PRINCESS AMELIA 4'
        && $Fields[3] == 1818
        && $Fields[4] == 12
        && $Fields[5] == 24 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '       PRINCESS AMELIA 4'
        && $Fields[3] == 1816
        && $Fields[4] == 9
        && $Fields[5] == 2 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '       PRINCESS AMELIA 4'
        && $Fields[3] == 1809
        && $Fields[4] == 5
        && $Fields[5] == 18 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '       PRINCESS AMELIA 4'
        && $Fields[3] == 1817
        && $Fields[4] == 7
        && ( $Fields[5] == 24 || $Fields[5] == 20 ) )

    {
        $Fields[6] = '';
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '       PRINCESS AMELIA 4'
        && $Fields[3] == 1816
        && $Fields[4] == 11
        && $Fields[5] == 15 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '       PRINCESS AMELIA 4'
        && $Fields[3] == 1813
        && $Fields[4] == 3
        && $Fields[5] == 22 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '       PRINCESS AMELIA 4'
        && $Fields[3] == 1811
        && $Fields[4] == 9
        && $Fields[5] == 4 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '       PRINCESS AMELIA 4'
        && $Fields[3] == 1818
        && $Fields[4] == 7
        && $Fields[5] == 24 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '       PRINCESS AMELIA 4'
        && $Fields[3] == 1818
        && $Fields[4] == 12
        && $Fields[5] == 24 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '       PRINCESS AMELIA 4'
        && $Fields[3] == 1810
        && $Fields[4] == 3
        && $Fields[5] == 5 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '       PRINCESS AMELIA 4'
        && $Fields[3] == 1821
        && $Fields[4] == 1
        && $Fields[5] == 9 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '       PRINCESS AMELIA 4'
        && $Fields[3] == 1818
        && $Fields[4] == 8
        && $Fields[5] == 20 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '       PRINCESS AMELIA 4'
        && $Fields[3] == 1812
        && $Fields[4] == 3
        && $Fields[5] == 16 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '       PRINCESS AMELIA 4'
        && $Fields[3] == 1821
        && $Fields[4] == 3
        && $Fields[5] == 19 )

    {
        $Fields[7] = 'S';
    }

    if (   $Fields[0] eq '         PRINCESS MARY 2'
        && $Fields[3] == 1803
        && $Fields[4] == 10
        && $Fields[5] == 22 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '         PRINCESS MARY 2'
        && $Fields[3] == 1802
        && $Fields[4] == 9
        && $Fields[5] == 26 )

    {
        $Fields[7] = 'S';
    }

    if (   $Fields[0] eq '    PRINCE WILLIAM HENRY'
        && $Fields[3] == 1797
        && $Fields[4] == 8
        && $Fields[5] == 24 )

    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '               SWALLOW 3'
        && $Fields[3] == 1792
        && $Fields[4] == 10
        && $Fields[5] == 27 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '               SWALLOW 3'
        && $Fields[3] == 1793
        && $Fields[4] == 6
        && $Fields[5] == 9 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '                THETIS 1'
        && $Fields[3] == 1796
        && $Fields[4] == 5
        && $Fields[5] == 29 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '                THETIS 1'
        && $Fields[3] == 1797
        && $Fields[4] == 10
        && $Fields[5] == 4 )

    {
        $Fields[9] = '';
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '                THETIS 1'
        && $Fields[3] == 1797
        && $Fields[4] == 3
        && $Fields[5] == 3 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '                THETIS 1'
        && $Fields[3] == 1797
        && $Fields[4] == 1
        && $Fields[5] == 7 )

    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '           BRIDGEWATER 3'
        && $Fields[3] == 1792
        && $Fields[4] == 2
        && $Fields[5] == 20 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '           BRIDGEWATER 3'
        && $Fields[3] == 1793
        && $Fields[4] == 3
        && $Fields[5] == 7 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '           BRIDGEWATER 3'
        && $Fields[3] == 1791
        && $Fields[4] == 11
        && $Fields[5] == 7 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '           BRIDGEWATER 3'
        && $Fields[3] == 1792
        && $Fields[4] == 9
        && ( $Fields[5] == 11 || $Fields[5] == 12 ) )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '           BRIDGEWATER 5'
        && $Fields[3] == 1817
        && $Fields[4] == 8
        && $Fields[5] == 19 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '           BRIDGEWATER 5'
        && $Fields[3] == 1817
        && $Fields[4] == 9
        && $Fields[5] == 2 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '           BRIDGEWATER 5'
        && $Fields[3] == 1830
        && $Fields[4] == 4
        && $Fields[5] == 19 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '           BRIDGEWATER 5'
        && $Fields[3] == 1830
        && $Fields[4] == 4
        && $Fields[5] == 14 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '           BRIDGEWATER 5'
        && $Fields[3] == 1821
        && $Fields[4] == 4
        && $Fields[5] == 30 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '           BRIDGEWATER 5'
        && $Fields[3] == 1823
        && $Fields[4] == 6
        && $Fields[5] == 6 )

    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '         EARL OF WYCOMBE'
        && $Fields[3] == 1797
        && $Fields[4] == 9
        && $Fields[5] == 23 )

    {
        $Fields[10] = 'W';
    }

    if (   $Fields[0] eq '             FARQUHARSON'
        && $Fields[3] == 1825
        && $Fields[4] == 2
        && $Fields[5] == 23 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '             FARQUHARSON'
        && $Fields[3] == 1827
        && $Fields[4] == 5
        && $Fields[5] == 10 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '             FARQUHARSON'
        && $Fields[3] == 1827
        && $Fields[4] == 7
        && $Fields[5] == 9 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '             FARQUHARSON'
        && $Fields[3] == 1833
        && $Fields[4] == 9
        && $Fields[5] == 5 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '                  KENT 7'
        && $Fields[3] == 1823
        && $Fields[4] == 1
        && $Fields[5] == 9 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '                 QUEEN 4'
        && $Fields[3] == 1795
        && $Fields[4] == 11
        && $Fields[5] == 2 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '                 QUEEN 4'
        && $Fields[3] == 1795
        && $Fields[4] == 3
        && $Fields[5] == 11 )

    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '              WATERLOO 1'
        && $Fields[3] == 1827
        && $Fields[4] == 9
        && $Fields[5] == 8 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '              WATERLOO 1'
        && $Fields[3] == 1826
        && $Fields[4] == 2
        && $Fields[5] == 26 )

    {
        $Fields[7] = 'S';
    }
    if (   $Fields[0] eq '              WATERLOO 1'
        && $Fields[3] == 1830
        && $Fields[4] == 4
        && $Fields[5] == 3 )

    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '              WATERLOO 1'
        && $Fields[3] == 1829
        && $Fields[4] == 6
        && $Fields[5] == 7 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '              WATERLOO 1'
        && $Fields[3] == 1829
        && $Fields[4] == 5
        && $Fields[5] == 20 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '              WATERLOO 1'
        && $Fields[3] == 1827
        && $Fields[4] == 4
        && $Fields[5] == 17 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '              WATERLOO 1'
        && $Fields[3] == 1827
        && $Fields[4] == 5
        && $Fields[5] == 13 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '              WATERLOO 1'
        && $Fields[3] == 1821
        && $Fields[4] == 3
        && $Fields[5] == 16 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '              WATERLOO 1'
        && $Fields[3] == 1817
        && $Fields[4] == 3
        && $Fields[5] == 29 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '            WINCHELSEA 3'
        && $Fields[3] == 1805
        && $Fields[4] == 1
        && $Fields[5] == 28 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '            WINCHELSEA 3'
        && $Fields[3] == 1805
        && $Fields[4] == 1
        && $Fields[5] == 5 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '            WINCHELSEA 3'
        && $Fields[3] == 1804
        && $Fields[4] == 8
        && $Fields[5] == 7 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '            WINCHELSEA 3'
        && $Fields[3] == 1804
        && $Fields[4] == 5
        && $Fields[5] == 26 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '            WINCHELSEA 3'
        && $Fields[3] == 1811
        && $Fields[4] == 5
        && $Fields[5] == 28 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '            WINCHELSEA 3'
        && $Fields[3] == 1805
        && $Fields[4] == 8
        && $Fields[5] == 12 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '            WINCHELSEA 3'
        && $Fields[3] == 1814
        && $Fields[4] == 7
        && $Fields[5] == 3 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '            WINCHELSEA 3'
        && $Fields[3] == 1832
        && $Fields[4] == 3
        && $Fields[5] == 24 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '            WINCHELSEA 3'
        && $Fields[3] == 1805
        && $Fields[4] == 3
        && $Fields[5] == 28 )

    {
        $Fields[7] = 'S';
    }

    if (   $Fields[0] eq '               BARWELL 1'
        && $Fields[3] == 1791
        && $Fields[4] == 2
        && $Fields[5] == 4 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '               BARWELL 1'
        && $Fields[3] == 1790
        && $Fields[4] == 1
        && ( $Fields[5] >= 28 && $Fields[5] <= 30 ) )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '                  BOMBAY'
        && $Fields[3] == 1833
        && $Fields[4] == 12
        && $Fields[5] == 6 )

    {
        $Fields[7] = 'S';
    }
     if (   $Fields[0] eq '                  BOMBAY'
        && $Fields[3] == 1833
        && $Fields[4] == 9
        && $Fields[5] == 22 )

    {
        $Fields[10] = 'E';
    }
     if (   $Fields[0] eq '                  BOMBAY'
        && $Fields[3] == 1833
        && $Fields[4] == 8
        && $Fields[5] == 10 )

    {
        $Fields[9] = '';
    }
     if (   $Fields[0] eq '                  BOMBAY'
        && $Fields[3] == 1820
        && $Fields[4] == 2
        && $Fields[5] == 4 )

    {
        $Fields[9] = '';
    }
     if (   $Fields[0] eq '                  BOMBAY'
        && $Fields[3] == 1820
        && $Fields[4] == 2
        && $Fields[5] == 2 )

    {
        $Fields[6] = '';
    }
     if (   $Fields[0] eq '                  BOMBAY'
        && $Fields[3] == 1820
        && $Fields[4] == 4
        && $Fields[5] == 18 )

    {
        $Fields[6] = '';
    }
     if (   $Fields[0] eq '                  BOMBAY'
        && $Fields[3] == 1832
        && $Fields[4] == 5
        && $Fields[5] == 7 )

    {
        $Fields[10] = 'W';
    }
     if (   $Fields[0] eq '                  BOMBAY'
        && $Fields[3] == 1831
        && $Fields[4] == 8
        && $Fields[5] == 11 )

    {
        $Fields[9] = '';
    }
     if (   $Fields[0] eq '                  BOMBAY'
        && $Fields[3] == 1831
        && $Fields[4] == 8
        && $Fields[5] == 10 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '                  BOMBAY'
        && $Fields[3] == 1815
        && $Fields[4] == 11
        && $Fields[5] == 12 )

    {
        $Fields[7] = 'S';
    }
    if (   $Fields[0] eq '                  BOMBAY'
        && $Fields[3] == 1814
        && $Fields[4] == 1
        && $Fields[5] == 13 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '                  BOMBAY'
        && $Fields[3] == 1817
        && $Fields[4] == 8
        && $Fields[5] == 9 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '                  BOMBAY'
        && $Fields[3] == 1817
        && $Fields[4] == 5
        && $Fields[5] == 1 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '                  BOMBAY'
        && $Fields[3] == 1818
        && $Fields[4] == 1
        && $Fields[5] == 21 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '                  BOMBAY'
        && $Fields[3] == 1818
        && $Fields[4] == 2
        && $Fields[5] == 28 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '          EARL OF OXFORD'
        && $Fields[3] == 1796
        && $Fields[4] == 6
        && $Fields[5] == 16 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '          EARL OF OXFORD'
        && $Fields[3] == 1796
        && $Fields[4] == 4
        && $Fields[5] == 24 )

    {
        $Fields[9] = '';
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '          EARL OF OXFORD'
        && $Fields[3] == 1796
        && $Fields[4] == 6
        && $Fields[5] == 2 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '          EARL OF OXFORD'
        && $Fields[3] == 1795
        && $Fields[4] == 8
        && $Fields[5] == 5 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '          EARL OF OXFORD'
        && $Fields[3] == 1795
        && $Fields[4] == 9
        && $Fields[5] == 1 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '          EARL OF OXFORD'
        && $Fields[3] == 1796
        && $Fields[4] == 4
        && $Fields[5] == 2 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '                EUROPA 2'
        && $Fields[3] == 1795
        && $Fields[4] == 7
        && $Fields[5] == 13 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '                EUROPE 2'
        && $Fields[3] == 1807
        && $Fields[4] == 3
        && $Fields[5] == 22 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '                EUROPE 2'
        && $Fields[3] == 1807
        && $Fields[4] == 3
        && $Fields[5] == 23 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '                EUROPE 2'
        && $Fields[3] == 1804
        && $Fields[4] == 8
        && $Fields[5] == 6 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '               FRANCIS 2'
        && $Fields[3] == 1796
        && $Fields[4] == 1
        && $Fields[5] == 26 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '         GENERAL GODDARD'
        && $Fields[3] == 1792
        && $Fields[4] == 5
        && $Fields[5] == 27 )

    {
        $Fields[7] = 'S';
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '           HEREFORDSHIRE'
        && $Fields[3] == 1832
        && $Fields[4] == 3
        && $Fields[5] == 24 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '           HEREFORDSHIRE'
        && $Fields[3] == 1823
        && $Fields[4] == 12
        && $Fields[5] == 15 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '           HEREFORDSHIRE'
        && $Fields[3] == 1826
        && $Fields[4] == 2
        && $Fields[5] == 12 )

    {
        $Fields[10] = 'W';
    }
     if (   $Fields[0] eq '           HEREFORDSHIRE'
        && $Fields[3] == 1824
        && $Fields[4] == 2
        && $Fields[5] == 24 )

    {
        $Fields[10] = 'W';
    }

    if (   $Fields[0] eq '             MIDDLESEX 2'
        && $Fields[3] == 1793
        && $Fields[4] == 5
        && $Fields[5] == 19 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '             MIDDLESEX 2'
        && $Fields[3] == 1792
        && $Fields[4] == 5
        && $Fields[5] == 15 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '             MIDDLESEX 2'
        && $Fields[3] == 1795
        && $Fields[4] == 4
        && ($Fields[5] == 10 || $Fields[5] == 11) )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '                RODNEY 2'
        && $Fields[3] == 1793
        && $Fields[4] == 5
        && $Fields[5] == 3 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '            VANSITTART 4'
        && $Fields[3] == 1820
        && $Fields[4] == 4
        && ($Fields[5] == 14 || $Fields[5] == 15) )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '            VANSITTART 4'
        && $Fields[3] == 1820
        && $Fields[4] == 3
        && $Fields[5] == 9 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '            VANSITTART 4'
        && $Fields[3] == 1820
        && $Fields[4] == 3
        && $Fields[5] == 26 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '            VANSITTART 4'
        && $Fields[3] == 1822
        && $Fields[4] == 1
        && $Fields[5] == 11 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '            VANSITTART 4'
        && $Fields[3] == 1834
        && $Fields[4] == 3
        && $Fields[5] == 9 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '            VANSITTART 4'
        && $Fields[3] == 1818
        && $Fields[4] == 1
        && $Fields[5] == 26 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '            VANSITTART 4'
        && $Fields[3] == 1833
        && $Fields[4] == 12
        && $Fields[5] == 25 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '            VANSITTART 4'
        && $Fields[3] == 1818
        && $Fields[4] == 2
        && $Fields[5] == 14 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '            VANSITTART 4'
        && $Fields[3] == 1829
        && $Fields[4] == 5
        && $Fields[5] == 12 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '            VANSITTART 4'
        && $Fields[3] == 1821
        && $Fields[4] == 8
        && $Fields[5] == 29 )

    {
        $Fields[7] = 'N';
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '              COLDSTREAM'
        && $Fields[3] == 1816
        && $Fields[4] == 5
        && $Fields[5] == 1 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '              COLDSTREAM'
        && $Fields[3] == 1813
        && $Fields[4] == 4
        && $Fields[5] == 20 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '    EARL OF CHESTERFIELD'
        && $Fields[3] == 1794
        && $Fields[4] == 8
        && $Fields[5] == 21 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '    EARL OF CHESTERFIELD'
        && $Fields[3] == 1793
        && $Fields[4] == 1
        && $Fields[5] == 15 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '    EARL OF CHESTERFIELD'
        && $Fields[3] == 1793
        && $Fields[4] == 5
        && $Fields[5] == 16 )

    {
        $Fields[7] = 'N';
    }

    if (   $Fields[0] eq '             GENERAL KYD'
        && $Fields[3] == 1816
        && $Fields[4] == 6
        && $Fields[5] == 13 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '             GENERAL KYD'
        && $Fields[3] == 1816
        && $Fields[4] == 3
        && $Fields[5] == 30 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '             GENERAL KYD'
        && $Fields[3] == 1815
        && $Fields[4] == 9
        && $Fields[5] == 7 )

    {
        $Fields[7] = 'N';
    }
    if (   $Fields[0] eq '             GENERAL KYD'
        && $Fields[3] == 1826
        && $Fields[4] == 2
        && $Fields[5] == 5 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '             GENERAL KYD'
        && $Fields[3] == 1827
        && $Fields[4] == 8
        && $Fields[5] == 11 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '             GENERAL KYD'
        && $Fields[3] == 1828
        && $Fields[4] == 1
        && $Fields[5] == 22 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '             GENERAL KYD'
        && $Fields[3] == 1827
        && $Fields[4] == 5
        && $Fields[5] == 23 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '             GENERAL KYD'
        && $Fields[3] == 1828
        && $Fields[4] == 2
        && $Fields[5] == 1 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '             GENERAL KYD'
        && $Fields[3] == 1829
        && $Fields[4] == 3
        && $Fields[5] == 1 )

    {
        $Fields[6] = '';
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '          LOWTHER CASTLE'
        && $Fields[3] == 1827
        && $Fields[4] == 2
        && $Fields[5] == 21 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '          LOWTHER CASTLE'
        && $Fields[3] == 1819
        && $Fields[4] == 12
        && $Fields[5] == 2 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '          LOWTHER CASTLE'
        && $Fields[3] == 1813
        && $Fields[4] == 7
        && $Fields[5] == 24 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '          LOWTHER CASTLE'
        && $Fields[3] == 1824
        && $Fields[4] == 3
        && $Fields[5] == 28 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '          LOWTHER CASTLE'
        && $Fields[3] == 1825
        && $Fields[4] == 5
        && $Fields[5] == 30 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '          LOWTHER CASTLE'
        && $Fields[3] == 1818
        && $Fields[4] == 5
        && $Fields[5] == 11 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '          LOWTHER CASTLE'
        && $Fields[3] == 1833
        && $Fields[4] == 5
        && $Fields[5] == 24 )

    {
        $Fields[7] = 'S';
    }
    if (   $Fields[0] eq '          LOWTHER CASTLE'
        && $Fields[3] == 1814
        && $Fields[4] == 8
        && $Fields[5] == 4 )

    {
        $Fields[10] = 'W';
    }

    if (   $Fields[0] eq ' MARQUIS OF WELLINGTON 1'
        && $Fields[3] == 1819
        && $Fields[4] == 6
        && $Fields[5] == 7 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq ' MARQUIS OF WELLINGTON 1'
        && $Fields[3] == 1819
        && $Fields[4] == 7
        && $Fields[5] == 15 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq ' MARQUIS OF WELLINGTON 1'
        && $Fields[3] == 1814
        && $Fields[4] == 6
        && $Fields[5] == 3 )

    {
        $Fields[7] = 'S';
    }
    if (   $Fields[0] eq ' MARQUIS OF WELLINGTON 1'
        && $Fields[3] == 1827
        && $Fields[4] == 8
        && $Fields[5] == 5 )

    {
        $Fields[7] = 'S';
    }
    if (   $Fields[0] eq ' MARQUIS OF WELLINGTON 1'
        && $Fields[3] == 1827
        && $Fields[4] == 9
        && $Fields[5] == 3 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq ' MARQUIS OF WELLINGTON 1'
        && $Fields[3] == 1819
        && $Fields[4] == 5
        && $Fields[5] == 28 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq ' MARQUIS OF WELLINGTON 1'
        && $Fields[3] == 1828
        && $Fields[4] == 6
        && ($Fields[5] == 1 || $Fields[5] == 2) )

    {
        $Fields[9] = '';
    }
    
    if (   $Fields[0] eq 'PRINCESS CHARLOTTE OF WA'
        && $Fields[3] == 1820
        && $Fields[4] == 3
        && $Fields[5] == 26 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq 'PRINCESS CHARLOTTE OF WA'
        && $Fields[3] == 1819
        && $Fields[4] == 6
        && $Fields[5] == 9 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq 'PRINCESS CHARLOTTE OF WA'
        && $Fields[3] == 1820
        && $Fields[4] == 4
        && $Fields[5] == 21 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq 'PRINCESS CHARLOTTE OF WA'
        && $Fields[3] == 1828
        && $Fields[4] == 2
        && $Fields[5] == 15 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq 'PRINCESS CHARLOTTE OF WA'
        && $Fields[3] == 1828
        && $Fields[4] == 2
        && $Fields[5] == 3 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq 'PRINCESS CHARLOTTE OF WA'
        && $Fields[3] == 1828
        && $Fields[4] == 4
        && $Fields[5] == 19 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq 'PRINCESS CHARLOTTE OF WA'
        && $Fields[3] == 1828
        && $Fields[4] == 3
        && $Fields[5] == 4 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq 'PRINCESS CHARLOTTE OF WA'
        && $Fields[3] == 1814
        && $Fields[4] == 2
        && $Fields[5] == 3 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq 'PRINCESS CHARLOTTE OF WA'
        && $Fields[3] == 1813
        && $Fields[4] == 7
        && $Fields[5] == 28 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq 'PRINCESS CHARLOTTE OF WA'
        && $Fields[3] == 1813
        && $Fields[4] == 7
        && $Fields[5] == 20 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq 'PRINCESS CHARLOTTE OF WA'
        && $Fields[3] == 1816
        && $Fields[4] == 5
        && $Fields[5] == 2 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq 'PRINCESS CHARLOTTE OF WA'
        && $Fields[3] == 1816
        && $Fields[4] == 6
        && $Fields[5] == 23 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq 'PRINCESS CHARLOTTE OF WA'
        && $Fields[3] == 1825
        && $Fields[4] == 7
        && ($Fields[5] == 12 || $Fields[5] == 13) )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq 'PRINCESS CHARLOTTE OF WA'
        && $Fields[3] == 1828
        && $Fields[4] == 2
        && $Fields[5] == 15 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '     PRINCESS OF WALES 3'
        && $Fields[3] == 1795
        && $Fields[4] == 9
        && $Fields[5] == 14 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '                 REPULSE'
        && $Fields[3] == 1828
        && $Fields[4] == 3
        && $Fields[5] == 12 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '    ABERCROMBIE ROBINSON'
        && $Fields[3] == 1832
        && $Fields[4] == 8
        && $Fields[5] == 28 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '    ABERCROMBIE ROBINSON'
        && $Fields[3] == 1830
        && $Fields[4] == 8
        && $Fields[5] == 18 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '    ABERCROMBIE ROBINSON'
        && $Fields[3] == 1830
        && $Fields[4] == 12
        && $Fields[5] == 3 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '    ABERCROMBIE ROBINSON'
        && $Fields[3] == 1831
        && $Fields[4] == 2
        && $Fields[5] == 7 )

    {
        $Fields[7] = 'S';
    }

    if (   $Fields[0] eq '               CAMBRIDGE'
        && $Fields[3] == 1826
        && $Fields[4] == 8
        && $Fields[5] == 22 )

    {
        $Fields[6] = '';
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '               CAMBRIDGE'
        && $Fields[3] == 1812
        && $Fields[4] == 3
        && $Fields[5] == 7 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '               CAMBRIDGE'
        && $Fields[3] == 1812
        && $Fields[4] == 6
        && $Fields[5] == 14 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '                MAITLAND'
        && $Fields[3] == 1828
        && $Fields[4] == 9
        && $Fields[5] == 14 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '          MARQUIS CAMDEN'
        && $Fields[3] == 1813
        && $Fields[4] == 8
        && $Fields[5] == 27 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '          MARQUIS CAMDEN'
        && $Fields[3] == 1821
        && $Fields[4] == 3
        && $Fields[5] == 19 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '          MARQUIS CAMDEN'
        && $Fields[3] == 1833
        && $Fields[4] == 5
        && $Fields[5] == 27 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '          MARQUIS CAMDEN'
        && $Fields[3] == 1833
        && $Fields[4] == 3
        && $Fields[5] == 20 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '      MARQUIS OF HUNTLEY'
        && $Fields[3] == 1822
        && $Fields[4] == 8
        && $Fields[5] == 12 )

    {
        $Fields[7] = 'S';
    }
    if (   $Fields[0] eq '      MARQUIS OF HUNTLEY'
        && $Fields[3] == 1833
        && $Fields[4] == 12
        && $Fields[5] == 5 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '      MARQUIS OF HUNTLEY'
        && $Fields[3] == 1812
        && $Fields[4] == 5
        && $Fields[5] == 1 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '      MARQUIS OF HUNTLEY'
        && $Fields[3] == 1813
        && $Fields[4] == 3
        && $Fields[5] == 20 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '      MARQUIS OF HUNTLEY'
        && $Fields[3] == 1813
        && $Fields[4] == 5
        && $Fields[5] == 11 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '                  ROSE 2'
        && $Fields[3] == 1800
        && $Fields[4] == 7
        && $Fields[5] == 25 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '                  ROSE 2'
        && $Fields[3] == 1800
        && $Fields[4] == 5
        && $Fields[5] == 11 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '                  ROSE 4'
        && $Fields[3] == 1812
        && $Fields[4] == 5
        && $Fields[5] == 8 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '                  ROSE 4'
        && $Fields[3] == 1813
        && $Fields[4] == 1
        && $Fields[5] == 30 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '                  ROSE 4'
        && $Fields[3] == 1813
        && $Fields[4] == 9
        && $Fields[5] == 24 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '                  ROSE 4'
        && $Fields[3] == 1817
        && $Fields[4] == 8
        && $Fields[5] == 10 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '                  ROSE 4'
        && $Fields[3] == 1818
        && $Fields[4] == 2
        && $Fields[5] == 8 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '                  ROSE 4'
        && $Fields[3] == 1826
        && $Fields[4] == 7
        && $Fields[5] == 27 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '         WILLIAM FAIRLIE'
        && $Fields[3] == 1832
        && $Fields[4] == 3
        && $Fields[5] == 28 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '         WILLIAM FAIRLIE'
        && $Fields[3] == 1823
        && $Fields[4] == 3
        && $Fields[5] == 21 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '         WILLIAM FAIRLIE'
        && $Fields[3] == 1823
        && $Fields[4] == 3
        && $Fields[5] == 28 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '         WILLIAM FAIRLIE'
        && $Fields[3] == 1828
        && $Fields[4] == 5
        && $Fields[5] == 17 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '     MARQUIS OF HASTINGS'
        && $Fields[3] == 1830
        && $Fields[4] == 8
        && $Fields[5] == 19 )

    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '           BROXBORNEBURY'
        && $Fields[3] == 1812
        && $Fields[4] == 8
        && $Fields[5] == 12 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '           BROXBORNEBURY'
        && $Fields[3] == 1813
        && $Fields[4] == 6
        && $Fields[5] == 22 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '           BROXBORNEBURY'
        && $Fields[3] == 1813
        && $Fields[4] == 4
        && $Fields[5] == 2 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '          DUKE OF SUSSEX'
        && $Fields[3] == 1831
        && $Fields[4] == 12
        && $Fields[5] == 18 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '          DUKE OF SUSSEX'
        && $Fields[3] == 1831
        && $Fields[4] == 5
        && $Fields[5] == 27 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '          DUKE OF SUSSEX'
        && $Fields[3] == 1831
        && $Fields[4] == 2
        && $Fields[5] == 28 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '                GANGES 1'
        && $Fields[3] == 1792
        && $Fields[4] == 6
        && $Fields[5] == 8 )

    {
        $Fields[7] = 'N';
    }

    if (   $Fields[0] eq '                GANGES 3'
        && $Fields[3] == 1802
        && $Fields[4] == 9
        && $Fields[5] == 1 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '                GANGES 3'
        && $Fields[3] == 1798
        && $Fields[4] == 11
        && $Fields[5] == 16 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '                GANGES 3'
        && $Fields[3] == 1801
        && $Fields[4] == 11
        && $Fields[5] == 6 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq 'GEORGE THE FOURTH (GEORG'
        && $Fields[3] == 1827
        && $Fields[4] == 1
        && $Fields[5] == 10 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq 'GEORGE THE FOURTH (GEORG'
        && $Fields[3] == 1826
        && $Fields[4] == 9
        && $Fields[5] == 9 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '                 MANGLES'
        && $Fields[3] == 1818
        && $Fields[4] == 8
        && $Fields[5] == 31 )

    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '                THAMES 2'
        && $Fields[3] == 1812
        && $Fields[4] == 1
        && $Fields[5] == 6 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '                THAMES 2'
        && $Fields[3] == 1813
        && $Fields[4] == 5
        && $Fields[5] == 8 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '                THAMES 2'
        && $Fields[3] == 1803
        && $Fields[4] == 1
        && $Fields[5] == 4 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '                THAMES 2'
        && $Fields[3] == 1804
        && $Fields[4] == 9
        && $Fields[5] == 1 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '                THAMES 5'
        && $Fields[3] == 1824
        && $Fields[4] == 9
        && $Fields[5] == 14 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '                THAMES 5'
        && $Fields[3] == 1825
        && $Fields[4] == 2
        && $Fields[5] == 25 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '                THAMES 5'
        && $Fields[3] == 1826
        && $Fields[4] == 2
        && $Fields[5] == 19 )

    {
        $Fields[9] = '';
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '                THAMES 5'
        && $Fields[3] == 1827
        && $Fields[4] == 5
        && $Fields[5] == 23 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '                THAMES 5'
        && $Fields[3] == 1827
        && $Fields[4] == 5
        && $Fields[5] == 31 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '                THAMES 5'
        && $Fields[3] == 1827
        && $Fields[4] == 6
        && $Fields[5] == 9 )

    {
        $Fields[6] = '';
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '                THAMES 5'
        && $Fields[3] == 1827
        && $Fields[4] == 5
        && $Fields[5] == 26 )

    {
        $Fields[6] = '';
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '                THAMES 5'
        && $Fields[3] == 1820
        && $Fields[4] == 3
        && $Fields[5] == 5 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '       WARREN HASTINGS 3'
        && $Fields[3] == 1819
        && $Fields[4] == 6
        && $Fields[5] == 25 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '       WARREN HASTINGS 3'
        && $Fields[3] == 1819
        && $Fields[4] == 6
        && $Fields[5] == 17 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '       WARREN HASTINGS 3'
        && $Fields[3] == 1819
        && $Fields[4] == 6
        && $Fields[5] == 12 )

    {
        $Fields[6] = '';
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '       WARREN HASTINGS 3'
        && $Fields[3] == 1831
        && $Fields[4] == 8
        && $Fields[5] == 1 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '       WARREN HASTINGS 3'
        && $Fields[3] == 1831
        && $Fields[4] == 8
        && $Fields[5] == 8 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '       WARREN HASTINGS 3'
        && $Fields[3] == 1809
        && $Fields[4] == 2
        && $Fields[5] == 28 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '       WARREN HASTINGS 3'
        && $Fields[3] == 1809
        && $Fields[4] == 6
        && $Fields[5] == 30 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '       WARREN HASTINGS 3'
        && $Fields[3] == 1809
        && $Fields[4] == 7
        && $Fields[5] == 1 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '       WARREN HASTINGS 3'
        && $Fields[3] == 1810
        && $Fields[4] == 4
        && $Fields[5] == 25 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '       WARREN HASTINGS 3'
        && $Fields[3] == 1810
        && $Fields[4] == 6
        && $Fields[5] == 20 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '       WARREN HASTINGS 3'
        && $Fields[3] == 1827
        && $Fields[4] == 11
        && $Fields[5] == 10 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '       WARREN HASTINGS 3'
        && $Fields[3] == 1816
        && $Fields[4] == 6
        && $Fields[5] == 3 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '       WARREN HASTINGS 3'
        && $Fields[3] == 1821
        && $Fields[4] == 5
        && $Fields[5] == 17 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '       WARREN HASTINGS 3'
        && $Fields[3] == 1820
        && $Fields[4] == 4
        && $Fields[5] == 7 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '       WARREN HASTINGS 3'
        && $Fields[3] == 1820
        && $Fields[4] == 4
        && $Fields[5] == 12 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '       WARREN HASTINGS 5'
        && $Fields[3] == 1815
        && $Fields[4] == 7
        && $Fields[5] == 30 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '       WARREN HASTINGS 5'
        && $Fields[3] == 1811
        && $Fields[4] == 7
        && $Fields[5] == 4 )

    {
        $Fields[10] = 'E';
    }

    if (   $Fields[0] eq '          DUKE OF YORK 2'
        && $Fields[3] == 1829
        && $Fields[4] == 4
        && $Fields[5] == 22 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '          DUKE OF YORK 2'
        && $Fields[3] == 1825
        && $Fields[4] == 8
        && $Fields[5] == 10 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '          DUKE OF YORK 2'
        && $Fields[3] == 1818
        && $Fields[4] == 3
        && $Fields[5] == 3 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '          DUKE OF YORK 2'
        && $Fields[3] == 1819
        && $Fields[4] == 2
        && $Fields[5] == 9 )

    {
        $Fields[6] = '';
    }

    if (   $Fields[0] eq '           KELLIE CASTLE'
        && $Fields[3] == 1821
        && $Fields[4] == 4
        && $Fields[5] == 13 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '           KELLIE CASTLE'
        && $Fields[3] == 1822
        && $Fields[4] == 3
        && $Fields[5] == 23 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '           KELLIE CASTLE'
        && $Fields[3] == 1819
        && $Fields[4] == 6
        && $Fields[5] == 1 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '           KELLIE CASTLE'
        && $Fields[3] == 1819
        && $Fields[4] == 7
        && $Fields[5] == 1 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '           KELLIE CASTLE'
        && $Fields[3] == 1819
        && $Fields[4] == 6
        && $Fields[5] >= 22 )

    {
        $Fields[10] = 'E';
    }
    if (   $Fields[0] eq '           KELLIE CASTLE'
        && $Fields[3] == 1825
        && $Fields[4] == 12
        && $Fields[5] == 8 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '           KELLIE CASTLE'
        && $Fields[3] == 1833
        && $Fields[4] == 12
        && $Fields[5] == 25 )

    {
        $Fields[7] = 'S';
    }
    if (   $Fields[0] eq '           KELLIE CASTLE'
        && $Fields[3] == 1824
        && $Fields[4] == 3
        && $Fields[5] == 2 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '           KELLIE CASTLE'
        && $Fields[3] == 1823
        && $Fields[4] == 12
        && $Fields[5] == 30 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '           KELLIE CASTLE'
        && $Fields[3] == 1828
        && $Fields[4] == 3
        && $Fields[5] >= 13 )

    {
        $Fields[10] = 'W';
    }
    if (   $Fields[0] eq '           KELLIE CASTLE'
        && $Fields[3] == 1827
        && $Fields[4] == 5
        && $Fields[5] == 20 )

    {
        $Fields[7] = 'S';
    }

    if (   $Fields[0] eq '               NEPTUNE 5'
        && $Fields[3] == 1809
        && $Fields[4] == 3
        && $Fields[5] == 21 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '               NEPTUNE 5'
        && $Fields[3] == 1809
        && $Fields[4] == 3
        && $Fields[5] == 29 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '               NEPTUNE 5'
        && $Fields[3] == 1801
        && $Fields[4] == 8
        && $Fields[5] == 26 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '               NEPTUNE 5'
        && $Fields[3] == 1800
        && $Fields[4] == 10
        && $Fields[5] == 25 )

    {
        $Fields[6] = '';
    }
    if (   $Fields[0] eq '               NEPTUNE 5'
        && $Fields[3] == 1801
        && $Fields[4] == 11
        && $Fields[5] == 16 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '               NEPTUNE 5'
        && $Fields[3] == 1804
        && $Fields[4] == 10
        && $Fields[5] == 28 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '               NEPTUNE 5'
        && $Fields[3] == 1805
        && $Fields[4] == 8
        && $Fields[5] == 18 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '           THOMAS COUTTS'
        && $Fields[3] == 1819
        && $Fields[4] == 1
        && $Fields[5] == 30 )

    {
        $Fields[9] = '';
    }
    if (   $Fields[0] eq '           THOMAS COUTTS'
        && $Fields[3] == 1818
        && $Fields[4] == 8
        && $Fields[5] == 5 )

    {
        $Fields[9] = '';
    }

    if (   $Fields[0] eq '           THOMAS COUTTS'
        && $Fields[3] == 1819
        && $Fields[4] == 2
        && $Fields[5] == 20 )

    {
        $Fields[10] = 'W';
    }
    
    if (   $Fields[0] eq '              OSTERLEY 3'
        && $Fields[3] == 1798
        && $Fields[4] == 12
        && $Fields[5] == 12 )

    {
        $Fields[10] = 'E';
    }

    return @Fields;

}

1;
