---
layout: page
title: "Exercices Admin HPC Module1"
permalink: /hpc/exercicesModule1/
tags: [ linux, HPC, cluster, module load ]
description: HPC Practice page
---

| Description | Exercices pour le Module1 du HPC Admin |
| :------------- | :------------- | :------------- | :------------- |
| Related-course materials | [HPC](https://southgreenplatform.github.io/trainings/HPC/) |
| Authors | Ndomassi TANDO (ndomassi.tando@ird.fr)  |
| Creation Date | 27/09/2019 |
| Last Modified Date | 27/09/2019 |


-----------------------

### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Exercice 1: Installer centos 7 sur une VM](#exercice-1)
* [Exercice 2: Ajout d'un disque scratch sur un noeud de calcul](#exercice-2)
* [Exercice 3: Installations de logiciels](#exercice-3)
* [Exercice 4: Création de Modulefile](#exercice-4)
* [Links](#links)
* [License](#license)


-----------------------

<a name="exercice-1"></a>
### Exercice 1: Installer centos 7 sur une VM`

Récupérer l'iso de Centos 7 et faire l'installation du système en suivant la procédure

-----------------------


<a name="Exercice-2"></a>
### Exercice 2: Ajout d'un disque scratch sur un noeud de calcul

Rajouter physiquement un disque dur le node0.

Formater le disque en xfs.

Monter le disque avec le nom /scratch


-----------------------


<a name=">Exercice-3"></a>
### Exercice 3: Installations de logiciels

A partir des sources, installer sur le cluster dans /usr/local les logiciels suivants:

-  gatk 3.3
-  atropos 1.1.14
-  picard-tools
-  flash
-  cutadapt 1.2.1
-  

-----------------------


<a name="practice-4"></a>
### Practice 4: Transfer your data from the nas server to the node


1. Using scp, transfer the folder `TPassembly` located in `/data2/formation` into your working directory
2. Check your result with ls
 


-----------------------
<a name="practice-5"></a>
### Practice 5: Use module environment to  load your tools


1. Load ea-utils V2.7 module
2. Check if the tool are loaded
 


-----------------------

<a name="practice-6"></a>
###  Practice 6 : Launch analyses

#### Get stats on fastq   

1. Go into  the folder `TPassembly/Ebola`
2. Launch the command `fastq-stats ebola1.fastq`
3. Launch the command `fastq-stats -D ebola1.fastq`

#### Perform an assembly with abyss-pe

With abyss software, we reassembly the sequences using the 2 fastq files ebola1.fastq and ebola2.fastq

Launch the commands

`module load bioinfo/abyss/1.9.0`

`qsub -q formation.q -l hostname=nodeX -cwd -b y abyss-pe k=35 in=\'ebola1.fastq ebola2.fastq\' name=k35`



-----------------------
<a name="practice-7"></a>
### Practice 7: Transfering data to the nas server


1. Using scp, transfer your results from your `/scratch/formationX` to your `/home/login` 
2. Check if the transfer is OK with ls
 




-----------------------
<a name="practice-8"></a>
### Practice 8: Deleting your temporary folder

`cd /scratch`

`rm -r formationX`

`exit`

 -----------------------
<a name="practice-9"></a>
### Practice 9: Launch a job with qsub

We are  going to launch a 4 steps analysis:

1) Perform a multiple alignment with the nucmer  tool

2) Filter these alignments with the delta-filter  tool

3) Generate a tab file easy to parse the with show-coords tools

4) Generate a png image with mummerplot


- Retrieve the script /data2/formation/script/alignment.sh into your /home/formation

- launch the script with qsub:

`qsub -q formation.q alignment.sh`

- Do a `ls -altr` in your `/home/formationX`. What do you notice?

- Launch the following command to obtain info on the finished job:

`qacct -j JOB_ID`

- Open filezilla and retrieve the png image to your computer

- Launch the following commande to clear the /scratch of the node

`ssh nodeX rm -r /scratch/formationX*`

-----------------------

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
                  
 
