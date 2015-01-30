#!/usr/bin/perl -w
use strict;
use warnings;

use Bio::EnsEMBL::Registry;
use Bio::EnsEMBL::LookUp;
use Bio::SeqIO;

use Data::Dumper;

# Retrieve the canonical peptides from genes belonging to a given family

# Input data
my $input_family = 'MF_00395';

# lookup
my $lookup = Bio::EnsEMBL::LookUp->new();

# load registry
my $reg = 'Bio::EnsEMBL::Registry';
$reg->load_registry_from_db(
        -host => 'mysql-eg-publicsql.ebi.ac.uk',
        -port => '4157',
        -user => 'anonymous'
        );

# load compara family adaptor
my $family_adaptor = $reg->get_adaptor(
        'bacteria', 'compara', 'family'
        );
my $family = $family_adaptor->fetch_by_stable_id($input_family);

my $outfile = ">". $family->stable_id. ".fa";
my $seq_out = Bio::SeqIO->new(-file => $outfile,
                              -format => "fasta"
                              );

print "Write family: ", $family->stable_id(), " to $outfile\n";

# loop over members
my $members = $family->get_all_Members();
foreach my $member (@{$members}){
    my $genome_db = $member->genome_db();
    my $member_dba = $lookup->get_by_name_exact($genome_db->name());
    if(defined $member_dba){
        my $gene = $member_dba->get_GeneAdaptor()->fetch_by_stable_id($member->gene_member()->stable_id() );
        print "Write sequence of ", $member->stable_id(), "\n";
        my $s = $gene->canonical_transcript()->translate();
        $seq_out->write_seq($s);
        $member_dba->dbc()->disconnect_if_idle();
    }

}


