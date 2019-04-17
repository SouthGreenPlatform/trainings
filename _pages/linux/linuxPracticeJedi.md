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
* command sra &
* kill -9

* On the console, type the 2 following linux commands to get data necessary for the next (we will explain the two commands latter):
{% highlight bash %}
# get the file on the web
wget http://sg.ird.fr/LINUX-TP/LINUX-TP.tar.gz && 

# decompress the gzip file
tar -xzvf LINUX-TP.tar.gz
{% endhighlight %}

* Check through filezilla the content of your home directory on the server now (cf. filetree just below)
* Delete through filezilla the file LINUX-TP.tar.gz on the server

<img width="50%" class="img-responsive" src="{{ site.url }}/images/tpLinux/tp-arbo.png"/>




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
                  
 
