#!/usr/bin/perl -w
use strict;
use warnings;

use Bio::EnsEMBL::LookUp;
use Bio::EnsEMBL::Compara::DBSQL::DBAdaptor;

my $lookup = Bio::EnsEMBL::LookUp->new();

my $nom = 'escherichia_coli_str_k_12_substr_mg1655';
my $dba = $lookup->get_by_name_exact($nom);

# load the gene adaptor
my $gene = $dba->get_GeneAdaptor()->fetch_by_stable_id('b0344');

# load the compara adaptor
my $compara_dba = Bio::EnsEMBL::Compara::DBSQL::DBAdaptor->new(
        -host => $dba->dbc()->host,
        -port => $dba->dbc()->port,
        -user => $dba->dbc()->username,
        -dbname => $dba->dbc()->dbname
        );

my $member = $compara_dba->get_GeneMemberAdaptor()->fetch_by_source_stable_id('ENSEMBLGENE', $gene->stable_id());

# find families
my @families = $compara_dba->get_GeneMemberAdaptor()->fetch_all_by_Member($member);
foreach my $family (@families){
    print "Family: ", $family->stable_id(), "\n";
}


#my $family = $compara_dba->get_FamilyAdaptor()->fetch_by_stable_id('MF_00395');
#print "Family: ", $family->stable_id(), "\n";

