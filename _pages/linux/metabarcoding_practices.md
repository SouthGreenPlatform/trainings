---
layout: page
title: "Metabarcoding Practice"
permalink: /linux/metabarcodingPractice/
tags: [ Metabarcoding, survival guide ]
description: Metabarcoding Practice page
---

| Description | Hands On Lab Exercises for Metabarcoding |
| :------------- | :------------- | :------------- | :------------- |
| Authors | Julie Orjuela (julie.orjuela@ird.fr), Alexis Dereeper (alexis.dereeper@ird.fr), Florentin Constancias (florentin.constancias@cirad.fr) |
| Creation Date | 18/04/2018 |
| Last Modified Date | 18/04/2018 |


-----------------------

### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Practice 1: Obtaining an OTU table with FROGS in Galaxy](#practice-1)
* [Practice 2: Visualizing and plotting all sample results with Phinch](#practice-2)
* [Practice 3: Statistical analysis of diversity using PhyloSeq R package](#practice-3)
* [Links](#links)
* [License](#license)


<a name="practice-1"></a>
<table class="table-contact">
<tr>
<td width="25%"><img width="60%" src="{{ site.url }}/images/trainings-galaxy.png" alt="" />
</td>
<td width="25%"><img width="30%" src="{{ site.url }}/images/FROGS_logo.png" alt="" />
</td>
<td width="25%"><img width="70%" src="{{ site.url }}/images/phinch.png" alt="" />
</td> 
<td width="25%"><img width="70%" src="{{ site.url }}/images/bioconductor.png" alt="" />
</td> 
</tr>
</table>

### Practice 1 : Obtaining an OTU table with FROGS in Galaxy

In this training we will performed metabarcoding analysis with the FROGS pipeline in the Galaxy environment.
* Connect to [Galaxy South Green](http://galaxy.southgreen.fr/galaxy/)
* Create a new history and import eight Metabarcoding samples datasets (paired-end fastq files) from Data library
`Galaxy_trainings_2015 => Metagenomics`
  - Fastq file used here are a subset of reads obtained in a metagenomic study of rice.
  
* Merge paired reads and dereplicate using the Preprocessing tool - `FROGS Pre-process`
  - Read size is 300 pb, expected, minimum and maximun amplicon size are 480,420,520 pb respectively, use custom sequencing protocol.
  - How many sequences have been overlapped? 
  - How many remain after dereplication?
  - What is the amplicon size obtained in the majority of merged sequences?  

* Build Clustering using swarm - `FROGS Clustering swarm`
  - Use an agregation distance of 3 with perform denoising clustering.
  - The biom file shows the abundance of each cluster.
  - The fasta file contains the cluster (OTU) representative sequences.
  - The tsv file shows what sequences are contained in each cluster.

* Obtain statistics about abondance of sequences in clusters - `FROGS Clusters stat`
  - How many clusters were obtained by swarm?
  - How many sequences are contained in the biggest cluster?
  - How many clusters contain only one sequence?
  - Observe the cumulative sequences proportion by cluster size
  - Observe cluster sharing between samples through hierarchical clustering tree
  
* Remove chimera - `FROGS Remove chimera`
  - What proportion of clusters were kept in this step?
  
* Filters OTUs on several criteria. - `FROGS Filters`
  - Elimine OTUs with low number of sequences (abondance < 10) and keep OTUs present in at least two samples.
  - How many OTUs were removed in this step?
  - How many OTUs were removed because of low abondance?
  
* Rerun statistics of clusters after filtering - `FROGS Clusters stat`
  - Look the effect of the cumulative proportion by cluster size.
  
* Perform taxonomic affiliation of each OTU by BLAST - `FROGS Affiliation OTU`
  - Use the SILVA 16S database for BLAST.
  - How many OTU were taxonomically assigned to species?
  - Visualize the biom file enriched with taxomonic information.
  
* Obtain statistics of affiliation - `FROGS Affiliation stat`
  - Observe global distribution of taxonomies by sample.
  - Look the rarefaction curve, which is a measure of samples vs diversity.
  
* Recovery a OTU table (human readable) in tsv format - `FROGS BIOM to TSV`
  - Download the tsv file for potential subsequent filtering.
  
-----------------------


<a name="practice-2"></a>
### Practice 2 : Visualize and plot all sample results with Phinch
<td>Practice2 will be performed in a specialized website.</td>
* Before start, recovery the biom file containing taxomonic information of the whole of rice samples.
From Galaxy, download  the file rice.biom from Data library `Galaxy_trainings_2015 => Metagenomics`. TO DO 
* Connect to [Phinch](http://phinch.org/) and import biom file obtained by FROGS.
* Explore ... To complete
* To complete
* To complete

-----------------------


<a name="practice-3"></a>
### Practice 3 : Statistical estimation of diversity using PhyloSeq R package
<td>Practice3 will be performed in the R environment.</td>
* TO DO  Recovery [phyloseq.r](https://southgreenplatform.github.io/trainings/files/phyloseq.r) file and import it in Rstudio.
* Run the Phyloseq program for differential analysis - `to complete`
* To complete
* To complete
* To complete

-----------------------

### Links
<a name="links"></a>
* Related courses : [Metabarcoding](http://sepsis-omics.github.io/tutorials/modules/frogs/)

-----------------------

### License
<a name="license"></a>

<div>
The resource material is licensed under the Creative Commons Attribution 4.0 International License (<a href="http://creativecommons.org/licenses/by-nc-sa/4.0/">here</a>).
<center><img width="25%" class="img-responsive" src="http://creativecommons.org.nz/wp-content/uploads/2012/05/by-nc-sa1.png"/>
</center>
</div>
