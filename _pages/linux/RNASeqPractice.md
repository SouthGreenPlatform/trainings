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
| Authors | Alexis Dereeper (alexis.dereeper@ird.fr), Sebastien Ravel (sebastien.ravel@cirad.fr), Sebastien Cunnac (sebastien.cunnac@ird.fr) |
| Creation Date | 15/03/2018 |
| Last Modified Date | 15/03/2018 |


-----------------------

### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Practice 1: Mapping against transcriptome reference + counting with Kallisto](#practice-1)
* [Practice 2: Mapping against annotated genome reference with TopHat + counting with HTSeq-count](#practice-2)
* [Practice 3: Differential expression analysis using EdgeR and DESeq2](#practice-3)
* [Practice 4: Visualization of mapped reads against genes using IGV](#practice-4)
* [Practice 5: Filtering and Generating plots](#practice-5)
* [Practice 6: Heatmap and Hierarchical Clustering](#practice-6)
* [Practice 7: Co-expression network analysis](#practice-7)
* [Practice 8: Gene Ontology (GO) enrichment](#practice-8)
* [Links](#links)
* [License](#license)


-----------------------

<a name="practice-1"></a>
### Practice 1 : Mapping against transcriptome reference + counting with Kallisto
<table class="table-contact">
<tr>
<td>Practice1 will be performed in the Galaxy environment.</td>
<td><img width="60%" src="{{ site.url }}/images/trainings-galaxy.png" alt="" />
</td>
</tr>
</table>
We will perform a transcriptome-based mapping and estimates of transcript levels using Kallisto, and a differential analysis using EdgeR.
* Connect to [Galaxy South Green](http://galaxy.southgreen.fr/galaxy/)
* Create a new history and import RNASeq samples datasets (paired-end fastq files) from Data library
`Galaxy_trainings_2015 => RNASeq_DE`
* Upload the Chr1 of rice transcriptome (cDNA) to be used as reference  - `http://rice.plantbiology.msu.edu/pub/data/Eukaryotic_Projects/o_sativa/annotation_dbs/pseudomolecules/version_7.0/chr01.dir/Chr1.cdna`
* Run the kallisto program by providing Chr1 as transcriptome reference and specifying correctly pairs of input fastq- `kallisto quant`
* Convert kallisto outputs (collection of count files) into one single file taht can be used as input for EdgeR - `Kallisto2EdgeR`

-----------------------

<a name="practice-2"></a>
### Practice 2 : Mapping against annotated genome reference with TopHat + counting with HTSeq-count
<table class="table-contact">
<tr>
<td>Practice2 will be performed with the TOGGLe workflow management system.</td>
<td><img width="60%" src="{{ site.url }}/images/toggleLogo2.png" alt="" />
</td>
</tr>
</table>
* TopHat + cufflinks + cuffmerge + cuffdiff ...
* Is there any new gene (not defined in GFF annotation) that shows significant differential expression?

-----------------------

<a name="practice-3"></a>
### Practice 3 : Differential expression analysis using EdgeR and DESeq2
<td>Practice3 will be performed in the Galaxy environment.</td>
* Run the EdgeR program for differential analysis - `edger`
* Verify relevance of normalized expression values provided by EdgeR
* Observe MDS plot of experimental conditions. Observe Smear plot.
* Using `sort` and  its `general numeric sort` parameter, combined with `filter` tool, determine how many genes are found to be differentally expressed using a minimum pvalue <= 0.05? Using a minimum FDR-adjusted pvalue <= 0.05?

* Upload your count file into [Degust](http://degust.erc.monash.edu/)
* Observe the different plots available
* How many genes can be found DE for a minimum pvalue <= 0.05 and abs(logFC) > 2? Observe the plots.

* By using `cut` on the global count file, generate individual input files for DESeq for each sample and run the DESeq2 program for differential analysis - `DESeq2`
* Compare lists of DE genes with the two approches using [Venny](http://bioinfogp.cnb.csic.es/tools/venny/)

-----------------------

<a name="practice-4"></a>
### Practice 4 : Visualization of mapped reads against genes using IGV
Practice3 will be performed with Integrated Genome Viewer (IGV).
* Load reference genome, GFF annotation file and two BAM files corresponding to 0dpi and 2dpi
* Focus on a gene that has been shown to be differentially expressed and observe the difference of accumation of reads

-----------------------

<a name="practice-5"></a>
### Practice 5 : Explore multiple expression projects/experiments using DiffExDB
Practice5 will be performed using DiffExDB

* Go to the DiffExDB database, dedicated to centralize expression projects at IRD: [DiffExDB](http://bioinfo-web.mpl.ird.fr/cgi-bin2/microarray/public/diffexdb.cgi)


-----------------------

<a name="practice-6"></a>
### Practice 6 : Heatmap and Hierarchical Clustering
Practice5 will be performed in the Galaxy environment.
* Connect to [Galaxy South Green](http://galaxy.southgreen.fr/galaxy/)
* Run the plotHeatmap program for heatmap and hierarchical clustering - `plotHeatmap`. Using EdgeR output and count file, display heatmap and gene clustering dendrogram on genes having a minimum pvalue <= 0.05 and abs(logFC) > 1

-----------------------

<a name="practice-7"></a>
### Practice 7 : Co-expression network analysis
Practice6 will be performed in the Galaxy environment.
* Run the WGCNA program - `wgcna`
* Run the network program - `cytoscape`

-----------------------

<a name="practice-8"></a>
### Practice 8 : Gene Ontology (GO) enrichment

-----------------------

### Links
<a name="links"></a>

* Related courses : [Transcriptomics](https://southgreenplatform.github.io/trainings/linuxJedi/)
* Degust : [Degust](http://degust.erc.monash.edu/)
* MeV: [MeV](http://mev.tm4.org/)
* MicroScope: [MicroScope](http://microscopebioinformatics.org/)

-----------------------

### License
<a name="license"></a>

<div>
The resource material is licensed under the Creative Commons Attribution 4.0 International License (<a href="http://creativecommons.org/licenses/by-nc-sa/4.0/">here</a>).
<center><img width="25%" class="img-responsive" src="http://creativecommons.org.nz/wp-content/uploads/2012/05/by-nc-sa1.png"/>
</center>
</div>
                  
 
