#!/usr/bin/perl -w
use strict;
use warnings;

use Bio::EnsEMBL::LookUp;
use Bio::EnsEMBL::Compara::DBSQL::DBAdaptor;

my $lookup = Bio::EnsEMBL::LookUp->new();


# Find dba
my @dbas = $lookup->get_by_name_pattern('prochlorococcus_marinus');


# find all genomes of a filter
my $taxid = 1219; # prochlorococcus marinus, prochlorococcus_marinus_str_natl2a

my %target_species = map{$_->species() => $_} @{$lookup->get_all_by_taxon_branch($taxid)};

# load compara adaptor
my $compara_dba = Bio::EnsEMBL::Compara::DBSQL::DBAdaptor->new(
        -host => 'mysql-eg-publicsql.ebi.ac.uk',
        -port => '4157',
        -user => 'anonymous',
#        -dbname => 'ensembl_compara_bacteria_24_77'
        -dbname => 'bacteria_17_collection_core_25_78_1'
        );

# find the corresponding member
my $family = $compara_dba->get_FamilyAdaptor()->fetch_by_stable_id('MF_00395');
print "Family ", $family->stable_id(), "\n";

foreach my $member (@{$family->get_all_Members()}){
    my $genome_db = $member->genome_db();
    # filter by taxon from the calculated list
    my $member_dba = $target_species{$genome_db->name()};
    if(defined $member_dba){
        my $gene = $member_dba->get_GeneAdaptor()->fetch_by_stable_id($member->gene_member()->stable_id());
        print $member_dba->species(), " ", $gene->external_name, "\n";
        $member_dba->dbc()->disconnect_if_idle();
    }
}

