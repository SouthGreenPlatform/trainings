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
| Last Modified Date | 14/04/2022 |
| Modified by | Christine Tranchant-Dubreuil |

-----------------------

### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Preambule: Softwares to install before connecting to a distant linux server ](#preambule)
* [Practice 1: Get Connecting on a linux server by `ssh`](#practice-1)
* [Practice 2: Preparing working environnement](#practice-2)
* [Practice 3: Using the `&&` separator](#practice-3)
* [Practice 4: Monitoring processes) with `w, ps, kill, top`](#practice-4)
* [Practice 5: Searching for text using `grep`](#practice-5)
* [Practice 6: Displaying lines with `sed`](#practice-6)
* [Practice 7: Deleting lines with `sed`](#practice-7)
* [Practice 8: Parsing files with `sed` using regexp](#practice-8)
* [Practice 9: Modifying files with `sed`](#practice-9)
* [Practice 10: Manipulating files with `awk`](#practice-10)

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

* Type qrsh to connect on one node
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
We want to download one fastq file from NCBI SRA (available here https://www.ncbi.nlm.nih.gov/sra?linkname=bioproject_sra_all&from_uid=518559) using SRAtoolkit as below :

` module load bioinfo/sratoolkit/2.9.2 
fastq-dump --gzip --split-files SRXXXX`

This will download the SRA file (in sra format) and then convert them to fastq.gz file . More details on https://isugenomics.github.io/bioinformatics-workbook/dataAcquisition/fileTransfer/sra.html

* Download the fastq file in the directory `LINUX4JEDI-TP/1-fastq `fastq-dump, &`
* Open a new terminal to connect on bioinfo-inter.ird.fr 
* From this terminal, display the list of processes running on the node where you are downloading the fastq file with fastq-dump
* From this terminal, kill your process "fastq-dump" directly from bioinfo-master

-----------------------



<a name="practice-5"></a>
### Practice 5 : Searching for text using `grep`

#### from a gff file

* Go on the following page : http://rice.plantbiology.msu.edu/pub/data/Eukaryotic_Projects/o_sativa/annotation_dbs/pseudomolecules/version_7.0/
* Copy the url of the rice genome annotation file (gff format) that we will use to download the file directly on the server (all.gff3)
* Go to the `bank` directory and type the following command :

{% highlight bash %}
wget gff_url
{% endhighlight %}

* Prints the number of lines with the word `gene` in the gff file - `grep -e`
* Counts the number of genes - `grep -c` 
* Search for the nbs-lrr genes - `grep -i`
* Counts the number of genes without the word `putative` - `grep -v`
* Counts the number of mRNA in the chromosome 1 - `grep -c regexp`
* Counts the number of mRNA in the first five chromosomes - `grep -c regexp`
* print the chromosome id withot redundancy
* count the number of gene by chromosome => a caler

* Copy the url of the rice genome fasta (fasta format) that we will use to download the file directly on the server (all.con)
* print the chromosome id
* print the size of the genome => a caler seqtk comp + awk + sort

-----------------------

<a name="practice-6"></a>
### Practice 6 :  Displaying lines with `sed`
For this exercise, you will work on the fastq file LINUX-TP/Data/fastq/pairedTwoIndividusGzippedIrigin/irigin1_1.fastq.gz

* Print the 8 first lines
* Print the lines 5 to 12
* Print only the sequences ids
* Print only the sequences ids and nucleotides sequences

-----------------------

<a name="practice-7"></a>
### Practice 7 : Deleting lines with `sed`
For this exercise, you will work on the fastq file LINUX-TP/Data/fastq/pairedTwoIndividusIrigin/irigin1_1.fastq

* Delete the end of the file from the line 9
* Delete the lines containing only a `+`
* Delete the lines containing only a `+` and the quality sequences

-----------------------

<a name="practice-8"></a>
### Practice 8 : File parsing with `sed` using regexp

#### From the gff file precedently downloaded
* Count the number of genes

#### From a vcf file
* Download the vcf file available at this url http://sg.ird.fr/LINUX-TP/OgOb-all-MSU7-CHR6.GATKVARIANTFILTRATION-100000.vcf.tar.gz
* How many polymorphisms were considered bad and filtered out (Displaying all the lines without neither the `PASS` tag nor starting with `#` )?

-----------------------

<a name="practice-9"></a>
### Practice 9 : File modification with `sed`

#### From the vcf file OgOb-all-MSU7-CHR6.GATKVARIANTFILTRATION-100000.vcf
* Transform the vcf file in a coordinate file `chr\tpos\tpos`
* Now, in the VCF file, we would like to replace the genotypes by allelic dose. This means that we should replace the whole field by `0` when the genotype is `0/0`, by `1` when the genotype is `0/1` and `2` when the genotype is `1/1`

#### From fasta files in `LINUX-TP/Fasta`
* In `fasta` directory, there are two files : `C_AllContigs.fasta` and `contig_tgicl.fasta`. Before to generate a unique file with all 2 libraries, we would like to tag each sequence per its origin. In each file, add the respective tag VS1- / VS2- just before the identifier.

{% highlight bash %}
# File C_AllContigs.fasta initially
>C_pseu_c1
AAAAATGTTTGAAATCCACTTGGCATTMAATGGTGAAAGAATTTTAGATTTTTATATACT
CCCTCGGTAAGGAAATTGTTGTCTCATTTTGGGATTCACAATTATTACCAACAGTGCAAG
GGTTTT

#File C_AllContigs.fasta
>VS1-C_pseu_c1
AAAAATGTTTGAAATCCACTTGGCATTMAATGGTGAAAGAATTTTAGATTTTTATATACT
CCCTCGGTAAGGAAATTGTTGTCTCATTTTGGGATTCACAATTATTACCAACAGTGCAAG
GGTTTT
{% endhighlight %}

Rq : Test first the sed command on one file and STDOUT, then store the results in new files named RN-VS.MID1.clean.sff.fasta …

* Generate a file named all-contigs.fasta with all the sequences - `cat file1 file2 > file3`
* Count the number of sequences in the fasta file just created `grep -c ">" `
* Count the sequence number of each library in this file

#### From fastq files in `Data/fastq/pairedTwoIndividusIrigin`
* In the directory `Data/fastq/pairedTwoIndividusIrigin` transform the fastq file irigin1_1.fastq in fasta format
* In one command line transform all fastq files of the directory in fasta (save the files before)

-----------------------

<a name="practice-10"></a>
### Practice 10 : Manipulating files with `awk`

#### From the gff file precedently downloaded
* Extract the coordinate from the gff file
* Calculate the mean of the gene length
* Calculate the mean of the gene length for the chromosome 1
* Count the number of genes above 2000bp length
* Bonus: calculate the mean of gene length for each chromosomes in one command line

#### From the result of a nucmer analysis

We want to rapidly align an assembly against a entire genome using nucmer. (i.e., assembling etc.) to a reference genome. Type the three following commands :
{% highlight bash %}
#So we compare one multifasta that have been created against a genome
nucmer --mum reference.fasta contigs.fasta -p ctgVSref.NUCMER


#The previous command produces a file named ctgVSref.NUCMER.delta that can then be filtered using delta-filter and formatted using show-coords to produce a human-readable table of overlapping alignments between the two multifastas.

#Filtering the nucmer results 
#The -l in delta-filter sets the minimum alignment length to 300. The -q “Maps each position of each query to its best hit in the reference, allowing for reference overlaps”.
delta-filter -l300 -q ctgVSref.NUCMER.delta > ctgVSref.filter300.delta

#Generate results (tab format)
#The -c and -l in show-coords indicate that percent identity and sequence length information, respectively, should be included in the output. -L sets the minimum alignment length to display, -r sorts the output lines by reference IDs and coordinates, and -T switches the output to tab-delimited format.
show-coords -c -l -L 300 -r -T ctgOMAP.filter300.delta > ctgOMAP.filter300.delta.coords.txt
{% endhighlight %}

* Count the number of contigs in the fasta file
* Count the number of alignements performed by nucmer
* Count the number of contigs that have been aligned
* sort by alignment percent ascending
* count the number of alignement with alignment % > 50 then 80

-----------------------

<a name="practice-11"></a>
### Practice 11

* Go into the directory `LINUX-TP/Data/fastq/pairedTwoIndividusGzippedIrigin` - `cd`
* List the directory content
* Run fastq-stats program ( [more](http://manpages.ubuntu.com/manpages/xenial/man1/fastq-stats.1.html) to get stats about the fastq file `irigin1_1.fastq.gz`
{% highlight bash %}
fastq-stats -D irigin1_1.fastq.gz
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
                  
 
