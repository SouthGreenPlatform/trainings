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
| Last Modified Date | 26/05/2018 |


-----------------------

### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Preambule: Softwares to install before connecting to a distant linux server ](#preambule)
* [Practice 1: Dealing with Blast results](#practice-1)
* [Practice 2: Redirecting a command output to a File with `>`](#practice-2)
* [Practice 3: Sending data from one command to another (piping) with `|`](#practice-3)
* [Practice 4: Searching for text using `grep`](#practice-4)
* [Practice 5: Running many commands with `|` - `grep`](#practice-5)
* [Practice 6 : Modifying a file with `sed` command](#practice-6)
* [Practice 7 : Modifying a file with `awk` command](#practice-7)
* [Practice 8 : Running the same command with different files successively with `for` loop](#practice-8)

* [Links](#links)
* [License](#license)


-----------------------

<a name="preambule"></a>
### Preambule 
* List of Softwares to install before connecting to a distant linux server [more information](https://southgreenplatform.github.io/trainings/linux/linuxPractice/#preambule)
* Arborescence image :

-----------------------

<a name="practice-1"></a>
### Practice 1 : Dealing with Blast results

A blastn were performed between the fasta file allTranscritsAssembled.fasta and the bank `AllEst.fasta`.
* Display  the  first  10  lines  of  the  file  - `head`
* Display  the  first  15  lines  of  the  file  - `head`
* Display  it  last  15  lines  - `tail`
* Count  the  number  of  line - `wc`
* Sort the lines using the second field (subject  id) by alphabetical order, ascending then descending   - `csort`
* Sort lines by e‐value (ascending) and by “alignment length” (descending) - `csort`
* Extract the first 4 fields - `cut -f1-4`
* Extract query id, subject id, evalue, alignment length - `cut`

-----------------------

<a name="practice-2"></a>
### Practice 2 : Redirecting a command output to a File with `>`
* Extract all ESTs identifiers and print them in the file  ESTs_accession.list - `cut >`

-----------------------

<a name="practice-3"></a>
### Practice 3 :  Sending data from one command to another (piping) with `|`
* How many sequences have a homology with EST sequences ? (TIPs: `cut` command with `sort -u` (uniq) or `uniq` command ))
* Extract ESTs sequences from database with `blastdbcmd` by typing :

{% highlight bash %}
blastdbcmd -entry_batch hits.txt -db bank -out hits.fasta 
{% endhighlight %}

{% highlight bash %}
 -entry_batch is the file containing the sequence names 
{% endhighlight %}

* Count the number of sequences extracted - `grep ">" c `
-----------------------

<a name="practice-4"></a>
### Practice 4 : Searching for text using `grep`
* Go on the following page : http://rice.plantbiology.msu.edu/pub/data/Eukaryotic_Projects/o_sativa/annotation_dbs/pseudomolecules/version_7.0/
* Copy the url of the rice genome annotation file (gff format) that we will use to download the file directly on the server
* Go to the `bank` directory and type the following command :

{% highlight bash %}
wget gff_url
{% endhighlight %}
 
* After checking the content of your current directory, what have you done with the `wget` command?
* Displays the firts and lasts line of the gff file - `head`, `tail`
* Prints the number of lines with the word `gene` in the gff file - `grep -P`
* Counts the number of genes - `grep -c` 
* Search for the nbs-lrr genes - `grep -i`
* Removes the lines with `putative` word - `grep -v`

-----------------------

<a name="practice-5"></a>
### Practice 5 :  Running many commands with `|` - `grep`
To get some basics stats of the output VCF file `/work/sarah1/Formation_Linux/VCF/OgOb-all-MSU7-CHR6.GATKSELECTVARIANTS.vcf`, let's use linux command!
* How many raw polymorphisms were detected (Displaying all the lines which does not start with # / header lines)?
* How many polymorphisms were considered good after filtering steps by GATK VARIANTFILTRATION (ie marked `PASS`)?
* How many polyporphisms were considered bad and filtered out (Displaying all the lines without the `PASS` tag )?

-----------------------

<a name="practice-6"></a>
### Practice 6 : Modifying a file with `sed`

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

-----------------------

<a name="practice-7"></a>
### Practice 7 : Modifying a file with `awk`
Let's parse the output VCF file `/work/sarah1/Formation_Linux/VCF/OgOb-all-MSU7-CHR6.GATKSELECTVARIANTS.vcf`.
* Display the columns 1, 2, 4 and 5 (chromosome, position, polymorphisme, reference)
* Display the line number followed by the columns 1, 2, 4, 5, 6 and 7  (chromosome, position, polymorphisme, reference, calling quality and filter)
* Display the whole line if the line does not contain `#` (condition : `!/^#/`) - `NR`
* Display the line number followed by the columns 1, 2, 4, 5, 6 and 7  and at the end, the polymorphism number (the header line are automatically removed using a condition)
* Display the columns 1, 2, 4, 5, 6 and 7 only if the line does not start by `#`and the tag PASS is present 

-----------------------

<a name="practice-8"></a>
### Practice 8 : Running the same command with different files successively with `for` loop
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
                  
 
