#!/usr/bin/perl -w
use strict;
use warnings;

use Bio::EnsEMBL::Registry;
use Bio::EnsEMBL::LookUp;
use Bio::EnsEMBL::Compara::DBSQL::DBAdaptor;

use Data::Dumper;

# find all genomes that descendants of a specified node (as a filter)

my $lookup = Bio::EnsEMBL::LookUp->new();

my $input_family = 'MF_00395';

my $taxid = 1219; # Prochlorococcus marinus
my $branches = $lookup->get_all_by_taxon_branch($taxid);
my %target_species = map {$_->species() => $_ } @{$branches};

# load family adaptors
#my $reg = 'Bio::EnsEMBL::Registry';
#$reg->load_registry_from_db(
#        -host => 'mysql-eg-publicsql.ebi.ac.uk',
#        -port => '4157',
#        -user => 'anonymous'
#        );
#
#my $family_adaptor = $reg->get_adaptor(
#        'bacteria', 'compara', 'Family'
#        );
#
#my $family = $family_adaptor->fetch_by_stable_id($input_family);

# load compara adaptors
my $compara_dba = Bio::EnsEMBL::Compara::DBSQL::DBAdaptor->new(
        -host => 'mysql-eg-publicsql.ebi.ac.uk',
        -port => '4157',
        -user => 'anonymous',
        -dbname => 'ensembl_compara_bacteria_25_78'        
        );
my $family = $compara_dba->get_FamilyAdaptor()->fetch_by_stable_id($input_family);

print "Retrieve genes from a given family, of specific genomes\n";
print "Input family: ", $family->stable_id(), "\t", $family->description(), "\n";

# find members in this family
print "Find members of taxid 1219 in this family\n\n";
print "GeneID", "\t", "Species", "\n";
my $members = $family->get_all_Members();
foreach my $member (@{$members}){
    my $genome_db = $member->genome_db();
     
    # filter by taxon from the list
    my $member_dba = $target_species{$genome_db->name()};
    if(defined $member_dba){
        my $gene_adaptor = $member_dba->get_GeneAdaptor();
        my $gene = $gene_adaptor->fetch_by_stable_id($member->gene_member()->stable_id());
        
        my $out_gene_name = (defined $gene->stable_id())?$gene->stable_id():"-";
        my $out_gene_ext  = (defined $gene->external_name())?$gene->external_name():"-";
        my $out_species = (defined $member_dba->species())?$member_dba->species():"-";
        print $out_gene_name, "\t", $out_gene_ext, "\t", $out_species, "\n";
        $member_dba->dbc()->disconnect_if_idle();
    }
}

