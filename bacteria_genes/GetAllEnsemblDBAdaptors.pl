#!/usr/bin/perl -w
use strict;
use warnings;

use Bio::EnsEMBL::Registry;

#my $lookup = Bio::EnsEMBL::LookUp->new();

my $registry = 'Bio::EnsEMBL::Registry';
$registry->load_registry_from_multiple_dbs( {
        -host => 'mysql-eg-publicsql.ebi.ac.uk',
        -port => '4157',
        -user => 'anonymous',
#        -verbose => '1'
        },
        { -host => 'ensembldb.ensembl.org',
          -port => '5306',
          -user => 'anonymous',
#          -verbose => '1'
        } );

my $dbas = $registry->get_all_DBAdaptors();

#use Data::Dumper;
#print Dumper($dbas); # print out all hash structure

foreach my $dba (@{$dbas}){
    printf("%-30s %4d %-10s %-50s %4d %-50s\n",
            $dba->dbc()->host, $dba->dbc()->port, $dba->dbc()->username,
            $dba->dbc()->dbname, $dba->species_id, $dba->species );
}

