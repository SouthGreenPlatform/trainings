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
| Authors | christine Tranchant-Dubreuil (christine.tranchant@ird.fr)  |
| Creation Date | 11/03/2018 |
| Last Modified Date | 11/03/2018 |


-----------------------

### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Preambule: Softwares to install before connecting to a distant linux server ](#preambule)
* [Practice 1: Dealing with Blast results](#practice-1)
* [Practice 2: Redirecting a command output to a File with `>`](#practice-2)
* [Practice 3: Sending data from one command to another (piping) with `|`](#practice-3)
* [Practice 4: Searching for text using `grep`](#practice-4)
* [Practice 5: Running many commands with `|` - `grep`](#practice-5)
* [Practice 6 : Modifying a file with `sed`](#practice-6)

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
* Sort the lines using the second field (subject  id) by alphabetical order, ascending then descending   - `sort`
* Sort lines by e‐value (ascending) and by “alignment length” (descending) - `sort`
* Extract the first 4 fields - `cut`
* Extract query id, subject id, evalue, alignment length - `cut`

-----------------------

<a name="practice-2"></a>
### Practice 2 : Redirecting a command output to a File with `>`
* Extract all ESTs identifiers and print them in the file  ESTs_accession.list - `cut`

-----------------------

<a name="practice-3"></a>
### Practice 3 :  Sending data from one command to another (piping) with `|`
* How many sequences have a homology with EST sequences ? (TIPs: use `sort -u` (uniq) or `uniq` command ))
* Extract ESTs sequences from database with `blastdbcmd` by typing :

{% highlight bash %}
blastdbcmd -entry_batch hits.txt -out hits.fasta 
{% endhighlight %}

{% highlight bash %}
 -entry_batch is the file containing the sequence names 
{% endhighlight %}

-----------------------

<a name="practice-4"></a>
### Practice 4 : Searching for text using `grep`
* Go on the following page : http://rice.plantbiology.msu.edu/pub/data/Eukaryotic_Projects/o_sativa/annotation_dbs/pseudomolecules/version_7.0/
* Copy the url of the rice genome annotation file (gff format) that we will use to download the file directly on the server
* Go to the `bank` directory and type the following command :

{% highlight bash %}
wget gff_url
{% highlight bash %}

* After checking the content of your current directory, what have you done with the `wget` command?
* Displays the firts and lasts line of the gff file - `head`, `tail`
* Prints the number of lines with the word `genes` in the gff file - `grep`
* Counts the number of genes - `grep -c` 
* Search for the nbs-lrr genes - `grep -i`
* Removes the lines with `putative` word - `grep -v`

-----------------------

<a name="practice-5"></a>
### Practice 5 :  Running many commands with `|` - `grep`
* How many raw polymorphisms were detected (file `OgOb-all-MSU7-CHR6.GATKSELECTVARIANTS.vcf`)?
* How many filtered polymorphisms were detected (file `OgOb-all-MSU7-CHR6.GATKSELECTVARIANTS.vcf`)?
* How many filtered SNP were detected (file `OgOb-all-MSU7-CHR6.GATKSELECTVARIANTS.vcf`)?

-----------------------

<a name="practice-6"></a>
### Practice 6 : Modifying a file with `sed`

* In `fasta` directory, there are two files : `C_AllContigs.fasta` and `contig_tgicl.fasta`. Before to generate a unique file with all 2 libraries, we would like to tag each sequence per its origin. In each file, add the respective tag VS1- / VS2- at the identifier.

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

* Generate a file named all-contigs.fasta with all the sequences

* Count the number of complete sequences and then the number of sequences of each library in this final file


### Links
<a name="links"></a>

* Related courses : [Linux for Dummies](https://southgreenplatform.github.io/trainings/linux/)
* Tutorials : [Linux Command-Line Cheat Sheet](https://southgreenplatform.github.io/trainings/linux/linuxTuto/)

-----------------------

### License
<a name="license"></a>

<div>
The resource material is licensed under the Creative Commons Attribution 4.0 International License (<a href="http://creativecommons.org/licenses/by-nc-sa/4.0/">here</a>).
<center><img width="25%" class="img-responsive" src="http://creativecommons.org.nz/wp-content/uploads/2012/05/by-nc-sa1.png"/>
</center>
</div>
                  
 
