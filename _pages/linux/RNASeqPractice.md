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
| Authors | Julie Orjuela (julie.orjuela@irf.fr), Gautier Sarah (gautier.sarah@cirad.fr), Catherine Bréton (c.breton@cgiar.org), Aurore Comte (aurore.compte@ird.fr),  Alexis Dereeper (alexis.dereeper@ird.fr), Sebastien Ravel (sebastien.ravel@cirad.fr), Sebastien Cunnac (sebastien.cunnac@ird.fr) |
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
<td>Practice3 will be performed in the Galaxy environment.</td>
* Run the EdgeR program for differential analysis - `edger`
* Verify relevance of normalized expression values provided by EdgeR
* Observe MDS plot of experimental conditions. Observe Smear plot.
* Using `sort` and  its `general numeric sort` parameter, combined with `filter` tool, determine how many genes are found to be differentally expressed using a minimum pvalue <= 0.05? Using a minimum FDR-adjusted pvalue <= 0.05?

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
                  
 
