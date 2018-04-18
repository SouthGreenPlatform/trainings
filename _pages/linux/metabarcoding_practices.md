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
* [Practice 1: OTU picking with FROGS in Galaxy](#practice-1)
* [Practice 2: Visualize and plot all sample results with Phinch](#practice-2)
* [Practice 3: Statistical estimation of diversity using PhyloSeq R package](#practice-3)

* [Links](#links)
* [License](#license)


-----------------------

<a name="practice-1"></a>
### Practice 1 : OTU picking with FROGS in Galaxy
<table class="table-contact">
<tr>
<td>Practice1 will be performed with the FROGS pipeline in the Galaxy environment.</td>
<td><img width="60%" src="{{ site.url }}/images/trainings-galaxy.png" alt="" />
</td>
</tr>
</table>
We will perform a transcriptome-based mapping and estimates of transcript levels using Kallisto, and a differential analysis using EdgeR.
* Connect to [Galaxy South Green](http://galaxy.southgreen.fr/galaxy/)
* Create a new history and import RNASeq samples datasets (paired-end fastq files) from Data library
`Galaxy_trainings_2015 => RNASeq_DE`
* (Operational Taxonomic Unit)  - `http://rice.plantbiology.msu.edu/pub/data/Eukaryotic_Projects/o_sativa/annotation_dbs/pseudomolecules/version_7.0/chr01.dir/Chr1.cdna`
* Preprocessing - `FROGS Pre-process`
* FROGS Clustering swarm - `FROGS Clustering swarm`
* FROGS Remove chimera - `FROGS Remove chimera`
* Filters OTUs on several criteria. - `FROGS Filters`
* Step 4 in metagenomics analysis : Taxonomic affiliation of each OTU's seed by RDPtools and BLAST - `FROGS Affiliation OTU`
* FROGS Clusters stat - `FROGS Clusters stat`

-----------------------


<a name="practice-2"></a>
### Practice 2 : Visualize and plot all sample results with Phinch
<td>Practice2 will be performed in a specialized website.</td>
* Connect to [Phinch](http://phinch.org/)


-----------------------


<a name="practice-3"></a>
### Practice 3 : Statistical estimation of diversity using PhyloSeq R package
<td>Practice3 will be performed in the R environment.</td>
* Run the EdgeR program for differential analysis - `edger`
* Verify relevance of normalized expression values provided by EdgeR
* Observe MDS plot of experimental conditions. Observe Smear plot.
* Using `sort` and  its `general numeric sort` parameter, combined with `filter` tool, determine how many genes are found to be differentally expressed using a minimum pvalue <= 0.05? Using a minimum FDR-adjusted pvalue <= 0.05?


-----------------------

### Links
<a name="links"></a>

* Related courses : [Metabarcoding](https://southgreenplatform.github.io/trainings/linuxJedi/)
-----------------------

### License
<a name="license"></a>

<div>
The resource material is licensed under the Creative Commons Attribution 4.0 International License (<a href="http://creativecommons.org/licenses/by-nc-sa/4.0/">here</a>).
<center><img width="25%" class="img-responsive" src="http://creativecommons.org.nz/wp-content/uploads/2012/05/by-nc-sa1.png"/>
</center>
</div>
