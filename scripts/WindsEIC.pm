# Module to handle decoding of wind speed data
#  from the EIC logs

package WindsEIC;

use strict;
no strict 'refs';    #  Still don't understand this
use warnings;
use Carp;
use MarineOb::WindTerms qw(WordsToBeaufort);
@WindsEIC::ISA       = ('Exporter');
@WindsEIC::EXPORT_OK = qw(ncdc_to_beaufort);

# Translation table for NCDC numeric format to words

my %NumberToWords = (
    '001' => 'Air',
    '002' => 'Breeze',
    '003' => 'Calm',
    '004' => 'Favorable',
    '005' => 'Gale',
    '006' => 'Hard',
    '007' => 'Hurricane',
    '008' => 'Monsoon',
    '009' => 'Puff',
    '010' => 'Storm',
    '011' => 'Sea',
    '012' => 'Tempest',
    '013' => 'Trade',
    '014' => 'Typhoon',
    '015' => 'Wind',
    '016' => 'More',
    '017' => 'Lighter',
    '018' => 'Gust',
    '019' => 'Large',
    '020' => 'Low',
    '021' => 'Land',
    '022' => 'Sharp',
    '023' => 'Hauling',
    '024' => 'Drawing',
    '025' => 'Blow',
    '026' => 'Very',
    '028' => 'Quite',
    '029' => 'Bad',
    '030' => 'Round',
    '031' => 'Rather',
    '032' => 'Stray',
    '033' => 'Scant',
    '034' => 'Abating',
    '035' => 'Slight',
    '036' => 'Raising',
    '037' => 'Descending',
    '038' => 'Veering',
    '039' => 'Confused',
    '040' => 'Favorable',
    '041' => 'Baffling',
    '042' => 'Blowing',
    '043' => 'Brisk',
    '044' => 'Changeable',
    '045' => 'Declining',
    '046' => 'Easy',
    '047' => 'Faint',
    '048' => 'Fine',
    '049' => 'Fresh',
    '050' => 'Furious',
    '051' => 'Gentle',
    '052' => 'Good',
    '053' => 'Hard',
    '054' => 'Heavy',
    '055' => 'Increasing',
    '056' => 'Leading',
    '057' => 'Less',
    '058' => 'Light',
    '059' => 'Little',
    '060' => 'Moderate',
    '061' => 'Nice',
    '062' => 'Pleasant',
    '063' => 'Powerful',
    '064' => 'Severe',
    '065' => 'Small',
    '066' => 'Smart',
    '067' => 'Steady',
    '068' => 'Stiff',
    '069' => 'Strong',
    '070' => 'Top-Gallant',
    '071' => 'Tremendous',
    '072' => 'Unsteady',
    '073' => 'Variable',
    '074' => 'Violent',
    '075' => 'Whole',
    '076' => 'Freshened',
    '078' => 'Delightful',
    '079' => 'Freshening',
    '080' => 'Moderating',
    '081' => 'Springing',
    '082' => 'Gusts',
    '083' => 'Disagreeable',
    '084' => 'Settled',
    '085' => 'Gusty',
    '086' => 'Inclining',
    '087' => 'Squalls',
    '088' => 'Freshes',
    '089' => 'Decreasing',
    '090' => 'Promising',
    '091' => 'Foul',
    '092' => 'Mostly',
    '093' => 'High',
    '094' => 'Spurts',
    '095' => 'Gradually',
    '097' => 'Getting',
    '098' => 'Shifted',
    '099' => 'Increased',
    '100' => 'Settling',
    '101' => 'Freshing',
    '102' => 'Much',
    '103' => 'Dying',
    '105' => 'Regular',
    '107' => 'Almost',
    '106' => 'Middling',
    '109' => 'Abated',
    '110' => 'Perfect',
    '111' => 'Close',
    '114' => 'One',
    '115' => 'Ones',
    '119' => 'Decreased',
    '120' => 'Agreeable',
    '124' => 'Subtle',
    '125' => 'Lightish',
    '126' => 'Feeble',
    '127' => 'Delicate',
    '136' => 'Passing',
    '138' => 'Stronger',
    '145' => 'Frequent',
    '146' => 'Charming',
    '148' => 'Trifling',
    '149' => 'Clear',
    '164' => 'Fair',
    '179' => 'Inclinable',
    '735' => 'Windy',
    '750' => 'Unsettled',
    '780' => 'Nearly',
    '795' => 'Falling',
    '810' => 'Stirring',
    '840' => 'Up',
    '850' => 'Mild',
);

sub ncdc_to_words {
    my @ncdc = (@_);
    my @Words;
    for my $Number (@ncdc) {
        unless ( defined($Number) && $Number =~ /\d/ ) { next; }
        my $Word = $NumberToWords{$Number};
        unless ( defined( $NumberToWords{$Number} ) ) {
            warn "Bad Number $Number";
            return;
        }
        push @Words, $NumberToWords{$Number};
    }
    return @Words;
}

# Returns -1 for failure - undef means good set of words with no
#  associated beaufort force.
sub ncdc_to_beaufort {
    my @ncdc  = (@_);
    my @Words = ncdc_to_words(@ncdc);
    unless (@Words) { return -1; }
    return WordsToBeaufort(@Words);
}

1;

