#!/usr/bin/perl -w
use strict;
use warnings;

use Bio::EnsEMBL::Registry;
use Bio::EnsEMBL::LookUp;
use Getopt::Long;

my $usage = qq{
perl SearchBacDBname.pl

Usage: perl SearchBacDBname.pl -input=mycobacterium_tuberculosis_h37rv -output=rv.txt

    Getting help;
      [--help]

    For the query by "name of bac"
      [-i]
          Name of the bacteria, default is 
          'escherichia_coli_str_k_12_substr_mg1655'
      [--output]
          The name of the output file. By default the output is the
          standard output
};


#my $input = 'escherichia_coli_str_k_12_substr_mg1655';
my $input = 'mycobacterium_tuberculosis_h37rv_gca_000195955_2';
my $output_file = undef;
my $help;

GetOptions(
        "help" => \$help,
        "input=s" => \$input,
        "output=s" => \$output_file
        );

# Print help and exit
if ($help) {
    print $usage;
    exit(0);
}

if ($output_file) {
    open (STDOUT, ">$output_file") or die ("Cannot open $output_file");
}

# Pre-processing input parameter
$input =~ s/\s+$//;


my $lookup = Bio::EnsEMBL::LookUp->new();
my @dbas = @{$lookup->get_all_by_name_pattern($input)};

print "Found ", scalar(@dbas), " genomes of ", $input, "\n";
print "Write these results to: ", $output_file, "\n\n";

# loop the dbas
my $count = 1;
foreach my $dba (@dbas) {
    print $count, "\n";
    printf("dbname: %s \nSpecies_id: %d \nSpecies: %-35s \nhost: %s \nport: %4d \nuser: %s \n\n",
         $dba->dbc()->dbname(), $dba->species_id, $dba->species, $dba->dbc()->host(),
         $dba->dbc()->port(), $dba->dbc()->username() );
    $count ++;
}

