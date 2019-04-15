HELLO
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
* [Practice 3: Handling and visualizing OTU table using PhyloSeq R package](#practice-3)
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
* Connect to [Galaxy South Green](http://galaxy.southgreen.fr/galaxy/) with formationN account.
* Create a new history and import 8 Metabarcoding sample datasets (paired-end fastq files) from Data library
`Galaxy_trainings_2015 => Metagenomics`
  - Fastq file used here are a subset of reads obtained in a metagenomic study of rice root.
  
* Merge paired reads and dereplicate using the Preprocessing tool - `FROGS Pre-process`
  - Read size is 300 pb, expected, minimum and maximun amplicon size are 480,420,520 pb respectively. Use custom sequencing protocol.
  - How many sequences have been overlapped? 
  - How many sequences remain after dereplication?
  - What amplicon size is obtained in the majority of merged sequences?  

* Build Clustering using swarm - `FROGS Clustering swarm`
  - Use an aggregation distance of 1.
  - The biom file shows the abundance of each cluster.
  - The fasta file contains the cluster (OTU) representative sequences.
  - The tsv file shows what sequences are contained in each cluster.

* Obtain statistics about abundance of sequences in clusters - `FROGS Clusters stat`
  - How many clusters were obtained by swarm?
  - How many sequences are contained in the biggest cluster?
  - How many clusters contain only one sequence?
  - Observe the cumulative sequence proportion by cluster size
  - Observe cluster sharing between samples through hierarchical clustering tree
  
* Remove chimera - `FROGS Remove chimera`
  - What proportion of clusters were kept in this step?
  
* Filters OTUs on several criteria. - `FROGS Filters`
  - Eliminate OTUs with a low number of sequences (abundance < 10) and keep OTUs present in at least two samples.
  - How many OTUs were removed in this step?
  - How many OTUs were removed because of low abundance?
  
* Rerun statistics of clusters after filtering - `FROGS Clusters stat`
  - Look the effect of the cumulative proportion by cluster size.
  
* Perform taxonomic affiliation of each OTU by BLAST - `FROGS Affiliation OTU`
  - Use the SILVA 16S database for taxonomic assignation by BLAST.
  - How many OTU were taxonomically assigned to species?
  - Visualize the biom file enriched with taxomonic information.
  
* Obtain statistics of affiliation - `FROGS Affiliation stat`
  - Observe global distribution of taxonomies by sample.
  - Look the rarefaction curve, which is a measure of samples vs diversity.
  
* Retrieve a (human readable) OTU table in tsv format - `FROGS BIOM to TSV`
  - Download the tsv file for potential subsequent filtering.
  
-----------------------


<a name="practice-2"></a>
### Practice 2 : Visualizing and plotting sample results with Phinch
<td>Practice2 will use a specialized website to have an overview of a complete biom file. This dataset includes 24 samples of rice microbiome : 3 fields of sampling, 4 replicates, for infected and non-infected. These details were inclued in the metadata information on biom file. </td>
* Before start, retrieve the biom file containing taxomonic information of the whole rice samples.
From Galaxy, download  the file riz2.biom.txt from Data library `Galaxy_trainings_2015 => Metagenomics`. 
* Connect to [Phinch](http://phinch.org/) and import this biom file (obtained by FROGS).
* Select the 24 samples in ordet to analyse the whole data.
* Explore the `Graph Gallery`.
* Observe the diversity contained in each sample by using `Taxonomy Bar Chart`. Change the lineage level to family, genus or species. Change also to percentage view. 
* Observe the `Donut Partition` and compare the infected with the non-infected. It combines the distribution from the 3 fields infected versus the 3 fields not infected. Can you observe some differencies? Are there some over-represented phylum or order in infected fields?

-----------------------


<a name="practice-3"></a>
### Practice 3 : Handling and visualizing OTU table using PhyloSeq R package
<td>Practice3 will be performed in the R environment using Rstudio.</td>
* From Galaxy, download  the file riz_metadata.txt from Data library `Galaxy_trainings_2015 => Metagenomics`
* Download [phyloseq.r](https://southgreenplatform.github.io/trainings/files/phyloseq.r) file and import it in Rstudio.
* Import ‘OTU’ table and metadata
* Generate rarefaction curves, filter and normalize ‘OTU’ table
* Visualize and alpha-diversity, beta-diversity - generate basic statistics
* Generate taxonomy summary at different levels


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
