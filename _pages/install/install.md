---
layout: page
title: "Install"
permalink: /install/install/
tags: [ install, Requirements, tools, GitHub, Docker, automatic script ]
description: Install page
---
## Requirements

#### Perl minimal version 5.16

* [Capture::Tiny](http://search.cpan.org/~dagolden/Capture-Tiny-0.30/lib/Capture/Tiny.pm)
* [Data::Translate](http://search.cpan.org/~davieira/Data_Translate-0.3/Translate.pm)
* [Data::Dumper](http://search.cpan.org/~smueller/Data-Dumper-2.154/Dumper.pm)
* [Getopt::ArgParse](http://search.cpan.org/~mytram/Getopt-ArgParse-1.0.2/lib/Getopt/ArgParse.pm)
* [List::Compare](http://search.cpan.org/~jkeenan/List-Compare-0.53/lib/List/Compare.pm)
* [Switch](https://metacpan.org/pod/Switch)
* [Test::More](http://search.cpan.org/~exodist/Test-Simple-1.001014/lib/Test/More.pm)
* [Test::Deep](http://search.cpan.org/~rjbs/Test-Deep-0.119/lib/Test/Deep.pm)

{% highlight Bash %}
sudo cpan install Capture::Tiny Data::Translate Data::Dumper Getopt::ArgParse List::Compare Switch Test::More Test::Deep
{% endhighlight %}

## Required Bioinformatics tools

<!-- Button trigger modal -->
<button class="btn btn-home" data-toggle="modal" data-target="#modal-lg">
  Required Bioinfomatics tools
</button>

## Install Toggle

There are 3 ways to obtain TOGGLE. We recommend the first one for an install in a cluster.

1. [INSTALL FROM GitHub REPOSITORY](#github)
2. [INSTALL FROM THE DOCKER IMAGE](#docker)
3. [INSTALL FROM THE AUTOMATIC SCRIPT](#script)

## <a name="github"></a>INSTALL FROM GitHub REPOSITORY

* Create the directory TOGGLE where you want to install TOGGLE and go into this directory

* Get the TOGGLE code Clone the git

{% highlight Bash %}
git clone https://github.com/SouthGreenPlatform/TOGGLE.git .
{% endhighlight %}

* Add the Module path to the PERL5LIB environment variable

{% highlight Bash %}
export PERL5LIB=$PERL5LIB:/pathToToggle/modules
{% endhighlight %}

* In the same way add the TOGGLE directory to the PATH environment variable

{% highlight Bash %}
export PATH=$PATH:/pathToToggle
{% endhighlight %}

Rq : you can add this to the ~/.bashrc to make it always available when you log-in.


* Change the permission of the perl files in the directory TOGGLE

{% highlight Bash %}
cd /pathToToggle
chmod 755 *pl
{% endhighlight %}

* Modify the file /pathToToggle/modules/localConfig.pm
* Modify the shebang of perl in the begining of the script /pathToToggle/toggleGenerator.pl and onTheFly/startBlock.txt

* Test the pipeline with the test data

Modify the path of adaptator file in the file SNPdiscoveryPaired.config.txt

{% highlight perl %}
$cutadapt
-O=10
-m=35
-q=20
--overlap=7
-u=8
#If you have a specific adaptator file, please indicate here.
-adaptatorFile=/path/to/adaptator.txt
{% endhighlight %}

{% highlight Bash %}
$cd /pathToToggle
toggleGenerator.pl -c SNPdiscoveryPaired.config.txt -d data/testData/fastq/pairedTwoIndividusIrigin/ -r data/Bank/referenceIrigin.fasta -o toggleout2/
{% endhighlight %}

* Check the good running
> > * No error message
> > * toggleOUTPUT has been created in the /tmp folder
> > * the data generated are good


{% highlight Bash %}
tail /tmp/toggleOUTPUT/finalResults/GATKVARIANTFILTRATION.vcf

TO BE CHANGED FOR  THE FINAL VCF USING IRIGIN
{% endhighlight %}


* Test the RNASeq pipeline with the test data


{% highlight Bash %}
$cd /pathToToggle
toggleGenerator.pl -c RNASeq.config.txt -d data/testData/rnaseq/pairedOneIndividu/ -r data/Bank/referenceRnaseq.fa -g data/Bank/referenceRnaseq.gff3 -o toggleout/
{% endhighlight %}

* Check the good running
> > * No error message
> > * the directory toggleout has been created
> > * the directory toggleout/output contain all the results
> > * the file toggleout/finalResults/RNASeq.accepted_hits.HTSEQCOUNT.txt has been created
> > * the data generated are good


## <a name="docker"></a>INSTALL FROM THE DOCKER IMAGE

A Docker image based on Ubuntu 14.04 is available at http://bioinfo-web.mpl.ird.fr/toggle/toggle.tgz

If Docker is installed on your system, you can use this image:


{% highlight Bash %}
$wget http://bioinfo-web.mpl.ird.fr/toggle/toggle.tgz
$cat toggle.tgz | docker import - toggle
$docker run -i -t toggle /bin/bash
{% endhighlight %}

You can then download your data in the container (or attach a network/local drive within). TOGGLE can be launch as for a GitHub installation.

## <a name="script"></a>INSTALL FROM THE AUTOMATIC SCRIPT

This script is dedicated for an installation in the user space (no admin rights required).

Just download it, launch it and follow the instructions.


{% highlight Bash %}
$wget http://bioinfo-web.mpl.ird.fr/toggle/TOGGLEinstall.sh
$bash TOGGLEinstall.sh
{% endhighlight %}

Then you can launch the different scripts in the TOGGLE folder
