#!/bin/bash  

/home/wangming/.aspera/connect/bin/ascp -QT -l 100M  -i /home/wangming/asperaweb_id_dsa.openssh  anonftp@ftp-private.ncbi.nlm.nih.gov:/refseq/release/bacteria/bacteria.1.1.genomic.fna.gz   /share/wangming/refseq/bacteria/ 
