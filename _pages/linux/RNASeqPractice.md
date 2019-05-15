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
* [Practice 5: Visualization of mapped reads against genes using IGV](#practice-5)
* [Practice 6: Explore multiple expression projects/experiments using web sites](#practice-6)
* [Practice 7: Hierarchical Clustering ](#practice-7)
* [Practice 8: Co-expression network analysis](#practice-8) 
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
* Create a new history and import RNASeq samples datasets (paired-end fastq files) from Data library
`Galaxy_trainings_2019 => RNASeq_DE`
* Upload the Chr1 of rice transcriptome (cDNA) to be used as reference  - `http://rice.plantbiology.msu.edu/pub/data/Eukaryotic_Projects/o_sativa/annotation_dbs/pseudomolecules/version_7.0/chr01.dir/Chr1.cdna`
* Run the kallisto program by providing Chr1 as transcriptome reference and specifying correctly pairs of input fastq- `kallisto quant`
* Convert kallisto outputs (collection of count files) into one single file that can be used as input for EdgeR - `Kallisto2EdgeR`

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
-q bioinfo.q
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
-q bioinfo.q
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
#$ cwd
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

Compare output before and after run `mstrg_prep.py`
you can choose a gene and explore differencies `grep 'LOC_Os01g01010.1' intermediateResults.STRINGTIEMERGE*`

- ... Now we launch stringtie:

{% highlight bash %}
for i in *bam ; do echo "mkdir ${i/.SAMTOOLSSORT.bam/}; qsub -q bioinfo.q -N stringtie2 -cwd -V -b yes 'module load bioinfo/stringtie/1.3.4; stringtie" $PWD"/"$i "-G $PWD"/"intermediateResults.STRINGTIEMERGE_prep.gtf -e -B -o $PWD/${i/.SAMTOOLSSORT.bam/}/${i/bam/count}'"; done
{% endhighlight %}

- Convert stringtie output in counts using `prepDE.py`. Dont forget. You are in /scratch `/scratch/formation1`   


{% highlight bash %}
mkdir counts
cd counts/
ln -s $OUTPUT/stringtieEB/*/*.count .
for i in \*.count; do echo ${i/.SAMTOOLSSORT.count/} $PWD/$i; done > listGTF.txt
python2 /data/projects/TALseq/stringtie-scripts/prepDE.py -i listGTF.txt
{% endhighlight %}

- Don't forget scp \*.counts files to you $OUTPUT



-----------------------

<a name="practice-3"></a>
### Practice 3 : Differential expression analysis using EdgeR and DESeq2
<td>Practice3 will be performed in PIVOT via R Studio.</td>



PIVOT: Platform for Interactive analysis and Visualization Of Transcriptomics data
Qin Zhu, Junhyong Kim Lab, University of Pennsylvania
Oct 26th, 2017

Intallation of PIVOT

### Dependecies that needs to be manually installed.
### You may need to paste the following code line by line 
### and choose if previously installed packages should be updated (recommended).

{% highlight bash %}
install.packages("devtools") 
library("devtools")
install.packages("BiocManager")
BiocManager::install("BiocUpgrade") 
BiocManager::install("GO.db")
BiocManager::install("HSMMSingleCell")
BiocManager::install("org.Mm.eg.db")
BiocManager::install("org.Hs.eg.db")
BiocManager::install("DESeq2")
BiocManager::install("SingleCellExperiment")
BiocManager::install("scater")
BiocManager::install("monocle")
BiocManager::install("GenomeInfoDb")
{% endhighlight %}

### Install PIVOT

{% highlight bash %}
install_github("qinzhu/PIVOT")
BiocManager::install("BiocGenerics") # You need the latest BiocGenerics >=0.23.3
{% endhighlight %}

Launch PIVOT
To run PIVOT, in Rstudio console related to a web shinny interface, use command
{% highlight bash %}
library(PIVOT)
pivot()
{% endhighlight %}

Go to your web Brother.

-----------------------

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

* Run the EdgeR program for differential analysis - `edger`
* Verify relevance of normalized expression values provided by EdgeR
* Observe MDS plot of experimental conditions. Observe Smear plot.
* Using filters parameters, determine how many genes are found to be differentally expressed using a minimum pvalue <= 0.05, 0.1? Using a minimum FDR-adjusted pvalue <= 0.05, 0.1?

* Determine how many genes are found to be differentally expressed using a minimum pvalue <= 0.05? Using a minimum FDR-adjusted pvalue <= 0.05? 
 
  
#### Step 6  : Differential Expression

Once data have been normalized in the Step 1, you can choose the method to find the Differential expression gene between the condition previously choosen. 

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
 
 Question : 
  - Do you have the sample number of defferential gene for a FDR cutoff 0.1 and 0.05?
  - According to you, what is the best cutoff?
  - When you change the order of the Term1 and Term2, what are the consequence on the Results Table?
  

---------------------


#### Second part with DESeq on PIVOT


* Run the DESeq program for differential analysis - `DESeq2`
* Verify relevance of normalized expression values provided by DESeq2
* Observe MDS plot of experimental conditions. Observe Smear plot.
* Using filters parameters, determine how many genes are found to be differentally expressed using a minimum pvalue <= 0.05, 0.1? Using a minimum FDR-adjusted pvalue <= 0.05, 0.1?



* Determine how many genes are found to be differentally expressed using a minimum pvalue <= 0.05? Using a minimum FDR-adjusted pvalue <= 0.05?

-----------------------

 
#### Step 6  : Differential Expression

Once data have been normalized in the Step 1, you can choose the method to find the Differential expression gene between the condition previously choosen. 

 - Go to Differential Expression, choose edgeR
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
 
 Question : 
  - Do you have the sample number of defferential gene for a FDR cutoff 0.1 and 0.05?
  - According to you, what is the best cutoff?
  - When you change the order of the Term1 and Term2, what are the consequence on the Results Table?



----------------------------


 
#### Step 7  : Visualisation 

You can make correlation between the control and the rep in order to identify library bias if exists.


Correlation between sample and control
 - Go to Correlation.
 - 1 Pairwaise Scatterplot show the pairwaise comparison between your samples. 
 - 2 Sample correlation with 3 methods, pearson, sperman or kendal, with the agglomeration method show you how are linked your samples.
 - 3 Feature Correlation represented with a heatMap ordered by variance of the expression.

PCA
 - To separate your sample a PCA is  way to make a dimension reduction.


Question : 
 - Can you discribe the structure of your sample, with a correlation analysis, and a PCA?
 
 
-----------------------

<a name="practice-4"></a>
### Practice 4 : Compare list of DE genes with EdgeR and DESeq2
Practice4 will be performed with Venn Diagramm implemented on PIVOT.



* Compare lists of DE genes with the two approches using [Venny](http://bioinfogp.cnb.csic.es/tools/venny/). Look at the expression values for a gene found DE with EdgeR and not with DESeq2, and vice-versa.

-----------------------

<a name="practice-5"></a>
### Practice 5 : Visualization of mapped reads against genes using IGV
Practice5 will be performed with Integrated Genome Viewer (IGV).
* Load reference genome, GFF annotation file and two BAM files corresponding to 0dpi and 2dpi
* Focus on a gene that has been shown to be differentially expressed and observe the difference of accumation of reads

-----------------------

<a name="practice-6"></a>
### Practice 6 : Explore multiple expression projects/experiments using web sites
Practice6 (first part) will be performed using [Degust](http://degust.erc.monash.edu/)

* After having removed the first line, upload your count file into [Degust](http://degust.erc.monash.edu/)
* Observe the different plots available
* How many genes can be found DE for a minimum pvalue <= 0.05 and abs(logFC) > 2? Observe the plots.

-----------------------

<a name="practice-7"></a>
### Practice 7 : Hierarchical Clustering
Practice7 will be performed in the Galaxy environment.
* Connect to [Galaxy South Green](http://galaxy.southgreen.fr/galaxy/)
* Run the plotHeatmap program for heatmap and hierarchical clustering - `plotHeatmap`. Using EdgeR output and count file, display heatmap and gene clustering dendrogram on genes having a minimum pvalue <= 0.05 and abs(logFC) > 1

-----------------------

<a name="practice-8"></a>
### Practice 8 : Co-expression network analysis
Practice8 will be performed in the Galaxy environment.
* Import appropriate datasets from data libraries `test.count` and `Traits.csv`: expression values for less genes but more conditions. Run the WGCNA program - `wgcna`
* Download, install and run the network program - `cytoscape` to display networks for each gene cluster.

-----------------------

### Links
<a name="links"></a>

* Related courses : [Transcriptomics](https://southgreenplatform.github.io/trainings/linuxJedi/)
* Degust : [Degust](http://degust.erc.monash.edu/)
* MeV: [MeV](http://mev.tm4.org/)
* MicroScope: [MicroScope](http://microscopebioinformatics.org/)
* Comparison of methods for differential expression: [Report](https://southgreenplatform.github.io/trainings//files/Comparison_of_methods_for_differential_gene_expression_using RNA-seq_data.pdf)

-----------------------

### License
<a name="license"></a>

<div>
The resource material is licensed under the Creative Commons Attribution 4.0 International License (<a href="http://creativecommons.org/licenses/by-nc-sa/4.0/">here</a>).
<center><img width="25%" class="img-responsive" src="http://creativecommons.org.nz/wp-content/uploads/2012/05/by-nc-sa1.png"/>
</center>
</div>
                  
 
