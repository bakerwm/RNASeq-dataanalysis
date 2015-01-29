#!/usr/bin/perl -w
use strict;
use warnings;

use Bio::EnsEMBL::Registry;

my $registry = 'Bio::EnsEMBL::Registry';
$registry->load_registry_from_db(
        -host =>'ensembldb.ensembl.org',
        -user => 'anonymous'
        );

my $slice_adaptor = $registry->get_adaptor('Human', 'Core', 'Slice');

# fetch by gene stable id with 2kb of flanking dna
my $slice = $slice_adaptor->fetch_by_gene_stable_id('ENSG00000101266', 2000);


print "Done, Core3_ex2.pl\n";
