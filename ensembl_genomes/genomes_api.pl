#!/usr/bin/perl -w
use strict;
use warnings;

use Bio::EnsEMBL::LookUp;

my $lookup = Bio::EnsEMBL::LookUp->new();

#my $input = 'mycobacterium_tuberculosis_*';
my $input = 'prochlorococcus_marinus_*'; # prochlorococcus_marinus_str_natl2a
#my $dba = $lookup->get_by_name_exact('escherichia_coli_str_k_12_substr_mg1655');
#my @dbas = @{$lookup->get_all_by_name_pattern('escherichia_coli_.*')};
my @dbas = @{$lookup->get_all_by_name_pattern($input)};

# print out detail info of each genome
print "Found the number of genomes: ", scalar(@dbas), " by ", $input, "\n\n";

foreach my $dba (@dbas){
    printf("Species_id: %04d \t dbname: %34s \t species: %-35s \n",
            $dba->species_id, $dba->dbc()->dbname(), $dba->species);
}

#$dba->dbc()->disconnect_if_idle();


# Search the genomes in ensemblgenomes, and find the dbname/ for compara .
