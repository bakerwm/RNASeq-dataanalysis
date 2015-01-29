#!/usr/bin/perl -w
use strict;
use warnings;

use Bio::EnsEMBL::Registry;

my $registry = 'Bio::EnsEMBL::Registry';
$registry->load_registry_from_db(
        -host =>'ensembldb.ensembl.org',
        -user => 'anonymous'
        );

my $slice_adaptor = $registry->get_adaptor('Human', 'Core', 'Slice');

my @slices = @{$slice_adaptor->fetch_all('chromosome')};
print "Number of chromosome: ". scalar(@slices). "\n";

foreach my $slice(@slices){
    print $slice->seq_region_name, "\t", $slice->length, "\n";
}

