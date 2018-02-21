---
layout: page
title: "Example SGE configuration"
permalink: /FAQ/configSGE/
tags: [ SGE, cluster, module, load, qsub ]
description: SGE configuration page
---

# Example SGE configuration

## With module load environment:

### build own module load file:

Use own module load if not install from admin

<pre><code class="ruby">
mkdir $HOME/privatemodules
</code></pre>

adding to .bashrc

<pre><code class="ruby">
#use own module
module use --append $HOME/privatemodules
</code></pre>


add file toggle in $HOME/privatemodules 

<pre><code class="ruby">
vim $HOME/privatemodules/toggle
</code></pre>

<pre><code class="ruby">
#%Module1.0
##

## Required internal variables
set     prefix       $env(HOME)/TOGGLE/
set     version      "TOGGLE"

if {![file exists $prefix]} {
	puts stderr "\t[module-info name] Load Error: $prefix does not exist"
	break
	exit 1
}

## List conflicting modules here

## List prerequisite modules here
set		fullname	TOGGLE
set		externalurl	"https://github.com/SouthGreenPlatform/TOGGLE\n"
set		description	"A framework to quickly build pipelines and to perform large-scale NGS analysis"

## Required for "module help ..."

proc ModulesHelp { } {
  global description externalurl
  puts stderr "Description - $description"
  puts stderr "More Docs   - $externalurl"
}

## Required for "module display ..." and SWDB
module-whatis   "loads the [module-info name] environment"

## Software-specific settings exported to user environment
module load system/java/jre-1.8.111
module load system/perl/5.24.0
module load bioinfo/FastQC/0.11.5
module load bioinfo/bwa/0.7.12
module load bioinfo/picard-tools/2.5.0
module load bioinfo/samtools/1.3.1
module load bioinfo/gatk/3.6
module load bioinfo/cutadapt/1.10
module load system/libgtextutils/0.7
module load bioinfo/fastx_toolkit/0.0.14
module load bioinfo/tophat/2.1.1
module load bioinfo/bowtie/1.1.2
module load bioinfo/bowtie2/2.2.9
module load bioinfo/cufflinks/2.2.1
module load bioinfo/tgicl_linux/1.0
module load bioinfo/trinityrnaseq/2.2.0
module load bioinfo/stacks/1.43
module load bioinfo/snpEff/4.3
module load bioinfo/ngsutils/0.5.9
module load bioinfo/crac/2.5.0
module load bioinfo/duplicationDetector/1.0
module load bioinfo/sNMF/1.2
module load bioinfo/readseq/1.0
module load bioinfo/plink/1.90
module load bioinfo/bedtools/2.26.0

# Path
prepend-path PATH $prefix
prepend-path PERL5LIB $prefix/modules:$prefix/test/pipelines
prepend-path TOGGLE_PATH $prefix
prepend-path SNMF_PATH /usr/local/sNMF-1.2/bin/

</code></pre>


Du coup le fichier **localConfig.pm** toggle devient:

<pre><code class="ruby">
package localConfig;


###################################################################################################################################
#
# Copyright 2014-2017 IRD-CIRAD-INRA-ADNid
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, see <http://www.gnu.org/licenses/> or
# write to the Free Software Foundation, Inc.,
# 51 Franklin Street, Fifth Floor, Boston,
# MA 02110-1301, USA.
#
# You should have received a copy of the CeCILL-C license with this program.
#If not see <http://www.cecill.info/licences/Licence_CeCILL-C_V1-en.txt>
#
# Intellectual property belongs to IRD, CIRAD and South Green developpement plateform for all versions also for ADNid for v2 and v3 and INRA for v3
# Version 1 written by Cecile Monat, Ayite Kougbeadjo, Christine Tranchant, Cedric Farcy, Mawusse Agbessi, Maryline Summo, and Francois Sabot
# Version 2 written by Cecile Monat, Christine Tranchant, Cedric Farcy, Enrique Ortega-Abboud, Julie Orjuela-Bouniol, Sebastien Ravel, Souhila Amanzougarene, and Francois Sabot
# Version 3 written by Cecile Monat, Christine Tranchant, Laura Helou, Abdoulaye Diallo, Julie Orjuela-Bouniol, Sebastien Ravel, Gautier Sarah, and Francois Sabot
#
###################################################################################################################################



use strict;
use warnings;
use Exporter;

our @ISA=qw(Exporter);
our @EXPORT=qw($bwa $picard $samtools $GATK $cutadapt $fastqc $java $toggle $fastxTrimmer $tophat2 $bowtie2Build $bowtieBuild $htseqcount $cufflinks $cuffdiff $cuffmerge $tgicl $trinity  $stacks $snpEff $bamutils $crac $cracIndex $bowtie $bowtie2 $atropos $duplicationDetector $plink $bedtools $snmfbin $readseqjar);

#toggle path
our $toggle=$ENV{"TOGGLE_PATH"};

#PATH for Mapping on cluster
our $java = "$ENV{'JAVA_HOME'}/bin/java -jar";

our $bwa = "bwa";
our $picard = "$java $ENV{'PICARD_PATH'}/picard.jar";

our $samtools = "samtools";
our $GATK = "$java $ENV{'GATK_PATH'}/GenomeAnalysisTK.jar";
our $fastqc = "fastqc";

#Path for CutAdapt
our $cutadapt = "cutadapt";

##### FOR RNASEQ analysis
#Path for fastq_trimmer
our $fastxTrimmer="fastx_trimmer";

#Path for tophat2
our $tophat2="tophat2";

#path for bowtie2-build
our $bowtie2Build="bowtie2-build";

#path for bowtie-build
our $bowtieBuild="bowtie-build";

#path for htseqcount
our $htseqcount = "htseq-count";

#path for Cufflinks
our $cufflinks = "cufflinks";
our $cuffdiff = "cuffdiff";
our $cuffmerge = "cuffmerge";

#path for tgicl
our $tgicl = "tgicl";

#path for trinity
our $trinity = "Trinity";

#path for process_radtags
our $stacks = "process_radtags";

#path to snpEff
our $snpEff = "$java $ENV{'SNPEFF_PATH'}/snpEff.jar";

#path to bamutils
our $bamutils = "bamutils";

#path to crac
our $crac = "crac";
our $cracIndex = "crac-index";

#Path to bowtie bowtie2
our $bowtie = "bowtie";
our $bowtie2 = "bowtie2";

# path for atropos
our $atropos="/usr/local/bin/atropos";

#Path for duplicationDetector
our $duplicationDetector = "duplicationDetector.pl";

# path for plink
our $plink="plink";

#path for bedtools
our $bedtools = "bedtools"

# path to sNMF
our $snmfbin = "$ENV{'SNMF_PATH'}";

# path to readseq
our $readseqjar = "$java $ENV{'READSEQ_PATH'}/readseq.jar";

1;
</code></pre>