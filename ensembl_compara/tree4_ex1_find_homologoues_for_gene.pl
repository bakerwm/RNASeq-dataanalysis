#!/usr/bin/perl -w
use strict;
use warnings;

use Bio::EnsEMBL::Registry;

my $reg = "Bio::EnsEMBL::Registry";
$reg->load_registry_from_url('mysql://anonymous@ensembldb.ensembl.org');

# 1. ex1 Find homogoues for a gene
my $gene_member_adaptor = $reg->get_adaptor("Multi", "compara", "GeneMember");

my $homology_adaptor = $reg->get_adaptor("Multi", "compara", "Homology");

#my $gene_member = $gene_member_adaptor->fetch_by_stable_id("ENSEMBLGENE", "ENSG00000229314");
my $gene_member = $gene_member_adaptor->fetch_by_stable_id('ENSG00000229314'); # changed by Ming, delete "ENSEMBLGENE" in para

my $all_homologies = $homology_adaptor->fetch_all_by_Member($gene_member); 

foreach my $this_homology (@{$all_homologies}) {
    ## print the description (type of homology) and the
    ## subtype (taxonomy level of the event: duplic. or speciation)
    print $this_homology->description(), " [", $this_homology->taxonomy_level(), "]\n";

    ## print the members in this homology
    my $gene_members = $this_homology->get_all_GeneMembers();
    foreach my $this_member (@{$gene_members}) {
        print $this_member->source_name(), " ", $this_member->stable_id(), " (", $this_member->genome_db()->name(()), ")\n";
    }
    print "\n";
}

