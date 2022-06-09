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
| Authors | Julie Orjuela (julie.orjuela@irf.fr), Gautier Sarah (gautier.sarah@cirad.fr), Catherine Breton (c.breton@cgiar.org), Aurore Comte (aurore.compte@ird.fr),  Alexis Dereeper (alexis.dereeper@ird.fr), Sebastien Ravel (sebastien.ravel@cirad.fr), Sebastien Cunnac (sebastien.cunnac@ird.fr) Alexandre Soriano (alexandre.soriano@cirad.fr) |
| Creation Date | 15/03/2018 |
| Last Modified Date | 09/06/2022 |


-----------------------

### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Practice 1: Pseudo-mapping against transcriptome reference + counting with Kallisto](#practice-1)
* [Practice 2: Mapping against annotated genome reference with Hisat2 + counting with Stringtie](#practice-2)
* [Practice 3: Differential expression analysis using DIANE](#practice-3)
* Introduction
* Step 1  : Data Input 
* Step 2 : Input Design Information
* step 3 : Normalisation
* step 4 : Feature Filtering
* Step 5 : Basic statistics
* Step 6 : Explore normalized gene expression
* Step 7 : Differential expression analysis
* [Practice 4: Compare list of DE genes with DIANE EdgeR and DESeq2](#practice-4)
* [Practice 5: Hierarchical Clustering](#practice-5)
* [Practice 6: Visualization of mapped reads against genes using IGV](#practice-6)
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
### Practice 1 : Mapping against transcriptome reference + counting with Kallisto
<table class="table-contact">
<tr>
<td>Practice1 will be performed in the Galaxy environment.</td>
<td><img width="60%" src="{{ site.url }}/images/trainings-galaxy.png" alt="" />
</td>
</tr>
</table>
We will perform a transcriptome-based mapping and estimates of transcript levels using Kallisto, and a differential analysis using EdgeR.
* Connect to [Galaxy IRD](http://bioinfo-inter.ird.fr:8080/)
* Create a new history and import all the 8 RNASeq samples datasets (paired-end fastq files) from Data library
`Shared Data => Data Libraries => Galaxy_trainings_2019 => RNASeq`
* Upload the Chr1 of rice transcriptome (cDNA) to be used as reference  - `http://rice.plantbiology.msu.edu/pub/data/Eukaryotic_Projects/o_sativa/annotation_dbs/pseudomolecules/version_7.0/chr01.dir/Chr1.cdna`
* Run the kallisto quant program by providing Chr1 as transcriptome reference and specifying correctly pairs of input fastq- `kallisto quant`
You can do it with the pairs made one by one manually or you can make lists of dataset pairs. If you choose this second option:
- Build one list with the pairs of condition 1 and on other list with the pairs of condition 2. 
- launch kallisto on each of the two lists => you get 2 kallisto outputs collections
* Convert kallisto outputs (collection of count files) into one single file that can be used as input for EdgeR -`Kallisto2EdgeR`

-----------------------

<a name="practice-2"></a>
## Practice 2 : Mapping against annotated genome reference with Hisat2 + counting with Stringtie
<img width="20%" src="{{ site.url }}/images/toggleLogo2.png" alt="" />

#### Running Hisat2 and Stringtie with TOGGLe

Connection to account in IRD i-Trop cluster `ssh formationX@bioinfo-master.ird.fr`

Input data are accessible from :
* Input data : /data2/formation/tp-toggle/RNASeqData/
* Reference : /data2/formation/tp-toggle/RNASeqData/referenceFiles/chr1.fasta
* Annotation : /data2/formation/tp-toggle/RNASeqData/referenceFiles/chr1.gff3
* Config file: [RNASeqReadCount.config.txt](https://raw.githubusercontent.com/SouthGreenPlatform/TOGGLE/master/exampleConfigs/RNASeqHisat2Stringtie.config.txt)

Import data from nas to your $HOME
* Create a toggleTP directory in your $HOME `mkdir ~/TP-RNASEQ`
* Make à copy for reference and input data into TP-RNASEQ directory: `cp -r /data2/formation/tp-toggle/RNASeqData/ ~/TP-RNASEQ`
* Add the configuration file used by TOGGLe `cd ~/TP-RNASEQ/; wget https://raw.githubusercontent.com/SouthGreenPlatform/TOGGLE/master/exampleConfigs/RNASeqHisat2Stringtie.config.txt`
* change SGE key `$sge` as below using a texte editor like nano `nano RNASeqHisat2Stringtie.config.txt`
{% highlight bash %}
$sge
-q formation.q
-b Y
-cwd
{% endhighlight %}
* in TOGGLe configuration file use /scratch in `$scp` key to launch your job from scratch folder and also `$env` key using
`module load bioinfo/TOGGLE-dev/0.3.7` module installed on cluster. 
* Check parameters of every step in `~/toggleTP/RNASeqData/RNASeqHisat2Stringtie.config.txt` as recommended by https://www.nature.com/articles/nprot.2016.095.


Mapping is performed using HISAT2 and usually the first step, prior to mapping, is to create an index of the reference genome. TOGGle index genome automatically if indexes are absents in reference folder. 
In order to save some space think to only keep sorted BAM files one these are created.
After mapping, assemble the mapped reads into transcripts. StringTie can assemble transcripts with or without annotation, annotation can be helpful when the number of reads for a transcript is too low for an accurate assembly.

{% highlight bash %}
$order
1=fastqc
2=hisat2
3=samtoolsView
4=samtoolsSort
5=stringtie 1
1000=stringtie 2

$samtoolsview
-b
-h

$samtoolssort

$cleaner
3

#PUT YOUR OWN SGE CONFIGURATION HERE
$sge
-q formation.q
-b Y

$stringtie 1

$stringtie 2
--merge

$hisat2
--dta

$scp
/scratch/

$env
module load bioinfo/TOGGLE-dev/0.3.7
{% endhighlight %}


... Your data are now in ~/TP-RNASEQ.  


Now, create a `runTOGGLeRNASEQ.sh` bash script to launch TOGGLe as follow : 
{% highlight bash %}
#!/bin/bash
#$ -N TOGGLeRNAseq
#$ -b yes
#$ -q formation.q
#$ -cwd
#$ -V

dir="~/TP-RNASEQ/RNASeqData/fastq"
out="~/TP-RNASEQ/outTOGGLe"
config="~/TP-RNASEQ/RNASeqHisat2Stringtie.config.txt"
ref="~/TP-RNASEQ//RNASeqData/referenceFiles/chr1.fasta"
gff="~/TP-RNASEQ//RNASeqData/referenceFiles/chr1.gff3"
## Software-specific settings exported to user environment
module load bioinfo/TOGGLE-dev/0.3.7

#running tooglegenerator 
toggleGenerator.pl -d $dir -c $config -o $out -r $ref -g $gff --report --nocheck;

echo "FIN de TOGGLe ^^"
{% endhighlight %}

Convert runTOGGLeRNASEQ in an executable file with `chmod +x runTOGGLeRNASEQ.sh`

Launch runTOGGLeRNASEQ.sh in qsub mode
{% highlight bash %}
qsub -q formation.q -N TOGGLeRNASEQ -b yes -cwd 'module load bioinfo/TOGGLE-dev/0.3.7; ./runTOGGLeRNASEQ.sh '
{% endhighlight %}

Explore output `outTOGGLe` TOGGLe and check if everything was ok.

Open and explore`outTOGGLe/finalResults/intermediateResults.STRINGTIEMERGE.gtf`

### Now that we have our assembled transcripts, we can estimate their abundances. 

To estimate abundances, we have to run again stringtie using options -B and -e. 

##### prepare data

- Create symbolics links to order data before transferring them to `/scratch`

{% highlight bash %}
MOI="formationX"
OUTPUT="/home/$MOI/TP-RNASEQ/outTOGGLe/"
mkdir $OUTPUT/stringtieEB
cd $OUTPUT/stringtieEB 
ln -s $OUTPUT/finalResults/intermediateResults.STRINGTIEMERGE.gtf .
ln -s $OUTPUT/output/*/4_samToolsSort/*SAMTOOLSSORT.bam .
{% endhighlight %}

##### transfert to /scratch

- Remember good practices to work at IRD Cluster. *You have to copy data into a path /scratch in a node*. What is your node number?

{% highlight bash %}
qrsh -q formation.q
MOI="formationX"
OUTPUT="/home/$MOI/TP-RNASEQ/outTOGGLe/"
scp -r nas:$OUTPUT/stringtieEB /scratch/$MOI 
cd /scratch/$MOI
{% endhighlight %}

##### Recovery annotations

- Before merging gtf files obtained by stringtie, we have to recover the annotations in order to see the known genes names in gtf file. Stringtie annotate transcripts using gene id 'MSTRG.1' nomenclature . See https://github.com/gpertea/stringtie/issues/179

{% highlight bash %}
module load system/python/3.6.5
python3 /data2/formation/TP_RNA-seq_2019/gpertea-scripts/mstrg_prep.py intermediateResults.STRINGTIEMERGE.gtf > intermediateResults.STRINGTIEMERGE_prep.gtf
{% endhighlight %}

- Compare gtf files before and after running `mstrg_prep.py` script. To do it you can choose a gene and explore differences: 
{% highlight bash %}
grep 'LOC_Os01g01010.1' intermediateResults.STRINGTIEMERGE*
{% endhighlight %}

##### gffcompare

- Let’s compare the StringTie transcripts to known transcripts using gffcompare https://github.com/gpertea/gffcompare and explore results. Observe statistics. How many "J", "U" and "=" do you obtain?. `gffcompare_out.annotated.gtf` file will be visualised with IGV later.

{% highlight bash %}
scp ~/TP-RNASEQ//RNASeqData/referenceFiles/chr1.fasta .
/data2/formation/TP_RNA-seq_2019/gffcompare/gffcompare -r chr1.gff3 -o gffcompare_out  intermediateResults.STRINGTIEMERGE_prep.gtf
{% endhighlight %}

##### Stringtie -e -B

- ... Finally, we launch stringtie: (change nodeXX by your node number)

{% highlight bash %}
for i in *bam ; do eval "mkdir ${i/.SAMTOOLSSORT.bam/}; qsub -q formation.q@nodeXX -N stringtie2 -cwd -V -b yes 'module load bioinfo/stringtie/1.3.4; stringtie" $PWD"/"$i "-G $PWD"/"intermediateResults.STRINGTIEMERGE_prep.gtf -e -B -o $PWD/${i/.SAMTOOLSSORT.bam/}/${i/bam/count}'"; done
{% endhighlight %}

##### Convert to counts table

- Convert stringtie output in counts using `prepDE.py`. Dont forget! You are in /scratch `/scratch/formationX`  
{% highlight bash %}
mkdir counts
cd counts/
ln -s /scratch/$MOI/*/*.count .
for i in *.count; do echo ${i/.SAMTOOLSSORT.count/} $PWD/$i; done > listGTF.txt
python2 /data2/formation/TP_RNA-seq_2019/prepDE.py -i listGTF.txt
{% endhighlight %}

You have obtained `gene_count_matrix.csv` and `transcript_count_matrix.csv`

##### Transfer data from /scratch to your home on cluster

- Don't forget scp \*.counts files to your $OUTPUT

{% highlight bash %}
scp -r /scratch/$MOI/counts/ ~/TP-RNASEQ/
scp -r /scratch/$MOI/gffcompare*/ ~/TP-RNASEQ/
{% endhighlight %}

##### Transfer data to local machine

- From your local terminal, transfer counts to your local machine with scp
{% highlight bash %}
scp -r formationX@bioinfo-nas.ird.fr:/home/formationX/TP-RNASEQ/counts/ .
{% endhighlight %}

- Transfer also reference files fasta, gff and `gffcompare_out.annotated.gtf` to use it later with IGV.
{% highlight bash %}
scp -r formationX@bioinfo-nas.ird.fr:/home/formationX/toggleTP/RNASeqData/referenceFiles/*.gff3 .
scp -r formationX@bioinfo-nas.ird.fr:/home/formationX/toggleTP/RNASeqData/referenceFiles/*.fasta .
scp -r formationX@bioinfo-nas.ird.fr:/home/formationX/TP-RNASEQ/gffcompare* .
{% endhighlight %}


-----------------------


<a name="practice-3"></a>
## Practice 3 : Differential expression analysis using EdgeR and DESeq2 on DIANE 
<td>Practice 3 will be performed in DIANE via Website Interface.</td>


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

To input expression matrix, select “Data import” as input file type. DIANE expects the count matrix to have rows as genes and samples as columns.
Gene names and sample names should be the first column and the first row, respectively.

 - Go to file Tab.
 - Take the count file `gene_count_matrix.csv` generated previously.
 - Import this file into  Data import  and then Expression file upload.
 - Add Use Comma separator as it is a csv.
 - Check if yours data are imported in the rigth window. (Preview of the expression matrix)

#### Step 2 : Input Design Information

The design infomation are used for sample point coloring and differential expression analysis. Users can input the entire sample meta sheet as 
design information for each sample.

 - Go to Design and gene information files.
 - Go to Designed Table Upload.  Choose CSV/TXT design file (optional) `info.txt`
 - Verify that the header of the info file corresponds to the count file. 
 - Choose the Separator : Tab or the appropriate separator.
 - Verify on the Design Table Preview and submit design.


#### Step 3 : Normalisation


 - Choose the Normalieation Method : 
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
 - If needed, you can download the Variably Expressed Genes, and on the graph, you can see the dispersion of your data.
 

#### Step 6 : Explore normalized gene expression 

With the PCA  Principal Component Analysis, you can see verify if your experimental design is correct, for example the PCA separate conditions.
Performing PCA on normalized RNA-Seq counts can be really informative about the conditions that impact gene expression the most. During PCA, new variables are computed, as linear combinations of your initial variables (e.g. experimental conditions). Those new variables, also called principal components, are designed to carry the maximum of the data variability.

Go to the summary menu, and use the "Exploratory analysis".


#### Step 7 : Differential expression analysis

To detect the genes that have significant changes in their expression caused by experimental perturbations, we use the edgeR package, based on negative binomals models.

The first step is thus to estimate the gene dispersions, which is acheived by pooling genes with similar expression level, and using empirical Bayes stragtegies.

The results are presented in a dataframe, ordered by adjusted pvalues (FDR). The dataframe contains the log fold changes (logFC), the average expression (logCPM) for each genes which FDR is lower than the specified adjusted p-value threshold. You can also choose to to select one genes having an absolute log fold change over a certain constant.


 - Go to Differential Expression.
 - Choose "Conditions to compare for differential analysis".
 - Use the Adjusted pvalue ( FDR ). 
 - Absolute Log Fold Change ( Log2 ( Perturbation / Reference ) ) :.
 - DETECT DIFFERENTIALLY EXPRESSED GENES
 
The output files are presented in a table "Results table, MA plot, Volcano Plot, Heatmap.
If you have the annotation file, you can explore the Gene Ontology enrichment.

The output file is a "DEGs_Batch-CENPK.tsv" file usable in R the make some graph and other analysis.

-----------------------

<a name="practice-4"></a>
## Practice 4 : Compare list of DE genes with DIANE EdgeR and DESeq2 
<td>Practice 4 will be performed in DIANE via Website Interface.</td>


#### First part with EdgeR on DIANE

* Run the normalisation for differential analysis - `Tmm` `deseq2` `none`
* Check relevance of normalized expression values provided by each normalisation
* Observe PCA plot of experimental conditions. 


Questions :
  - Using filters parameters, determine how many genes are found to be differentally expressed using a minimum FDR-adjusted pvalue <= 0.05, 0.1?
  - Do you have the sample number of differential gene for a FDR cutoff 0.1 and 0.05?
  - According to you, what is the best cutoff?
  
 
-----------------------

<a name="practice-5"></a>
### Practice 5 : Hierarchical Clustering
Practice 5 will be performed with DIANE.
* Connect to your DIANE interface.
- Go to Clustering.
 - For each analysis EdgeR or DESeq2 specify the Data Input (count, log...).
 - Choose the distance `Euclidean` or an other, the Agglomeration method `Ward`and the number of cluster.

-----------------------

<a name="practice-6"></a>
### Practice 6 : Visualization of mapped reads against genes using IGV
Practice 6 will be performed with Integrated Genome Viewer (IGV).

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
* DIANE : [ShinyApp] (https://diane.bpmp.inrae.fr/)
* Related courses : [Transcriptomics](https://southgreenplatform.github.io/trainings/linuxJedi/)
* Degust : [Degust](http://degust.erc.monash.edu/)
* MeV: [MeV](http://mev.tm4.org/)
* MicroScope: [MicroScope](http://microscopebioinformatics.org/)
* Comparison of methods for differential expression: [Report](https://southgreenplatform.github.io/trainings//files/Comparison_of_methods_for_differential_gene_expression_using RNA-seq_data.pdf)
* PIVOT: [PIVOTGithub](https://github.com/qinzhu/PIVOT/)
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
                  
    
 
