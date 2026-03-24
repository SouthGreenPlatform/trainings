---
layout: page
title: "S2: SNP Data Handling & Quality Control & S3 part: Distance Phylogenetic Tree"
permalink: /cocogeno_ictp4/S2_gigwa_flapjack_S3_taxonium/
tags: [ Genomic variations, INDEL, Gigwa, NoSQL, Web, Interoperability, individual phylogogenetic tree, SNP distance matrix, PCA, VCF, Flapjack, Hamap, JUKES-CANTOR, Newick, PLINK ]
description: This pratical introduces version 2.12 of Gigwa (Genotype Investigator for Genome-Wide Analyses)
author: Stéphanie Bocs
date: 25/03/2026
---

<table class="table-contact">
<tr>
<td><img width="60%" class="img-responsive" src="{{ site.url }}/images/trainings-gigwa.png" alt="" />
</td>
<td>
Hands on version 2.12 of Gigwa<br>
(Genotype Investigator for Genome-Wide Analyses)
</td>
</tr>
</table>

## Goal of this tutorial
* SNP Data Handling & Quality Control (session 2).
* Observe population diversity (170 individuals of coconut palm diversity panel) with a distance phylogenetic tree colored by a trait (coconut color).
You will understand:
* The benefits of using Gigwa.
* How to use it.
For this tutorial, we will use the staging implementation of Gigwa (gigwa-dev), where are stored coconut databases.

## Gigwa documentation and links
* [Gigwa v2 article](https://doi.org/10.1186/s13742-016-0131-8) and citation
<pre>
Gigwa v2 - Extended and improved genotype investigator
Guilhem Sempéré; Adrien Pétel; Mathieu Rouard; Julien Frouin; Yann Hueber; F De Bellis; Pierre Larmande
GigaScience, Volume 8, Issue 5, May 2019, giz051
</pre>
* [Gigwa v2.12 – Documentation](https://gigwa.southgreen.fr/gigwa/docs/gigwa_docs.html)
* [Videos on how to use Gigwa](https://www.youtube.com/playlist?list=PLMHx16OgbKiObTprXWyYsn73EQa5-Bpza)

## Demo on the full private dataset

* How the raw VCF looks like
```
$ ls -l
$ more 
```
* [Gigwa v2.12 staging private](https://gigwa-dev.southgreen.fr/gigwaV2/login.do)

## Hands-on on the light dataset 
[Gigwa v2.12 staging public](https://gigwa-dev.southgreen.fr/gigwaV2/)
  
## How was preparated this light dataset ?
Successive filters have been applied to reduce the VCF:
* Take only one harm of chromosomes 10, 11 and 14.
* Keep only SNP markers (remove INDELs)
* Remove monomorphic SNPs
* Keep only biallelic SNPs

## S2: SNP handling quality control with Gigwa

### SNP filters on the full dataset of the light coconut database

1. Accept the terms of Gigwa use and choose the 'Coconut_KU' Database  
<img width="100%" src="{{ site.url }}/images/ictp4/gigwa_s2_1.png" alt="" />
1. Choose to investigate genotypes 'on 1 group', click on 'Enable browse and export' and then click on search  
<img width="50%" src="{{ site.url }}/images/ictp4/gigwa_s2_2.png" alt="" />
<img width="50%" src="{{ site.url }}/images/ictp4/gigwa_s2_3.png" alt="" />
1. Observe the total SNP number (53056) and then select only the SNP marker (filter 1)  
<img width="100%" src="{{ site.url }}/images/ictp4/gigwa_s2_4.png" alt="" />
1. Observe the SNP number (F1: 48133) and then select only the biallelic SNPs (filter 2)   
<img width="100%" src="{{ site.url }}/images/ictp4/gigwa_s2_5.png" alt="" />
1. Observe the SNP number (F1-F2: 47122) and then select less or equal to 5% of missing data (filter 3)  
<img width="100%" src="{{ site.url }}/images/ictp4/gigwa_s2_6.png" alt="" />
1. Observe the SNP number (F1-F3: 34872) and then select less or equal to 5% of MAF (Minor Allele Frequency; filter 4)  
<img width="100%" src="{{ site.url }}/images/ictp4/gigwa_s2_7.png" alt="" />
1. Observe the final SNP number with these filters (F1-F4: 16548) and then click on alleles of on line to display the variant details (e.g. genotypes)  
<img width="100%" src="{{ site.url }}/images/ictp4/gigwa_s2_8.png" alt="" />  
<img width="100%" src="{{ site.url }}/images/ictp4/gigwa_s2_9.png" alt="" />

### Quality control on the light coco db chr 14 arm

1. Accept the Gigwa terms and choose your database
Blabla
1. Chose to investigate one group and click search and browse
pdofgjfop
1. Chose SNP marker and filter

### Visual inspection on the light coco db chr 14:147336001..150373000


## S3 part: individual phylogogenetic tree based on SNP distance matrix
