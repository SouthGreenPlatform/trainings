---
layout: page
title: "Galaxy Practice"
permalink: /linux/galaxyPractice/
tags: [ galaxy, survival guide ]
description: Galaxy Practice page
---

| Description | Hands On Lab Exercises for Galaxy |
| :------------- | :------------- | :------------- | :------------- |
| Related-course materials | [Galaxy introduction](http://galaxyproject.github.io/training-material/topics/introduction/slides/introduction.html#22) |
| Authors | Alexis Dereeper (alexis.dereeper@ird.fr)  |
| Creation Date | 15/03/2018 |
| Last Modified Date | 15/03/2018 |


-----------------------

### Summary

* [Practice 1: Basics of Galaxy (by Galaxy team)](#practice-1)
* [Practice 2: How to import datasets](#practice-2)
* [Practice 3: Concrete application: from reads to SNPs](#practice-3)
* [Links](#links)
* [License](#license)


-----------------------

<a name="practice-1"></a>
### Practice 1 : Basics of Galaxy (by Galaxy team)

Practice1 will be performed in the [Galaxy main](https://usegalaxy.org/) -
Practice1 consists of following the ["Galaxy 101" hands-on provided by Galaxy team](http://galaxyproject.github.io/training-material/topics/introduction/tutorials/galaxy-intro-101/tutorial.html#find-exons-with-the-highest-number-of-snps)

-----------------------

<a name="practice-1"></a>
### Practice 2 : How to import datasets

Practice2 will be performed in the Galaxy South Green. 

* Connect to [Galaxy South Green](http://galaxy.southgreen.fr/galaxy/) -
* Log in using FormationN@cirad.fr account
* Rename your history "test data upload"

Test the different ways to import datasets into your history:
* Copy/paste the content of a dataset
* Copy/paste the link/URL of an external file to be imported - `http://rice.plantbiology.msu.edu/pub/data/Eukaryotic_Projects/o_sativa/annotation_dbs/pseudomolecules/mitochondrion.dir/chrM.cds`
* Upload any txt file from your local computer
* Use FTP procedure to upload big file following the [procedure](http://galaxy.southgreen.fr/galaxy/u/dereeper/p/howtoload) described form Galaxy homepage
* Import a dataset from a shared data library

-----------------------

<a name="practice-3"></a>
### Practice 3 : Concrete application: From reads to SNPs

Practice3 will be performed in the Galaxy South Green.
* Create a new history for this practice (ex: SNP calling)
* From `Shared data => Data libraries`, import into your history fastq datasets for 3 individuals (RC1, RC2, RC3) as well as reference fasta
`Galaxy_trainings_2015 => NGS`
* Check these 6 files and create a collection of 3 dataset pairs `Build a list of dataset pairs`. Associate files by pair and give a name to your collection
* Process a FastqC analysis for RC1 to control the quality of sequencing
* Import the shared workflow called `Mapping_SNPCalling_PairedEnd`
* Observe the different steps of the workflow
* Run the complete workflow. It provides a collection of Bam files.
* Observe the final VCF output

-----------------------

### Links
<a name="links"></a>

* Related courses : [Galaxy introduction](http://galaxyproject.github.io/training-material/topics/introduction/slides/introduction.html#22)
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
                  
 
