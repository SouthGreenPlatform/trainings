---
layout: page
title: "S2: SNP Data Handling & Quality Control & S3 part: Distance Phylogenetic Tree"
permalink: /cocogeno_ictp4/S2_gigwa_flapjack_S3_taxonium/
tags: [ Genomic variations, INDEL, Gigwa, NoSQL, Web, Interoperability, individual phylogogenetic tree, SNP distance matrix, PCA, VCF, Flapjack, Hamap, JUKES-CANTOR, Newick, PLINK ]
description: This pratical introduces version 2.12 of Gigwa (Genotype Investigator for Genome-Wide Analyses)
author: Stéphanie Bocs
date: 25/03/2026
---

<table class="table-contact">
<tr>
<td><img width="60%" class="img-responsive" src="{{ site.url }}/images/trainings-gigwa.png" alt="" />
</td>
<td>
Hands on version 2.12 of Gigwa<br>
(Genotype Investigator for Genome-Wide Analyses)
</td>
</tr>
</table>

## Goal of this tutorial
* Session 2
  * SNP Data Handling & Quality Control.
  * Export VCF for session 3
* Part of session 3
  * Observe population diversity (170 individuals of coconut palm diversity panel) with a distance phylogenetic tree colored by a trait (coconut color).
* You will understand:
  * The benefits of using Gigwa.
  * How to use it.  
⚠️ For this tutorial, we will use the staging implementation of Gigwa (gigwa-dev), where are stored coconut databases.

