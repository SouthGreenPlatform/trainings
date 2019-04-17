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
| Authors | Christine Tranchant-Dubreuil (christine.tranchant@ird.fr)  |
| Creation Date | 11/03/2018 |
| Last Modified Date | 14/04/2019 |


-----------------------

### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Preambule: Softwares to install before connecting to a distant linux server ](#preambule)
* [Practice 1: Get Connecting on a linux server by `ssh`](#practice-1)
* [Practice 2: Preparing working environnement](#practice-2)
* [Practice 3: Monitoring processes) with `w, ps, kill, top`](#practice-3)
* [Practice 4: Using the `&&` separator](#practice-4)
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
| IRD HPC |  bioinfo-master.ird.fr | 
| AGAP HPC |  cc2-login.cirad.fr |

* Connect on the HPC

-----------------------

<a name="practice-2"></a>
### Practice 2 : Preparing working environnement 

* Type qrsh to connect on one node
* Move into the directory /scratch
* Create a working directory such as Formation-<X> (x corresdponds to your login id/number) 
* Move into this directory just created and check the current/working directory just by looking the prompt
 
-----------------------

<a name="practice-3"></a>
### Practice 3 :  Monitoring processes

* Type the command `w` through 2 consoles : one connected on bioinfo-master, the other connected on one node
* Type (on the node connected) the command `ps`without option, then with the option `u`, `ua`,  `uax`
* Type the command `top`on the node 
> then use the "option" c to display the complete process
> then display only your processes
* We will start downloading fastq files from ncbi and then stop the process with `kill` :
manual https://www.ncbi.nlm.nih.gov/books/NBK158899/ 
> we want to download the fastq avalaible on ncbi at this url :https://trace.ncbi.nlm.nih.gov/Traces/sra/?run=SRR6147997
> we will use the following command :
`wget ftp://ftp-trace.ncbi.nih.gov/sra/sra-instant/reads/ByRun/sra/SRR/SRRXXX/SRRXXXXXX/SRRXXXXXX.sra`

TIPS :
`Reminder of path:

/sra/sra-instant/reads/ByRun/sra/{SRR\|ERR\|DRR}/<first 6 characters of accession>/< accession >/< accession >.sra

Where

{SRR\|ERR\|DRR} should be either ‘SRR’, ‘ERR’, or ‘DRR’ and should match the prefix of the target .sra file

Examples:

Downloading SRR304976 by wget or FTP:

wget ftp://ftp-trace.ncbi.nih.gov/sra/sra-instant/reads/ByRun/sra/SRR/SRR304/SRR304976/SRR304976.sra`

command sra &
* kill -9

<a name="practice-4"></a>
### Practice 4 : Using the && separator

* On the console, type the 2 following linux commands to get data necessary for the next (we will explain the two commands latter):
{% highlight bash %}
# get the file on the web and decompress the gzip file 
wget http://sg.ird.fr/LINUX-TP/LINUX-TP.tar.gz && tar -xzvf LINUX-TP.tar.gz

{% endhighlight %}

* Check through filezilla the content of your home directory on the server now (cf. filetree just below)
* Delete through filezilla the file LINUX-TP.tar.gz on the server

<img width="50%" class="img-responsive" src="{{ site.url }}/images/tpLinux/tp-arbo.png"/>




-----------------------

<a name="practice-5"></a>
### Practice 5 : Searching for text using `grep`
* Go on the following page : http://rice.plantbiology.msu.edu/pub/data/Eukaryotic_Projects/o_sativa/annotation_dbs/pseudomolecules/version_7.0/
* Copy the url of the rice genome annotation file (gff format) that we will use to download the file directly on the server
* Go to the `bank` directory and type the following command :

{% highlight bash %}
wget gff_url
{% endhighlight %}

* Prints the number of lines with the word `gene` in the gff file - `grep -P`
* Counts the number of genes - `grep -c` 
* Search for the nbs-lrr genes - `grep -i`
* Removes the lines with `putative` word - `grep -v`
* Counts the number of mRNA in the chromosome 1 - `grep -c regexp`
* Counts the number of mRNA in the first five chromosomes - `grep -c regexp`
* In the infoseq file counts the number of sequences with a length between 1000 and 9999 --------- CD ------------

-----------------------

<a name="practice-6"></a>
### Practice 6 :  Displaying lines with `sed`
For this exercise, you will work on a fastq file

* Print the 8 first lines
* Print the lines 5 to 12
* Print only the sequences ids
* Print only the sequences ids and nucleotides sequences

-----------------------

<a name="practice-7"></a>
### Practice 7 : Deleting lines with `sed`
For this exercise, you will work on a fastq file

* Delete the end of the file from the line 9
* Delete the lines containing only a `+`
* Delete the lines containing only a `+` and the quality sequences

-----------------------

<a name="practice-8"></a>
### Practice 8 : File parsing with `sed` using regexp

In the gff file
* Count the number of genes

Let's now parse the output VCF file `OgOb-all-MSU7-CHR6.GATKSELECTVARIANTS.vcf`.

* How many polymorphisms were considered bad and filtered out (Displaying all the lines without neither the `PASS` tag nor starting with `#` )?

-----------------------

<a name="practice-9"></a>
### Practice 9 : File modification with `sed`

* Transform the vcf file `OgOb-all-MSU7-CHR6.GATKSELECTVARIANTS.vcf` in a coordinate file `chr\tpos\tpos`
* In the VCF file `OgOb-all-MSU7-CHR6.GATKSELECTVARIANTS.vcf` we would like to replace the genotypes by allelic dose. This means that we should replace the whole field by `0` when the genotype is `0/0`, by `1` when the genotype is `0/1` and `2` when the genotype is `1/1`

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

* In the directory `Data/fastq/pairedTwoIndividusIrigin` transform a fastq file in fasta
* In one command line transform all fastq files of the directory in fasta (save the files before)

-----------------------

<a name="practice-10"></a>
### Practice 10 : Manipulating files with `awk`

* Extract the coordinate from the gff file
* Calculate the mean of the gene length
* Calculate the mean of the gene length for the chromosome 1
* Count the number of genes above 2000bp length
* Bonus: calculate the mean of gene length for each chromosomes in one command line

Lancer nucmer et faites des filtres


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
                  
 
