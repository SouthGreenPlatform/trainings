---
layout: page
title: "Linux Tutorial"
permalink: /linux/linuxTuto/
tags: [ linux, survival guide ]
description: Linux page
---

| Description | Linux Command-Line Cheat Sheet |
| :------------- | :------------- | :------------- | :------------- |
| Related-course materials | [Linux for Dummies](https://southgreenplatform.github.io/trainings/linux/) |
| Authors | christine Tranchant-Dubreuil (christine.tranchant@ird.fr)  |
| Creation Date | 26/02/2018 |
| Last Modified Date | 3/03/2018 |

### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
- Moving around the Filesystem  and manipulating files/folders
  - [Printing the full path of the current directory `pwd`](#pwd)
  - [Listing files in a directory  `ls`](#ls)
  - [Moving in the file tree  `cd`](#cd)

<a name="pwd"></a>
### Printing the name/full path of the current directory `pwd`
**_Present Work Directory_**

```ruby
[tranchant@master0 ~]$ pwd
/home/tranchant
```

<a name="ls"></a>
### Listing files in a directory `ls`
**_List_** : list all files in the current directory

```ruby
[tranchant@master0 ~]$ ls 
AIRAIN
All-EST-coffea.fasta
all-gene.gff3.100000.gene-density
all_no_TE.gff3
all_no_TE.gff3.100000.gene-density
all_no_TE.gff3.10000.gene-density
All-SNP.vcf.density100000.snpden
blast_batch.pl
blast.sh
circos
DEDUP2-1
DEDUP2-all
Desktop
FASTA-TRINITY
fastq-stat.txt
GBS
```

`ls -l` : Display the long format listing of all files in the current directory 

```ruby
[tranchant@master0 ~]$ ls -l
total 148272
drwxr-xr-x 10 tranchant ggr      4096 13 mars   2017 AIRAIN
-rwxr-xr-x  1 tranchant ggr  51128305 11 sept. 14:16 All-EST-coffea.fasta
-rw-r--r--  1 tranchant ggr     95117 24 févr.  2017 all-gene.gff3.100000.gene-density
-rwxr-xr-x  1 tranchant ggr  64221458 24 févr.  2017 all_no_TE.gff3
-rw-r--r--  1 tranchant ggr     93796 24 févr.  2017 all_no_TE.gff3.100000.gene-density
-rw-r--r--  1 tranchant ggr    889389 24 févr.  2017 all_no_TE.gff3.10000.gene-density
-rwxr-xr-x  1 tranchant root    90498  5 déc.  07:21 All-SNP.vcf.density100000.snpden
-rwxr-xr-x  1 tranchant ggr     10366 29 mars   2017 blast_batch.pl
-rwxr-xr-x  1 tranchant ggr       878 29 mars   2017 blast.sh
drwxr-xr-x  3 tranchant ggr      4096 19 janv. 15:02 circos
drwxr-sr-x  2 tranchant ggr      4096  8 juin   2017 DEDUP2-1
drwxr-sr-x  2 tranchant ggr      4096  8 juin   2017 DEDUP2-all
drwxr-xr-x  4 root      root     4096  9 juil.  2015 Desktop
drwxr-sr-x  2 tranchant ggr      8192  8 juin   2017 FASTA-TRINITY
-rw-r--r--  1 tranchant ggr      1056 30 nov.  15:31 fastq-stat.txt
drwxr-xr-x  2 tranchant ggr        48 10 août   2016 GBS
```

<a name="ls"></a>
### Listing files in a directory giving as argument `ls directory_name`

```ruby
[tranchant@master0 ~]$ [tranchant@master0 ~]$ ls /home 
abate
abdelrah
adam
adeoti
adereeper
admin
agrondi
aichatou
```
