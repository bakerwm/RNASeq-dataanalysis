
# Parsing BAM files

Usage: parseBAM.pl <command> [arguments]    
Command: stat   count mapping reads for each BAM    
         view   create "*.bedgraph" files for each BAM    
         tags   find tags from each BAM files (sRNA candidates)    
         
* 1 Example 1    
    statistic mapped reads for input bam files; (samtools view -c in.bam)
    
```
cat inbam.list
# data/bam/test01.bam
# data/bam/test02.bam

./parseBAM.pl stat -o test_out inbam.list    
```    

* 2 Example 2  
    Create bedgraph files for each BAM file; (strand-specific bam files)
    
```
./parseBAM.pl view -o test_out -s 1 inbam.list
```

* 3 Example 3
    Find tags from BAM file, merge multiple tags from all bam files;
    
```
./parseBAM.pl tags -o test_out -f data/ref/ref.fa -g data/ref/ref.gff -s 1 -c 50 -m 1 -z 1 -db data/ref/RNAz.db.fa inbam.list 
```
