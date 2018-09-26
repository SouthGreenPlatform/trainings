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

### EGN-EP

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

### Eugene

#### 4) Where is the eugene executable?

{% highlight bash %} 
/usr/bin/eugene-4.2a/bin/eugene
{% endhighlight %}

#### 1) Where to find and what is the command line to run eugene?

{% highlight bash %} 

{% endhighlight %}

#### 3) Where are the splice signal WAM files?

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
