# Download data from NCBI using Aspera

## @CentOS X64

### 1. Install Aspera
* Download
	* Download Aspera connect of your platform: http://downloads.asperasoft.com/connect2/
	* It is "aspera-connect-3.3.3.81344-linux-64.gz"
	* decompress the file, and run the ***.sh** file
	 
```
tar  -zxvf  aspera-connect-3.3.3.81344-linux-64.gz
sh   aspera-connect-3.3.3.81344-linux-64.gz
```

	* Complete. [No need **root** right]

### 2. Configure Aspera
* You can find a dir in your $Home (~/): .aspera
There are two important files:
	* Aspera executable file: ~/.aspera/connect/bin/ascp
	* Aspera key file: ~/.aspera/connect/etc/asperaweb_id_dsa.openssh
_(it should be *.putty for versions before v3.3.3)_

Move the two files to your $Home (~/) dir for easy use.

```
cp ~/.aspera/connect/bin/ascp  ~/
cp ~/.aspera/connect/etc/asperaweb_id_dsa.openssh  ~/
```

	* Add ascp to your ENV or create shortcut

```
add the following line to ~/.bashrc
 export PATH="$PATH:/home/wangming/.aspera/connect/bin/"
source ~/.bashrc
```

### 3. Download dataset from NCBI or EBI
The basic command:
ascp -i asperaweb_id_dsa.openssh  user@server_IP  local_dir

1. Download NCBI datasets
For example, The NCBI ftp address of the file is:
ftp://ftp.ncbi.nlm.nih.gov/refseq/release/bacteria/bacteria.1.1.genomic.fna.gz
The Aspera command should be:
```
ascp -i ~/asperaweb_id_dsa.openssh  anonftp@ftp-private.ncbi.nlm.nih.gov:/refseq/release/bacteria/bacteria.1.1.genomic.fna.gz  ~/Download
```

2. Download EBI datasets
For example, The EBI ftp address of the file is:
ftp://ftp.sra.ebi.ac.uk/vol1/fastq/SRR346/SRR346368/SRR346368.fastq.gz
The aspera commnand should be:
```
ascp -i asperaweb_id_dsa.openssh  era-fasp@fasp.sra.ebi.ac.uk:/vol1/fastq/SRR346/SRR346368/SRR346368.fastq.gz   ~/Download
```

**We can try the para for faster speed:  -QT -l 100M

## @Windows

### 1. Install Aspera connect

* Download executable file for windows:
http://downloads.asperasoft.com/connect2/
* Run the file

### 2. Download NCBI files
* Go to http://www.ncbi.nlm.nih.gov/public/
