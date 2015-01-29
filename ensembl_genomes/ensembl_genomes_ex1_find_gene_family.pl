#!/usr/bin/perl -w
use strict;
use warnings;

use Bio::EnsEMBL::Registry;
use Bio::EnsEMBL::LookUp;
use Bio::EnsEMBL::Compara::DBSQL::DBAdaptor;

my $lookup = Bio::EnsEMBL::LookUp->new();

my $nom = 'escherichia_coli_str_k_12_substr_mg1655';
print "Gettting DBA for $nom \n";

#my $dbas = $lookup->get_by_name_exact('mycobacterium_tuberculosis');
my $dbas = $lookup->get_by_name_exact($nom);
#my ($dba) = @{$helper->get_by_name_exact($nom)};

my $gene_adaptor = $dbas->get_GeneAdaptor();
my $gene = $gene_adaptor->fetch_by_stable_id('b0344');
print "Found gene ". $gene->external_name(). "\n";

# load compara adaptor
my $compara = Bio::EnsEMBL::Compara::DBSQL::DBAdaptor->new(
        -HOST => 'mysql-eg-publicsql.ebi.ac.uk',
        -USER => 'anonymous',
        -PROT => '4157',
        -DBNAME => 'ensembl_compara_bacteria_24_77'
        );

my $member_adaptor = $compara->get_GeneMemberAdaptor();
my $member = $member_adaptor->fetch_by_source_stable_id(
        'ENSEMBLGENE', $gene->stable_id()
        );

print $member, "\n";

##for my $family (@{$compara->get_FamilyAdaptor()->fetch_all_by_Member($member)}){
##    print "Family ". $family->stable_id(). "\n";
##
##}
#
