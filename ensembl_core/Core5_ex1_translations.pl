#!/usr/bin/perl -w
use strict;
use warnings;

use Bio::EnsEMBL::Registry;

my $registry = 'Bio::EnsEMBL::Registry';
$registry->load_registry_from_db(
        -host => 'ensembldb.ensembl.org',
        -user => 'anonymous'
        );

my $transcript_adaptor = $registry->get_adaptor('Human', 'Core', 'Transcript');

my $transcript = $transcript_adaptor->fetch_by_stable_id('ENST00000333012');

my $translation = $transcript->translation;

print "Translation: ", $translation->stable_id, "\n";
print "Start Exon: ", $translation->start_Exon->stable_id, "\n";
print "End Exon: ", $translation->end_Exon->stable_id, "\n";

print "Start: ", $translation->cdna_start, "\n";
print "End: ", $translation->cdna_end, "\n";

print "Peptide: ", $transcript->translate->seq, "\n";

