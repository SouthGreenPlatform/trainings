---
layout: page
title: "TOGGLe Practice"
permalink: /linux/togglePractice/
tags: [ TOGGLe, survival guide ]
description: TOGGLe Practice page
---

| Description | Hands On Lab Exercises for TOGGLe |
| :------------- | :------------- | :------------- | :------------- |
| Related-course materials | [TOGGLe introduction](https://southgreenplatform.github.io/trainings//toggle/) |
| Authors | Sébastien RAVEL (sebastien.ravel@cirad.fr)<br/>Christine TRANCHANT (christine.tranchant@ird.fr)  |
| Creation Date | 15/03/2018 |
| Last Modified Date | 16/04/2019 |


-----------------------

### Summary

* [Practice 1: Creating your own workflow](#practice-1)
* [TP on IRD cluster](#TPcluster)
* [Links](#links)
* [License](#license)


-----------------------

<a name="practice-1"></a>
### Creating your own workflow :

Practice 1 consists of using  base one pre-defined configuration file to build own workflow to use with TOGGLe.

<a target="_blank" href="http://toggle.southgreen.fr/manual/completeManual/" >TOGGLe Manual Page</a>

The <a target="_blank" href="https://raw.githubusercontent.com/SouthGreenPlatform/TOGGLE/master/exampleConfigs/SNPdiscoveryPaired.config.txt" >SNPdiscoveryPaired.config.txt</a> file is an example of how to customize your pipeline.

#### <a name="order"></a>Providing an order
The order of a pipeline is provided with key <b>$order</b>, base on the file, build new config file to run only from mapping to SNP calling.

-----------------------

#### Launching an analysis

Use only one script to run all pipeline: <b>toggleGenerator.pl</b> script usage

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
| -report / --report:      | generate pdf report <a href="{{ site.url }}/manual/completeManual/#report">(more info)</a>                        |
| -h / --help:                    | show help message and exit                                                                                                     |

(1): If no database index exists, it will be automtically created if it is necessary. If the index already exists, they will not be re-created UNLESS the pipeline order (see below) expressively requests it (updating the index e.g.)

All the the paths (files and folders) can be provided as absolute (/home/mylogin/data/myRef.fasta) or relative (../data/myRef.fasta).

Example of a command to run TOGGLe :
{% highlight bash %}
  toggleGenerator.pl -d ~/toggle/fastq -c ~/toggle/SNPdiscoveryPaired.config.txt -o ~/toggle/outputRES -r ~/toggle/reference.fasta -nocheck
{% endhighlight %}

-----------------------

#### <a name="TPcluster"></a>TP on IRD cluster

All input data:
* Input data : /data2/formation/TPsnpSV/fastqDir/
* Reference : /data2/formation/TPsnpSV/reference.fasta
* Config file: /data2/formation/TPsnpSV/configFiles/SNPdiscoveryPaired.config.txt

To do:
* Create a "formationX" directory in your account
* Make à copy for reference and input data into "formationX" directory (scp).
* Add the configuration file used by TOGGLe and change SGE key as below
{% highlight bash %}
$sge
-q bioinfo.q
-b Y
-cwd
{% endhighlight %}

##### Connect to account and prepare datas:

1. Connect to the cluster:
{% highlight bash %}
    ssh -X formationX@bioinfo-master.ird.fr
{% endhighlight %}
2. Launch a QRSH command:
{% highlight bash %}
    qrsh -q formation.q
{% endhighlight %}
3. Create your folder in scratch and go in it:
{% highlight bash %}
    mkdir /scratch/formationX
    cd /scratch/formationX
{% endhighlight %}
  4. Transfer the data from nas using SCP:
{% highlight bash %}
    scp -r nas:/data2/formation/TPsnpSV .
{% endhighlight %}


SOLUTIONS:

{% highlight bash %}
mkdir ~/toggleTP
cd ~/toggleTP
cp /data/formation/tp-toggle/fastq/ ./ -r
cp /data/formation/tp-toggle/reference/ ./ -r
vim toggle.config.txt
toggleGenerator.pl -c toggle.config.txt -d ~/toggleTP/fastq/ -r ~/toggleTP/reference/reference.fasta -o outTOGGLE -nocheck -report
{% endhighlight %}

* Run TOGGLe commande line

-----------------------

### Links
<a name="links"></a>

* Related courses : [TOGGLe]({{ site.url }}/toggle)

-----------------------

### License
<a name="license"></a>

<div>
The resource material is licensed under the Creative Commons Attribution 4.0 International License (<a href="http://creativecommons.org/licenses/by-nc-sa/4.0/">here</a>).
<center><img width="25%" class="img-responsive" src="http://creativecommons.org.nz/wp-content/uploads/2012/05/by-nc-sa1.png"/>
</center>
</div>
                  
 
