---
layout: page
title: "Galaxy Practice"
permalink: /linux/galaxyPractice/
tags: [ galaxy, survival guide ]
description: Galaxy Practice page
---

| Description | Hands On Lab Exercises for Galaxy |
| :------------- | :------------- | :------------- | :------------- |
| Related-course materials | [Transcriptomique](https://southgreenplatform.github.io/trainings/linux/linuxPracticeJedi//) |
| Authors | Alexis Dereeper (alexis.dereeper@ird.fr)  |
| Creation Date | 15/03/2018 |
| Last Modified Date | 15/03/2018 |


-----------------------

### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Practice 1: Data upload, data format and histories](#practice-1)
* [Practice 2: My first analyses in Galaxy](#practice-2)
* [Practice 3: Create a workflow](#practice-3)
* [Practice 4: How to share your work](#practice-4)

* [Links](#links)
* [License](#license)


-----------------------

<a name="practice-1"></a>
### Practice 1 : Mapping against transcriptome reference with Kallisto in Galaxy

Practice1 will be performed in the Galaxy environment.

We will perform a transcriptome-based mapping and estimates of transcript levels using Kallisto, and a differential analysis using EdgeR.
* Connect to Galaxy South Green - [http://galaxy.southgreen.fr/galaxy/](](http://galaxy.southgreen.fr/galaxy/)
* Create a new history and import RNASeq samples datasets (paired-end fastq files) from Data library  - `head`


-----------------------

<a name="practice-2"></a>
### Practice 2 : Mapping against annotated genome reference with TopHat in TOGGLe
Practice2 will be performed with the TOGGLe workflow management system.
* Is there any new gene (not defined in GFF annotation) that shows significant differential expression?

-----------------------

<a name="practice-3"></a>
### Practice 3 : Visualization of mapped reads against genes using IGV
Practice3 will be performed with Integrated Genome Viewer (IGV).
* Load reference genome, GFF annotation file and two BAM files corresponding to 0dpi and 2dpi
* Focus on a gene that has been shown to be differentially expressed and observe the difference of accumation of reads


-----------------------

<a name="practice-4"></a>
### Practice 4 : Filtering and Generating plots
Practice4 will be performed using an external website (Degust/MeV/MicroScope).
* Upload count file into [Degust](http://degust.erc.monash.edu/)
* Observe the different plots available
* How many genes can be found DE for a minimum pvalue <= 0.05 and abs(logFC) > 2? Observe the plots.

-----------------------

### Links
<a name="links"></a>

* Related courses : [Transcriptomics](https://southgreenplatform.github.io/trainings/linuxJedi/)
* Galaxy main : [Galaxy main](https://usegalaxy.org/)
* Galaxy IRD : [Galaxy IRD](http://bioinfo-inter.ird.fr:8080/)
* Galaxy Cirad : [Galaxy CIRAD](http://galaxy.southgreen.fr/galaxy/)
* Galaxy trainings materials: [Galaxy trainings materials](https://galaxyproject.github.io/training-material/)

-----------------------

### License
<a name="license"></a>

<div>
The resource material is licensed under the Creative Commons Attribution 4.0 International License (<a href="http://creativecommons.org/licenses/by-nc-sa/4.0/">here</a>).
<center><img width="25%" class="img-responsive" src="http://creativecommons.org.nz/wp-content/uploads/2012/05/by-nc-sa1.png"/>
</center>
</div>
                  
 
