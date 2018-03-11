---
layout: page
title: "Advanced Linux Practice"
permalink: /linux/linuxPracticeJedi/
tags: [ linux, survival guide ]
description: Advanced Linux Practice page
---

| Description | Hands On Lab Exercises for Linux |
| :------------- | :------------- | :------------- | :------------- |
| Related-course materials | [Linux for Jedi](https://southgreenplatform.github.io/trainings//linuxJedi/) |
| Authors | christine Tranchant-Dubreuil (christine.tranchant@ird.fr)  |
| Creation Date | 11/03/2018 |
| Last Modified Date | 11/03/2018 |


-----------------------

### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Preambule: Softwares to install before connecting to a distant linux server ](#preambule)
* [Practice 1: Manipuling Blast results](#practice-1)
* [Practice 2: Printing a command output into a file with `>`](#practice-2)
* [Practice 3: Running many commands with `|`](#practice-2)
* [Links](#links)
* [License](#license)


-----------------------

<a name="preambule"></a>
### Preambule 
* List of Softwares to install before connecting to a distant linux server [more information](https://southgreenplatform.github.io/trainings/linux/linuxPractice/#preambule)
* Arborescence image :

-----------------------

<a name="practice-1"></a>
### Practice 1 : Blast analysis

A blastn were performed between the fasta file allTrasncritsAssembled.fasta and the bank `AllEst.fasta`.
* If not already done:
1- create the directory `blastAnalysis`
2- copy the file `blastn-results.blastn`(scratch directory) into this directory
3- copy the databank into the directory Bank

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
### Practice 2 : Printing a command output into a file with `>`
* Extract ESTs identifiers and print them in the file  ESTs_accession.list

-----------------------

<a name="practice-3"></a>
### Practice 3 :  Running many commands with `|`
* How many sequences have a homology with EST sequences ? (TIPs: use `sort -u` (uniq) or `uniq` command ))
* Extract ESTs sequences from database with `blastdbcmd` by typing :

{% highlight bash %}
blastdbcmd -entry_batch hits.txt -out hits.fasta 
{% endhighlight %}

{% highlight bash %}
 -entry_batch is the file containing the sequence names and -outfmt here says we want fasta formatted sequences (%f). 
{% endhighlight %}



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
                  
 
