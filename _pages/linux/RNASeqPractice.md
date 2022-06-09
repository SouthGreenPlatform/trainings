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
| Authors | Julie Orjuela (julie.orjuela@irf.fr), Gautier Sarah (gautier.sarah@inrae.fr), Catherine Breton (c.breton@cgiar.org), Aurore Comte (aurore.comte@ird.fr),  Alexis Dereeper (alexis.dereeper@ird.fr), Sebastien Ravel (sebastien.ravel@cirad.fr), Sebastien Cunnac (sebastien.cunnac@ird.fr) Alexandre Soriano (alexandre.soriano@cirad.fr) |
| Creation Date | 15/03/2018 |
| Last Modified Date | 09/06/2022 |


-----------------------

### Summary

* [Practice 1: Reads QC and cleaning with fastp](#practice-1)
* [Practice 2: Mapping against annotated genome reference with STAR](#practice-2)
* [Practice 3: Counting with htseq-count](#practice-3)
* [Practice 4: Differential expression analysis using DIANE](#practice-4)
  - Introduction
  - Step 1  : Data Input 
  - Step 2 : Input Design Information
  - step 3 : Normalisation
  - step 4 : Feature Filtering
  - Step 5 : Basic statistics
  - Step 6 : Explore normalized gene expression
  - Step 7 : Differential expression analysis
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
<<<<<<< HEAD
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
* Create the index creation cell. What file do you need to create the index?
* Run the mapping with STAR
* Sort your BAM on read name


-----------------------
<a name="practice-3"></a>
# Practice 3 : Counting with htseq-count

* Run htseq-count on the VM
* Have a look to the coubt table generated



<a name="practice-4"></a>
# Practice 4 : Differential expression analysis using EdgeR and DESeq2 on DIANE 
<td>Practice 4 will be performed in DIANE via Website Interface.</td>



DIANE: is a shiny application for the analysis of high throughput gene expression data (RNA-Seq). 
Its function is to extract important regulatory pathways involved in the response to environmental changes, 
or any perturbation inducing genomic modifications.

To cite DIANE in publications use:

Cassan, O., Lèbre, S. & Martin, A. Inferring and analyzing gene regulatory networks from multi-factorial expression data: a complete and interactive suite. BMC Genomics 22, 387 (2021). https://doi.org/10.1186/s12864-021-07659-2

### Use DIANE


Authors : Océane Cassan, Antoine Martin, Sophie Lèbre

Dev : Océane Cassan, PhD Student at IPSIM (Institute for Plant Sciences in Montpellier) research unit, SUPAGRO Montpellier, with contributions from Alexandre Soriano.

### Install DIANE

To use DIANE locally, download and install DIANE in your R console as follows (you need the remotes package installed) :

{% highlight bash %}
remotes::install_github("OceaneCsn/DIANE")
{% endhighlight %}

DIANE relies on R 4.0.0, available for all OS at https://cloud.r-project.org/.

You can then launch the application :

{% highlight bash %}
library(DIANE)
DIANE::run_app()
{% endhighlight %}



-----------------------

### Introduction 

As you have seen, RNA sequencing (RNA-seq) is an experimental method for measuring RNA expression levels via high-throughput sequencing of small adapter-ligated fragments.
The number of reads that map to a gene is the proxy for its expression level.
There are many steps between receiving the raw reads from the sequencer and gaining biological insight.
In this tutorial, we will start with a "Table of counts" and end with a "List of differentially expressed genes".

#### Step 1  : Data Input 

To input expression matrix, select `Data import` as input file type. DIANE expects the count matrix to have rows as genes and samples as columns.
Gene names and sample names should be the first column and the first row, respectively.

 - Go to file Tab.
 - Take the count file `gene_count_matrix.csv` generated previously.
 - Import this file into `Data import`  and then Expression file upload.
 - Add Use `Comma` separator as it is a csv.
 - Check if yours data are imported in the rigth window. (Preview of the expression matrix)

#### Step 2 : Input Design Information

The design infomation are used for sample point coloring and differential expression analysis. Users can input the entire sample meta sheet as 
design information for each sample.

 - Go to `Design and gene information files`.
 - Go to Designed Table Upload.  Choose CSV/TXT design file (optional) `info.txt`
 - Verify that the header of the info file corresponds to the count file. 
 - Choose the Separator : `Tab` or the appropriate separator.
 - Verify on the Design Table Preview and submit design.


#### Step 3 : Normalisation


 - Choose the `Normalieation` Method : 
  - for Edge R you can use `DESeq, Trimmed Mean of M-values TMM, or Upperquartile`.
  - for DESeq you can use `DESeq2`
 
 In order to have a quick view of your chosen data, look at the summary. 

#### Step 4 : Feature Filtering

 - Removing genes with very low aboundance is a common practice in RNA-Seq analysis pipelines for several reasons :

    They have little biological signifiance, and could be caused either by noise or mapping errors.
    The statitical modelling we are planning to perform next is not well suited for low counts, as they make the mean-variance relationship harder to estimate.

 - Recommendation for filtered the low number 10*sampleNumber
 - You can choose the filter criteria. 

#### Step 5 : Basic statistics

 - If you want to keep the count table, upload it.
 - Check the distribution of each condition in the standard deviation graph, the dispersion graph.
 - If needed, you can download the Variably Expressed Genes.
 

#### Step 6 : Explore normalized gene expression 

With the PCA  Principal Component Analysis, you can see verify if your experimental design is correct, for example the PCA separate conditions.
Performing PCA on normalized RNA-Seq counts can be really informative about the conditions that impact gene expression the most. During PCA, new variables are computed, as linear combinations of your initial variables (e.g. experimental conditions). Those new variables, also called principal components, are designed to carry the maximum of the data variability.

Go to the summary menu, and use the `Exploratory analysis`.


#### Step 7 : Differential expression analysis

To detect the genes that have significant changes in their expression caused by experimental perturbations, we use the edgeR package, based on negative binomals models.

The first step is thus to estimate the gene dispersions, which is acheived by pooling genes with similar expression level, and using empirical Bayes stragtegies.

The results are presented in a dataframe, ordered by adjusted pvalues (FDR). The dataframe contains the log fold changes (logFC), the average expression (logCPM) for each genes which FDR is lower than the specified adjusted p-value threshold. You can also choose to to select one genes having an absolute log fold change over a certain constant.


 - Go to `Differential Expression`.
 - Choose `Conditions` to compare for differential analysis.
 - Use the Adjusted pvalue ( FDR ). 
 - Absolute Log Fold Change ( Log2 ( Perturbation / Reference ) ) :.
 - DETECT DIFFERENTIALLY EXPRESSED GENES
 
The output files are presented in a table "Results table, MA plot, Volcano Plot, Heatmap.
If you have the annotation file, you can explore the Gene Ontology enrichment.

The output file is a `DEGs_Batch-CENPK.tsv` file usable in R the make some graph and other analysis.

-----------------------

<a name="practice-5"></a>
## Practice 5 : Compare list of DE genes with DIANE EdgeR and DESeq2 
<td>Practice 5 will be performed in DIANE via Website Interface.</td>


#### First part with EdgeR on DIANE

* Run the normalisation for differential analysis - `Tmm` `deseq2` `none`
* Check relevance of normalized expression values provided by each normalisation
* Observe PCA plot of experimental conditions. 


Questions :
  - Using filters parameters, determine how many genes are found to be differentally expressed using a minimum FDR-adjusted pvalue <= 0.05, 0.1?
  - Do you have the sample number of differential gene for a FDR cutoff 0.1 and 0.05?
  - According to you, what is the best cutoff?
  
 
-----------------------

<a name="practice-6"></a>
### Practice 6 : Hierarchical Clustering
Practice 6 will be performed with DIANE.
* Connect to your DIANE interface.
- Go to Clustering.
 - For each analysis EdgeR or DESeq2 specify the Data Input (count, log...).
 - Choose the distance `Euclidean` or an other, the Agglomeration method `Ward`and the number of cluster.

-----------------------

<a name="practice-7"></a>
### Practice 7 : Visualization of mapped reads against genes using IGV
Practice 7 will be performed with Integrated Genome Viewer (IGV).

* Focus on a gene that has been found to be differentially expressed and observe the structure of the gene.

- From master0 `qlogin -q formation.q`

- Lauch `samtools index` using bam obtained by STAR:

{% highlight bash %}
for fl in ./*.bam; do samtools index $fl; done
{% endhighlight %}

- Run igv : 

- Load reference genome, GFF annotation file, BAMs files and the gffCompare `gffcompare_out.annotated.gtf` output.

- Recovery some ID to visualise it in IGV:
{% highlight bash %}
grep 'class_code "u"' gffcompare_out.annotated.gtf | less
{% endhighlight %}

- Copy a identifiant, for example, "XLOC_000469" et and search it in IGV. Show this loci.

- or  :
{% highlight bash %}
grep 'class_code "x"' gffcompare_out.annotated.gtf | less
{% endhighlight %}

- Search other gene, for example, "LOC_Os01g01710".

-----------------------

### Links
<a name="links"></a>
* DIANE : [ShinyApp](https://diane.bpmp.inrae.fr/)
* Related courses : [Transcriptomics](https://southgreenplatform.github.io/trainings/linuxJedi/)
* Comparison of methods for differential expression: [Report](https://southgreenplatform.github.io/trainings//files/Comparison_of_methods_for_differential_gene_expression_using RNA-seq_data.pdf)
* DESeq2: [DESeq2](http://www.bioconductor.org/packages/release/bioc/html/DESeq2.html)
* EdgR: [EdgeR](https://bioconductor.org/packages/release/bioc/html/edgeR.html)

-----------------------

### License
<a name="license"></a>

<div>
The resource material is licensed under the Creative Commons Attribution 4.0 International License (<a href="http://creativecommons.org/licenses/by-nc-sa/4.0/">here</a>).
<center><img width="25%" class="img-responsive" src="http://creativecommons.org.nz/wp-content/uploads/2012/05/by-nc-sa1.png"/>
</center>
</div>
                  
    
 
