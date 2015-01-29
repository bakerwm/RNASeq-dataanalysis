#!/usr/bin/perl -w
use strict;
use warnings;

use Bio::EnsEMBL::Registry;
use Bio::EnsEMBL::DBSQL::DBAdaptor;
use Bio::EnsEMBL::LookUp;

# Find the gene info of a bacteria

my $lookup = Bio::EnsEMBL::LookUp->new();

#my $nom = 'mycobacterium_tuberculosis_h37rv_gca_000195955_2';
my $nom = 'mycobacterium_tuberculosis_h37ra';

my $dba = $lookup->get_by_name_exact($nom);

my $genes = $dba->get_GeneAdaptor()->fetch_all();

# Header
print join "\t", ('#stable_id', 'start', 'end', 'strand', 'biotype', 'description');
print "\n";

foreach my $gene (@{$genes}){
    my $out = &GetGeneInfo($gene);
    print $out, "\n";
#    exit;
}

# sub, return gene info: stable_id, start, end, strand, biotype, description
sub GetGeneInfo{
    my $gene = shift(@_); # pass a geneadaptor
    my $stable_id = '';
    my $start = '';
    my $end = '';
    my $strand = '';
    my $biotype = '';
    my $description = '';

    my %Info = %{$gene};
    my @outInfo = ();
    foreach my $key (qw{stable_id start end strand biotype description}){
        my $value = (exists $Info{$key})?$Info{$key}:'-';
        $value = '-' unless (defined $value );
        push @outInfo,  $value;
    }
    my $out = join ("\t", @outInfo);
    return $out;
};

