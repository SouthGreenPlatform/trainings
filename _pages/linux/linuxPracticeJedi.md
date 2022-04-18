---
layout: page
title: "Advanced Linux Practice"
permalink: /linux/linuxPracticeJedi/
tags: [ linux, survival guide ]
description: Advanced Linux Practice page
---

| Description | Hands On Lab Exercises for Linux |
| :------------- | :------------- | :------------- | :------------- |
| Related-course materials | [Linux for Jedi](https://southgreenplatform.github.io/trainings/linux/linuxPracticeJedi//) |
| Authors | Christine Tranchant-Dubreuil (christine.tranchant@ird.fr) & Gautier Sarah (gautier.sarah |
| Creation Date | 11/03/2018 |
| Last Modified Date | 18/04/2022 |
| Modified by | Christine Tranchant-Dubreuil |

-----------------------

### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Preambule: Softwares to install before connecting to a distant linux server ](#preambule)
* [Practice 1: Get Connecting on a linux server by `ssh`](#practice-1)
* [Practice 2: Preparing working environnement](#practice-2)
* [Practice 3: Using the `&&` separator](#practice-3)
* [Practice 4: Monitoring processes) with `w, ps, kill, top`](#practice-4)
* [Practice 5: Searching for text using `regex101.com`](#practice-5)
* [Practice 6: Searching for text using `grep`](#practice-6)
* [Practice 7: Displaying lines with `sed`](#practice-7)
* [Practice 8: Deleting lines with `sed`](#practice-8)
* [Practice 9: Parsing files with `sed` using regexp](#practice-9)
* [Practice 10: Modifying files with `sed`](#practice-10)
* [Practice 11: Manipulating files with `awk`](#practice-11)

* [Links](#links)
* [License](#license)


-----------------------

<a name="preambule"></a>
### Preambule 
* List of Softwares to install before connecting to a distant linux server [more information](https://southgreenplatform.github.io/trainings/linux/linuxPractice/#preambule)
* Arborescence image :

-----------------------

<a name="practice-1"></a>
### Practice 1 : Get Connecting on a linux server by `ssh`

In mobaXterm:
1. Click the session button, then click SSH.
  * In the remote host text box, type: HOSTNAME (see table below)
  * Check the specify username box and enter your user name
2. In the console, enter the password when prompted.
Once you are successfully logged in, you will use this console for the rest of the lecture.

| Cluster HPC | hostname| 
| :------------- | :------------- | 
| IRD HPC |  bioinfo-inter.ird.fr | 

* Connect on the HPC

-----------------------

<a name="practice-2"></a>
### Practice 2 : Preparing working environnement 

* Move into the directory /scratch2
* Create a working directory such as Formation-X (X corresponds to your login id/number) 
* Move into this directory just created and check the current/working directory just by looking the prompt
 
-----------------------

<a name="practice-3"></a>
### Practice 3 : Using the && separator

* On the console, type the 2 following linux commands to get data necessary for the next (we will explain the two commands latter):

{% highlight bash %}
# get the file on the web and decompress the gzip file 
wget http://itrop.ird.fr/LINUX-TP/LINUX4JEDI.tar.gz && tar -xzvf LINUX4JEDI.tar.gz
{% endhighlight %}

* Check the content of your home directory on the server now 
* Delete the file LINUX4JEDI.tar.gz on the server - `rm`
* Execute the `tree` command 

<img width="80%" class="img-responsive" src="{{ site.url }}/images/tpLinux/arbo3.png"/>



-----------------------
<a name="practice-4"></a>
### Practice 4 :  Monitoring processes

#### Displaying the list of processes
* Type the command `w` through 2 consoles : one connected on bioinfo-master, the other connected on one node
* Type (on the node) the command `ps`without option, then with the option `u`, `ua`,  `uax`
* Type the command `top`on the node 
* Then use the "option" c to display the complete process
* Then use the "option" u to display only your processes

#### Kill a process - downloading files from SRA through two ways

* Go into the directory `LINUX4JEDI-TP/1-fastq` 
* Display the size of all fastq files - `ls -lh, du -h`

We want to download one fastq file from NCBI SRA (available here https://www.ncbi.nlm.nih.gov/sra?linkname=bioproject_sra_all&from_uid=518559) using SRAtoolkit as below :

{% highlight bash %}
module load bioinfo/sratoolkit/2.9.2 
fastq-dump --gzip --split-files SRXXXX
{% endhighlight %}

This will download the SRA file (in sra format) and then convert them to fastq.gz file . More details on https://isugenomics.github.io/bioinformatics-workbook/dataAcquisition/fileTransfer/sra.html

* Download the fastq file in the directory `LINUX4JEDI-TP/1-fastq` `fastq-dump, &`
* Check that 2 fastq files are downloading `ls -lhrt, watch -n 5 -d`
* Display the list of processes `ps -ux, jobs`
* kill your process "fastq-dump" directly from bioinfo-master `kill -9`

-----------------------



<a name="practice-5"></a>
### Practice 5 : Searching for text using `https://regex101.com/`

* Go to the web site https://regex101.com/
* Copy the following accession gene names and paste it in the field `test string`
{% highlight bash %}
xkn59438
yhdck2
eihd39d9
chdsye847
hedle3455
xjhd53e
45da
de37dp
{% endhighlight %}

* print only the accession names that satisfy the following criteria – treat each criterion separately
> * contain the number 5
> * contain the letter d or e
> * contain the letters d and e in that order
> * contain the letters d and e in that order with a single letter between them
> * contain both the letters d and e in any order
> * start with x or y
> * start with x or y and end with e
> * contain three or more digits in a row
> * end with d followed by either a, r or p

------------------------

<a name="practice-6"></a>
### Practice 6 : Searching for text using `grep`

* List the content of the directory `LINUX4JEDI-TP/Bank` 
* Display the first 10 lines of all the files that are the `Bank` directory - `head`
* Display the last 20 lines of all the files  - `tail`
* Count the sequences number in the two files that are the `Bank` directory - `grep`
* Print the line that contains the gene name `DEFL` - `grep regexp`, all.seq
* Print the line that contains the gene name `DEFL` following just by one digit - `grep regexp`, all.seq

Infos:  The file all.con contains the sequence of the asian rice genome (fasta format) and all. pep contains the sequence of all the genes annotated on the rice genome (fasta format).


#### from a gff file

We have the genome reference (all.con, fasta file) and we want to download the annotation of our genome reference (gff format).
* Go on the following page : http://rice.uga.edu/pub/data/Eukaryotic_Projects/o_sativa/annotation_dbs/pseudomolecules/version_7.0/all.dir
* Copy the url of the rice genome annotation file that we will use to download the file directly on the server (all.gff3)
* Go to the `bank` directory and type the following command :

{% highlight bash %}
wget PUT_GFF_URL
{% endhighlight %}

* Count the number of genes annotated in the genome reference (lines with the word `gene` in the gff file) - `grep`
* Search for the nbs-lrr genes - `grep`
* Count the number of gene `DEFL` following just by one digit - `grep regexp`
* Count the number of gene `DEFL` following by one or two digit ranging from 1 to 50 - `grep regexp`
* Counts the number of mRNA in the chromosome 1 - `grep -c regexp`
* Counts the number of mRNA in the first five chromosomes - `grep -c regexp`
* count the number of gene by chromosome - `grep, cut, sort, uniq` 

-----------------------

<a name="practice-7"></a>
### Practice 7 :  Displaying lines with `sed`
For this exercise, you will work on the fastq file LINUX4JEDI-TP/1-fastq/SRR8517015_1.10000.fastq

* Print the 8 first lines
* Print the lines 5 to 12
* Print only the sequences ids
* Print only the sequences ids and nucleotides sequences

-----------------------

<a name="practice-8"></a>
### Practice 8 : Deleting lines with `sed`
For this exercise, you will work on the fastq file LINUX4JEDI-TP/1-fastq/SRR8517015_1.10000.fastq

* Delete the end of the file from the line 9
* Delete the lines containing only a `+`
* Delete the lines containing only a `+` and the quality sequences

-----------------------

<a name="practice-9"></a>
### Practice 9 : File parsing with `sed` using regexp

#### Fastq file
For this exercise, you will work on the fastq file `LINUX4JEDI-TP/1-fastq/SRR8517015_1.10000.fastq`
* Print only read sequences using a regexp (print only lines with the letters ATCG)

#### vcf file
For this exercise, you will work with the vcf file `LINUX4JEDI-TP/4-vcf/OgOb-all-MSU7-CHR6.GATKVARIANTFILTRATION.shuf.100000.vcf.gz`
* Print only the line corresponding to the header or a polymorphism with the `PASS` tag

-----------------------

<a name="practice-10"></a>
### Practice 10 : File modification with `sed`

#### From fasta files in `LINUX-TP/Fasta`
* In the `LINUX4JEDI-TP/9-denovoAssembly` directory, there are two files : `DAOSW_abyss-contigs.fa`and `TOG5681_abyss-contigs.fa`. Before to generate a unique file with all 2 libraries, we would like to tag each sequence per its origin. In each file, add the respective tag DAOSW_ / TOG5681_ just before the identifier.

{% highlight bash %}
# File DAOSW_abyss-contigs.fa initially
>0 71 531
CTTTTTGAACTTTTTCATTCCGGTCAAAAAAATATCGCACCCGTGGGGGCTCAATATATGCCAATATTGGC
>2 217 449


# File DAOSW_abyss-contigs.rename.fasta
>DAOSW_0 71 531
CTTTTTGAACTTTTTCATTCCGGTCAAAAAAATATCGCACCCGTGGGGGCTCAATATATGCCAATATTGGC
>DAOSW_2 217 449

{% endhighlight %}

Rq : Test first the sed command on one file and STDOUT, then store the results in new files named DAOSW_abyss-contigs.renamed.fasta and TOG5681_abyss-contigs.renamed.fasta

> BONUS : try to change each line starting with > such as :  `>0 71 531`=> `>DAOSW_0`

#### vcf file `LINUX4JEDI-TP/4-vcf/OgOb-all-MSU7-CHR6.GATKVARIANTFILTRATION.shuf.100000.vcf.gz`
* Now, in the VCF file, we would like to replace the genotypes by allelic dose. This means that we should replace the whole field by `0` when the genotype is `0/0`, by `1` when the genotype is `0/1` and `2` when the genotype is `1/1`

#### With fastq files in LINUX4JEDI-TP/1-fastq/
* Transform the fastq file SRR8517015_1.10000.fastq in fasta format
* In one command line transform all fastq files of the directory in fasta (save the files before)

-----------------------

<a name="practice-11"></a>
### Practice 11 : Manipulating files with `awk`

### From a fasta file

#### seqtk
Seqtk (https://github.com/lh3/seqtk) is a fast and lightweight tool for processing sequences in the FASTA or FASTQ format. It seamlessly parses both FASTA and FASTQ files which can also be optionally compressed by gzip.

We are going to use seqtk comp to get statistics  get the nucleotide composition of FASTA/Qprint the size of the genome => a caler seqtk comp + awk + sort

* Run seqtk comp on the file `Bank/all.con`- `seqtk comp all.con`  
* With awk, print le whole line, then the column 1 and 2 of the seqtk comp command output - `| awk `
* Print the column 1 and 2 only for chr1 to chr12
* Calculate the genome size in pb

#### From the gff file precedently downloaded
* Extract the coordinate from the gff file
* Calculate the mean of the gene length
* Calculate the mean of the gene length for the chromosome 1
* Count the number of genes above 2000bp length
* Bonus: calculate the mean of gene length for each chromosomes in one command line


-----------------------

<a name="practice-12"></a>
### Practice 12

* Go into the directory `LINUX4JEDI-TP/1-fastq/`
* List the directory content
* Run fastq-stats program ( [more](http://manpages.ubuntu.com/manpages/xenial/man1/fastq-stats.1.html) to get stats about the fastq file `SRR8517015_1.10000.fastq`
{% highlight bash %}
fastq-stats -D SRR8517015_1.10000.fastq
{% endhighlight %}
* Use a `for` loop to run fastq-stats with every fastq file in the directory
{% highlight bash %}
for file in *fastq; do 
  fastq-stats -D $file > $file.fastq-stats ; 
done;
{% endhighlight %}

-----------------------

### Links
<a name="links"></a>

* Related courses : [Linux for Jedi](https://southgreenplatform.github.io/trainings/linuxJedi/)
* Tutorials : [Linux Command-Line Cheat Sheet](https://southgreenplatform.github.io/trainings/linux/linuxTuto/)

-----------------------

### License
<a name="license"></a>

<div>
The resource material is licensed under the Creative Commons Attribution 4.0 International License (<a href="http://creativecommons.org/licenses/by-nc-sa/4.0/">here</a>).
<center><img width="25%" class="img-responsive" src="http://creativecommons.org.nz/wp-content/uploads/2012/05/by-nc-sa1.png"/>
</center>
</div>
                  
 
