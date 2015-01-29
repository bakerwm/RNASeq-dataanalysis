#!/usr/bin/perl -w
use strict;
use warnings;

use Bio::EnsEMBL::Registry;

my $registry = 'Bio::EnsEMBL::Registry';
$registry->load_registry_from_db(
        -host => 'ensembldb.ensembl.org',
        -user => 'anonymous'
        );

my $gene_adaptor = $registry->get_adaptor('Human', 'Core', 'Gene');

my $gene = $gene_adaptor->fetch_by_stable_id('ENSG00000139618');

my $gene_xrefs = $gene->get_all_DBEntries;

print "Xrefs on gene level: \n\n";

foreach my $gene_xref (@{$gene_xrefs}){
    print $gene_xref->dbname, ":\t", $gene_xref->display_id, "\n";
}

my $all_xrefs = $gene->get_all_DBLinks;

print "\nXrefs on gene, transcript and protein level: \n\n";

foreach my $all_xref (@{$all_xrefs} ){
    print $all_xref->dbname, ":\t", $all_xref->display_id, "\n";
}
