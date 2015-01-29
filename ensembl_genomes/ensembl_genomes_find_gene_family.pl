#!/usr/bin/perl -w
use strict;
use warnings;

use Bio::EnsEMBL::LookUp;
use Bio::EnsEMBL::Compara::DBSQL::DBAdaptor;

print "Building helper\n";
my $helper = Bio::EnsEMBL::LookUp->new();

# load compara adaptor
my $compara_dba = Bio::EnsEMBL::Compara::DBSQL::DBAdaptor->new(
        -HOST => 'mysql-eg-publicsql.ebi.ac.uk', 
        -USER => 'anonymous', 
        -PORT => '4157', 
        -DBNAME => 'ensembl_compara_bacteria_24_78'
        );
# find the corresponding member
my $family = $compara_dba->get_FamilyAdaptor()->fetch_by_stable_id('MF_00395');
print "Family " . $family->stable_id() . "\n";

for my $member (@{$family->get_all_Members()}) {
  my $genome_db = $member->genome_db();
  print $genome_db->name();
  my ($member_dba) = @{$helper->get_by_name_exact($genome_db->name())};
  if (defined $member_dba) {
	my $gene = $member_dba->get_GeneAdaptor()->fetch_by_stable_id($member->gene_member()->stable_id());
	print $member_dba->species() . " " . $gene->external_name . "\n";
        $member_dba->dbc()->disconnect_if_idle();
  }
}
