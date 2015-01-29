#!/usr/bin/perl -w
use strict;
use warnings;

use Bio::EnsEMBL::LookUp;
use Bio::EnsEMBL::Compara::DBSQL::DBAdaptor;

my $lookup = Bio::EnsEMBL::LookUp->new();

# lookup the genomes

my $nom = 'escherichia_coli_str_k_12_substr_mg1655';
#my $nom = 'mycobacterium_tuberculosis_h37rv_gca_000667805_1';
#my $nom = 'mycobacterium_tuberculosis_h37rv_gca_000195955_2';
#my $nom = 'mycobacterium_tuberculosis_h37rv_gca_000277735_2';

my $dba = $lookup->get_by_name_exact($nom);
my $gene = $dba->get_GeneAdaptor()->fetch_by_stable_id('b0344');

# load compara adaptor
my $host = $dba->dbc()->host;
my $port = $dba->dbc()->port;
my $user = $dba->dbc()->username; # anonymous
my $dbname = $dba->dbc()->dbname;

my $compara_dba = Bio::EnsEMBL::Compara::DBSQL::DBAdaptor->new(
        -host => 'mysql-eg-publicsql.ebi.ac.uk',
        -user => 'anonymous',
        -port => '4157',
        -dbname => 'ensembl_compara_bacteria_24_77'
        );

use Data::Dumper;
# find compara adaptor
my $member = $compara_dba->get_GeneMemberAdaptor()->fetch_by_source_stable_id('ENSEMBLGENE',$gene->stable_id());
print Dumper($member);


#my @families = $compara_dba->fetch_all_by_stable_id_list();
#my @families = @{$compara_dba->get_FamilyAdaptor()->fetch_all_by_Member($member)};
#
#foreach my $family (@families){
#    print "Family ", $family->stable_id(), "\n";
#}



