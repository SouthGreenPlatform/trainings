---
layout: page
title: "Metabarcoding Practice"
permalink: /linux/metabarcodingPractice/
tags: [ Metabarcoding, survival guide ]
description: Metabarcoding Practice page
---

| Description | Hands On Lab Exercises for Metabarcoding |
| :------------- | :------------- | :------------- | :------------- |
| Authors | J Orjuela (julie.orjuela@ird.fr), A Dereeper (alexis.dereeper@ird.fr), F Constancias (florentin.constancias@cirad.fr), J Reveilleud (JR) (julie.reveillaud@inra.fr), M Simonin (marie.simonin@ird.fr), F Mahé (frederic.mahe@cirad.fr), A Comte aurore.comte@ird.fr| 
| Creation Date | 18/04/2018 |
| Last Modified Date | 17/05/2019 |

-----------------------

### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Practice 1: Obtaining an OTU table with FROGS in Galaxy](#practice-1)
  * [Practice 1.1: Preprocessing](#preprocess)
  * [Practice 1.2: Clustering](#clustering)
  * [Practice 1.3: Stats on clustering (optional)](#statsClustering1)
  * [Practice 1.2: Clustering](#clustering)
  * [Practice 1.2: Clustering](#clustering)
  * [Practice 1.2: Clustering](#clustering)
  * [Practice 1.2: Clustering](#clustering)
  

* [Practice 3: Handling and visualizing OTU table using PhyloSeq R package](#practice-3)
* [Links](#links)
* [License](#license)


<table class="table-contact">
<tr>
<td width="25%"><img width="60%" src="{{ site.url }}/images/trainings-galaxy.png" alt="" />
</td>
<td width="25%"><img width="30%" src="{{ site.url }}/images/FROGS_logo.png" alt="" />
</td>
<td width="25%"><img width="70%" src="{{ site.url }}/images/qiime2.png" alt="" />
</td> 
<td width="25%"><img width="70%" src="{{ site.url }}/images/bioconductor.png" alt="" />
</td> 
</tr>
</table>

-----------------------
<a name="practice-1"></a>
### Practice 1 : Obtaining an OTU table with FROGS in Galaxy

In this training we will first performed metabarcoding analysis with the FROGS v3.1 pipeline in the Galaxy environment `https://github.com/geraldinepascal/FROGS `. In a second time, we will perform similar analysis in command line on HPC i-Trop cluster.

* Connect to [Galaxy i-Trop](http://http://bioinfo-inter.ird.fr:8080/) with formationN account.
* Create a new history and import Metabarcoding sample datasets (paired-end fastq files compressed by tar ) from  
`Shared Data / Data libraries /formation Galaxy 2019 / Metabarcoding`. Recovery  `DATA_s.tar.gz` and `Summary.txt`
  - Fastq files used here are a subset of reads obtained in a metagenomic study of Edwards et al 2015 containing 4 soil compartments:  Rhizosphere, Rhizoplane, Endosphere and Bulk_Soil of a rice culture.
  
We will launch every step of a metabarcoding analysis as follow :

-----------------------
<a name="preprocess"></a>
### Preprocess

* Merge paired reads and dereplicate using the Preprocessing tool with FLASH as merge software - `FROGS Pre-process`
  - => Read size is 250 pb, expected, minimum and maximun amplicon size are 250,100,350 pb respectively. Use custom sequencing protocol. Use a mistmach rate of 0.15.
  - How many sequences have been overlapped? 
  - How many sequences remain after dereplication?
  - What amplicon size is obtained in the majority of merged sequences?  

-----------------------
<a name="clustering"></a>
### Clustering

* Build Clustering using swarm - `FROGS Clustering swarm`
  - => Use an aggregation distance of 1. Don't use denoising option.
  - The biom file shows the abundance of each cluster.
  - The fasta file contains the cluster (OTU) representative sequences.
  - The tsv file shows what sequences are contained in each cluster.

-----------------------
<a name="statsClustering1"></a>
### Stats on clustering (optional)

* Obtain statistics about abundance of sequences in clusters - `FROGS Clusters stat`
  - How many clusters were obtained by swarm?
  - How many sequences are contained in the biggest cluster?
  - How many clusters contain only one sequence?
  - Observe the cumulative sequence proportion by cluster size
  - Observe cluster sharing between samples through hierarchical clustering tree

-----------------------
<a name="chimera"></a>
### Remove chimera

* Remove chimera using biom obtained from swarm - `FROGS Remove chimera`
  - What proportion of clusters were kept in this step?
  
-----------------------
<a name="otuFiltering"></a>
### OTU Filtrering 

* Filters OTUs on several criteria. - `FROGS Filters`
  - Eliminate OTUs with a low number of sequences (abundance at 0.005%) and keep OTUs present in at least two samples.
  - How many OTUs were removed in this step?
  - How many OTUs were removed because of low abundance?
* Relauch OTU Filtering but using abundance at 0.01%.  How many OTUs were removed because of low abundance?

-----------------------
<a name="statsClustering2"></a>
### Stats on clustering (optional)

* Rerun statistics of clusters after filtering - `FROGS Clusters stat`
  - Look the effect of the cumulative proportion by cluster size.

-----------------------
<a name="afiliation"></a>
### Taxonomic affiliation

* Perform taxonomic affiliation of each OTU by BLAST - `FROGS Affiliation OTU`
  - Use the SILVA 132 16S database for taxonomic assignation by BLAST.
  - Activate RDP assignation.
  - How many OTU were taxonomically assigned to species?
  - Visualize the biom file enriched with taxomonic information.

-----------------------
<a name="afiliationStats"></a>
### Affiliation stat
 
* Obtain statistics of affiliation - `FROGS Affiliation stat`
  - Use rarefaction ranks : Family Genus Species
  - Observe global distribution of taxonomies by sample.
  - Look the rarefaction curve, which is a measure of samples vs diversity.

-----------------------
<a name="standarizationBIOM"></a>
### BIOM format standarization 

Retrieve a standardize biom file using - `FROGS BIOM to std BIOM `
  - You have now a standard BIOM file to phyloseq analysis. 

-----------------------
<a name="tree"></a>
###  Build a Tree

* Build a tree with mafft `FROGS Tree` using filter.fasta and filter.biom

-----------------------
<a name="phyloseq"></a>
###  Phyloseq stats in FROGSTAT

* Import data in R `FROGSSTAT Phyloseq Import`  using the standard BIOM file and the `summary.txt` file without normalisation. 

* Make taxonomic barcharts (kingdom level) `FROGSSTAT Phyloseq Composition Visualisation` using `env_material` as grouping variable and the R data objet.

* Compute alpha diversity `FROGSSTAT Phyloseq Alpha Diversity` Calculate Observed, Chao1 and Shannon diversity indices. Use `env_material` as enviroment variable. 

* Compute beta diversity `FROGSSTAT Phyloseq Beta Diversity`.  Use `env_material` as grouping variable and the R data objet and 'Other methods': cc, unifrac.

* Build a head map plot and ordination `FROGSSTAT Phyloseq Structure Visualisation` : Use `env_material` as grouping variable,  the R data objet and the beta-diversity unifrac.tsv output.

* Hierarchical clustering of samples using Unifrac distance matrix `FROGSSTAT Phyloseq Sample Clustering` : Use `env_material` as grouping variable, the R data objet and the beta-diversity unifrac.tsv output.

* Calculate a anova using unifrac distance matrix with `FROGSSTAT Phyloseq Anova`

-----------------------
<a name="workflow"></a>
#### Workflow in Galaxy

Import a preformated workflow from Galaxy. Go to `Shared Data / Workflows /FROGS` and import it to history. this workflow  contains the whole of steps used before. We can launch it or modified as you want.

-----------------------
<a name="practice-2"></a>

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
