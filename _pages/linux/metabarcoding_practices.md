---
layout: page
title: "Metabarcoding Practice"
permalink: /linux/metabarcodingPractice/
tags: [ Metabarcoding, survival guide ]
description: Metabarcoding Practice page
---

| Description | Hands On Lab Exercises for Metabarcoding |
| :------------- | :------------- | :------------- | :------------- |
| Authors | J Orjuela (julie.orjuela@ird.fr), A Dereeper (alexis.dereeper@ird.fr), F Constancias (florentin.constancias@cirad.fr), J Reveilleud (JR) (julie.reveillaud@inra.fr), M Simonin (marie.simonin@ird.fr), F Mahé (frederic.mahe@cirad.fr)| 
| Creation Date | 18/04/2018 |
| Last Modified Date | 17/05/2019 |

-----------------------

### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Practice 1: Obtaining an OTU table with FROGS in Galaxy](#practice-1)
* [Practice 2: Obtaining an OTU table with QIIME2](#practice-2)
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
<td width="25%"><img width="70%" src="{{ site.url }}/images/qiime2.png" alt="" />
</td> 
<td width="25%"><img width="70%" src="{{ site.url }}/images/bioconductor.png" alt="" />
</td> 
</tr>
</table>

### Practice 1 : Obtaining an OTU table with FROGS in Galaxy

In this training we will first performed metabarcoding analysis with the FROGS pipeline in the Galaxy environment. In a second time, we will perform similar analysis in command line on HPC i-Trop cluster.

* Connect to [Galaxy i-Trop](http://http://bioinfo-inter.ird.fr:8080/) with formationN account.
* Create a new history and import Metabarcoding sample datasets (paired-end fastq files compressed by tar ) from Data library : DATA
`Libraries /formation Galaxy 2019 / Metabarcoding`
  - Fastq file used here are a subset of reads obtained in a metagenomic study of Edwards et al 2015 containing 4 soil compartments:  Rhizosphere, Rhizoplane, Endosphere and Bulk_Soil of a rice culture.
  
* We will build a workflow to analyse sequences from fastq to estimation of diversity using tools included into FROGs package:

* Merge paired reads and dereplicate using the Preprocessing tool - `FROGS Pre-process`
  - => Read size is 250 pb, expected, minimum and maximun amplicon size are 250,100,350 pb respectively. Use custom sequencing protocol.
  - How many sequences have been overlapped? 
  - How many sequences remain after dereplication?
  - What amplicon size is obtained in the majority of merged sequences?  

* Build Clustering using swarm - `FROGS Clustering swarm`
  - => Use an aggregation distance of 1.
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
  - Use the SILVA 132 16S database for taxonomic assignation by BLAST.
  - How many OTU were taxonomically assigned to species?
  - Visualize the biom file enriched with taxomonic information.
  
* Obtain statistics of affiliation - `FROGS Affiliation stat`
  - Observe global distribution of taxonomies by sample.
  - Look the rarefaction curve, which is a measure of samples vs diversity.
  
* Retrieve a (human readable) OTU table in tsv format - `FROGS BIOM to TSV`
  - Download the tsv file for potential subsequent filtering.

* Retrieve a standardize biom file - `FROGS TSV std BIOM `

* convert taxonomic assignment table to biom

* build a tree with pynast `FROGS Tree`

* build a tree with mafft `FROGS Tree`

* import data in R `FROGSSTAT Phyloseq Import`

* make taxonomic barcharts (kingdom level) `FROGSSTAT Phyloseq Composition Visualisation`

* compute alpha diversity `FROGSSTAT Phyloseq Alpha Diversity`

* compute beta diversity `FROGSSTAT Phyloseq Beta Diversity`


Launch you workflow and in a second time, launch the following in single mode 

* compute sample ordination (NMDS)

* hierarchical clustering of samples using Unifrac distance matrix

* anova using Unifrac distance matrix

-----------------------
<a name="practice-2"></a>
### Practice 2 : Obtaining an OTU table with QIIME : Microbiome denoising and pre-processing

Connect you in ssh mode to bioinfo-master.ird.fr cluster using formation counts.
`ssh formationX@bioinfo-master.ird.fr`

##### 1.Import raw sequence data (demultiplexed fastQ files) into Qiime2.

https://docs.qiime2.org/2019.1/tutorials/importing/

Option with a manifest file: you need to create and use a manifest file that links the sample names to the fastq files The manifest file is a csv file where the first column is the "sample-id", the second column is the "absolute-filepath" to the fastq.gz file, the third column is the "direction" of the reads (forward or reverse). These are mandatory column names.Here is an example for paired end sequences with Phred scores of 33. !! The csv file must be in the american format: replace ";" by "," as a separator if needed.

##### Create the manifest file to import the fastq files in qiime2

- Go into the folder where are the fastq.gz
{% highlight bash %}
echo "sample-id,absolute-filepath,direction" > manifest.csv 
for i in *R1* ; do echo "${i/_R1.fastq.gz},$PWD/$i,forward"; done >> manifest.csv 
for i in *R2* ; do echo "${i/_R2.fastq.gz},$PWD/$i,reverse"; done >> manifest.csv
{% endhighlight %}

- Load Qiime2 on the server
{% highlight bash %}
module load bioinfo/qiime2/2018.11
source activate qiime2-2018.11
{% endhighlight %}

- Import the fastq files in Qiime2 (stored in Qiime2 as a qza file). qza file is the data format (fastq, txt, fasta) in Qiime2 
```{r}
qiime tools import \
  --type 'SampleData[PairedEndSequencesWithQuality]' \
  --input-path manifest.csv \
  --output-path paired-end-demux.qza \
  --input-format PairedEndFastqManifestPhred33
```

##### 2.Verification of sequence quality and number of sequences per sample. Visualize the qzv file on qiime tools view: https://view.qiime2.org/. qzv file is the visualization format in Qiime2
```{r}
qiime demux summarize \
  --i-data paired-end-demux.qza \
  --o-visualization paired-end-demux.qzv
```
- If you are working locally (not on the server), use this function to visualize the qzv file online
```{r}
qiime tools view paired-end-demux.qzv
```

##### 3.Denoising with DADA2. Based on the quality information and presence of primers the different p-trim and p-trunc parameters need to be changed. they are specific to each study and primers. Here we have forward primers of 21 bp and reverse of 20 bp.  The total amplicon length is 291 bp, based on the qzv visualization we decide on the truncation length (p-trunc-len) of the forward and reverse reads. You can change the number of threads on the server with p-n-threads. This command will generate 3 files: the OTU table (16S-table.qza), the representative sequence fasta file (16S-rep-seqs.qza) and denoising statistic file (16S-denoising-stats.qza).
```{r}
qiime dada2 denoise-paired \
  --i-demultiplexed-seqs paired-end-demux.qza \
  --p-trim-left-f 21 \
  --p-trim-left-r 20 \
  --p-trunc-len-f 220 \
  --p-trunc-len-r 160 \
  --p-n-threads 8 \
  --o-table 16S-table.qza \
  --o-representative-sequences 16S-rep-seqs.qza \
  --o-denoising-stats 16S-denoising-stats.qza \
  --verbose
```


##### 4.Make summary files and visualize the outputs of DADA2. It necessitates a metadata file with the treatment information (provided). The first column needs to be "sample-id"and the other columns are treatment, site, etc information. Go to Qiime2 View website to visualize the qzv files
```{r}
qiime metadata tabulate \
  --m-input-file 16S-denoising-stats.qza \
  --o-visualization 16S-denoising-stats.qzv

qiime feature-table summarize \
  --i-table 16S-table.qza \
  --o-visualization 16S-table.qzv \
  --m-sample-metadata-file metadata.txt

qiime feature-table tabulate-seqs \
  --i-data 16S-rep-seqs.qza \
  --o-visualization 16S-rep-seqs.qzv
```

##### 5.Assign taxonomy to the SVs. Download pretrained classifier for the V4 region (Silva 132 99% OTUs from 515F/806R region of sequences) based on the SILVA database: https://docs.qiime2.org/2019.1/data-resources/
###To create the classifier based on your own parameters (fragment size, region) follow this tutorial, for now we will use the pre-trained classifier for the V4 region (515F-806R) at 99% similarity: https://docs.qiime2.org/2019.1/tutorials/feature-classifier/
```{r}
qiime feature-classifier classify-sklearn \
  --i-classifier silva-132-99-515-806-nb-classifier.qza \
  --i-reads 16S-rep-seqs.qza \
  --o-classification 16S-rep-seqs-taxonomy.qza
```

##Visualization of the taxonomy output
```{r}
qiime metadata tabulate \
  --m-input-file 16S-rep-seqs-taxonomy.qza \
  --o-visualization 16S-rep-seqs-taxonomy.qzv
```

##### 6.Remove SVs in the table that are Chloroplast or Mitochondria (not bacterial or archaeal taxa)
```{r}
qiime taxa filter-table \
  --i-table 16S-table.qza \
  --i-taxonomy 16S-rep-seqs-taxonomy.qza \
  --p-exclude mitochondria,chloroplast \
  --o-filtered-table 16S-table-noplant.qza
```

##### 7.Possible filtering/cleaning steps 
- Rarefy in Qiime2
```{r}
qiime feature-table rarefy \
  --i-table 16S-table-noplant.qza \
  --p-sampling-depth 10000 \
  --o-rarefied-table 16S-table-noplant-rarefied-10000.qza
```

- Remove SVs that are present only in 1 sample
```{r}
qiime feature-table filter-features \
  --i-table 16S-table-noplant-rarefied-10000.qza \
  --p-min-samples 2 \
  --o-filtered-table 16S-table-noplant-rarefied-10000_filtered.qza
```

- Filter the the rep-seq.qza to keep only SVs that are present in the final SV table (remove SVs that were Chloroplast, Mitochondria or found in only one sample...)
```{r}
 qiime feature-table filter-seqs \
  --i-data 16S-rep-seqs.qza \
  --i-table 16S-table-noplant-rarefied-10000_filtered.qza \
  --o-filtered-data 16S-rep-seqs-filtered.qza
```

- Summary after cleaning steps
```{r}
  qiime feature-table summarize \
  --i-table 16S-table-noplant-rarefied-10000_filtered.qza \
  --o-visualization 16S-table-noplant-rarefied-10000_filtered.qzv \
  --m-sample-metadata-file metadata.txt
```

##### 8.Export SV table (biom file) and representative sequences (fasta file) for analyses in R studio (structure and diversity analyses) - Qiime2 
```{r}
qiime tools export \
  --input-path 16S-rep-seqs.qza \
  --output-path Dada2-output

qiime tools export \
  --input-path 16S-table-noplant-rarefied-10000_filtered.qza \
  --output-path Dada2-output
```


##### 9.Make Phylogenetic tree 
```{r}
qiime phylogeny align-to-tree-mafft-fasttree \
  --i-sequences 16S-rep-seqs-filtered.qza \
  --o-alignment aligned-16S-rep-seqs-filtered.qza \
  --o-masked-alignment masked-aligned-rep-seqs-filtered.qza \
  --o-tree unrooted-16S-tree-filteredSVs.qza \
  --o-rooted-tree rooted-16S-tree-filteredSVs.qza
```

##### Export trees
```{r}
qiime tools export \
  --input-path unrooted-16S-tree-filteredSVs.qza \
  --output-path exported-tree-16S

qiime tools export \
  --input-path  rooted-16S-tree-filteredSVs.qza \
  --output-path exported-tree-16S
```
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