## Gigwa documentation and links
* [Gigwa v2 article](https://doi.org/10.1186/s13742-016-0131-8) and citation
<pre>
Gigwa v2 - Extended and improved genotype investigator
Guilhem Sempéré; Adrien Pétel; Mathieu Rouard; Julien Frouin; Yann Hueber; F De Bellis; Pierre Larmande
GigaScience, Volume 8, Issue 5, May 2019, giz051
</pre>
* [Gigwa v2.12 – Documentation](https://gigwa.southgreen.fr/gigwa/docs/gigwa_docs.html)
* [Videos on how to use Gigwa](https://www.youtube.com/playlist?list=PLMHx16OgbKiObTprXWyYsn73EQa5-Bpza)

## Demo on the full private dataset

* How the raw VCF looks like  
49G FF68_CN_170ea.vcf.gz

{% highlight bash %}
##fileformat=VCFv4.2
##ALT=<ID=NON_REF,Description="Represents any possible alternative allele not already represented at this location by REF and ALT">
##FILTER=<ID=LowQual,Description="Low quality">
##FORMAT=<ID=AD,Number=R,Type=Integer,Description="Allelic depths for the ref and alt alleles in the order listed">
##FORMAT=<ID=DP,Number=1,Type=Integer,Description="Approximate read depth (reads with MQ=255 or with bad mates are filtered)">
##FORMAT=<ID=GQ,Number=1,Type=Integer,Description="Genotype Quality">
##FORMAT=<ID=GT,Number=1,Type=String,Description="Genotype">
##FORMAT=<ID=MIN_DP,Number=1,Type=Integer,Description="Minimum DP observed within the GVCF block">
##FORMAT=<ID=PGT,Number=1,Type=String,Description="Physical phasing haplotype information, describing how the alternate alleles are phased in relation to one another; will always be heterozygous and is not intended to describe called alleles">
##FORMAT=<ID=PID,Number=1,Type=String,Description="Physical phasing ID information, where each unique ID within a given sample (but not across samples) connects records within a phasing group">
##FORMAT=<ID=PL,Number=G,Type=Integer,Description="Normalized, Phred-scaled likelihoods for genotypes as defined in the VCF specification">
...
##contig=<ID=1,length=173652922>
##contig=<ID=2,length=163495435>
##contig=<ID=3,length=162606868>
##contig=<ID=4,length=142141205>
##contig=<ID=5,length=150795600>
##contig=<ID=6,length=135242429>
##contig=<ID=7,length=137336685>
##contig=<ID=8,length=171529932>
##contig=<ID=9,length=130416533>
##contig=<ID=10,length=203275661>
##contig=<ID=11,length=177134676>
##contig=<ID=12,length=93961403>
##contig=<ID=13,length=87523642>
##contig=<ID=14,length=168523987>
##contig=<ID=15,length=82895430>
##contig=<ID=16,length=81497861>
##source=CombineGVCFs
##source=GenotypeGVCFs
##source=HaplotypeCaller
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO    FORMAT  FF68_CN1        FF68_CN10       FF68_CN100      FF68_CN101      FF68_CN102         FF68_CN103      FF68_CN104      FF68_CN105      FF68_CN106      FF68_CN107      FF68_CN108      FF68_CN109      FF68_CN11       FF68_CN110         FF68_CN111      FF68_CN112      FF68_CN113      FF68_CN114      FF68_CN115      FF68_CN116      FF68_CN117      FF68_CN118      FF68_CN119         FF68_CN12       FF68_CN120      FF68_CN121      FF68_CN122      FF68_CN123      FF68_CN124      FF68_CN125      FF68_CN126      FF68_CN127         FF68_CN128      FF68_CN129      FF68_CN13       FF68_CN130      FF68_CN131      FF68_CN132      FF68_CN133      FF68_CN134      FF68_CN135         FF68_CN136      FF68_CN137      FF68_CN138      FF68_CN139      FF68_CN14       FF68_CN140      FF68_CN141      FF68_CN142      FF68_CN143         FF68_CN144      FF68_CN145      FF68_CN146      FF68_CN147      FF68_CN148      FF68_CN149      FF68_CN15       FF68_CN150      FF68_CN151         FF68_CN152      FF68_CN153      FF68_CN154      FF68_CN155      FF68_CN156      FF68_CN157      FF68_CN158      FF68_CN159      FF68_CN16          FF68_CN160      FF68_CN161      FF68_CN162      FF68_CN163      FF68_CN164      FF68_CN165      FF68_CN166      FF68_CN167      FF68_CN168         FF68_CN169      FF68_CN17       FF68_CN170      FF68_CN18       FF68_CN19       FF68_CN2        FF68_CN20       FF68_CN21       FF68_CN22          FF68_CN23       FF68_CN24       FF68_CN25       FF68_CN26       FF68_CN27       FF68_CN28       FF68_CN29       FF68_CN3        FF68_CN30          FF68_CN31       FF68_CN32       FF68_CN33       FF68_CN34       FF68_CN35       FF68_CN36       FF68_CN37       FF68_CN38       FF68_CN39          FF68_CN4        FF68_CN40       FF68_CN41       FF68_CN42       FF68_CN43       FF68_CN44       FF68_CN45       FF68_CN46       FF68_CN47          FF68_CN48       FF68_CN49       FF68_CN5        FF68_CN50       FF68_CN51       FF68_CN52       FF68_CN53       FF68_CN54       FF68_CN55        FF68_CN56       FF68_CN57       FF68_CN58       FF68_CN59       FF68_CN6        FF68_CN60       FF68_CN61       FF68_CN62       FF68_CN63          FF68_CN64       FF68_CN65       FF68_CN66       FF68_CN67       FF68_CN68       FF68_CN69       FF68_CN7        FF68_CN70       FF68_CN71          FF68_CN72       FF68_CN73       FF68_CN74       FF68_CN75       FF68_CN76       FF68_CN77       FF68_CN78       FF68_CN79       FF68_CN8           FF68_CN80       FF68_CN81       FF68_CN82       FF68_CN83       FF68_CN84       FF68_CN85       FF68_CN86       FF68_CN87       FF68_CN88          FF68_CN89       FF68_CN9        FF68_CN90       FF68_CN91       FF68_CN92       FF68_CN93       FF68_CN94       FF68_CN95       FF68_CN96          FF68_CN97       FF68_CN98       FF68_CN99
1       8752    .       C       T       421.76  .       AC=4;AF=1.00;AN=4;DP=4;ExcessHet=0.0000;FS=0.000;MLEAC=65;MLEAF=1.00;MQ=23.34;QD=25.36;SOR=1.179   GT:AD:DP:GQ:PGT:PID:PL:PS       ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.        ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.        ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.        ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.        ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     1|1:0,1:1:3:1|1:8752_C_T:45,3,0:8752       ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.        ./.     ./.     ./.     ./.     1|1:0,2:2:6:1|1:8752_C_T:90,6,0:8752    ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.        ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.        ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.:1,0:1:0:.:.:0,0,0      ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.        ./.     ./.     ./.     ./.
...
1       9459    .       A       G       3462.94 .       AC=44;AF=1.00;AN=44;DP=83;ExcessHet=0.0000;FS=0.000;InbreedingCoeff=0.3486;MLEAC=260;MLEAF=1.00;MQ=34.94;QD=26.00;SOR=1.096        GT:AD:DP:GQ:PGT:PID:PL:PS       ./.:2,0:2:0:.:.:0,0,0   ./.     ./.:2,0:2:0:.:.:0,0,0   1|1:0,2:2:6:1|1:9459_A_G:73,6,0:9459       1/1:0,2:2:6:.:.:57,6,0  ./.:1,0:1:0:.:.:0,0,0   ./.:2,0:2:0:.:.:0,0,0   ./.     1/1:0,2:2:6:.:.:74,6,0  ./.:2,0:2:0:.:.:0,0,0      1/1:0,2:2:6:.:.:73,6,0  ./.     ./.     1/1:0,3:3:9:.:.:108,9,0 1/1:0,2:2:6:.:.:75,6,0  ./.:1,0:1:0:.:.:0,0,0   1/1:0,2:2:6:.:.:90,6,0  ./.        1/1:0,1:1:3:.:.:45,3,0  ./.     ./.     1/1:0,2:2:6:.:.:90,6,0  ./.     ./.     ./.     ./.:1,0:1:0:.:.:0,0,0   ./.     ./.     ./.     ./.        ./.     ./.     ./.     ./.     ./.     ./.     ./.:1,0:1:0:.:.:0,0,0   ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.        ./.     ./.     ./.     ./.     1/1:0,1:1:3:.:.:45,3,0  ./.     ./.     ./.     1/1:0,2:2:6:.:.:90,6,0  ./.:2,0:2:0:.:.:0,0,0   ./.:1,0:1:0:.:.:0,0,0      ./.     ./.     1|1:0,2:2:6:1|1:9459_A_G:90,6,0:9459    ./.     ./.     ./.     ./.:4,0:4:0:.:.:0,0,0   ./.     ./.:1,0:1:0:.:.:0,0,0      ./.:1,0:1:0:.:.:0,0,0   1/1:0,2:2:6:.:.:57,6,0  ./.     1/1:0,2:2:6:.:.:73,6,0  ./.     ./.     ./.     ./.     ./.     ./.:1,0:1:0:.:.:0,0,0      ./.     ./.     ./.:1,0:1:0:.:.:0,0,0   ./.     ./.     ./.     ./.     ./.     ./.     ./.:1,0:1:0:.:.:0,0,0   ./.     ./.     ./.:1,0:1:0:.:.:0,0,0      ./.     ./.     ./.     ./.:1,0:1:0:.:.:0,0,0   ./.     1/1:0,2:2:6:.:.:57,6,0  ./.     1/1:0,2:2:6:.:.:84,6,0  ./.     ./.     ./.        ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.:1,0:1:0:.:.:0,0,0   1/1:0,1:1:3:.:.:42,3,0  ./.     ./.     ./.        ./.     ./.     ./.     ./.     ./.     ./.:2,0:2:0:.:.:0,0,0   ./.     ./.     ./.     ./.     ./.     ./.     1/1:0,1:1:3:.:.:42,3,0  ./.        ./.     ./.     ./.     ./.     ./.     ./.     ./.     ./.:1,0:1:0:.:.:0,0,0   ./.:1,0:1:0:.:.:0,0,0   ./.     ./.:1,0:1:0:.:.:0,0,0   ./.        ./.     ./.:2,0:2:0:.:.:0,0,0   1/1:0,1:1:3:.:.:45,3,0  ./.     ./.     ./.     ./.     ./.     ./.:1,0:1:0:.:.:0,0,0   1/1:0,2:2:6:.:.:76,6,0     ./.     ./.:1,0:1:0:.:.:0,0,0   ./.     ./.     ./.     ./.     ./.:2,0:2:0:.:.:0,0,0   ./.     ./.     ./.     ./.     ./.     ./.     ./.        1/1:0,2:2:6:.:.:71,6,0  1/1:0,1:1:3:.:.:45,3,0  ./.     ./.     ./.:1,0:1:0:.:.:0,0,0   ./.:1,0:1:0:.:.:0,0,0
1       12331   .       G       A       791.51  .       AC=18;AF=0.055;AN=328;BaseQRankSum=-8.420e01;DP=1010;ExcessHet=0.0000;FS=16.375;InbreedingCoeff=0.3359;MLEAC=16;MLEAF=0.049;MQ=27.65;MQRankSum=-1.645e+00;QD=11.64;ReadPosRankSum=0.00;SOR=2.613  GT:AD:DP:GQ:PL  0/0:6,0:6:18:0,18,193   0/0:10,0:10:30:0,30,238    0/0:7,0:7:21:0,21,251   0/0:3,0:3:9:0,9,119     0/0:9,0:9:27:0,27,324   0/0:4,0:4:12:0,12,155   0/0:7,0:7:21:0,21,211   0/0:5,0:5:15:0,15,181      0/0:2,0:2:6:0,6,46      0/0:3,0:3:9:0,9,88      0/0:7,0:7:21:0,21,222   0/0:5,0:5:15:0,15,154   0/0:10,0:10:30:0,30,350 0/0:7,0:7:21:0,21,266      0/0:2,0:2:6:0,6,78      0/0:2,0:2:6:0,6,78      0/0:12,0:12:36:0,36,413 0/0:4,0:4:12:0,12,161   0/0:9,0:9:21:0,21,315   0/0:8,0:8:24:0,24,251      0/0:6,0:6:18:0,18,205   0/0:8,0:8:24:0,24,285   0/0:2,0:2:6:0,6,75      0/0:3,0:3:9:0,9,79      0/0:5,0:5:15:0,15,187   0/0:4,0:4:12:0,12,155      ./.:1,0:1:0:0,0,0       0/0:7,0:7:21:0,21,236   0/0:4,0:4:12:0,12,163   0/0:4,0:4:12:0,12,159   0/0:5,0:5:15:0,15,192   0/1:3,2:5:42:42,0,102      0/0:11,0:11:33:0,33,390 0/0:7,0:7:21:0,21,233   0/0:3,0:3:9:0,9,83      0/1:3,2:5:47:47,0,95    0/1:4,2:6:31:31,0,97    0/1:4,2:6:31:31,0,110      0/0:2,0:2:6:0,6,78      0/0:6,0:6:18:0,18,224   ./.:4,0:4:0:0,0,92      0/0:6,0:6:18:0,18,209   0/0:6,0:6:18:0,18,241   0/1:3,2:5:37:37,0,98       0/0:1,0:1:3:0,3,39      0/0:5,0:5:15:0,15,176   0/0:6,0:6:18:0,18,211   0/0:2,0:2:6:0,6,82      0/0:2,0:2:6:0,6,49      1/1:0,6:6:18:167,18,0      0/0:4,0:4:12:0,12,144   0/0:12,0:12:36:0,36,416 0/0:6,0:6:18:0,18,201   0/0:4,0:4:12:0,12,127   0/0:4,0:4:12:0,12,108   0/0:9,0:9:27:0,27,301      0/0:9,0:9:27:0,27,279   0/0:6,0:6:18:0,18,178   0/0:1,0:1:3:0,3,30      0/0:3,0:3:9:0,9,119     0/0:4,0:4:12:0,12,154   0/0:3,0:3:9:0,9,119        0/0:6,0:6:18:0,18,211   0/0:12,0:12:36:0,36,352 0/0:8,0:8:24:0,24,259   0/0:3,0:3:9:0,9,88      0/0:2,0:2:6:0,6,79      0/0:12,0:12:36:0,36,401    0/0:4,0:4:12:0,12,158   0/0:8,0:8:24:0,24,258   0/0:4,0:4:12:0,12,115   0/0:5,0:5:15:0,15,190   0/0:6,0:6:18:0,18,209   0/0:7,0:7:21:0,21,246      1/1:0,7:7:21:189,21,0   0/0:4,0:4:12:0,12,155   0/0:4,0:4:12:0,12,127   0/0:3,0:3:9:0,9,120     0/0:6,0:6:18:0,18,148   0/0:4,0:4:12:0,12,117      0/0:7,0:7:21:0,21,241   0/0:3,0:3:9:0,9,91      0/0:5,0:5:15:0,15,199   0/0:4,0:4:12:0,12,154   0/0:7,0:7:21:0,21,239   ./.:1,0:1:0:0,0,0  0/0:10,0:10:30:0,30,401 0/0:5,0:5:15:0,15,158   0/0:15,0:15:42:0,42,630 0/0:12,0:12:36:0,36,397 0/0:3,0:3:9:0,9,110     0/0:10,0:10:30:0,30,348    0/0:7,0:7:21:0,21,220   0/0:6,0:6:18:0,18,184   0/0:4,0:4:12:0,12,132   0/0:10,0:10:30:0,30,384 ./.:1,0:1:0:0,0,0       0/0:7,0:7:21:0,21,258      0/0:4,0:4:12:0,12,137   0/1:5,5:10:95:95,0,106  1/1:0,2:2:6:58,6,0      0/0:4,0:4:12:0,12,166   0/1:3,3:6:64:64,0,68    0/0:6,0:6:18:0,18,206      0/0:7,0:7:21:0,21,243   0/0:6,0:6:12:0,12,180   0/0:15,0:15:45:0,45,449 ./.:3,0:3:0:0,0,42      0/0:8,0:8:24:0,24,256   0/0:7,0:7:21:0,21,208      0/0:7,0:7:21:0,21,217   0/0:11,0:11:33:0,33,325 0/1:2,2:4:47:47,0,60    1/1:0,4:4:12:111,12,0   0/0:7,0:7:21:0,21,224   0/0:3,0:3:9:0,9,122        0/0:8,0:8:24:0,24,245   0/0:6,0:6:18:0,18,181   ./.:2,0:2:0:0,0,0       0/0:3,0:3:9:0,9,104     1/1:0,2:2:6:49,6,0      0/0:6,0:6:18:0,18,242      0/0:12,0:12:36:0,36,397 0/0:9,0:9:27:0,27,265   0/0:10,0:10:30:0,30,350 0/0:8,0:8:24:0,24,294   0/0:7,0:7:18:0,18,270   0/0:9,0:9:27:0,27,338      0/0:9,0:9:27:0,27,341   0/0:12,0:12:36:0,36,418 0/0:4,0:4:12:0,12,156   0/0:10,0:10:30:0,30,279 0/0:5,0:5:15:0,15,199   0/0:9,0:9:27:0,27,330      0/0:4,0:4:12:0,12,155   0/0:9,0:9:24:0,24,360   0/0:4,0:4:12:0,12,130   0/0:7,0:7:21:0,21,226   0/0:4,0:4:12:0,12,99    0/0:6,0:6:18:0,18,221      0/0:4,0:4:12:0,12,125   0/0:15,0:15:45:0,45,452 0/0:4,0:4:12:0,12,124   0/0:4,0:4:12:0,12,127   0/0:9,0:9:27:0,27,297   0/0:9,0:9:27:0,27,356      0/0:4,0:4:12:0,12,159   0/0:5,0:5:15:0,15,200   0/0:10,0:10:30:0,30,301 0/0:5,0:5:12:0,12,180   0/0:3,0:3:9:0,9,120     0/0:9,0:9:24:0,24,360      0/0:1,0:1:3:0,3,39      0/0:6,0:6:18:0,18,215   0/0:4,0:4:12:0,12,153   0/0:6,0:6:18:0,18,182   0/0:8,0:8:24:0,24,257   0/0:9,0:9:27:0,27,237      0/0:3,0:3:9:0,9,119     0/0:7,0:7:21:0,21,225   0/0:10,0:10:30:0,30,349 0/0:3,0:3:9:0,9,96      0/0:5,0:5:15:0,15,157   0/0:5,0:5:15:0,15,194      0/0:5,0:5:15:0,15,168   0/0:6,0:6:18:0,18,228   0/0:3,0:3:9:0,9,110     0/0:3,0:3:9:0,9,87      0/0:8,0:8:24:0,24,293   0/0:5,0:5:15:0,15,162
{% endhighlight %}

* [Gigwa v2.12 staging private](https://gigwa-dev.southgreen.fr/gigwaV2/login.do)

## Hands-on on the light dataset 
[Gigwa v2.12 staging public](https://gigwa-dev.southgreen.fr/gigwaV2/)
  
## How was preparated this light dataset ?
Successive filters have been applied to reduce the VCF:
* Take only one harm of chromosomes 10, 11 and 14.
* Keep only SNP markers (remove INDELs)
* Remove monomorphic SNPs
* Keep only biallelic SNPs

## S2: SNP handling quality control with Gigwa

### SNP filters on the full dataset of the light coconut database

1. Accept the terms of Gigwa use and choose the 'Coconut_KU' Database  
<img width="100%" src="{{ site.url }}/images/ictp4/gigwa_s2_1.png" alt="" />
1. Choose to investigate genotypes 'on 1 group', click on 'Enable browse and export' and then click on search  
<img width="50%" src="{{ site.url }}/images/ictp4/gigwa_s2_2.png" alt="" />
<img width="50%" src="{{ site.url }}/images/ictp4/gigwa_s2_3.png" alt="" />
1. Observe the total SNP number (53056) and then select only the SNP marker (filter 1)  
<img width="100%" src="{{ site.url }}/images/ictp4/gigwa_s2_4.png" alt="" />
1. Observe the SNP number (F1: 48133) and then select only the biallelic SNPs (filter 2)   
<img width="100%" src="{{ site.url }}/images/ictp4/gigwa_s2_5.png" alt="" />
1. Observe the SNP number (F1-F2: 47122) and then select less or equal to 5% of missing data (filter 3)  
<img width="100%" src="{{ site.url }}/images/ictp4/gigwa_s2_6.png" alt="" />
1. Observe the SNP number (F1-F3: 34872) and then select less or equal to 5% of MAF (Minor Allele Frequency; filter 4)  
<img width="100%" src="{{ site.url }}/images/ictp4/gigwa_s2_7.png" alt="" />
1. Observe the final SNP number with these filters (F1-F4: 16548) and then click on alleles of on line to display the variant details (e.g. genotypes)  
<img width="100%" src="{{ site.url }}/images/ictp4/gigwa_s2_8.png" alt="" />  
<img width="100%" src="{{ site.url }}/images/ictp4/gigwa_s2_9.png" alt="" />

### Quality control on the light coco db chr 14 arm

1. Accept the Gigwa terms and choose your database
Blabla
1. Chose to investigate one group and click search and browse
pdofgjfop
1. Chose SNP marker and filter

### Visual inspection on the light coco db chr 14:147336001..150373000


## S3 part: individual phylogogenetic tree based on SNP distance matrix
