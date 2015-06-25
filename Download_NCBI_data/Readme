# Download genome annotation files or SRA data from NCBI ftp

## Examples

1. Download one genome by full name

```
perl bin/ascp_ncbi_download.pl -t bac -o out Mycobacterium_JDM601_uid67369
```

2. search multiple genomes, from a id list

```
perl bin/ascp_ncbi_download.pl -t bac -o out bac.list
```

3. Download genomes with part name: (H37Rv, NC_000962)

```
perl bin/ascp_ncbi_download.pl -t bac -o out -d bacteria.info -m search  H37Rv

```

4. Download SRA data by specific ID: SRR/ERR/DRR

```
perl bin/ascp_ncbi_download.pl -t sra -o out SRR123456

# or from a id.list

perl bin/ascp_ncbi_download.pl -t sra -o out sra.list
```

5. Retrieve genome list from NCBI FTP site

```
perl bin/fetch_ncbi_info.pl -p 10 -n 1 bacteria > bac.log  
perl bin/fetch_ncbi_info.pl -p 20 -n 2 fungi    > fungi.log
```

**Caution**

For some unknown reason, the output (bac.log) may miss some "NC_" information. check with "grep NC_ |wc , and wc bac.log"


