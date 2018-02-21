---
layout: page
title: "Internal Tools"
permalink: /manual/internalTools/
tags: [Internal Tools, fastq, tool, tools, format, bam, sam, fasta, vcf]
description: Internal tools documentation page
---
In TOGGLE, we developed also home made tools for different processes. The following functions can be accessed using *toggleGenerator*.

1. [fastqUtils Tools](#fastqUtils)
2. [checkFormat Tools](#checkFormat)


## <a name="fastqUtils"> </a>fastqUtils Tools

### checkFormatByASCIIcontrol
This module checks the FASTQ encoding level (64 or 33 PHRED) of a given file (plain text or gzip). 
The block provides a log file indicating if the encoding is 33 PHRED or not.

<br/>

## <a name="checkFormat"> </a>checkFormat Tools

### checkFormatFasta

This function checks if a file is really a FASTA file (accepting the degenerated IUPAC code).
The block returns a log file indicating if the FASTA file is a correct one and report the lines with errors.
Note: the system will stop after 20 errors are found.

### checkFormatFastq

This function checks if a file is really a FASTQ file.
The block returns a log file indicating if the FASTQ file is a correct one.

### checkFormatSamOrBam

This function checks if a file is really a SAM or BAM file.
The block returns a log file indicating if the SAM or BAM file is a correct one.

### checkFormatVcf

This function checks if a file is really a VCF v4+ file.
The block returns a log file indicating if the VCF file is a correct one.




