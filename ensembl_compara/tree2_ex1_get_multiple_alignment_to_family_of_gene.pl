#!/usr/bin/perl -w
use strict;
use warnings;

use Bio::EnsEMBL::Registry;

my $reg = 'Bio::EnsEMBL::Registry';
$reg->load_registry_from_url(
        'mysql://anonymous@ensembldb.ensembl.org'
        );

# 1. ex1 Get multiple alignment to the family with a stable id (gene)
my $family_adaptor = $reg->get_adaptor('Multi', 'Compara', 'Family');
my $this_family = $family_adaptor->fetch_by_stable_id('ENSFM00250000006121');

print $this_family->description(), " (description score = ", $this_family->description_score(), ")\n";

# output by bioperl 
use Bio::AlignIO;
my $simple_align = $this_family->get_SimpleAlign(-append_taxon_id => 1);
my $alignIO = Bio::AlignIO->newFh(-format => "clustalw");
print $alignIO $simple_align;

