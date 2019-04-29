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
| Last Modified Date | 05/04/2018 |


-----------------------

### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Practice 1: Psedo-mapping against transcriptome reference + counting with Kallisto](#practice-1)
* [Practice 2: Mapping against annotated genome reference with Hisat2 + counting with Stringtie](#practice-2)
* [Practice 3: Differential expression analysis using EdgeR and DESeq2](#practice-3)
* [Practice 4: Visualization of mapped reads against genes using IGV](#practice-4)
* [Practice 5: Explore multiple expression projects/experiments using DiffExDB ? ? ? ? ? ](#practice-5)
* [Practice 6: Heatmap and Hierarchical Clustering](#practice-6)
* [Practice 7: Co-expression network analysis](#practice-7)
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

* Running Hisat2 and Stringtie with TOGGLe

Connect to account in IRD i-Trop cluster:

{% highlight bash %}
ssh formation1@bioinfo-master.ird.fr
{% endhighlight %}

Input data are accessible from :

* Input data : /data/formation/tp-toggle/RNASeqData/
* Reference : /data/formation/tp-toggle/RNASeqData/referenceFiles/chr1.fasta
* Config file: [RNASeqReadCount.config.txt](https://raw.githubusercontent.com/SouthGreenPlatform/TOGGLE/master/exampleConfigs/RNASeqHisat2Stringtie.config.txt)

Before to start ...

* Create a toggleTP directory in your HOME
* Make à copy for reference and input data into toggleTP directory (cp).
* Add the configuration file used by TOGGLe and change SGE key as below

{% highlight bash %}
$sge
-q bioinfo.q
-b Y
-cwd
{% endhighlight %}

SOLUTION:
{% highlight bash %}
mkdir ~/toggleTP
cd ~/toggleTP
cp /data/formation/tp-toggle/RNASeqData/ ./ -r
wget https://raw.githubusercontent.com/SouthGreenPlatform/TOGGLE/master/exampleConfigs/RNASeqHisat2Stringtie.config.txt
vim RNASeqHisat2Stringtie.config.txt
{% endhighlight %}

Your data are now in ~/toogleTP. Great!  Now, create a `runTOGGLeRNASEQ.sh` bash script to launch TOGGLe :

SOLUTION:
{% highlight bash %}
#!/bin/bash
#$ -N TOGGLeRNAseq
#$ -b yes
#$ -q bioinfo.q
#$ cwd
#$ -V

dir="~/toggleTP/RNASeqData/fastq"
out="~/toggleTP/RNASeqData/outTOGGLe"
config="/data3/projects/mechajaz/RNASeqHisat2Stringtie.config.txt"
ref="~/toggleTP/RNASeqData/referenceFiles/chr1.fasta"
gff="~/toggleTP/RNASeqData/Chr1.gff3"
## Software-specific settings exported to user environment
module load bioinfo/TOGGLE-dev/0.3.7

#running tooglegenerator 
toggleGenerator.pl -d $dir -c $config -o $out -r $ref -g $gff --report --nocheck;

echo "FIN, TOGGLe is genial!"
{% endhighlight %}

This is the software configutation to create a TOGGLe pipeline with Hisat2 and Stringtie. You can check parametters of every step here.
`vim ~/toggleTP/RNASeqData/RNASeqHisat2Stringtie.config.txt`

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


Command line generates by `runTOGGLeRNASEQ.sh` is :
{% highlight bash %}
/usr/local/TOGGLE-dev-0.3.7/toggleGenerator.pl -d "~/toggleTP/RNASeqData/fastq -c ~/toggleTP/RNASeqData/RNASeqHisat2Stringtie.config.txt -o ~/toggleTP/RNASeqData/outTOGGLe -r ~/toggleTP/RNASeqData/referenceFiles/chr1.fasta -g ~/toggleTP/RNASeqData/Chr1.gff3 --report --nocheck
{% endhighlight %}

Launch runTOGGLeRNASEQ.sh in qsub mode
{% highlight bash %}
qsub -q bioinfo.q -N TOGGLeRNASEQ -b yes -cwd 'module load bioinfo/TOGGLE-dev/0.3.7; ./runTOGGLeRNASEQ.sh '
{% endhighlight %}

- Explore output TOGGLe and check if everything was ok

- Run again stringtie using options -B and -e

{% highlight bash %}
OUTPUT="~/toggleTP/RNASeqData/outTOGGLe/"
mkdir $OUTPUT/stringtieEB
cd $OUTPUT/stringtieEB 
ln -s $OUTPUT/finalResults/intermediateResults.STRINGTIEMERGE.gtf .
ln -s $OUTPUT/output/*/4_samToolsSort/*SAMTOOLSSORT.bam .
{% endhighlight %}

- Remember good pratices to work at IRD Cluster. You have to copy data into a path /scratch in a node.

{% highlight bash %}
qrsh -q formation.q
scp nas:$OUTPUT/stringtieEB /scratch/formation1 
cd /scratch/formation1 
{% endhighlight %}

- ... before merging gtf files obtained by stringtie, we have to recovery annotations in order to see gene name in gtf files. Stringtie annotate transcrips using gene id 'MSTRG.1' nomenclature . See https://github.com/gpertea/stringtie/issues/179

{% highlight bash %}
python3 ~/scripts/gpertea-scripts/mstrg_prep.py intermediateResults.STRINGTIEMERGE.gtf > intermediateResults.STRINGTIEMERGE_prep.gtf 
{% endhighlight %}

Compare output before and after run `mstrg_prep.py`

- ... Now we launch stringtie:

{% highlight bash %}
for i in \*bam ; do echo "mkdir ${i/.SAMTOOLSSORT.bam/}; qsub -q bioinfo.q -N stringtie2 -cwd -V -b yes 'module load bioinfo/stringtie/1.3.4; stringtie" $PWD"/"$i "-G $PWD"/"intermediateResults.STRINGTIEMERGE_prep.gtf -e -B -o $PWD/${i/.SAMTOOLSSORT.bam/}/${i/bam/count}'"; done
{% endhighlight %}

- Convert stringtie output in counts using `prepDE.py`. Dont forget. You are in /scratch `/scratch/formation1 `

{% highlight bash %}
mkdir counts
cd counts/
ln -s $OUTPUT/stringtieEB/*/*.count .
for i in \*.count; do echo ${i/.SAMTOOLSSORT.count/} $PWD/$i; done > listGTF.txt
python2 /data/projects/TALseq/stringtie-scripts/prepDE.py -i listGTF.txt
{% endhighlight %}

- Don't forget scp *.counts files to you $OUTPUT

-----------------------

<a name="practice-3"></a>
### Practice 3 : Differential expression analysis using EdgeR and DESeq2
<td>Practice3 will be performed in PIVOT via R Studio.</td>
<td>https://bmcbioinformatics.biomedcentral.com/articles/10.1186/s12859-017-1994-0<td>
PIVOT: Platform for Interactive analysis and Visualization Of Transcriptomics data
Qin Zhu, Junhyong Kim Lab, University of Pennsylvania
Oct 26th, 2017


"This program is developed based on the Shiny framework, a set of R packages and a collection of scripts written by members of Junhyong Kim Lab at University of Pennsylvania. Its goal is to facilitate fast and interactive RNA-Seq data analysis and visualization. Current version of PIVOT supports routine RNA-Seq data analysis including normalization, differential expression analysis, dimension reduction, correlation analysis, clustering and classification. Users can complete workflows of DESeq2, monocle and scde package with just a few button clicks. All analysis reports can be exported, and the program state can be saved, loaded and shared.

See http://kim.bio.upenn.edu/software/pivot.html for more details."

Launch PIVOT
To run PIVOT, in Rstudio console, use command
{% highlight bash %}
library(PIVOT)
pivot()
{% endhighlight %}

* Run the EdgeR program for differential analysis - `edger`
* Verify relevance of normalized expression values provided by EdgeR and DEseq
* Observe MDS plot of experimental conditions. Observe Smear plot.
* Using filters parameters, determine how many genes are found to be differentally expressed using a minimum pvalue <= 0.05? Using a minimum FDR-adjusted pvalue <= 0.05?


#Step 1  : Data Input 

To input expression matrix, select “Counts Table” as input file type. PIVOT expects the count matrix to have rows as genes and samples as columns.
Gene names and sample names should be the first column and the first row, respectively.

PIVOT support expression matrix in csv, txt, xls or xlsx formats. Choose proper settings on the left 
file input panel until the right “Loaded File Preview” correctly shows the data frame.

you need to make sure that the data matrix:
Contains no NA or non-numeric values.
Does not have duplicated feature or sample names (PIVOT will alert the user if it detects any).


{% highlight bash %}
Go to file Tab.
Take the count file `gene_count_matrix.csv` generated previously.
Import this file into  Data input  and then Input file type.
Add Use Tab separator to Skip Rows.
Check if yours data are imported in the rigth window.
{% endhighlight %}


#Step 2 : Input Design Information

The design infomation are used for sample point coloring and differential expression analysis. Users can input the entire sample meta sheet as 
design information, or manually specify groups or batches for each sample.

The first column of the design table should always be the sample name list, which must include all samples that’s in the expression matrix. 
The rest columns will be treated as “categories” or “design variables”, which can be “condition”, “batch”, “operator”, “experiment date”, etc. 
You will be able to choose which category to be used for analysis such as DE, as well as if the category should be treated as categorical or numerical.

You can also manually make a design-info file by specifying the sample grouping in PIVOT, and download it for later upload.

{% highlight bash %}
Go to Design tab.
Go to Designed Table Upload. `info.txt`
Verify that the header of the info file corresponds to the count file. 
Choose the Separator : Space
Verify on the Design Table Preview and submit design 
{% endhighlight %}

#step 3 : Feature Filtering

There are currently 3 types of feature filter in PIVOT: the expression filter, which filters based on various expression statistics; 
the feature list filter, which filters based on user input gene list; and the P-value filter, which filters data with differentially expressed genes.

You can choose the filter criteri. 


#Step 3 : Select samples

{% highlight bash %}
Go To sample 
Select your sample and condition
{% endhighlight %}


#Step 4  : Data Normalization


PIVOT applies a pre-filtering step before doing normalization. By default, PIVOT will filter out genes with all 0 expressions.
Users can also specify a different row mean or row sum threshold to remove those low confidence features.

Once data have been normalized, you can check the normlization details which contain information such as the estimated size factors.

{% highlight bash %}
Go to Basic statistic
If you want to keep the normalized, log10 count table, upload it.
Verify the distribution of each condition in the standard deviation graph, the dispersion graph.
{% endhighlight %}

- #Step 5 : Basic Statistics


- #Step 6 : Differential Expression Analysis With EdgR 

DESeq2
This module is a graphical interface for the DESeq2 package (https://bioconductor.org/packages/release/bioc/html/DESeq2.html). Because DESeq requires raw 
counts input, if the input file is a normalized counts table, this analysis will not be available.

edgeR
Similarly to DESeq, edgeR require raw count input. To keep the consistency between PIVOT and edgeR package, PIVOT will renormalize the raw count using the edgeR 
supported methods, including TMM, RLE(DESeq) and UpperQuantile. PIVOT implements all three tests provided by edgeR: exact text, GLM likelihood ratio test 
and GLM quasi-likelihood F test. For details of these tests, please refer to the edgeR user manual: https://www.bioconductor.org/packages/devel/bioc/vignettes/edgeR/inst/doc/edgeRUsersGuide.pdf

* Go to Differential expression 
* Launch EdgeR, experimental design



- #Step 7: Clustering
Hieararchical Clustering

You can perform hierarchical clustering on various transformations of the expression matrix, as well as projection matrix of PCA, 
t-SNE, MDS or diffusion map. The latter requires you to have performed corresponding analysis first. For projections by PCA or diffusion map, 
you can further choose which sets of PC/DCs should be used as input for clustering.

You can color the leaves of the dendrogram by multiple sample meta data (design categories). You can use different color sets for different 
categories by specifying the same number of color palettes in the “group color” input box.

You can compare the clustering result to existing design categories using the confusion matrix.

- #Step 8 : Correlation Analysis
Pairwise Scatterplot

The plot shows pairwise comparison between your samples. The x and y axis of each plot show log10 RPM estimates in the cell corresponding 
to a given column and row respectively. The set of smoothed scatter plots on the lower left shows the overall correspondence between the transcript 
abundances estimated in two given cells. The upper right corner shows three-component mixture model, separating genes that “drop-out” in one of the 
cells (green component shows drop/out events in the column cell, red component shows drop-out events in the row cell). The correlated component is shown 
in blue. The percent of genes within each component is shown in the legend.


- #Step 9 :  Heatmap

Sample Correlation Heatmap

The sample correlation heatmap provides a more intuitive way of visualizing the correlation between your samples. If you specifies color by group, 
a color bar will be added to the heatmap to show the group info.

You can also adjust multiple aesthetics of the plot, and choose if the plot should be static or interactive by changing the plotting package.

Feature Heatmap

You can set multiple parameters for the feature heatmap. By default, PIVOT will only plot the top 100 genes ranked by a chosen statistic 
(variance, fano-factor, row mean or median). You can change the number of genes to plot by using the range slider, or manually input a range. 
If you want to plot a specific set of genes, please use the feature filter in the File panel.

- #Step  10 : Dimension Reduction

PCA
To run PCA, simply choose the type of input data and whether the data should be scaled, then press Run. You can specify the coloring of points and the 
palette for coloring after you have run PCA. You can download the tables for explained variance, feature loading and data projection. 
The Scree plot shows how much variance is explained by each PC.

You can visualzie the 1D, 2D and 3D projection by PCA, and adjust relevant aesthetics. For example, you can choose which PC combination should be used for 
2D PCA plot. Additionally, you can use ggplot or ggbiplot package (require installation from github) to visualize the 2D PCA plot.

You can directly drag on the plotly version of the 2D plot to specify groups for each sample (point). The grouping will be added as a meta column (pca_group), 
which can be used for coloring points and by other analysis such as DE.

T-SNE
Note that unlike PCA, 1D, 2D and 3D T-SNE are results of 3 different t-SNE runs (parameter dims = 1, 2 or 3).
According to http://lvdmaaten.github.io/tsne/,
“Perplexity is a measure for information that is defined as 2 to the power of the Shannon entropy. The perplexity of a fair die with k sides is equal to k. 
In t-SNE, the perplexity may be viewed as a knob that sets the number of effective nearest neighbors. It is comparable with the number of nearest neighbors k 
that is employed in many manifold learners.”

Similar to PCA, you can specify groups directly on the 2D plot.


-----------------------

* Connect to [IRD Galaxy](http://bioinfo-inter.ird.fr:8080) and run DESeq2 after having cutting and importing columns for each conditions. Determine how many genes are found to be differentally expressed using a minimum pvalue <= 0.05? Using a minimum FDR-adjusted pvalue <= 0.05?

-----------------------

* Compare lists of DE genes with the two approches using [Venny](http://bioinfogp.cnb.csic.es/tools/venny/). Look at the expression values for a gene found DE with EdgeR and not with DESeq2, and vice-versa.

-----------------------

<a name="practice-4"></a>
### Practice 4 : Visualization of mapped reads against genes using IGV
Practice3 will be performed with Integrated Genome Viewer (IGV).
* Load reference genome, GFF annotation file and two BAM files corresponding to 0dpi and 2dpi
* Focus on a gene that has been shown to be differentially expressed and observe the difference of accumation of reads

-----------------------

<a name="practice-5"></a>
### Practice 5 : Explore multiple expression projects/experiments using web sites
Practice5 (first part) will be performed using [Degust](http://degust.erc.monash.edu/)

* After having removed the first line, upload your count file into [Degust](http://degust.erc.monash.edu/)
* Observe the different plots available
* How many genes can be found DE for a minimum pvalue <= 0.05 and abs(logFC) > 2? Observe the plots.

-----------------------

Practice5 (second part) will be performed using DiffExDB, a database dedicated to centralize expression projects at IRD

* Go to the DiffExDB database: [DiffExDB](http://bioinfo-web.mpl.ird.fr/cgi-bin2/microarray/public/diffexdb.cgi). Select the project  `Response to M.graminicola`. 
* How many genes are differentially expressed at early stage of infection (2 day) in complete genome? Is there any overrepresented Gene Ontology (GO) term? Look at  volcano plot.
* How many genes are induced by the presence of nematode with logFC > 2? How many genes are repressed?
* How many genes are induced at both early and late stages of infection?
* How many genes are repressed gradually along infection? Have a look at heatmap representation for these genes?

-----------------------

<a name="practice-6"></a>
### Practice 6 : Hierarchical Clustering
Practice5 will be performed in the Galaxy environment.
* Connect to [Galaxy South Green](http://galaxy.southgreen.fr/galaxy/)
* Run the plotHeatmap program for heatmap and hierarchical clustering - `plotHeatmap`. Using EdgeR output and count file, display heatmap and gene clustering dendrogram on genes having a minimum pvalue <= 0.05 and abs(logFC) > 1

-----------------------

<a name="practice-7"></a>
### Practice 7 : Co-expression network analysis
Practice6 will be performed in the Galaxy environment.
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
                  
 
