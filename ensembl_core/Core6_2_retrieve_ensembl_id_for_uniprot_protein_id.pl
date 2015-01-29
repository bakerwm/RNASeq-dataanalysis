#!/usr/bin/perl -w
use strict;
use warnings;

use Bio::EnsEMBL::Registry;

my $registry = 'Bio::EnsEMBL::Registry';
$registry->load_registry_from_db(
        -host => 'ensembldb.ensembl.org',
        -user => 'anonymous'
        );

my $translation_adaptor = $registry->get_adaptor('Human', 'Core', 'Translation');

my @uniprot_ids = qw(P51587 P15056 B8A597 B8A595 B7ZW72);

foreach my $uniprot_id (@uniprot_ids){
    my @trans = @{$translation_adaptor->fetch_all_by_external_name($uniprot_id, 'Uniprot%')};
    foreach my $translation (@trans){
        print $translation->stable_id. "\t". $uniprot_id. "\n";
    }
}


