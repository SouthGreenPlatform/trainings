---
layout: page
title: "Assembly and Annotation Course - Montpellier"
permalink: /annotation/MAKER/inspect_the_result/
tags: [ Annotation, MAKER, structural, elixir]
description: Annotation Practice page
author: Jacques Dainat
date: 14/09/2018
---

## Inspect the result

You have two options now for gathering the output from MAKER in some usable form - copy select files by hand to wherever you want them. Or you can use scripts that do the job for you.

MAKER comes with fasta_merge and gff3_merge scripts but we promote to use the script called 'maker\_merge\_outputs\_from\_datastore' from the [GAAS](https://github.com/NBISweden/GAAS) git repository already include in your VM (not with the appliance). Consequently you need to copy (rsync or scp) the genome.maker.output on your VM. Then if you are in the same folder where genome.maker.output is located you should be able to use this command:
{% highlight bash %}
maker_merge_outputs_from_datastore.pl 
{% endhighlight %}
This will create a directory called "**maker_output_processed**" containing:

\-annotations.proteins.fa 
\-maker_bopts.ctl  
\-maker_evm.ctl
\-maker_exe.ctl
\-maker_opts.ctl
\-mixup.gff
\-gff_by_type/  

 - ***mixup.gff* file**  

It's a mix of all the gff tracks produced/handled by maker. It contains the annotation done by maker mixed up with other gff lines like the protein alignments, repeats, etc..
If you use 'less' to read the annotation file *mixup.gff* ([GFF3 format](http://www.sequenceontology.org/gff3.shtml)), you will see a range of different features:
{% highlight bash %}
##gff-version 3  
chr4       .       contig  1       1351857 .       .       .       ID=4;Name=4
chr4       maker   gene    24134   25665   .       +       .       ID=maker-4-exonerate_protein2genome-gene-0.0;Name=maker-4-exonerate_protein2genome-gene-0.0
chr4       maker   mRNA    24134   25665   917     +       .       ID=maker-4-exonerate_protein2genome-gene-0.0-mRNA-1;Parent=maker-4-exonerate_protein2genome-gene-0.0;Name=maker-4-exonerate_protein2genome-gene-0.0-mRNA-1;_AED=0.09;_eAED=0.09;_QI=0|0.33|0.25|1|0|0|4|44|290
...
{% endhighlight %}

For example, the above lines read:

A new contig is being shown, with the id 'chr4' and a length of 1351857 nucleotides  
On this contig, a gene feature is located from position 24134 to 25665, on the plus strand and with the id 'maker-4-exonerate\_protein2genome-gene-0.0'. 
On this contig, belonging to the gene, is located a transcript from position 24134 to 25665, on the plus strand and with the id 'maker-4-exonerate\_protein2genome-gene-0.0-mRNA-1'. It's quality, or AED score, is 0.09 - which means that the evidence alignments are close to be in perfect agreement with the transcript model.

And so on.

 - ***annotations.proteins.fa* file**  
This file contains the proteins translated from the CDS of gene models predicted.

 - ***maker_\*.ctl* files**

 Those are backups in case you would like to remember in the future how you have used MAKER to get the corresponding results.

 - ***gff_by_type* directory**  
The different types of information present in the annotation file (mixup.gff) are separated into independent files into the "gff_by_type" directory.This is useful for a number of applications, like visualizing it as separate tracks in a genome browser. Or to compute some intersting numbers from the gene models.

This should contains a bunch of files, including '**maker.gff**' - which contains the actual gene models.
