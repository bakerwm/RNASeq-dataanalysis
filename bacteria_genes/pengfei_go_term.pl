#!/usr/bin/perl -w
use strict;
use warnings;

use Bio::EnsEMBL::LookUp;
use Bio::EnsEMBL::DBSQL::OntologyDBAdaptor;

my $nom = 'mycobacterium_tuberculosis_h37rv_gca_000195955_2';
#my $nom = 'methanocella_conradii_hz254';

my $lookup = Bio::EnsEMBL::LookUp->new();

# find the correct database adaptor using a unique name
my $dba = $lookup->get_by_name_exact($nom);
my $genes = $dba->get_GeneAdaptor()->fetch_all();

# 
print "Found ". scalar(@{$genes}). " genes for ". $dba->species(). "\n";

# Find the GO term for each gene
my $ontology_dba = Bio::EnsEMBL::DBSQL::OntologyDBAdaptor->new(
        -HOST => 'mysql.ebi.ac.uk',
        -USER => 'anonymous',
        -PROT => '4157',
        -group => 'ontology',
        -dbname => 'ensemblgenomes_ontology_21_78',
        -species => 'multi'
        );

my $goads = $ontology_dba->get_adaptor('OntologyTerm');

## get go information
open (F, ">> RvGene_GO.txt");
foreach my $gene (@$genes){
    foreach my $link (@{$genes->get_all_DBLinks}){
        if($link->database eq 'GO'){
            my $term_id = $link->display_id;
            my $term_name = '-';
            my $term = $goads->fetch_by_accession($term_id);
            if($term && $term->name) {
                $term_name = $term->name;
            }
            print F $gene->stable_id, "\t", $term_id, "\n";
        }
    }
}

close F;


