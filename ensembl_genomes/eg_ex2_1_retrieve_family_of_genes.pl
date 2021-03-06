#!/usr/bin/perl -w
use strict;
use warnings;

use Bio::EnsEMBL::Registry;
use Bio::EnsEMBL::LookUp;
use Bio::EnsEMBL::Compara::DBSQL::DBAdaptor;

use Data::Dumper;

# Retrieve the family of a given gene

#my $nom = 'mycobacterium_tuberculosis_h37rv_gca_000195955_2';
#my $input_gene = 'Rv2925c'; # RNase III
my $nom = 'escherichia_coli_str_k_12_substr_mg1655';
my $input_gene = 'b0344';

my $lookup = Bio::EnsEMBL::LookUp->new();

# load gene adaptor
my $dba = $lookup->get_by_name_exact($nom);

my $gene_adaptor = $dba->get_GeneAdaptor();

my $gene = $gene_adaptor->fetch_by_stable_id($input_gene); # lacZ

# load Registry
my $registry = 'Bio::EnsEMBL::Registry';
$registry->load_registry_from_db(
        -host => 'mysql-eg-publicsql.ebi.ac.uk',
        -port => '4157',
        -user => 'anonymous'
        );

my $member_adaptor = $registry->get_adaptor('bacteria', 'compara', 'GeneMember');

my $family_adaptor = $registry->get_adaptor('bacteria', 'compara', 'Family');

my $member = $member_adaptor->fetch_by_stable_id($input_gene);

my $families = $family_adaptor->fetch_all_by_GeneMember($member);

## load compara adaptor
#my $compara_dba = Bio::EnsEMBL::Compara::DBSQL::DBAdaptor->new(
#        -host => 'mysql-eg-publicsql.ebi.ac.uk',
#        -port => '4157',
#        -user => 'anonymous',
#        -dbname => 'ensembl_compara_bacteria_25_78'
#        );
#
#my $member = $compara_dba->get_GeneMemberAdaptor()->fetch_by_stable_id($input_gene);

#my $families = $compara_dba->get_FamilyAdaptor()->fetch_all_by_GeneMember($member);

# loop out
print "Retrieve the family of input gene: ", $input_gene, "\n", "From genome: ", $nom, "\n\n";
print "Family", "\t", "Family_description", "\n";

foreach my $family (@{$families}){
    # this family
    print $family->stable_id(), "\t", $family->description(), "\n";
}

