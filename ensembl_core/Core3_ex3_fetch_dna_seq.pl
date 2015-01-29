#!/usr/bin/perl -w
use strict;
use warnings;

use Bio::EnsEMBL::Registry;

my $registry = 'Bio::EnsEMBL::Registry';
$registry->load_registry_from_db(
        -host =>'ensembldb.ensembl.org',
        -user => 'anonymous'
        );
# 3.3 Fethch the first 10MB seq of chromosome 20, write it to a fasta file and 
# get the number of genes in this region 

my $slice_adaptor = $registry->get_adaptor('Human', 'Core', 'Slice');

# fetch and write the sequence from chr20
use Bio::SeqIO;

my $chromosome_output = Bio::SeqIO->new(
        -file => '> chrom20.fasta',
        -format => 'fasta'
        );

my $slice = $slice_adaptor->fetch_by_region('chromosome', '20', 1, 1e7);
$chromosome_output->write_seq($slice);

print "Write the first 10MB seq of chr20 to file: chrom20.fasta\n\n";

# get all the genes on the slice
my @genes = @{$slice->get_all_Genes};

print "Number of genes found : ", scalar(@genes), "\n";

