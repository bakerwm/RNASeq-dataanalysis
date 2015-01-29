#!/usr/bin/perl -w
use strict;
use warnings;

use Bio::EnsEMBL::LookUp;
use Bio::EnsEMBL::Compara::DBSQL::DBAdaptor;

my $lookup = Bio::EnsEMBL::LookUp->new();

my $nom = 'mycobacterium_tuberculosis_h37rv_gca_000195955_2';
my $dba = $lookup->get_by_name_exact($nom);

my @genes = $dba->get_GeneAdaptor()->fetch_by_stable_id('Rv0001');

foreach my $gene (@genes){
    print $gene->stable_id(), " ", $gene->source()," ", $gene->species(),"\n";
}

use Data::Dumper;
#print Dumper(@genes);

#
#
#my $host = $dba->dbc()->host;
#my $port = $dba->dbc()->port;
#my $user = $dba->dbc()->username;
#my $dbname = $dba->dbc()->dbname;
#
## load a compara adaptor
#my $compara_dba = Bio::EnsEMBL::Compara::DBSQL::DBAdaptor->new(
#        -host => $host,
#        -port => $port,
#        -user => $user,
#        -dbname => $dbname        
#        );
#
## find corresponding member
#my $family = $compara_dba->get_FamilyAdaptor()->fetch_by_stable_id();
#print "Family ", $family->stable_id(), "\n";
#
#my @members = @{$family->get_all_Members()};
#foreach my $member (@members){
#    my $genome_db = $member->genome_db();
#    print $genome_db->name();
#    my $member_dba = $lookup->get_by_name_exact($genome_db->name());
#    if(defined $member_dba){
#        my $gene = $member_dba->get_GeneAdaptor()->fetch_by_stable_id($member->gene_member()->stable_id() );
#        print $member_dba->species(), " ", $gene->external_name, "\n";
#        $member_dba->dbc()->disconnect_if_idle();
#    }
#}
#
#
#
