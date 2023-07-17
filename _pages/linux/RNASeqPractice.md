---
layout: page
title: "RNASeq Practice"
permalink: /linux/rnaseqPractice/
tags: [ rnaseq, survival guide ]
description: RNASeq Practice page
---

| Description | Hands On Lab Exercises for RNASeq |
| :------------- | :------------- | :------------- | :------------- |
| Related-course materials | [Transcriptomique](https://southgreenplatform.github.io/tutorials//bioanalysis/rnaSeq/) |
| Authors | Julie Orjuela (julie.orjuela@ird.fr), Gautier Sarah (gautier.sarah@inrae.fr), Catherine Breton (c.breton@cgiar.org), Aurore Comte (aurore.comte@ird.fr),  Alexis Dereeper (alexis.dereeper@ird.fr), Sebastien Ravel (sebastien.ravel@cirad.fr), Sebastien Cunnac (sebastien.cunnac@ird.fr) Alexandre Soriano (alexandre.soriano@cirad.fr) |
| Creation Date | 15/03/2018 |
| Last Modified Date | 31/06/2023 |


-----------------------

### Summary

* [Practice 1: Reads QC and cleaning with fastp](#practice-1)
* [Practice 2: Mapping against annotated genome reference with STAR](#practice-2)
* [Practice 3: Counting with htseq-count](#practice-3)
* [Practice 4: Differential expression analysis using DIANE](#practice-4)
* [Practice 5: Compare list of DE genes with DIANE EdgeR and DESeq2](#practice-5)
* [Practice 6: Hierarchical Clustering](#practice-6)
* [Practice 7: Visualization of mapped reads agains genes using IGV](#practice-7)
* [Links](#links)
* [License](#license)


-----------------------



<a name="Preambule"></a>
## Preambule. Dataset used during this pratice - 

### Dataset used in this practical comes from

Origine:

* ref : https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3488244/
* data : NCBI SRA database under accession number SRS307298 _S. cerevisiae_.
* Genome size of  _S. cerevisiae_ : 12M (12.157.105) (https://www.yeastgenome.org/strain/S288C#genome_sequence)

In this session, we will analyze RNA-seq data from one sample of _S. cerevisiae_ (NCBI SRA
SRS307298). It is from two different origin (CENPK and Batch), with three biological replications for each
origin (rep1, rep2 and rep3).


-----------------------

<a name="practice-1"></a>
### Practice 1 : Reads QC and cleaning with fastp
<table class="table-contact">
<tr>
<td>Practice1 will be performed on the biosphere VM using Jupyter notebook</td>
</tr>
</table>
We will perform the reads cleaning
* Connect to the VM you previously launched
* Connect to the terminal
* Download the notebook
{% highlight bash %}
wget --no-check-certificate hpc.cirad.fr/rnaseq/Practice.ipynb
{% endhighlight %}
* You can also download the correction
{% highlight bash %}
wget --no-check-certificate hpc.cirad.fr/rnaseq/Correction.ipynb
{% endhighlight %}
* Choose one sample between SRR453566_500k and SRR453571_500k
* Run the downloads cells
* Run Fastqc 
* Check data quality
* Run fastp
* Run Fastqc again
* Check cleaned data quality

-----------------------

<a name="practice-2"></a>
### Practice 2 : Mapping against annotated genome reference with STAR

#### Running STAR

* First you need to create the genome index
* Create the index genome index. What file do you need to create the index?
* Run the mapping with STAR
* Sort your BAM on read name


-----------------------
<a name="practice-3"></a>
# Practice 3 : Counting with htseq-count

* Run htseq-count on the VM
* Have a look to the count table generated



<a name="practice-4"></a>

## Practice 4 : Differential expression analysis DIANE 

- [Practice 4 : Differential expression analysis DIANE](#practice-4--differential-expression-analysis-diane)
  - [1.1. Introduction](#11-introduction)
  - [1.2. A bit of informations about DIANE](#12-a-bit-of-informations-about-diane)
  - [1.3. Test dataset presentation](#13-test-dataset-presentation)
  - [1.4. Get the input data](#14-get-the-input-data)
  - [1.5. Open the app](#15-open-the-app)
  - [1.6. discover the user interface](#16-discover-the-user-interface)
  - [1.7. Data import](#17-data-import)
    - [1.7.1. Input your expression matrix](#171-input-your-expression-matrix)
    - [1.7.2. Input Design Information (facultative)](#172-input-design-information-facultative)
  - [1.8. Normalization](#18-normalization)
  - [1.9. Exploratory analysis](#19-exploratory-analysis)
  - [1.10. Differential expression analysis](#110-differential-expression-analysis)
  - [1.11. Differentially expressed genes exploration](#111-differentially-expressed-genes-exploration)
    - [1.11.1. MA plot](#1111-ma-plot)
    - [1.11.2. Pvalue histogram](#1112-pvalue-histogram)
    - [1.11.3. Gene ontology enrichment](#1113-gene-ontology-enrichment)
    - [1.11.4. Venn diagram](#1114-venn-diagram)
  - [1.12. The last test, if you have finished](#112-the-last-test-if-you-have-finished)

### 1.1. Introduction

As you have seen, RNA sequencing is an experimental method for measuring RNA expression levels via high-throughput sequencing. The number of reads that map to a gene is the proxy for its expression level. There are many steps between receiving the raw reads from the sequencer and gaining biological insight. In this part, we will try to find differentially expressed genes between pairs of conditions, using an online tool : DIANE

### 1.2. A bit of informations about DIANE


[DIANE](https://oceanecsn.github.io/DIANE/index.html) *(Dashboard for the Inference and Analysis of Networks from Expression data)* is a web application written in R-shiny for the analysis of high throughput gene expression data (RNA-Seq) using state of the art methods. Its function is to extract important regulatory pathways involved in the response to environmental changes, or any perturbation inducing genomic modifications. For advanced users, DIANE can also be used through R command line, as the application is written as an R package.

To cite DIANE in publications use:

Cassan, O., Lèbre, S. & Martin, A. Inferring and analyzing gene regulatory networks from multi-factorial expression data: a complete and interactive suite. BMC Genomics 22, 387 (2021). [https://doi.org/10.1186/s12864-021-07659-2](https://doi.org/10.1186/s12864-021-07659-2)

Authors : Océane Cassan, Antoine Martin, Sophie Lèbre

Main developper : Océane Cassan, PhD Student at IPSIM (Institute for Plant Sciences in Montpellier) research unit, SUPAGRO Montpellier (now Postdoc researcher in statistical learning applied to gene regulation in LIRMM - Laboratory of Computer Science, Robotics and Microelectronics of Montpellier), with contributions from Alexandre Soriano.

### 1.3. Test dataset presentation

The chosen dataset contains the transcriptome of Arabidopsis thaliana plants exposed to global warming related conditions. It was generated for the article “Molecular plant responses to combined abiotic stresses put a spotlight on unknown and abundant genes”, by Sewelam et Al. in Journal of experimental Botany, 2020. (https://academic.oup.com/jxb/advance-article/doi/10.1093/jxb/eraa250/5842162#204457392).

The experimental perturbations studied are heat, salinity and drought in culture soil. Combinations of these perturbations have also been generated.

This is the "demo dataset" included in DIANE, but the data have been reanalyzed using the pipeline presented in this formation, using an expression matrix generated using the tools presented previously.

### 1.4. Get the input data

Download the data from `hpc.cirad.fr/rnaseq_southgreen_2023/data_DIANE_southgreen2023.zip`, and unzip the file.

Take a look at the count matrix. Notice that the rows contain genes and the column the different conditions. The names of the conditions follows a specific pattern, which is needed for DIANE : the name of the condition, followed by a “_”, followed by the replicate number. Your can refer to the corresponding slide for a coloured exemple.

for example, for the first replicate of a condition named "reference", the sample name must look like : reference_1

The first column must also be named “Gene”

### 1.5. Open the app

Open the application : http://shinyapps.southgreen.fr/app/dianebetapca

**note** : this is a beta version including some new functionalities. For the legacy version, you can use https://diane.ipsim.inrae.fr.

### 1.6. discover the user interface

DIANE user interface is divided in two parts. In the left part of the screen, you can see some tabs, each one allowing you to perform a specific analysis using state of the art methods. When you click on one of these tabs, you will be able to carry the corresponding analysis. You will see some green question marks (“?”) at some positions. Click on them to learn some information about a specific part of the analysis process.

### 1.7. Data import

#### 1.7.1. Input your expression matrix

This is the only mandatory file for any analysis with DIANE.

- First, click on the “data import” tab, in the upper left part of the screen. (This is very important, otherwise the count matrix that you will input will not be used.)
- click on “Toggle to import your data” in the “expression file upload” box
- Select the organism. Here we are working with “Arabidopsis Thaliana”.
- click on “browse” under the “Choose CSV/TXT expression file” field. Choose the count matrix you just downloaded.

Now your data should be loaded. A preview of your expression matrix should be displayed in the “Preview of the expression matrix” box. You can also check if the number of genes, conditions and samples is 

Note : there is a “other” organism available. Indeed, All the functions of DIANE can be used with any organism. For some functionalities, you’ll have to import files containing information, like functional annotations, for your custom organism. We can discuss this point if you are interested in using DIANE with a non integrated organism.

#### 1.7.2. Input Design Information (facultative)

The design information is used in some steps of the analysis process to provide additional information. It can be interesting when working with complex datasets, such as the one we are using. Note that only a few parts of the analysis make use of this file, you can work without uploading one.

Take a look at the “design.csv” file, downloaded previously.

To import this file inside of DIANE :

- click on “browse” in the “Design and gene information files” box, and select the “design.csv” file.

The content of the file should then appear just below.

### 1.8. Normalization

Now that your data is loaded, we will perform some analysis. But first, we need to normalize our count matrix. To do so, go to the “Normalisation” tab (the third tab in the left part of the screen).

Two normalization methods are included in DIANE. TMM, from the package “edgeR” , and DESeq2, from the package "DESeq2". These two methods are known to be robust, and should give similar results.
You can also tick “prior removal of differentially expressed genes”, to enable a special method that tries to remove differentially expressed genes before computing normalization factors. The two implemented normalization methods indeed rely on the presumption that most of the genes in our dataset are not differentially expressed, and this special method could help reduce biases in some conditions.
So select a normalization method and click on “normalize” to proceed with the normalization.

After that, it is advised to remove genes with very low abundance. It is a common practice in RNA-Seq analysis pipelines for several reasons :

- They have little biological significance, and could be caused either by noise or mapping errors.
- The statistical modeling we are planning to perform next is not well suited for low counts, as they make the mean-variance relationship harder to estimate.

The default value in DIANE is 10 * number_of_conditions. Click on “filter” in the “low count filtering” part to remove low count genes.

Take a look at the plot in the right part of the screen. Is it homogenous ?

### 1.9. Exploratory analysis

Go to the “Exploratory analysis” tab (the fourth tab in the left part of the screen). You will see a plot representing some PCA (Principal Component Analysis). During PCA, new variables are computed, as linear combinations of your initial variables (e.g. experimental conditions). Those new variables, also called principal components, are designed to carry the maximum of the data variability.

Look at the “PCA summary”. If you want to see the plots one by one, you can select the “Specific PCA plot” tab in the upper part of the screen. These plots should give you hints about the conditions that have a noticeable impact on gene expression.

Look at the first 3 PCA : Which conditions seem to be correlated with Component 1 ? Component 2 ? Component 3 ?

Look at the PCA correlation plot, in the tab “PCA correlation plot”. Does this plot agree with your observations ?

### 1.10. Differential expression analysis

To detect the genes that have significant changes in their expression caused by experimental perturbations, we use the edgeR package, based on negative binomial models.

The first step is thus to estimate the gene dispersions, which is achieved by pooling genes with similar expression levels, and using empirical Bayes strategies.
We will perform a differential expression analysis to see which genes are differentially expressed between two conditions. We will here compare the control and the heat condition. To do so :

- Go to `Differential Expression tab`.
- Choose the conditions to compare. Here we want to compare the control (C) and the heat stressed plants (H)
- click on detect differentially expressed genes

The results are presented in a table, ordered by adjusted pvalues (FDR). The table contains for each gene with a FDR inferior to a specific threshold and a fold change superior to a specific threshold :

- the log2 of the fold changes (logFC)
- the average expression in log2 of counts per million (logCPM)
- the adjusted pvalue (FDR)
- some information about the genes. These informations are available for integrated organisms, and must be imported for custom organisms.

How many genes are detected as differentially expressed ?

You can click on one gene in the table to see his expression level in all the conditions. You can try to click on any gene and see the differences in count between control and heat stress.

You can try to change the adjusted pvalue threshold and the fold change threshold, and rerun the analysis to see the difference in the number of DEG (differentially expressed genes) detected.

### 1.11. Differentially expressed genes exploration

DIANE offers some tools to explore DEG lists.

#### 1.11.1. MA plot

The MA - Vulcano plot allows you to see log2fc depending on logCPM. Take a look at this plot. What do you observe ?

#### 1.11.2. Pvalue histogram

Now observe the Pvalue histogram. You should observe this plot by setting “0” in the Fold change filter. The density of pvalue should be evenly distributed along the plot, except for a peak near 0.

Is it the case here ?

#### 1.11.3. Gene ontology enrichment

Now, set the pvalue threshold to 0.05 and the fold change threshold to 1. Click again in “Detect differentially expressed genes”. Then, go to the “Gene ontology enrichment” tab. Here you can perform gene ontology enrichment on your DEG list. 
Select only up-regulated genes in the “Genes to study section”, Click on “Start GO enrichment analysis”. This will display a plot showing the GO terms that are over represented in your gene set.
To display this plot as a data table, click on “Data table”. Then sort this data table by pvalue.

What is the enriched GO term with the lowest pvalue ? Is it expected ?

#### 1.11.4. Venn diagram

The last tab allows you to plot venn diagrams showing the common and different genes from multiple DEG lists. You can try to perform some other DEG analysis, and download the gene list common to all of these lists.

### 1.12. The last test, if you have finished 

Now you can try to run all the previous steps using a different normalization method. Are the results very different ?


 
-----------------------


### Links
<a name="links"></a>
* DIANE : [ShinyApp](https://diane.bpmp.inrae.fr/)
* Related courses : [Transcriptomics](https://southgreenplatform.github.io/trainings/linuxJedi/)
* Comparison of methods for differential expression: [Report](https://southgreenplatform.github.io/trainings//files/Comparison_of_methods_for_differential_gene_expression_using RNA-seq_data.pdf)
* DESeq2: [DESeq2](http://www.bioconductor.org/packages/release/bioc/html/DESeq2.html)
* EdgR: [EdgeR](https://bioconductor.org/packages/release/bioc/html/edgeR.html)


### Bibliography

Cassan, O., Lèbre, S. & Martin, A. Inferring and analyzing gene regulatory networks from multi-factorial expression data: a complete and interactive suite. BMC Genomics 22, 387 (2021). [https://doi.org/10.1186/s12864-021-07659-2](https://doi.org/10.1186/s12864-021-07659-2)
-----------------------

### License
<a name="license"></a>

<div>
The resource material is licensed under the Creative Commons Attribution 4.0 International License (<a href="http://creativecommons.org/licenses/by-nc-sa/4.0/">here</a>).
<center><img width="25%" class="img-responsive" src="http://creativecommons.org.nz/wp-content/uploads/2012/05/by-nc-sa1.png"/>
</center>
</div>
                  
    
 
