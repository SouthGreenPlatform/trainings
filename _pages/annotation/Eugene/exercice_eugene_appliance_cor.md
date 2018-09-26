---
layout: page
title: "EGNEP run - PGAA Montpellier"
permalink: /annotation/Eugene/exercice_eugene_appliance_cor/
tags: [ eugene, eukaryotic gene annotation pipeline ]
description: Reproducible run of Eugene eukaryotic pipeline on IFB cloud appliance
author: Stéphanie Bocs, Laurent Bouri, Jacques Dainat
date: 15/09/2018
---

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->

- [Goal of the exercice](#exercice)
- [Prerequisites](#prerequisites)
- [EGNEP run](#egnep-run)
- [Understanding EGNEP run](#understanding-egnep-run)
- [Understanding EGNEP results](#understanding-egnep-results)
- [EGNEP errors](#egnep-error)
- [EGNEP kill](#egnep-kill)
- [How to install EGNEP](#how-to-install-egnep)

<!-- /TOC -->

## Goal of the exercice

Annotate the genes of the whole Arabidopsis genome from the following dataset with Eugene-EP appliance / VM from IFB cloud

[Lineage (full): cellular organisms; Eukaryota; Viridiplantae; Streptophyta; Streptophytina; Embryophyta; Tracheophyta; Euphyllophyta; Spermatophyta; Magnoliophyta; Mesangiospermae; eudicotyledons; Gunneridae; Pentapetalae; rosids; malvids; Brassicales; Brassicaceae; Camelineae; Arabidopsis](https://www.ncbi.nlm.nih.gov/Taxonomy/Browser/wwwtax.cgi?id=3702)  

- 116M TAIR_genome.fasta (135 Mbp 5 chr)
- 30M TAIR_est2.fasta
RIKEN Arabidopsis full-length cDNA clones (RAFL clones) http://epd.brc.riken.jp/en/pdna/rafl_clones
- 8.3M uniprot_sp_viridiplantae_not_camelineae_short_header.fna
UniprotKB Swiss-Prot taxonomy:"Viridiplantae [33090]" NOT taxonomy:"Camelineae [980083]" => 23706
- 63M uniprot_trembl_brassiceae_short_header.fna
UniprotKB TrEMBL taxonomy:"Brassiceae 981071" => 171467


## Prerequisites

- You need an account on the IFB could. If you don't have any please refer to the following documentation:

<a target="_blank" href="{{ site.url }}/annotation/IFBcloud/create_IFB_cloud_user_account">Create a user account on the IFB cloud (if not already done)</a>

- You need to be connected to an EuGène appliance with **8 CPU et 32 Go de RAM**. If it is not the case, please refer to the following documentation:

<a target="_blank" href="{{ site.url }}/annotation/IFBcloud/use_IFB_cloud_appliance">Launch a Eugene-EP appliance on the IFB cloud</a>

## EGNEP run

From an Eugene IFB cloud appliance

### 1) Preparing your data

From your the root terminal of your appliance, index the databanks
{% highlight bash %}
	cd /root/bank_tair/
	makeblastdb -in TAIR_est2.fasta -dbtype nucl
	makeblastdb -in repbase20.05_aaSeq_cleaned_TE.fa -dbtype prot
	makeblastdb -in uniprot_sp_viridiplantae_not_camelineae_short_header.fna -dbtype prot -parse_seqids
	makeblastdb -in uniprot_trembl_brassiceae_short_header.fna -dbtype prot -parse_seqids
{% endhighlight %}

### 2) Running & checking
Run EGNEP (without --no_red option)
{% highlight bash %}
     cd
     nohup time $EGNEP/bin/int/egn-euk.pl --indir /root/input_dir/ --outdir /root/output_dir/ --cfg /root/bank_tair/egnep-test.cfg --workingdir /root/work_dir/ >& pipeline.txt &
{% endhighlight %}
Check the progress of the run
{% highlight bash %}
less pipeline.txt 
tail -f pipeline.txt

################################################################################
# /usr/bin/egnep-1.4/bin/int/egn-euk.pl --indir /root/input_dir/ --outdir /root/output_dir/ --cfg /root/bank_tair/egnep-test.cfg --workingdir /root/work_dir/
# EuGene Pipeline EUK - version 1.4
# EUGENEDIR /usr/bin/eugene-4.2a
# EGNEP /usr/bin/egnep-1.4
# Log file /root/work_dir/logger.1536944185.2045.txt
################################################################################
################################################################################

Create tree.....................................................................started
Create tree.....................................................................done
#########################  Protein database cleaning  ##########################
#####################  Protein sequence similarity search  #####################
BlastX uniprot_sp_viridiplantae_not_camelineae_short_header.fna uniprot_trembl_brassiceae_short_header.fnastarted
  BLASTX PARAMETERS=-outfmt 6 -evalue 0.01 -gapopen 9 -gapextend 2 -max_target_seqs 500000 -max_intron_length 15000  -seg yes
  UBLAST PARAMETERS=-threads 8 -evalue 1 -lopen 9 -lext 2 -accel 
{% endhighlight %}

## Understanding EGNEP run

#### 1) What are the value of environment variable $EGNEP and $EUGENEDIR ?

{% highlight bash %} 
echo $EGNEP 
/usr/bin/egnep-1.4
echo $EUGENEDIR 
/usr/bin/eugene-4.2a
{% endhighlight %}

#### 2) Where is the EGN-EP configuration file and how to set the data parameters ?

{% highlight bash %} 
gedit bank_tair/egnep-test.cfg &
blastx_db_list=1 2
blastx_db_1_file=/root/bank_tair/uniprot_sp_viridiplantae_not_camelineae_short_header.fna
blastx_db_2_file=/root/bank_tair/uniprot_trembl_brassiceae_short_header.fna
est_list=1
est_1_file=/root/bank_tair/TAIR_est2.fasta
repeat_sequence_db=/root/bank_tair/repbase20.05_aaSeq_cleaned_TE.fa
{% endhighlight %}

#### 3) Where is the EGN-EP executable?

{% highlight bash %} 
/usr/bin/egnep-1.4/bin/int/egn-euk.pl
{% endhighlight %}

#### 4) Where is the Log file?

{% highlight bash %} 
/root/work_dir/logger.1536944185.2045.txt
{% endhighlight %}

## Understanding EGNEP results

### EGN-EP

#### 1) Where are the analysis results of Chr4?

{% highlight bash %} 
/root/work_dir/0001/Chr4
ls *.gff3
Chr4.blast1.gff3  Chr4.est1.gff3        Chr4.masked.blastrep.gff3  Chr4.repet_noexpressed_nosimprot.gff3  Chr4.rnammer.gff3
Chr4.blast2.gff3  Chr4.ltrharvest.gff3  Chr4.red.gff3              Chr4.rfamscan.gff3                     Chr4.trnascan.gff3
{% endhighlight %}

#### 2) Where are the eugenev0.par and eugenev1.par and what are the difference?

{% highlight bash %} 
/root/work_dir/egn_param
diff eugenev0.par eugenev1.par 
< Sensor.AnnotaStruct.use 3
---
> AnnotaStruct.FileExtension[3]      repet_noexpressed_nosimprot
> AnnotaStruct.TranscriptFeature[3]  transcript
> AnnotaStruct.Start*[3]             0
> AnnotaStruct.StartType[3]          s
> AnnotaStruct.Stop*[3] 0
> AnnotaStruct.StopType[3] s
> AnnotaStruct.Acc*[3] 0
> AnnotaStruct.AccType[3] s
> AnnotaStruct.Don*[3] 0
> AnnotaStruct.DonType[3] s
> AnnotaStruct.TrStart*[3] 0
> AnnotaStruct.TrStartType[3] s
> AnnotaStruct.TrStop*[3] 0
> AnnotaStruct.TrStopType[3] s
> AnnotaStruct.TrStartNpc*[3] 0
> AnnotaStruct.TrStartNpcType[3] s
> AnnotaStruct.TrStopNpc*[3] 0
> AnnotaStruct.TrStopNpcType[3] s
> AnnotaStruct.Exon*[3] 0
> AnnotaStruct.Intron*[3] 1
> AnnotaStruct.CDS*[3] 0
> AnnotaStruct.npcRNA*[3]  0
> AnnotaStruct.Intergenic*[3]  2
> AnnotaStruct.format[3]             GFF3
> Sensor.AnnotaStruct.use 4
{% endhighlight %}

#### 3) Where is the report file?

{% highlight bash %} 
/root/output_dir
more report.1536944185.2045.txt 
## Transcriptome mapping information
Nb	transcriptome	seq_number	mapped_sequence_number(raw gmap result)	mapped_filtered_sequence_number(after filtering)	mapped_filtered_seque
nce__percentage
1	/root/bank_tair/TAIR_est2.fasta	20683	20668	20625	99.7

## Splicing sites read in the training dataset
Canonical acceptor	AG	72636 sites
Canonical donor	GT	71768 sites
Non canonical donor	GC	771 sites	1.1% of the canonical site number

## Arabidopsis Thaliana specific repeat domains
File=/root/work_dir/db/SpeciesRepeatDomain.fa
Repeat domain number=1274 Repeat domain length=684374 nt (0.6% of genomic sequences)

## LTR masking
LTR region length=2054544 nt (1.7% of genomic sequences)
## Red repeat predictions
Red region length=23443746 nt (19.6% of genomic sequences)

## Repeat regions (LTR + species specific repeat domains, where no expression and no protein similarity)
Repeat region number=10735 Repeat region length=21406343 nt (17.9% of genomic sequences)
{% endhighlight %}

#### 4) Where are the general statistics?

{% highlight bash %} 
/root/output_dir
root@machine068d5c96-f666-4443-aea3-7c6d0c83170a:~/output_dir# more sequences.general_statistics.xls
Number of nucleotides (without 'N')	119482012
	Per cent GC	36.06
Total number of genes	 25968
	Total nucleotides (bp)	51117321

** Protein coding genes
Number of protein coding genes	23786
	Mean gene length (bp)	2132.27
	Coding nucleotides (bp)	29924318
	Per cent genes with introns	78
	Per cent genes with five UTR	59
	Per cent genes with three UTR	65
Exons
	Mean number per gene	5.22
	Mean length (bp)	280.80
	GC per cent	42.85
Introns
	Mean number per gene	4.22
	Mean length (bp)	157.66
	GC per cent	32.52
CDS
	Mean length (bp)	1258.06
	Min length (bp)	123.00
	Max length (bp)	15234.00
	GC per cent	44.14
five_prime_UTR
	Mean length (bp)	131.84
	GC per cent	38.45
three_prime_UTR
	Mean length (bp)	201.22
	GC per cent	33.01

** Non protein coding genes
Number of non protein coding genes	2182
	Mean ncRNA gene length (bp)	182.93
	Min length (bp) 39
	Max length (bp) 7615
	GC per cent	46.45
	Per cent ncRNA genes with introns	 0
	Mean exon number per ncRNA gene	1.00

** Intergenic (inter protein-coding genes)
	Mean length	2639.79
	GC per cent	33.26
{% endhighlight %}

#### 5) Where are the gene annotation file and the polypeptide sequence file?

{% highlight bash %} 
/root/output_dir
root@machine068d5c96-f666-4443-aea3-7c6d0c83170a:~/output_dir# more sequences.gff3 
##gff-version 3
##sequence-region Chr1 1 30427671
Chr1	EuGene	gene	3634	5894	.	+	.	ID=gene:Chr1g0000001;Name=Chr1g0000001
Chr1	EuGene	mRNA	3634	5894	.	+	.	ID=mRNA:Chr1g0000001;Name=Chr1g0000001;Parent=gene:Chr1g0000001
Chr1	EuGene	exon	3634	3913	.	+	.	ID=exon:Chr1g0000001.1;Parent=mRNA:Chr1g0000001
Chr1	EuGene	exon	3996	4276	.	+	2	ID=exon:Chr1g0000001.2;Parent=mRNA:Chr1g0000001
Chr1	EuGene	exon	4486	4605	.	+	0	ID=exon:Chr1g0000001.3;Parent=mRNA:Chr1g0000001
Chr1	EuGene	exon	4706	5095	.	+	0	ID=exon:Chr1g0000001.4;Parent=mRNA:Chr1g0000001
Chr1	EuGene	exon	5174	5326	.	+	0	ID=exon:Chr1g0000001.5;Parent=mRNA:Chr1g0000001
Chr1	EuGene	exon	5439	5894	.	+	0	ID=exon:Chr1g0000001.6;Parent=mRNA:Chr1g0000001
Chr1	EuGene	five_prime_UTR	3634	3759	.	+	.	ID=five_prime_UTR:Chr1g0000001.0;Parent=mRNA:Chr1g0000001;est_cons=100.0;est_incons=0
.0
Chr1	EuGene	CDS	3760	3913	.	+	0	ID=CDS:Chr1g0000001.1;Parent=mRNA:Chr1g0000001;est_cons=100.0;est_incons=0.0
Chr1	EuGene	CDS	3996	4276	.	+	2	ID=CDS:Chr1g0000001.2;Parent=mRNA:Chr1g0000001;est_cons=100.0;est_incons=0.0
Chr1	EuGene	CDS	4486	4605	.	+	0	ID=CDS:Chr1g0000001.3;Parent=mRNA:Chr1g0000001;est_cons=100.0;est_incons=0.0
Chr1	EuGene	CDS	4706	5095	.	+	0	ID=CDS:Chr1g0000001.4;Parent=mRNA:Chr1g0000001;est_cons=100.0;est_incons=0.0
Chr1	EuGene	CDS	5174	5326	.	+	0	ID=CDS:Chr1g0000001.5;Parent=mRNA:Chr1g0000001;est_cons=100.0;est_incons=0.0
Chr1	EuGene	CDS	5439	5630	.	+	0	ID=CDS:Chr1g0000001.6;Parent=mRNA:Chr1g0000001;est_cons=100.0;est_incons=0.0
Chr1	EuGene	three_prime_UTR	5631	5894	.	+	.	ID=three_prime_UTR:Chr1g0000001.12;Parent=mRNA:Chr1g0000001;est_cons=100.0;est_incons
=0.0
grep -c '>' sequences_prot.fna 
23786
{% endhighlight %}

### Eugene

#### 6) Where to find and what is the command line to run eugene?

{% highlight bash %} 
/root/work_dir
more logger.1536944185.2045.txt
export PARALOOP=/usr/bin/egnep-1.4/bin/ext/paraloop ; /usr/bin/egnep-1.4/bin/ext/paraloop/bin/paraloop.pl --clean --wait --ncpus=7 --interleaved --program=Shell --input /root/work_dir/annotationV1//raw_eugene/EGN_ANNOT_1536944185.2045/eugene.cmd.paraloop --output /root/work_dir/annotationV1//raw_eugene/EGN_ANNOT_1536944185.2045/paraloop.output --clean > /dev/null 2>&1
more /root/work_dir/annotationV1//raw_eugene/EGN_ANNOT_1536944185.2045/eugene.cmd.paraloop
export EUGENEDIR=/usr/bin/eugene-4.2a; /usr/bin/eugene-4.2a/bin/eugene -A /root/work_dir/egn_param//eugenev1.par -m /root/work_dir/egn_param//eugene.mat -pg 
-O  /root/work_dir/annotationV1//raw_eugene/ /root/work_dir/0001/Chr1/Chr1 > /root/work_dir/annotationV1//raw_eugene/Chr1.eugene.stdout 2> /root/work_dir/ann
otationV1//raw_eugene/Chr1.eugene.stderr
export EUGENEDIR=/usr/bin/eugene-4.2a; /usr/bin/eugene-4.2a/bin/eugene -A /root/work_dir/egn_param//eugenev1.par -m /root/work_dir/egn_param//eugene.mat -pg 
-O  /root/work_dir/annotationV1//raw_eugene/ /root/work_dir/0001/Chr5/Chr5 > /root/work_dir/annotationV1//raw_eugene/Chr5.eugene.stdout 2> /root/work_dir/ann
otationV1//raw_eugene/Chr5.eugene.stderr
{% endhighlight %}

#### 7) Where are the intron parameters ?

{% highlight bash %}
/usr/bin/eugene-4.2a/models
root@machine068d5c96-f666-4443-aea3-7c6d0c83170a:/usr/bin/eugene-4.2a/models# more intron.dist 
40	0.0
41	0.0
{% endhighlight %}
If you change it you need to recompile (make; make install)

#### 8) Where are the splice signal WAM files?

{% highlight bash %}
/usr/bin/eugene-4.2a/models/WAM/plant
{% endhighlight %}

## EGNEP errors

### 1) Variables

The environment variables should be already set
{% highlight bash %} 
     # export EUGENEDIR=/usr/bin/eugene-4.2a
     # export EGNEP=/usr/bin/egnep-1.4
{% endhighlight %}
### 2) Index databanks

The database "/root/bank_tair/uniprot-thaliana_swiss2.fasta" does not exist or isn't indexed. (Use 'makeblastdb' program to index).

The database "/root/bank_tair/uniprot-thaliana_trembl2.fasta" does not exist or isn't indexed. (Use 'makeblastdb' program to index).

For software licence reasons, transfer the transposable element polypeptide file, for instance
{% highlight bash %}
     Downloads SIDIBEBOCS$ scp repbase20.05_aaSeq_cleaned_TE.fa root@134.158.247.40:/root/bank_tair/
{% endhighlight %}

### 3) Program missing

=>The value of the parameter prg_rnammer is >/usr/bin/egnep-1.4/bin/ext/rnammer< which is not a name of an existing and non empty file at /usr/bin/egnep-1.4/bin/int/egn-euk.pl line 2207.
Command exited with non-zero status 25

{% highlight bash %}
cd /usr/bin/egnep-1.4/bin/ext/
lrwxrwxrwx  1 root   root        17 Aug 27 15:14 bedtools2 -> bedtools2-2.24.0/
drwxrwxr-x 11 root   root      4096 Aug 27 15:12 bedtools2-2.24.0
drwxr-xr-x  4 root   root      4096 Aug 27 15:12 bin
-rwxrwxr-x  1    339 ubuntu   55318 Feb 24  2017 BioFileConverter.pl
drwxrwxr-x  5    339 ubuntu    4096 Feb 24  2017 blast-2.2.26
-rwxrwxr-x  1    339 ubuntu    2509 Feb 24  2017 convert_rfam2gff3.pl
-rwxrwxr-x  1    339 ubuntu    2280 Feb 24  2017 convert_rnammer2gff3.pl
-rwxrwxr-x  1    339 ubuntu    2813 Feb 24  2017 convert_trnascan2gff3.pl
lrwxrwxrwx  1 root   root        17 Aug 27 15:12 genometools -> genometools-1.5.6
drwxrwxr-x 15 root   root      4096 Aug 27 15:12 genometools-1.5.6
lrwxrwxrwx  1 root   root        15 Aug 27 15:22 gmap -> gmap-2017-02-15
drwxr-xr-x  7  11414   1279    4096 Aug 27 15:22 gmap-2017-02-15
drwxrwxr-x 13 990287  93203    4096 Mar  4  2015 hmmer-3.1b2-linux-intel-x86_64
drwxr-xr-x  3 root   root      4096 Aug 27 15:12 include
drwxr-xr-x 10  41650  93203    4096 Aug 27 15:08 infernal-1.1.1
drwxr-xr-x  3   2314 cdrom     4096 Jul  4  2006 lib
-rwxr-xr-x  1   2314 cdrom        0 Jul 24  2007 LICENSE
-rwxrwxr-x  1    339 ubuntu    9931 Feb 24  2017 lipm_bed_filter.pl
-rwxrwxr-x  1    339 ubuntu    3351 Feb 24  2017 lipm_bed_split_by_sequence.pl
-rwxrwxr-x  1    339 ubuntu   26402 Feb 24  2017 lipm_bed_to_expr.pl
-rwxrwxr-x  1    339 ubuntu    6591 Feb 24  2017 lipm_bed_to_gff3.pl
-rwxrwxr-x  1    339 ubuntu    4284 Feb 24  2017 lipm_dbprot_remove_repbase.pl
-rwxrwxr-x  1    339 ubuntu    1600 Feb 24  2017 lipm_fasta2overlappingwins.pl
-rwxrwxr-x  1    339 ubuntu   15028 Feb 24  2017 lipm_fasta2tree.pl
-rwxrwxr-x  1    339 ubuntu   10965 Feb 24  2017 lipm_fastafilter.pl
-rwxrwxr-x  1    339 ubuntu    3700 Feb 24  2017 lipm_fastasplitter.pl
-rwxrwxr-x  1    339 ubuntu   18852 Feb 24  2017 lipm_genome_statistics.pl
-rwxrwxr-x  1    339 ubuntu   12125 Feb 24  2017 lipm_m8_to_gff3.pl
-rwxrwxr-x  1    339 ubuntu    5885 Feb 24  2017 lipm_m8tom8plus.pl
-rwxrwxr-x  1    339 ubuntu    7770 Feb 24  2017 lipm_N50.pl
-rwxrwxr-x  1    339 ubuntu 1047496 Feb 24  2017 lipm_nrdb
-rwxrwxr-x  1    339 ubuntu    1172 Feb 24  2017 lipm_smp.pl
-rwxrwxr-x  1    339 ubuntu   13886 Feb 24  2017 lipm_transfer_gff3_attributes.pl
-rwxrwxr-x  1    339 ubuntu   10551 Feb 24  2017 lipm_wig_to_expr.pl
-rwxrwxr-x  1    339 ubuntu    9792 Feb 24  2017 MapWithBlast.pl
lrwxrwxrwx  1 root   root        18 Aug 27 15:14 ncbi-blast -> ncbi-blast-2.2.31+
drwxr-xr-x  4  11236  13030    4096 Jun  2  2015 ncbi-blast-2.2.31+
lrwxrwxrwx  1    339 ubuntu      13 Feb 24  2017 paraloop -> paraloop-1.3/
drwxrwxr-x  7    339 ubuntu    4096 Feb 24  2017 paraloop-1.3
lrwxrwxrwx  1 root   root         9 Aug 27 15:22 red -> redUnix64
drwxr-x---  2  10194  10194    4096 Jun 18  2015 redUnix64
-rwxr-xr-x  1   2314 cdrom        0 Aug 27 15:22 rnammer
-rw-r--r--  1 root   root         0 Feb  5  2015 rnammer-1.2.src.tar.Z
-rwxr-xr-x  1   2314 cdrom     8849 Aug 27 15:22 rnammere
drwxr-xr-x  4 root   root      4096 Aug 27 15:10 share
lrwxrwxrwx  1    339 ubuntu      17 Feb 24  2017 tRNAscan-SE -> tRNAscan-SE-1.3.1
drwxr-x---  5   2841 users     4096 Aug 27 15:08 tRNAscan-SE-1.3.1
-rw-r--r--  1 root   root    740960 Jun 16 07:54 tRNAscan-SE.tar.gz
lrwxrwxrwx  1 root   root        24 Aug 27 15:22 usearch -> usearch9.2.64_i86linux32
-rwxr-xr-x  1 root   root         0 Aug 27 15:22 usearch9.2.64_i86linux32
-rwxr-xr-x  1   2314 cdrom        0 Feb  6  2007 xml2fsa
-rwxr-xr-x  1   2314 cdrom        0 May 22  2007 xml2gff
     # rm rnammer
     # mv rnammere rnammer
{% endhighlight %}

=>The value of the parameter prg_usearch is >/usr/bin/egnep-1.4/bin/ext/usearch< which is not a name of an existing and non empty file at /usr/bin/egnep-1.4/bin/int/egn-euk.pl line 2307.
Command exited with non-zero status 25
{% highlight bash %}
    scp sidibebocs@cc2-login.cirad.fr:/homedir/sidibebocs/work/ganoderma/egnep-1.4/bin/ext/usearch9.2.64_i86linux32 .
{% endhighlight %}

### 4) Red error

You can try with the no_red argument will disable the repeat-masking and thus will require less memory to run.
However, it is not recommanded to use this argument as it will potentially have negative effect on gene prediction.
{% highlight bash %}
nohup $EGNEP/bin/int/egn-euk.pl --no_red --indir /root/input_dir/ --outdir /root/output_dir/ --cfg /root/bank_tair/egnep-test.cfg --workingdir /root
/work_dir >& pipeline.txt &
{% endhighlight %}

### 5) Empty result file?

{% highlight bash %}
# more pipeline.txt 
nohup: ignoring input
################################################################################
################################################################################
# /usr/bin/egnep-1.4/bin/int/egn-euk.pl --indir /root/input_dir/ --outdir /root/output_dir/ --cfg /root/bank_tair/egnep-test.cfg --workingdir /root/work_dir/
# EuGene Pipeline EUK - version 1.4
# EUGENEDIR /usr/bin/eugene-4.2a
# EGNEP /usr/bin/egnep-1.4
# Log file /root/work_dir/logger.1535964229.7865.txt
################################################################################
################################################################################

Create tree.....................................................................started
Create tree.....................................................................done
#########################  Protein database cleaning  ##########################
#####################  Protein sequence similarity search  #####################
BlastX uniprot-thaliana_swiss2.fasta uniprot-thaliana_trembl2.fasta.............started
  BLASTX PARAMETERS=-outfmt 6 -evalue 0.01 -gapopen 9 -gapextend 2 -max_target_seqs 500000 -max_intron_length 15000  -seg yes
  UBLAST PARAMETERS=-threads 8 -evalue 1 -lopen 9 -lext 2 -accel 1
/usr/bin/egnep-1.4/bin/ext/gmap/bin/gmap_build -d sequences -D /root/work_dir/db/GMAP_INDEX /root/work_dir/sequences 2> /root/work_dir/db/GMAP_INDEX/gmap_idx.7865.stde
BlastX uniprot-thaliana_swiss2.fasta uniprot-thaliana_trembl2.fasta.............done
###########################  Transcriptome mapping  ############################
Gmap TAIR_est2.fasta............................................................started
  PARAMETERS=-n0 -B 5 -t 8 -L 100000 --min-intronlength=35 -K 25000 --trim-end-exons=25 
  FILTERS=EST length percentage > 50, identity percentage > 95
Gmap TAIR_est2.fasta............................................................done
#############################  IMM model building  #############################
Build IMM models................................................................started
    BlastX TAIR_est2.fasta.filterlen300 uniprot-thaliana_swiss2.fasta...........started
      PARAMETERS=-outfmt 6 -evalue 0.01 -gapopen 9 -gapextend 2 -max_target_seqs 500000 -max_intron_length 15000  -seg yes
    BlastX TAIR_est2.fasta.filterlen300 uniprot-thaliana_swiss2.fasta...........done
    BLASTX FILTERS= HSP_length > 100 AA, identity percentage > 50, e-value > 0.0001
    Gmap TAIR_est2.fasta.filterlen300...........................................started
      PARAMETERS=-n0 -B 5 -t 8 -L 100000 --min-intronlength=35 -K 25000 --trim-end-exons=25 
      FILTERS=EST length percentage > 95, identity percentage > 95
ERROR: no data to train eugene IMM (because no result for mapping of the reference transcriptome to the genomic sequence): choose an other reference transcriptome and launch again.
    Gmap TAIR_est2.fasta.filterlen300...........................................done
{% endhighlight %}

## EGNEP kill
You know the process identifier (PID = 26448)
{% highlight bash %}
     # nohup $EGNEP/bin/int/egn-euk.pl --no_red --indir /root/input_dir/ --outdir /root/output_dir/ --cfg /root/bank_tair/egnep-test.cfg --workingdir /root/work_dir >& pipeline.txt &
[1] 26448
{% endhighlight %}

You can see all the subprocesses
{% highlight bash %}
 ps -edf | grep egn
root      4507 26367  0 16:11 pts/0    00:00:00 grep --color=auto egn
root     26448 26367  0 15:47 pts/0    00:00:01 /usr/bin/perl /usr/bin/egnep-1.4/bin/int/egn-euk.pl --no_red --indir /root/input_dir/ --outdir /root/output_dir/ --cfg /root/bank_tair/egnep-test.cfg --workingdir /root/work_dir
root     31805 26697  0 15:55 pts/0    00:00:00 /usr/bin/perl /usr/bin/egnep-1.4/bin/int/get_BlastX.pl --sequence /root/work_dir/0001/Chr1/Chr1 --cfg /root/bank_tair/egnep-test.cfg --db /root/work_dir/db/uniprot-thaliana_trembl2.fasta --outfile /root/work_dir/0001/Chr1/Chr1.blast2 --workingdir /root/work_dir/0001/Chr1/work.1536421660.26448/
root     31806 31805  0 15:55 pts/0    00:00:00 /usr/bin/perl /usr/bin/egnep-1.4/bin/ext/MapWithBlast.pl --sequence /root/work_dir/0001/Chr1/Chr1 --db /root/work_dir/db/uniprot-thaliana_trembl2.fasta --output /root/work_dir/0001/Chr1/Chr1.blast2 --workingdir /root/work_dir/0001/Chr1/work.1536421660.26448/ --cfg /root/bank_tair/egnep-test.cfg
root     31807 31806  0 15:55 pts/0    00:00:00 sh -c export PARALOOP=/usr/bin/egnep-1.4/bin/ext/paraloop ; /usr/bin/egnep-1.4/bin/ext/paraloop/bin/paraloop.pl --clean --wait --ncpus=7 --interleaved --program=Shell --input /root/work_dir/0001/Chr1/work.1536421660.26448//BlastX.31806.1536422142/Chr1_cmd.31806.1536422142 --output /root/work_dir/0001/Chr1/work.1536421660.26448//BlastX.31806.1536422142/Chr1_cmd.31806.1536422142.output  --clean 
root     31808 31807  0 15:55 pts/0    00:00:00 /usr/bin/perl /usr/bin/egnep-1.4/bin/ext/paraloop/bin/paraloop.pl --clean --wait --ncpus=7 --interleaved --program=Shell --input /root/work_dir/0001/Chr1/work.1536421660.26448//BlastX.31806.1536422142/Chr1_cmd.31806.1536422142 --output /root/work_dir/0001/Chr1/work.1536421660.26448//BlastX.31806.1536422142/Chr1_cmd.31806.1536422142.output --clean
{% endhighlight %}
You need to kill at least
{% highlight bash %}
     # kill -9 26448
     # kill -9 26697
{% endhighlight %}
Before rerunning 
{% highlight bash %}
     # rm pipeline.txt 
     # rm -fr work_dir
     # mkdir work_dir
{% endhighlight %}

## How to install EGNEP

See [Eugene page of the Elixir GAA wiki](https://biosphere.france-bioinformatique.fr/wikia2/index.php/Eugene)
