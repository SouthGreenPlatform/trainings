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
Demo and Hands-on coconut pangenomic data with Gigwa (version 2.12) <br>
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

* How the raw VCF file looks like on an hardware infrastructure (server or high performance computing data center) because it is too big to be stored on a personnal computer: size of FF68_CN_170ea.vcf.gz is **49 Gb**!
[Variant Call Format (VCF) Version 4.2 Specification](https://samtools.github.io/hts-specs/VCFv4.2.pdf)

{% highlight bash %}
$ less FF68_CN_170ea.vcf.gz
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
#CHROM  POS     ID      REF     ALT     QUAL    FILTER  INFO    FORMAT  FF68_CN1        FF68_CN10       FF68_CN100      FF68_CN101      FF68_CN102         FF68_CN103      FF68_CN104      FF68_CN105      FF68_CN106      FF68_CN107      
1       9459    .       A       G       3462.94 .       AC=44;AF=1.00;AN=44;DP=83;ExcessHet=0.0000;FS=0.000;InbreedingCoeff=0.3486;MLEAC=260;MLEAF=1.00;MQ=34.94;QD=26.00;SOR=1.096        GT:AD:DP:GQ:PGT:PID:PL:PS       ./.:2,0:2:0:.:.:0,0,0   ./.     ./.:2,0:2:0:.:.:0,0,0   1|1:0,2:2:6:1|1:9459_A_G:73,6,0:9459       1/1:0,2:2:6:.:.:57,6,0  ./.:1,0:1:0:.:.:0,0,0   ./.:2,0:2:0:.:.:0,0,0   ./.     1/1:0,2:2:6:.:.:74,6,0  ./.:2,0:2:0:.:.:0,0,0      1/1:0,2:2:6:.:.:73,6,0
1       12331   .       G       A       791.51  .       AC=18;AF=0.055;AN=328;BaseQRankSum=-8.420e01;DP=1010;ExcessHet=0.0000;FS=16.375;InbreedingCoeff=0.3359;MLEAC=16;MLEAF=0.049;MQ=27.65;MQRankSum=-1.645e+00;QD=11.64;ReadPosRankSum=0.00;SOR=2.613  GT:AD:DP:GQ:PL  0/0:6,0:6:18:0,18,193   0/0:10,0:10:30:0,30,238    0/0:7,0:7:21:0,21,251   0/0:3,0:3:9:0,9,119     0/0:4,0:4:12:0,12,155   ./.:1,0:1:0:0,0,0       0/0:7,0:7:21:0,21,236   0/1:3,2:5:42:42,0,102      0/0:11,0:11:33:0,33,390 0/1:3,2:5:47:47,0,95          0/0:2,0:2:6:0,6,49      1/1:0,6:6:18:167,18,0
{% endhighlight %}
The GQ is the difference between the PL of the second most likely genotype, and the PL of the most likely genotype. As noted above, the values of the PLs are normalized so that the most likely PL is always 0, so the GQ ends up being equal to the second smallest PL, unless that PL is greater than 99.

* [Gigwa v2.12 staging private](https://gigwa-dev.southgreen.fr/gigwaV2/login.do)
Studied coconut genomic region 14:148815000..148900000
* How to choose the MAF (Minor Allele Frequency)  
Phenotyping summary information

| Fruit color  | color code | Ind nb with this color |
|--------------|------------|------------------------|
| Green        | 1          | 135                    |
| Yellow-green | 2          | 15                     |
| Brown        | 3          | 3                      |
| Orange       | 4          | 5                      |
| Yellow       | 5          | 9                      |
| Unknown (NA) | 0          | 3                      |
| Total number of individuals | | 170                    |

Compute the percentage for the less frequent color

| Less frequent color | color code | Ind nb with this color |  Total |
|---------------------|------------|------------------------|--------|
| Brown               | 3          | 3                      | 170    |
| Percentage          | %          | 1.76                   | 100    |

➡️ With a MAF threshold equal or greater than 1.75, we keep specific genotypes even if it occurs only in 3 individuals.

## Hands-on the light thai coconut dataset 
[Gigwa v2.12 staging public](https://gigwa-dev.southgreen.fr/gigwaV2/)
  
### How was preparated this light dataset ?
Successive filters have been applied to reduce the VCF:
* Take only one harm of chromosomes 10, 11 and 14.
* Keep only SNP markers (remove INDELs)
* Remove monomorphic SNPs
* Keep only biallelic SNPs

### S2: SNP handling quality control and export filtered VCF with Gigwa

#### SNP filters on the full dataset of the light coconut database

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
1. Observe the SNP number (F1-F3: 34872) and then select less or equal to 5% of MAF (filter 4)  
<img width="100%" src="{{ site.url }}/images/ictp4/gigwa_s2_7.png" alt="" />
1. Observe the final SNP number with these filters (F1-F4: 16548) and then click on alleles of on line to display the variant details (e.g. genotypes)  
<img width="100%" src="{{ site.url }}/images/ictp4/gigwa_s2_8.png" alt="" />  
<img width="100%" src="{{ site.url }}/images/ictp4/gigwa_s2_9.png" alt="" />

#### Export the corresponding VCF file and keep it for the next session
<img width="100%" src="{{ site.url }}/images/ictp4/gigwa_s2_10.png" alt="" />  
<img width="100%" src="{{ site.url }}/images/ictp4/gigwa_s2_11.png" alt="" />
➡️ You should be able to retrieve this file Coconut_KU__project1__2026-03-24__16548variants__VCF.zip

#### SNP quality control on the chromosome 14 arm

1. Restrict the SNP search on the chr 14 with the same filters setup
<img width="100%" src="{{ site.url }}/images/ictp4/gigwa_s2_12.png" alt="" />
1. Go to the vizualisation charts with the 4847 selected SNPs
<img width="100%" src="{{ site.url }}/images/ictp4/gigwa_s2_13.png" alt="" />
1. Display the SNP density distribution
<img width="100%" src="{{ site.url }}/images/ictp4/gigwa_s2_14.png" alt="" />
1. Display the SNP missing data percentage
<img width="100%" src="{{ site.url }}/images/ictp4/gigwa_s2_15.png" alt="" />
1. Display the SNP MAF values
<img width="100%" src="{{ site.url }}/images/ictp4/gigwa_s2_16.png" alt="" />

#### Visual inspection of a region of the chromosome 14

1. Restrict the SNP search on the chr **14:147336001..150373000** with the same filters (252 SNP) and choose [Flapjack](https://ics.hutton.ac.uk/flapjack/) export format (FJ is an application for interactive visualizations of high-throughput genotype data)
<img width="100%" src="{{ site.url }}/images/ictp4/gigwa_s2_17.png" alt="" />
1. Export with metadata (fruit color) and 'keep files on server'
<img width="100%" src="{{ site.url }}/images/ictp4/gigwa_s2_18.png" alt="" />
1. 'View in Flapjack-Bytes' (web integration of FJ) and 'Open in separate windows'
<img width="100%" src="{{ site.url }}/images/ictp4/gigwa_s2_19.png" alt="" />
<img width="100%" src="{{ site.url }}/images/ictp4/gigwa_s2_20.png" alt="" />
1. Right click on allele line of FF68_CN1 (fruit color code 1) and 'Color by similarity to this line (allele match)' 
<img width="100%" src="{{ site.url }}/images/ictp4/gigwa_s2_21.png" alt="" />
  * green: homozygous genotype like the reference (0/0)
  * gray (in the FJ overview panel): heterozygous genotype (0/1)
  * red: homozygous genotype alternative to that of the reference allelle (1/1)
1. Right click on allele line of FF68_CN1 and 'Sort by similarity to this line' 
<img width="100%" src="{{ site.url }}/images/ictp4/gigwa_s2_22.png" alt="" />
➡️ at least two diversity profiles emerge.
1. Scroll down (in the FJ view panel) until FF68_CN63 (fruit color code 4) and 'Sort by similarity to this line' 
<img width="100%" src="{{ site.url }}/images/ictp4/gigwa_s2_23.png" alt="" />
<img width="100%" src="{{ site.url }}/images/ictp4/gigwa_s2_24.png" alt="" />
1. Scroll up and unzoom to observe the genotype that stick together at the top of the FJ view
<img width="100%" src="{{ site.url }}/images/ictp4/gigwa_s2_25.png" alt="" />
1. Observe the haploblock between **14:148836430..148873308** that good be associated with fruit color (recessive trait)
<img width="100%" src="{{ site.url }}/images/ictp4/gigwa_s2_26.png" alt="" />

### S3 part: individual phylogogenetic tree based on SNP distance matrix
