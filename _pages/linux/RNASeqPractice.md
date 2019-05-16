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
| Authors | Julie Orjuela (julie.orjuela@irf.fr), Gautier Sarah (gautier.sarah@cirad.fr), Catherine Breton (c.breton@cgiar.org), Aurore Comte (aurore.compte@ird.fr),  Alexis Dereeper (alexis.dereeper@ird.fr), Sebastien Ravel (sebastien.ravel@cirad.fr), Sebastien Cunnac (sebastien.cunnac@ird.fr) |
| Creation Date | 15/03/2018 |
| Last Modified Date | 17/05/2019 |


-----------------------

### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Practice 1: Psedo-mapping against transcriptome reference + counting with Kallisto](#practice-1)
* [Practice 2: Mapping against annotated genome reference with Hisat2 + counting with Stringtie](#practice-2)
* [Practice 3: Differential expression analysis using EdgeR and DESeq2](#practice-3)
* [Practice 4: Compare list of DE genes with EdgeR and DESeq2](#practice-4)
* [Practice 5: Hierarchical Clustering](#practice-5)
* [Practice 6: Visualization of mapped reads against genes using IGV](#practice-6)
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
* Connect to [Galaxy IRD](http://bioinfo-inter.ird.fr:8080/)
* Create a new history and import all the 8 RNASeq samples datasets (paired-end fastq files) from Data library
`Shared Data => Data Libraries => Galaxy_trainings_2019 => RNASeq`
* Upload the Chr1 of rice transcriptome (cDNA) to be used as reference  - `http://rice.plantbiology.msu.edu/pub/data/Eukaryotic_Projects/o_sativa/annotation_dbs/pseudomolecules/version_7.0/chr01.dir/Chr1.cdna`
* Run the kallisto quant program by providing Chr1 as transcriptome reference and specifying correctly pairs of input fastq- `kallisto quant`
* You can do it with the pairs made one by one manually or you can make lists of dataset pairs. 

If you choose this second option:
* Build one list with the pairs of condition 1 and on other list with the pairs of condition 2. 
* launch kallisto on each of the two lists => you get two kallisto outputs collections. One for each conditions.

* Convert kallisto outputs with `Kallisto2EdgeR`. Inputs are the two output collections.
 => You get one single file that can be used as input for EdgeR.


-----------------------

<a name="practice-2"></a>
### Practice 2 : Mapping against annotated genome reference with Hisat2 + counting with Stringtie
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
* change SGE key `$sge` as below using a texte editor as nano `nano RNASeqHisat2Stringtie.config.txt`
{% highlight bash %}
$sge
-q formation.q
-b Y
-cwd
{% endhighlight %}
* in TOGGLe configuration file use /scratch in `$scp` key to launch your job from scratch folder and also `$env` key using
`module load bioinfo/TOGGLE-dev/0.3.7` module installed on cluster. 
* Check parametters of every step in `~/toggleTP/RNASeqData/RNASeqHisat2Stringtie.config.txt` as recommended by https://www.nature.com/articles/nprot.2016.095.


Mapping is performed using HISAT2 and usually the first step, prior to mapping, is to create an index of the reference genome. TOGGle index genome automatically if indexes are absents in reference folder. 
It could be important only store sorted BAM files and delete the SAM files after conversion.
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

Convert runTOGGLeRNASEQ in a executable file with `chmod +x runTOGGLeRNASEQ.sh`

Launch runTOGGLeRNASEQ.sh in qsub mode
{% highlight bash %}
qsub -q bioinfo.q -N TOGGLeRNASEQ -b yes -cwd 'module load bioinfo/TOGGLE-dev/0.3.7; ./runTOGGLeRNASEQ.sh '
{% endhighlight %}

Explore output `outTOGGLe` TOGGLe and check if everything was ok.

Open and explore`outTOGGLe/finalResults/intermediateResults.STRINGTIEMERGE.gtf`

#### Now that we have our assembled transcripts, we can estimate their abundances. 

- Run again stringtie using options -B and -e

{% highlight bash %}
MOI="formationX"
OUTPUT="/home/$MOI/TP-RNASEQ/outTOGGLe/"
mkdir $OUTPUT/stringtieEB
cd $OUTPUT/stringtieEB 
ln -s $OUTPUT/finalResults/intermediateResults.STRINGTIEMERGE.gtf .
ln -s $OUTPUT/output/*/4_samToolsSort/*SAMTOOLSSORT.bam .
{% endhighlight %}

- Remember good pratices to work at IRD Cluster. You have to copy data into a path /scratch in a node.

{% highlight bash %}
qrsh -q formation.q
MOI="formationX"
OUTPUT="/home/$MOI/TP-RNASEQ/outTOGGLe/"
scp -r nas:$OUTPUT/stringtieEB /scratch/$MOI 
cd /scratch/$MOI
{% endhighlight %}

- ... before merging gtf files obtained by stringtie, we have to recovery annotations in order to see gene name in gtf files. Stringtie annotate transcrips using gene id 'MSTRG.1' nomenclature . See https://github.com/gpertea/stringtie/issues/179

{% highlight bash %}
module load system/python/3.6.5
python3 /data2/formation/TP_RNA-seq_2019/gpertea-scripts/mstrg_prep.py intermediateResults.STRINGTIEMERGE.gtf > intermediateResults.STRINGTIEMERGE_prep.gtf
{% endhighlight %}

Compare output before and after run `mstrg_prep.py` script.

you can choose a gene and explore differencies
`grep 'LOC_Os01g01010.1' intermediateResults.STRINGTIEMERGE*`

Let’s compare the StringTie transcripts to known transcripts using gffcompare

 `/data2/formation/TP_RNA-seq_2019/gffcompare/gffcompare -r ~/TP-RNASEQ//RNASeqData/referenceFiles/chr1.gff3 -o  gffcompare_out intermediateResults.STRINGTIEMERGE_prep.gtf`

- ... Now we launch stringtie:
{% highlight bash %}
for i in *bam ; do eval "mkdir ${i/.SAMTOOLSSORT.bam/}; qsub -q formation.q@nodeXX -N stringtie2 -cwd -V -b yes 'module load bioinfo/stringtie/1.3.4; stringtie" $PWD"/"$i "-G $PWD"/"intermediateResults.STRINGTIEMERGE_prep.gtf -e -B -o $PWD/${i/.SAMTOOLSSORT.bam/}/${i/bam/count}'"; done
{% endhighlight %}


- Convert stringtie output in counts using `prepDE.py`. Dont forget. You are in /scratch `/scratch/formationX`  
{% highlight bash %}
mkdir counts
cd counts/
ln -s /scratch/$MOI/*/*.count .
for i in *.count; do echo ${i/.SAMTOOLSSORT.count/} $PWD/$i; done > listGTF.txt
python2 /data2/formation/TP_RNA-seq_2019/prepDE.py -i listGTF.txt
{% endhighlight %}

You have obtained `gene_count_matrix.csv` and `transcript_count_matrix.csv`

- Don't forget scp `\*.counts` files to you $OUTPUT `scp -r /scratch/$MOI/counts/ ~/TP-RNASEQ/`

- And from your local terminal, transfer counts to your local machine with `scp -r formationX@bioinfo-nas.ird.fr:/home/formationX/TP-RNASEQ/counts/ .`

- Transfert also reference files fasta, gff and gffcompare_out.annotated.gtf to use it later with IGV.

-----------------------

<a name="practice-3"></a>
### Practice 3 : Differential expression analysis using EdgeR and DESeq2
<td>Practice3 will be performed in PIVOT via R Studio.</td>

PIVOT: Platform for Interactive analysis and Visualization Of Transcriptomics data
Qin Zhu, Junhyong Kim Lab, University of Pennsylvania
Oct 26th, 2017

#### Intallation of PIVOT

Dependecies that needs to be manually installed.
You may need to paste the following code line by line 
and choose if previously installed packages should be updated (recommended).

{% highlight bash %}
install.packages("devtools") 
library("devtools")
install.packages("BiocManager")
BiocManager::install("BiocUpgrade") 
#BiocManager::install("GO.db")
BiocManager::install("HSMMSingleCell")
#BiocManager::install("org.Mm.eg.db")
#BiocManager::install("org.Hs.eg.db")
BiocManager::install("DESeq2")
BiocManager::install("SingleCellExperiment")
BiocManager::install("scater")
BiocManager::install("monocle")
BiocManager::install("GenomeInfoDb")
{% endhighlight %}


#### Install PIVOT

{% highlight bash %}
install_github("qinzhu/PIVOT")
BiocManager::install("BiocGenerics") # You need the latest BiocGenerics >=0.23.3
{% endhighlight %}

### Launch PIVOT

To run PIVOT, in Rstudio console related to a web shinny interface, use command
{% highlight bash %}
library(PIVOT)
pivot()
{% endhighlight %}

Go to your web browser.

-----------------------

### Introduction 

As you have seen, RNA sequencing (RNA-seq) is an experimental method for measuring RNA expression levels via high-throughput sequencing of small adapter-ligated fragments.
The number of reads that map to a gene is the proxy for its expression level.
There are many steps between receiving the raw reads from the sequencer and gaining biological insight.
In this tutorial, we will start with a "Table of counts" and end with a "List of differentially expressed genes".

#### Step 1  : Data Input 

To input expression matrix, select “Counts Table” as input file type. PIVOT expects the count matrix to have rows as genes and samples as columns.
Gene names and sample names should be the first column and the first row, respectively.

 - Go to file Tab.
 - Take the count file `gene_count_matrix.csv` generated previously.
 - Import this file into  Data input  and then Input file type.
 - Add Use Tab separator to Skip Rows.
 - Check if yours data are imported in the rigth window.

#### Step 2 : Input Design Information

The design infomation are used for sample point coloring and differential expression analysis. Users can input the entire sample meta sheet as 
design information, or manually specify groups or batches for each sample.

 - Go to DESIGN.
 - Go to Designed Table Upload. Upload `info.txt`
 - Verify that the header of the info file corresponds to the count file. 
 - Choose the Separator : Space or the appropriate separator.
 - Verify on the Design Table Preview and submit design.
 - Choose the Normalieation Method : 
  - for Edge R you can use `DESeq, Trimmed Mean of M-values TMM, or Upperquartile`.
  - for DESeq you can use `DESeq, Modifed DESeq`
 
 In order to have a quick view of your chosen data, look at the summary. 

#### step 3 : Feature Filtering

 - There are currently 3 types of feature filter in PIVOT: the expression filter, which filters based on various expression statistics; 
 - You can choose the filter criteria. 

#### Step 4 : Select samples

 - Go To SAMPLE 
 - Select your sample and condition, 
   - Subset by sample and or subset by list, as you can creat different experiment analysis.
   
DATA MAP draw a summary of your different analysis, so you can save the history of your analysis.

#### Step 5 : Basic statistic

 - If you want to keep the count table, upload it.
 - Verify the distribution of each condition in the standard deviation graph, the dispersion graph.
 - If needed, you can download the Variably Expressed Genes, and on the graph, you can see the dispersion of your data.
 
#### First part with EdgeR on PIVOT

* Run the EdgeR program for differential analysis - `EdgeR`
* Verify relevance of normalized expression values provided by EdgeR
* Observe MDS plot of experimental conditions. Observe Smear plot.

Questions :
* Using filters parameters, determine how many genes are found to be differentally expressed using a minimum pvalue <= 0.05, 0.1? Using a minimum FDR-adjusted pvalue <= 0.05, 0.1?
  
#### Step 6  : Differential Expression with EdgeR

Once data have been normalized in the Step 1, you can choose the method to find the Differential expression gene between the condition previously choosen. 
In edgeR, is recommended to remove genes with very low counts.  Remove genes (rows) which have zero counts for all samples from the dge data object.

 - Go to Differential Expression, choose edgeR
 - Acording your normalized method choice in step 1, notify the Data Normalization method, and choose Experiment Design, and condition.
 - For this dataset choose `condition, condition`
 - Choose the Test Method, Exact test, GLM likelihood ratio test, and GLM quasi-likelihood F-test. 
 - For this dataset choose `Exact test`

Then `Run Modeling`

 - Choose the P adjustement adapted
 - For this dataset choose `False discovery rate` or `Bonferroni correction`
 - Choose FDR cutoff 0.1 and 0.05
 - Choose Term 1 and Term 2

You obtain a table containing the list of the differential gene expressed according to your designed analysis. This table contains logFoldChange, logCountPerMillion, PValue, FDR. 
This table can be download in order to use it for other analysis. The Mean-Differece Plot show you the up-regulated gene in green, and Down regulated gene in black.

 - Keep this file `edgeR_results.csv`
 - Change the name of the file according to your analysis.
 - Example : `edgeR_results_FDR_01.csv` to be able to recognize the different criteria used.
 
 Questions : 
  - Do you have the sample number of defferential gene for a FDR cutoff 0.1 and 0.05?
  - According to you, what is the best cutoff?
  - When you change the order of the Term1 and Term2, what are the consequence on the Results Table?
  

---------------------

#### Second part with DESeq2 on PIVOT

* Run the DESeq program for differential analysis - `DESeq2`
* Verify relevance of normalized expression values provided by DESeq2
* Observe MDS plot of experimental conditions. Observe Smear plot.

Questions:
* Using filters parameters, determine how many genes are found to be differentally expressed using a minimum pvalue <= 0.05, 0.1? Using a minimum FDR-adjusted pvalue <= 0.05, 0.1?

-----------------------
 
#### Step 6  : Differential Expression with DESeq2

Once data have been normalized in the Step 1, you can choose the method to find the Differential expression gene between the condition previously choosen. 

 - Go to Differential Expression, choose DEseq2
 - Acording your normalized method choice in step 1, notify the Data Normalization method, and choose Experiment Design, and condition.
 - For this dataset choose `condition, condition`
 - Choose the Test Method, Exact test, GLM likelihood ratio test, and GLM quasi-likelihood F-test. 
 - For this dataset choose `Exact test`

Then `Run Modeling`

 - Choose the P adjustement adapted
 - For this dataset choose `FDR cutoff`
 - Choose FDR cutoff 0.1 and 0.05

You obtain a table containing the list of the differential gene expressed according to your designed analysis. This table contains baseMean, log2FoldChange, PValue, pvalueadjust. 
This table can be download in order to use it for other analysis. The MA Plot show you the up-regulated gene LFC>0, and Down regulated gene LFC<0, the differential gene are in red.

 - Keep this file `deseq_results.csv`
 - Change the name of the file according to your analysis.
 - Example : `deseq_results_FDR_01.csv` to be able to recognize the different criteria used.
 
 Questions : 
  - Do you have the sample number of defferential gene for a FDR cutoff 0.1 and 0.05?
  - According to you, what is the best cutoff?
  - When you change the order of the Term1 and Term2, what are the consequence on the Results Table?

----------------------------

#### Step 7  : Visualisation Heatmap, Correlation, PCA

You can make correlation between the control and the rep in order to identify library bias if exists.
We can also explore the relationships between the samples by visualizing a heatmap of the correlation matrix.
The heatmap result corresponds to what we know about the data set.
First, the samples in group 1 and 2 come from very different the control and the repetition, so the two groups are very different.
Second, since the samples in each group are technical replicates, the within group variance is very low.

#### Correlation between sample and control
 - Go to Correlation.
 - 1 Pairwaise Scatterplot show the pairwaise comparison between your samples. 
 - 2 Sample correlation with 3 methods, pearson, sperman or kendal, with the agglomeration method show you how are linked your samples.
 - 3 Feature Correlation represented with a heatMap ordered by variance of the expression.

#### PCA
 - To separate your sample a PCA is  way to make a dimension reduction.

Question : 
 - Can you discribe the structure of your sample, with a correlation analysis, and a PCA?
 
 -----------------------

<a name="practice-4"></a>
### Practice 4 : Compare list of DE genes with EdgeR and DESeq2
Practice4 will be performed with Venn Diagramm implemented on PIVOT.

* Compare lists of DE genes with the two approches.
 - Go to Toolkit.
 - Upload your lists of gene obtained with edegR `edgeR_results_FDR_01.csv` , and DESeq2 `deseq_results_FDR_01.csv`.
 - Upload the first list then Add List and upload the second list.
 - You can see the Venn diagram and download the common list of gene between the both methods.

Questions: 

 - Look at the expression values for a gene found DE with EdgeR and not with DESeq2, and vice-versa, give the pvalue of each gene?

Some other tools are available to compare 2 lists of gene. [Venny](http://bioinfogp.cnb.csic.es/tools/venny/).
  
-----------------------

<a name="practice-5"></a>
### Practice 5 : Hierarchical Clustering
Practice5 will be performed with PIVOT.
* Connect to your PIVOT interface.
- Go to Clustering.
 - For each analysis EdgeR or DESeq2 specify the Data Input (count, log...).
 - Choose the distance `Euclidean` or an other, the Agglomeration method `Ward`and the number of cluster.

-----------------------

<a name="practice-6"></a>
### Practice 6 : Visualization of mapped reads against genes using IGV
Practice6 will be performed with Integrated Genome Viewer (IGV).
* Load reference genome, GFF annotation file and the file comming from the gffCompare.
* Focus on a gene that has been shown to be differentially expressed and observe the structure of the gene.

-----------------------

### Links
<a name="links"></a>

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
                  
 
