---
layout: page
title: "Release Notes"
permalink: /install/releaseNotes/
tags: [ Release ]
description: Release page
---
1. [Release 0.3.5, 8th of November, 2017](#0.3.5)
2. [Release 0.3.4, 27th of September, 2017](#0.3.4)
3. [Release 0.3.3, 5th of April, 2017](#0.3.3)
4. [Release 0.3.2, 1st of March, 2017](#0.3.2)
5. [Release 0.3.1, 11th of January, 2017](#0.3.1)
6. [Release 0.3, 16th of March, 2016](#0.3)
7. [Release 0.2.1, 15th of May, 2015](#0.2.1)
8. [Release 0.2, 14th of March, 2015](#0.2)

## <a name="0.3.5"> </a>Release 0.3.5, 8th of November, 2017

### Functions
- New softwares:
	* [Crac](http://crac.gforge.inria.fr)
	* [Bowtie](http://bowtie-bio.sourceforge.net/manual.shtml)
	* [Bowtie2](http://bowtie-bio.sourceforge.net/bowtie2/index.shtml)
	* [Atropos](https://github.com/jdidion/atropos)
	* [DuplicationDetector](http://github.com/SouthGreenPlatform/DuplicationDetector/)
	
### Modules
- including the possibility of transferring data using *scp* command by adding $scp tag in the configuration file [More details in Manual](http://toggle.ird.fr/manual/completeManual/#scp)

### Various
- Diverse bugs corrected

## <a name="0.3.4"> </a>Release 0.3.4, 25th of October, 2017

### Functions
- New version of scheduling system, including the possibility of adding bash commands with the $env key [More details in Manual](http://toggle.ird.fr/manual/completeManual/#env)
- Adding check format fasta for the reference file.

### Modules
- Adding BWA-SW
- Adding NGSUtils - bamutils

### Various
- Update DevManual
- Diverse bugs corrected

## <a name="0.3.3"> </a>Release 0.3.3, 5th of April, 2017

### Functions
- New possibilities for QC: checkFormat for FASTA, FASTQ, SAM/BAM and VCF.
- Software versions checked before launching (tracability).
- Current TOGGLE version checked before launching.
- Adding fastqUtils internal tools : checkEncodeByASCIIcontrol (64 or 33 PHRED format control).
- Adding blocks for samToolsDepth, samToolsFaidx, samToolsIdxstats, samToolsMerge.

### Modules
- Adding checkFormat.pm

### Various
- Diverse bugs corrected


## <a name="0.3.2"> </a>Release 0.3.2, 1st of March, 2017

### Functions
- In the Global log file print only path and version of softwares used in the workflow

### Various
- Syntax errors corrected in TOGGLEinstall.pl
- Diverse  bugs corrected

## <a name="0.3.1"></a>Release 0.3.1, 11th of January, 2017

### Functions

- Adding the MPRUN and LSF Scheduling system (through bash script launching)
- Adding the possibility to add ENV variables
- Some options are not required anymore
- Users can by pass the FASTQ checking in order to accelerate launching
- Help has been optimized (-h options)

### Modules
- Adding tgicl
- Adding Trinity
- Adding samtools MpileUp
- Adding snpEff annotation

### Various
Divers bugs corrected

## <a name="0.3"></a>Release 0.3, 16th of March, 2016

### Modules

- Adding the picardTools AddOrReplaceReadGroup CleanSam ValidateSamFile SamFormatConverter
- Adding the GATK UnifiedGenotyper BaseRecalibrator PrintReads
- Adding the samTools sortSam flagstats depth idxstats
- Adding scheduler.pm module for scheduling system
- Adding the SGE and Slurm schedulers
- Adding cleaning and compression of given steps


### Functions

- *On the fly* creation of pipeline (see MANUAL.md for a detailled explanation)
- Use of **Graphviz** to generate a visual output of the pipeline structure
- Adding the automatic scheduling-aware launching system - For SGE and Slurm
- Adding a cleaning and a compression system to remove/compress chosen intermediate data in order to save hard drive space (see MANUAL.md)
- Use of initial compressed gzipped files
- Possibility of starting from FASTQ, SAM/BAM or VCF (gzipped or not)
- Possibility of working in relative path
- Providing an output folder in order to not modify the input data (working with symbolic links)
- Single creation of index/dictionary for reference, once per pipeline and no more once per sample, only if they do not exist.

## <a name="0.2.1"></a>Release 0.2.1, 15th of May, 2015

### Addition to previous version
* Adding correct SGE version for globalAnalysis.pl
* Adding RNAseq pipeline v1

### Corrections of bugs
* Correction of the ls bug for only a single pair
* Correction of hard coded path
* Validation of current softwares versions
* Modification of the FASTQ format control
* Various minor bugs adjustments

### Software versions tested
* bwa
* Picard-tools 1.124 and Higher
* SAMtools
* GATK
* FastQC
* CutAdapt
* Java


## <a name="0.2"></a>Release 0.2, 14th of March, 2015

Second version release
