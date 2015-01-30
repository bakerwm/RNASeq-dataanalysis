#!/usr/bin/perl -w
use strict;
use warnings;

#use Bio::EnsEMBL::Registry;
use Bio::EnsEMBL::LookUp;
use Bio::EnsEMBL::Compara::DBSQL::DBAdaptor;

use Data::Dumper;

my $input_family = 'MF_00395'; #

# Retrieve genes from a given family
my $lookup = Bio::EnsEMBL::LookUp->new();

# load compara adaptor
my $compara_dba = Bio::EnsEMBL::Compara::DBSQL::DBAdaptor->new(
        -host => 'mysql-eg-publicsql.ebi.ac.uk',
        -port => '4157',
        -user => 'anonymous',
        -dbname => 'ensembl_compara_bacteria_25_78'
        );

my $family = $compara_dba->get_FamilyAdaptor()->fetch_by_stable_id($input_family);

# output
print "Retrieve genes from a given family\n";
print "Input family: ", $family->stable_id(), " ", $family->description(), "\n\n";

print "Output:\n", "Gene", "\t", "GeneName", "\t", "Species", "\n";
# find members in the family
my $members = $family->get_all_Members();
foreach my $member (@{$members}){
    my $genome_db = $member->genome_db();

    # member dba
    my $member_dba = $lookup->get_by_name_exact($genome_db->name());
    if(defined $member_dba){
        my $gene_adaptor = $member_dba->get_GeneAdaptor();
        my $gene = $gene_adaptor->fetch_by_stable_id($member->gene_member()->stable_id());
        my $gene_external_name  = (defined $gene->external_name())?$gene->external_name():"-";
        print $gene->stable_id(), "\t", $gene_external_name, "\t", $member_dba->species(), "\n";
        $member_dba->dbc()->disconnect_if_idle();
    }
}

