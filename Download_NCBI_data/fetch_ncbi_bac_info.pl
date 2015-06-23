#!/usr/bin/env perl

##################################################
# Download the LIST of bacteria genomes in NCBI
# from the FTP site:
# ftp://ftp.ncbi.nlm.nih.gov/genomes/Bacteria
#
# Usage: perl ncbi_bac_genome_list.pl  
# # waiting for XX minutes, depends on your network.
#
# WangMing wangmcas(AT)gmail.com
# 2015-06-22 
##################################################

use strict;
use warnings;
#use LWP::Simple;
use POSIX qw(strftime);

my $url = 'ftp://ftp.ncbi.nlm.nih.gov/genomes/Bacteria';

my $max = shift or die "Usage: perl fetch_info.pl [2-20]\n";
die("need input a integer:\n") if(! $max =~ /^\d+$/);

fetch_ncbi_acc();
exit(1);

# write the bacteria genome names to file: 
#
# Example:
# ncbi_bacteria_genomes_20150622_14-20-00.txt
#
sub fetch_ncbi_acc {
    print '['. show_date() . ']'. ' Parsing genome names:' . "\n";
    my @ids = parse_genome_id();
    print '['. show_date() . ']'. ' Parsing accession IDs for each genome:'. "\n";
    my $date = strftime "%Y%m%d", localtime;
    my $bak_file = 'test_' . $date . '.txt';
    my @out = mp_runs(\@ids, $bak_file); # using fork to clone N process
}

sub show_date {
    my $date = strftime "%Y-%m-%d %H:%M:%S", localtime;
    return $date;
}

sub mp_runs {
    my ($n, $f) = @_;
    my @names = @$n;
    my @pids  = ();
    my $children = 0;
    open my $fh_f, "> $f" or die "Cannot open $f, $!\n";
    for(my $i = 0; $i < @names; $i++) {
        my $position = $i + 1;
        print '['. show_date() .'] - ' . $names[$i] . ' ['. $position .'/'. scalar(@names) .']' . "\n";
        my $pid;
        if($children >= $max) {
            $pid = wait();
            $children --;
        }
        # clone a child process
        $pid = fork(); # clone a proc (child)
        die("Cannot fork\n") if(! defined $pid);
        if($pid) { # parent proc
            $children ++; # add a child process
            push @pids, $pid; # 
        }else { # this is child proc
            my $info = child($names[$i]); # run in child proc
            print $fh_f $info . "\n";
            exit 0; # terminate this child proc
        }
    }

    for my $n (@pids) {
        my $chk  = waitpid($n, 0);
        my $info = $? >> 8; # remove signal / dump bits from rc
        print "PID $n finished with info $info\n";
    }
    close $fh_f;

    sub child {
        my $id = $_[0];
        my $id_acc  = read_genome_dir($id);
        sleep(1);
        return "$id\t$id_acc";
    }
}

# parsing the genome IDs
#
# Examples:
# dr-xr-xr-x   2 ftp      anonymous     4096 Dec  6  2010 Mycobacterium_tuberculosis_H37Rv_uid57777
#
sub parse_genome_id {
    my $content = qx{GET $url};
    die "Could not get $url\n" unless defined $content;
    my @lines = split /\n/, $content;
    # parsing the genome IDs
    my @genomes = ();
    for(@lines) {
        chomp;
        next unless(my ($name) = $_ =~ /\d+\s+(\w+)$/); # one strain in each subdirectory
        push @genomes, $name;
    }
    return @genomes;
}

# parsing the content of each genome
#
# Examples:
# -r--r--r--   1 ftp      anonymous   157421 Oct 22  2010 NC_009932.fna
#
sub read_genome_dir {
    my $id = shift(@_);
    my $sub_url = $url . '/' . $id;
    my $sub_content = qx{GET $sub_url};
    warn "Could not get $sub_url\n" unless defined $sub_content;
    my @sub_lines = split /\n/, $sub_content;
    my @acc_ids = ();
    for(@sub_lines) {
        chomp;
        next unless(my ($acc) = $_ =~ /\d+\s+(NC\_\d+)\.fna/); # parsing the *.fna files
        push @acc_ids, $acc;    
    }
    my $note = join("\,", @acc_ids);
    return $note;
}

