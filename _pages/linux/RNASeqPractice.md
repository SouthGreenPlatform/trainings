---
layout: page
title: "RNASeq Practice"
permalink: /linux/rnaseqPractice/
tags: [ rnaseq, survival guide ]
description: RNASeq Practice page
---

| Description | Hands On Lab Exercises for RNASeq |
| :------------- | :------------- | :------------- | :------------- |
| Related-course materials | [Transcriptomique](https://southgreenplatform.github.io/trainings/linux/linuxPracticeJedi//) |
| Authors | Alexis Dereeper (alexis.dereeper@ird.fr)  |
| Creation Date | 15/03/2018 |
| Last Modified Date | 15/03/2018 |


-----------------------

### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Practice 1: Mapping against transcriptome reference with Kallisto in Galaxy](#practice-1)
* [Practice 2: Mapping against annotated genome reference with TopHat in TOGGLe](#practice-2)

* [Links](#links)
* [License](#license)


-----------------------

<a name="practice-1"></a>
### Practice 1 : Mapping against transcriptome reference with Kallisto in Galaxy

Practice1 will be performed in the Galaxy environment.

We will perform a transcriptome-based mapping and estimates of transcript levels using Kallisto, and a differential analysis using EdgeR.
* Connect to Galaxy South Green - http://http://galaxy.southgreen.fr/galaxy/
* Create a new history and import RNASeq samples datasets (paired-end fastq files) from Data library  - `head`
* Check these 8 files and create a collection of dataset pairs - `Build a list of dataset pairs`
Associate files by pairs and give a name to your collection
* Upload the Chr1 of rice transcriptome (cDNA) to be used as reference  - `http://rice.plantbiology.msu.edu/pub/data/Eukaryotic_Projects/o_sativa/annotation_dbs/pseudomolecules/version_7.0/chr01.dir/Chr1.cdna`
* Run the kallisto program by providing Chr1 as transcriptome reference - `kallisto quant`
* Convert kallisto outputs (collection of count files) into one single file taht can be used as input for EdgeR - `kallisto2EdgeRInput`
* Run the EdgeR program for differential analysis - `edger`
-----------------------

<a name="practice-2"></a>
### Practice 2 : Mapping against annotated genome reference with TopHat in TOGGLe
Practice2 will be performed with the TOGGLe workflow management system.


-----------------------


### Links
<a name="links"></a>

* Related courses : [Transcriptomics](https://southgreenplatform.github.io/trainings/linuxJedi/)

-----------------------

### License
<a name="license"></a>

<div>
The resource material is licensed under the Creative Commons Attribution 4.0 International License (<a href="http://creativecommons.org/licenses/by-nc-sa/4.0/">here</a>).
<center><img width="25%" class="img-responsive" src="http://creativecommons.org.nz/wp-content/uploads/2012/05/by-nc-sa1.png"/>
</center>
</div>
                  
 
