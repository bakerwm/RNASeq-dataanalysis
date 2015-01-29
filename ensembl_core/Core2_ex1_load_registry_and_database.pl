#!/usr/bin/perl -w
use strict;
use warnings;

use Bio::EnsEMBL::Registry;

my $registry = 'Bio::EnsEMBL::Registry';
$registry->load_registry_from_db(
        -host => 'ensembldb.ensembl.org',
        -port => '5306',
        -user => 'anonymous',
        -verbose => 1
        );

#my @adaps = @{$registry->get_all_adaptors()};
#my @alias = @{$registry->get_all_aliases('Homo sapiens')};

#print "Number of adaptors: ", scalar(@adaps), "\n";
#print "Number of alias of Homo sapiens: ", scalar(@alias), "\n";

