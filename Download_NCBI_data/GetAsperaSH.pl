#!/usr/bin/perl  -w
use warnings;
use strict;

## Download data from NCBI FTP site using Aspera
my $remotedir = shift or die 'Input the name of remote dir: /refseq/release/bacteria/';
my $outdir    = shift or die 'Input the name of output dir';

## Need input dir of the dataset
#my $remotedir = '/refseq/release/bacteria/';
#my $outdir = '/share/wangming/refseq/bacteria/';

## My command
my $aspera = '/home/wangming/.aspera/connect/bin/ascp';
my $para   = '-i /home/wangming/asperaweb_id_dsa.openssh  -QT  -l 100M';
my $ncbi   = 'anonftp@ftp-private.ncbi.nlm.nih.gov:';

# Download Files from NCBI FTP Site using Aspera Connect
my $cmdLine = "$aspera  $para  $ncbi".$remotedir;

# Genomic fna data:  bacteria.*.1.genomic.fna.gz   [1 to 106]
mkdir  "work_shells"  unless (-d  "work_shells");

for (my $i=0; $i<=106/4; $i++){
    my $label = sprintf "%02d",$i;
    open OUT,"> work_shells/work\_$label\.sh" or die;
    print OUT "#!/bin/bash  \n\n";
    for (my $k=1; $k<=4; $k++){
	    my $num = 4*$i+$k;
	    print OUT $cmdLine."bacteria.$num.1.genomic.fna.gz"."  $outdir \n";
    }
    close OUT;
}


# Create Runall.sh
open OUT,"> RunAllShells.sh" or die;
my @shells = glob"work_shells/work*.sh";
foreach (@shells){
    print OUT "sh  $_ & \n";
}
close OUT;
