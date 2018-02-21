---
layout: page
title: "Quick Manual"
permalink: /manual/quickManual/
tags: [ Quick Manual ]
description: Quick Manual page
---

Quick User Manual
===========
<center>
<video class="embed-responsive-item" width="50%" height="auto" controls="controls">
  <source src="{{ site.url }}/files/TOGGLE-DEMO-VF-2-HD.mp4" type="video/mp4">
Your browser does not support the video tag.
</video>
</center>


* [Input files naming convention](#prerequisites)
* [Launching an Analysis](#launching)
* [Creating pipeline](#fileconfig)
* [Providing an order](#order)
* [Sending soft options](#option)
* [Output results](#finalFolder)
* [Output and error LOGS](#logs)


### <a name="prerequisites"></a>Input files naming convention

TOGGLE will automatically assign sample name (readgroup) based on the input file name structure, picking up the "text" before the first dot.

* **individual1_1.fastq** will be understood as *individual1*
* **mapping1.sam** will be understood as *mapping1*
* **myVcf.complete.vcf** will be understood as *myVcf*

For *Fastq* files, only one underscore ('_') is allowed, before the direction of sequences ( _1, _2 or _R1, _R2), just before the extension (*.fastq*).

Please use only UTF-8 standard symbols, no weird characters or space, pipe, tilde or any type of commas.

### <a name="launching"></a>Launching an analysis

The current version is based on the <b>toggleGenerator.pl</b> script

{% highlight bash %}
  toggleGenerator.pl -d|--directory DIR -c|--config FILE -o|--outputdir DIR [-r|--reference FILE] [-k|--keyfile FILE] [-g|--gff FILE] [-nocheck|--nocheckFastq] [--help|-h]
{% endhighlight %}

| Required named arguments:       |                                                                                                                                |
| :------------------------------ | :----------------------------------------------------------------------------------------------------------------------------- |
| -d / --directory DIR:           | a folder with raw data to be treated (FASTQ, FASTQ.GZ, SAM, BAM, VCF)                                                          |
| -c / --config FILE:             | generally it is the *software.config.txt* file but it can be any text file structured as shown below.                          |
| -o / --outputdir DIR:           | the current version of TOGGLE will not modify the initial data folder but will create an output directory with all analyses in.|

| Optional named arguments:       |                                                                                                                                |
| :------------------------------ | :----------------------------------------------------------------------------------------------------------------------------- |
| -r / --reference FILE:          | the reference FASTA file to be used. (1)                                                                                           |
| -g / -gff FILE:                 | the GFF file to be used for some tools.                                                                                        |
| -k / --keyfile FILE:            | the keyfile use for demultiplexing step.                                                                                       |
| -nocheck / --nocheckFastq:      | by default toggle checks if fastq format is correct in every file. This option allows to skip this step.                       |
| -h / --help:                    | show help message and exit                                                                                                     |

(1): If no index exists it will be created accordingly to the pipeline requested index. If the index exist, they will not be re-created UNLESS the pipeline order (see below) expressively requests it (updating the index e.g.)

All the the paths (files and folders) can be provided as absolute (/home/mylogin/data/myRef.fasta) or relative (../data/myRef.fasta).


so for exemple command is:
{% highlight bash %}
  toggleGenerator.pl -d ~/toggle/fastq -c ~/toggle/SNPdiscoveryPaired.config.txt -o ~/toggle/outputRES -r ~/toggle/reference.fasta -nocheck
{% endhighlight %}


### <a name="fileconfig"></a>Creating pipeline

The <a href="{{ site.url }}/files/SNPdiscoveryPaired.config.txt" >SNPdiscoveryPaired.config.txt</a> file is an example of how to customize your pipeline.

#### <a name="order"></a>Providing an order
The order of a pipeline is provided with key <b>$order</b>

{% highlight perl %}
$order
1=fastqc
2=cutadapt
3=bwaAln
4=bwaSampe
5=picardToolsSortSam
6=samtoolsflagstat
7=samtoolsview
8=samToolsIndex
9=gatkRealignerTargetCreator
10=gatkIndelRealigner
11=picardToolsMarkDuplicates
{% endhighlight %}

#### <a name="option"></a>Sending soft options


Then add all software configuration using key <b>$softName</b> and after options such below:

{% highlight perl %}
$First Software
option1
option2

$Second Software
option1
option2
{% endhighlight %}

for exemple:

{% highlight perl %}
$bwa aln
-n=5

$bwa sampe
-a 500
{% endhighlight %}





### <a name="finalFolder"></a>Output results

TOGGLE will generate an output folder containing different files and subfolders, as follows:

<img class="img-responsive" src="{{ site.url }}/images/toggleOutputFolder.png" alt="TogglePipeline" />

 The final results are contained in the <b>finalResults</b> folder.
 TOGGLE will also copy the <b>software config</b> file corresponding to the analysis, in order users can recover their options.
 The <b>output</b> folder contains all sub analyses, i.e. the individual analyses or intermediate data.

### <a name="logs"></a>Output and Error Logs

TOGGLE will generate two main types of logs, the *.o* for normal output and the *.e* for the errors and warnings (these last ones are normally empty files).
Each level of TOGGLE will generate this pair of log:
* **GLOBAL_ANALYSIS_date.o/.e** logs represent the general output for the complete analysis (*toggleGenerator.pl* logs). They are located at the root of the output directory.
* **IndividualName_global_log.o/.e** logs represent the local output for sub analysis (*toggleBzz.pl* and *toggleMultiple.pl* logs). They are located in their respective subdirectories in the output folder.
