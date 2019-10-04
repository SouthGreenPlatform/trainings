---
layout: page
title: "RNASeq Practice"
permalink: /ouaga-NGS/rnaseqPractice/
tags: [ rnaseq, survival guide ]
description: RNASeq Practice page
---

| Description | Hands On Lab Exercises for RNASeq |
| :------------- | :------------- | :------------- | :------------- |
| Related-course materials | [Transcriptomique](https://southgreenplatform.github.io/tutorials//bioanalysis/rnaSeq/) |
| Related-course materials | [Trinity and Trinotate](https://southgreenplatform.github.io/trainings//trinity/) |
| Related-course materials | [Linux for Dummies](https://southgreenplatform.github.io/trainings/linux/) |
| Authors | Julie Orjuela (julie.orjuela_AT_irf.fr), Christine Tranchant (christine.tranchant_AT_ird.fr),  Gautier Sarah (gautier.sarah_AT_cirad.fr), Catherine Breton (c.breton_AT_cgiar.org), Aurore Comte (aurore.compte_AT_ird.fr),  Alexis Dereeper (alexis.dereeper_AT_ird.fr), Sebastien Ravel (sebastien.ravel_AT_cirad.fr), Sebastien Cunnac (sebastien.cunnac_AT_ird.fr) |
| Creation Date | 15/03/2018 |
| Last Modified Date | 03/10/2019 |


-----------------------

### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Preambule 0: Connection into cluster - `ssh,srun,scp`](#practice-0)
* [Practice 1: Check Reads Quality](#practice-1)
* [Practice 2: Pseudo-mapping against transcriptome reference + counting with Kallisto](#practice-2)
* [Practice 3: Mapping against annotated genome reference with Hisat2 + counting with Stringtie](#practice-3)
* [Practice 4: Differential expression analysis using EdgeR and DESeq2](#practice-4)
* [Practice 5: Compare list of DE genes with EdgeR and DESeq2](#practice-5)
* [Practice 6: Visualization of mapped reads against genes using IGV](#practice-6)
* [Links](#links)
* [License](#license)


-----------------------

<a name="practice-0"></a>
# 0. Going to the cluster - `ssh,srun,scp`

Dataset used in this practical comes from
* ref : https://www.ncbi.nlm.nih.gov/pmc/articles/PMC3488244/
* data : NCBI SRA database under accession number SRS307298 S. cerevisiae
* Genome size of S. cerivisiae : 12M (12.157.105) (https://www.yeastgenome.org/strain/S288C#genome_sequence)

In this session, we will analyze RNA-seq data from one sample of S. cerevisiae (NCBI SRA
SRS307298). It is from two different origin (CENPK and Batch), with three biological replications for each
origin (rep1, rep2 and rep3).

 
### Connection into cluster through `ssh` mode

We will work on the cluster with a "supermem" node using SLURM scheduler.

{% highlight python %}
ssh formationX@YOUR_IP_ADRESS
{% endhighlight %}

### Opening an interactive bash session on the node25 (supermem partition) - `srun -p partition --pty bash -i`

Read this survival document containig basic commands to SLURM (https://southgreenplatform.github.io/trainings/slurm/)

{% highlight python %}
srun -p supermem --time 08:00:00 --cpus-per-task 2 --pty bash -i
{% endhighlight %}

### Prepare input files

- Create your subdirectory in the scratch file system /scratch. In the following, please replace X with your own user ID number in formationX.

{% highlight python %}

- declare PATHTODATA variable
PATHTODATA="/PATH/TO/DATA/"

- create scratch repertory 
cd /scratch
mkdir formationX
cd formationX
{% endhighlight %}

- Copy the exercise files from the shared location to your scratch directory (it is essential that all
calculations take place here)

{% highlight python %}
scp -r  nas:$PATHTODATA/SRA_SRS307298/RAWDATA/ /scratch/formationX/
{% endhighlight %}

- When the files transfer is finished, verify by listing the content of the current directory and the subdirectory RAWDATA with the command `ls -al`. You should see 12 gzipped read files in a listing, a `samples.txt` file and a `adapt-125pbLib.txt` file. 


{% highlight python %}
[orjuela@node25 RAWDATA]$ more samples.txt 
CENPK	CENPK_rep1	PATH/SRR453569_1.fastq.gz	PATH/SRR453569_2.fastq.gz
CENPK	CENPK_rep2	PATH/SRR453570_1.fastq.gz	PATH/SRR453570_2.fastq.gz
CENPK	CENPK_rep3	PATH/SRR453571_1.fastq.gz	PATH/SRR453571_2.fastq.gz
Batch	Batch_rep1	PATH/SRR453566_1.fastq.gz	PATH/SRR453566_2.fastq.gz
Batch	Batch_rep2	PATH/SRR453567_1.fastq.gz	PATH/SRR453567_2.fastq.gz
Batch	Batch_rep3	PATH/SRR453568_1.fastq.gz	PATH/SRR453568_2.fastq.gz
{% endhighlight %}

-----------------------

<a name="practice-1"></a>
# 1. Check Reads Quality

FastQC perform some simple quality control checks to ensure that the raw data looks good and there are no problems or biases in data which may affect how user can usefully use it. http://www.bioinformatics.babraham.ac.uk/projects/fastqc/

{% highlight python %}
# make a fastqc repertoty
cd /scratch/formationX
mkdir FASTQC
cd FASTQC

#charge modules 
module load bioinfo/FastQC/0.11.7

# 1.1 run fastqc in the whole of samples
fastqc -t 2 /scratch/formationX/RAWDATA/*.gz -o /scratch/formationX/FASTQC/
{% endhighlight %}

Multiqc is a modular tool to aggregate results from bioinformatics analyses across many samples into a single report. Use this tool to visualise results of quality. https://multiqc.info/

{% highlight python %}
#charge modules 
module load bioinfo/multiqc/1.7

#launch Multiqc to create a report in html containing the whole of informations generated by FastQC
multiqc .

#transfer results to your cluster home 
scp -r multiqc* nas:/home/formationX/

# transfert results to your local machine by scp or filezilla
scp -r formationX@bioinfo-nas.ird.fr:/home/formationX/multiqc* ./

# open in your favorite web navigator
firefox multiqc_report.html .
{% endhighlight %}

In this practice, reads quality is ok. You need to observe sequences and check biases. To remove adaptors and primers you can use Trimmomatic. Use PRINSEQ2 to detect Poly A/T tails and low complexity reads. Remove contaminations with SortMeRNA, riboPicker or DeconSeq.

## 1.2  Cleanning reads with trimmomatic

{% highlight python %}
# loading modules
module load bioinfo/Trimmomatic/0.33

# changing PATH to current directory in samples file
sed -i 's|PATH|'$PWD'|ig' samples.txt 
 
# Running trimmomatic for each sample 

In this example, reads of SRR453566 sample are trimmed. (_U untrimmed _P paired)
- ILUMINACLIP is used to find and remove Illumina adapters.
- SLIDINGWINDOW performs a sliding window trimming, cutting once the average quality within the window falls below a threshold. By considering multiple bases, a single poor quality base will not cause the removal of high quality data later in the read. 
- LEADING removes low quality bases from the beginning. As long as a base has a value below this
threshold the base is removed and the next base will be investigated.
- TRAILING specifies the minimum quality required to keep a base
- MINLEN removes reads that fall below the specified minimal length

java -jar /usr/local/Trimmomatic-0.38/trimmomatic-0.38.jar PE -phred33  /scratch/orjuela/RAWDATA/SRR453567_1.fastq.gz /scratch/orjuela/RAWDATA/SRR453567_2.fastq.gz SRR453567_1.P.fastq.gz SRR453567_1.U.fastq.gz SRR453567_2.P.fastq.gz SRR453567_2.U.fastq.gz ILLUMINACLIP:/scratch/formationX/RAWDATA/adapt-125pbLib.txt:2:30:10 SLIDINGWINDOW:4:5 LEADING:5 TRAILING:5 MINLEN:25

{% endhighlight %}

In this example : 

{% highlight python %}
Input Read Pairs: 7615732 Both Surviving: 7504326 (98,54%) Forward Only Surviving: 71456 (0,94%) Reverse Only Surviving: 11202 (0,15%) Dropped: 28748 (0,38%)
TrimmomaticPE: Completed successfully
{% endhighlight %}

# 1.3 Check quality after trimming  

Observe effet of trimming in your samples. Run fastqc in the whole of trimmed reads and observe it with MultiQC 

-----------------------
<a name="practice-2"></a>
### Practice 2 : Mapping against transcriptome reference + counting with Kallisto

We will perform a transcriptome-based mapping and estimates of transcript levels using Kallisto, and a differential analysis using EdgeR.

* Transfert references of transcriptome (cDNA) to be used as reference and index it

{% highlight python %}
# make a REF repertoty
cd /scratch/formationX
mkdir REF
cd REF

# copy transcrits fasta reference file
scp -r  nas:$PATHTODATA/SRA_SRS307298/REF/GCF_000146045.2_R64_cds_from_genomic.fasta /scratch/formationX/REF

# charge modules 
module load bioinfo/kallisto/0.43.1

# index reference 
kallisto index -i GCF_000146045.2_R64_cds_from_genomic.fai GCF_000146045.2_R64_genomic.fasta
{% endhighlight %}

* create a KALLISTO repertory

{% highlight python %}
# make a KALLISTO repertory and go on
cd /scratch/formationX
mkdir KALLISTO
cd KALLISTO

# symbolic link to trimmed fastq 
ln -s /scratch/formationX/TRIMMOMATIC/*.P.fastq.gz .
{% endhighlight %}

 * Run the kallisto quant program by providing `GCF_000146045.2_R64_cds_from_genomic.fasta` as transcriptome reference and specifying correctly pairs of input fastq- `kallisto quant`
 
{% highlight python %}
kallisto quant -i GCF_000146045.2_R64_cds_from_genomic.fai -o $PWD --fr-stranded SRR453566_1.P.fastq.gz,SRR453567_1.P.fastq.gz,SRR453568_1.P.fastq.gz,SRR453569_1.P.fastq.gz,SRR453570_1.P.fastq.gz,/SRR453571_1.P.fastq.gz --rf-stranded SRR453566_2.P.fastq.gz,SRR453567_2.P.fastq.gz,SRR453568_2.P.fastq.gz,SRR453569_2.P.fastq.gz,SRR453570_2.P.fastq.gz,SRR453571_2.P.fastq.gz
{% endhighlight %}

* Convert kallisto outputs into one single file that can be used as input for EdgeR -`Kallisto2EdgeR` script

{% highlight python %}

{% endhighlight %}

-----------------------

<a name="practice-3"></a>
### Practice 3 : Mapping against annotated genome reference with Hisat2 + counting with Stringtie
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

<a name="practice-4"></a>
### Practice 4 : Differential expression analysis using EdgeR and DESeq2
<td>Practice 4 will be performed in PIVOT via R Studio.</td>

PIVOT: Platform for Interactive analysis and Visualization Of Transcriptomics data
Qin Zhu, Junhyong Kim Lab, University of Pennsylvania
Oct 26th, 2017

#### Intallation of PIVOT

Dependencies that needs to be manually installed.
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

To run PIVOT, in Rstudio console related to a web shiny interface, use command
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
   - Subset by sample and or subset by list, as you can create different experiment analysis.
   
DATA MAP draw a summary of your different analysis, so you can save the history of your analysis.

#### Step 5 : Basic statistics

 - If you want to keep the count table, upload it.
 - Check the distribution of each condition in the standard deviation graph, the dispersion graph.
 - If needed, you can download the Variably Expressed Genes, and on the graph, you can see the dispersion of your data.
 
#### First part with EdgeR on PIVOT

* Run the EdgeR program for differential analysis - `EdgeR`
* Check relevance of normalized expression values provided by EdgeR
* Observe MDS plot of experimental conditions. Observe Smear plot.

Questions :
* Using filters parameters, determine how many genes are found to be differentally expressed using a minimum pvalue <= 0.05, 0.1? Using a minimum FDR-adjusted pvalue <= 0.05, 0.1?
  
#### Step 6  : Differential Expression with EdgeR

Once data have been normalized in the Step 1, you can choose the method to find the Differential expression gene between the condition previously choosen. 
In edgeR, it is recommended to remove genes with very low counts.  Remove genes (rows) which have zero counts for all samples from the dge data object.

 - Go to Differential Expression, choose edgeR
 - According to your normalized method choice in step 1, notify the Data Normalization method, and choose Experiment Design, and condition.
 - For this dataset choose `condition, condition`
 - Choose the Test Method, Exact test, GLM likelihood ratio test, and GLM quasi-likelihood F-test. 
 - For this dataset choose `Exact test`

Then `Run Modeling`

 - Choose the P adjustement adapted
 - For this dataset choose `False discovery rate` or `Bonferroni correction`
 - Choose FDR cutoff 0.1 and 0.05
 - Choose Term 1 and Term 2

You obtain a table containing the list of the differential gene expressed according to your designed analysis. This table contains logFoldChange, logCountPerMillion, PValue, FDR. 
This table can be download in order to use it for other analysis. The Mean-Difference Plot show you the up-regulated gene in green, and Down regulated gene in black.

 - Keep this file `edgeR_results.csv`
 - Change the name of the file according to your analysis.
 - Example : `edgeR_results_FDR_01.csv` to be able to recognize the different criteria used.
 
 Questions : 
  - Do you have the sample number of differential gene for a FDR cutoff 0.1 and 0.05?
  - According to you, what is the best cutoff?
  - When you change the order of the Term1 and Term2, what are the consequences on the Results Table?
  

---------------------

#### Second part with DESeq2 on PIVOT

* Run the DESeq program for differential analysis - `DESeq2`
* Check relevance of normalized expression values provided by DESeq2
* Observe MDS plot of experimental conditions. Observe Smear plot.

Questions:
* Using filters parameters, determine how many genes are found to be differentially expressed using a minimum pvalue <= 0.05, 0.1? Using a minimum FDR-adjusted pvalue <= 0.05, 0.1?

-----------------------
 
#### Step 6  : Differential Expression with DESeq2

Once data have been normalized in the Step 1, you can choose the method to find the Differential expression gene between the condition previously choosen. 

 - Go to Differential Expression, choose DEseq2
 - According to your normalized method choice in step 1, notify the Data Normalization method, and choose Experiment Design, and condition.
 - For this dataset choose `condition, condition`
 - Choose the Test Method, Exact test, GLM likelihood ratio test, and GLM quasi-likelihood F-test. 
 - For this dataset choose `Exact test`

Then `Run Modeling`

 - Choose the P adjustement adapted
 - For this dataset choose `FDR cutoff`
 - Choose FDR cutoff 0.1 and 0.05

You obtain a table containing the list of the differential gene expressed according to your designed analysis. This table contains baseMean, log2FoldChange, PValue, pvalueadjust. 
This table can be downloaded in order to use it for other analysis. The MA Plot show you the up-regulated gene LFC>0, and Down regulated gene LFC<0, the differential gene are in red.

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
First, the samples in group 1 and 2 come from the control and the repetition, so the two groups are very different.
Second, since the samples in each group are technical replicates, the within group variance is very low.

#### Correlation between sample and control
 - Go to Correlation.
 - 1 Pairwaise Scatterplot show the pairwaise comparison between your samples. 
 - 2 Sample correlation with 3 methods, pearson, sperman or kendal, with the agglomeration method show you how are linked your samples.
 - 3 Feature Correlation represented with a heatMap ordered by variance of the expression.

#### PCA
 - To separate your sample a PCA is  way to make a dimension reduction.

Question : 
 - Can you describe the structure of your sample, with a correlation analysis, and a PCA?
 
 -----------------------

<a name="practice-4"></a>
### Practice 4 : Compare list of DE genes with EdgeR and DESeq2
Practice 4 will be performed with Venn Diagramm implemented on PIVOT.

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
Practice 5 will be performed with PIVOT.
* Connect to your PIVOT interface.
- Go to Clustering.
 - For each analysis EdgeR or DESeq2 specify the Data Input (count, log...).
 - Choose the distance `Euclidean` or an other, the Agglomeration method `Ward`and the number of cluster.

-----------------------

<a name="practice-6"></a>
### Practice 6 : Visualization of mapped reads against genes using IGV
Practice 6 will be performed with Integrated Genome Viewer (IGV).

* Focus on a gene that has been found to be differentially expressed and observe the structure of the gene.

- From master0 `qlogin -q formation.q`

- Lauch `samtools index` using bam obtained by hisat2:

{% highlight bash %}
for fl in ./*.bam; do samtools index $fl; done
{% endhighlight %}

- Run igv : `igv.sh &`

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
                  
 
