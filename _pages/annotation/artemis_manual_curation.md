---
layout: page
title: "Artemis Manual Protein Coding Gene Annotation Practice - PGAA Montpellier"
permalink: /annotation/artemis_manual_curation/
tags: [ artemis, annotation tool, gene curation ]
description: Manual curation of protein coding gene on Arabidopsis chromosome 4 with Artemis annotation tool page
---

| Description | Hands On Lab Exercises for Artemis |
| :------------- | :------------- | :------------- | :------------- |
| Related-course materials | [Structural annotation with MAKER](https://southgreenplatform.github.io/trainings/annotation/MAKER/StructuralAnnotation_mtp/) [Structural annotation with EGN-EP](https://southgreenplatform.github.io/trainings/annotation/Eugene/exercice_eugene_appliance/)|
| Authors | Stéphanie Bocs (stephanie.sidibe-bocs@cirad.fr)<br/>Lucile Soler (lucile.soler@nbis.se)<br/>Jacques Dainat (jacques.dainat@nbis.se)  |
| Creation Date | 26/09/2018 |
| Last Modified Date | 27/09/2018 |

-----------------------

## Summary

* [Goal of the exercice](#exercice)
* [Install & configure Artemis](#install-configure-artemis)
* [Get annotation and evidence gff3 files](#get-annotation-evidence-gff3-file)
* [Launch Artemis & Load data](#load-art-load-data)
* [Some Artemis functionalities](#art-functionalities)
* [Annotate AT4G32500](#annotate-AT4G32500)
* [Annotate AT4G32510](#annotate-AT4G32510)

-----------------------

<a name="exercice)"></a>
## Goal of the exercice

* General: Become familiar with the Artemis annotatio tool with regard to manual gene curation.
* Specific: Annotate two genes (AT4G32500 and AT4G32510) of the whole Arabidopsis chromosome 4 from the MAKER gene prediction with functionnal annotation

<a name="install-configure-artemis"></a>
##  Install & configure artemis :

Download Artemis from [github.io](http://sanger-pathogens.github.io/Artemis/) (e.g. v17 20180928).

Increase the memory allocated to Artemis following the [FAQ recommandations](http://sanger-pathogens.github.io/Artemis/Artemis/)
For instance -Xmx8g (Java max heap size) instead of -Xmx2g in Artemis.cfg if you have 16Gb of RAM on your personnal computer

<a name="get-annotation-evidence-gff3-file"></a>
##  Get annotation and evidence gff3 files :

To facilitate manual annotation, match_part must be linked in Artemis, so gff files need to be reformatted.
For your information, from the Eugene-EP IFB appliance:
{% highlight bash %}
/root/work_dir/0001/Chr4/
awk 'BEGIN{g=0}{if($3 ~ /EST_match/){g++; print $1"\t"$2"\tgene\t"$4"\t"$5"\t"$6"\t"$7"\t"$8"\tID="g; print  $1"\t"$2"\tmRNA\t"$4"\t"$5"\t"$6"\t"$7"\t"$8"\t"$9";Parent="g}else{if($3 ~ /match_part/){print $0}else{print $0}}}' Chr4.est1.gff3 |sed  's/match_part/exon/' > Chr4.est1_gene.gff3
{% endhighlight %}

Reformatted data are centralised on the Slovenian VM, for your information MAKER formatting
{% highlight bash %}
awk 'BEGIN{g=0}{if($3 ~ /protein_match/){g++; print $1"\t"$2"\tgene\t"$4"\t"$5"\t"$6"\t"$7"\t"$8"\tID="g; print  $1"\t"$2"\tmRNA\t"$4"\t"$5"\t"$6"\t"$7"\t"$8"\t"$9";Parent="g}else{if($3 ~ /match_part/){print $0}else{print $0}}}' protein_gff\:protein2genome.gff |sed  's/match_part/CDS/' > protein2genome_gene.gff
awk 'BEGIN{g=0}{if($3 ~ /^match$/){g++; print $1"\t"$2"\tgene\t"$4"\t"$5"\t"$6"\t"$7"\t"$8"\tID="g; print  $1"\t"$2"\tmRNA\t"$4"\t"$5"\t"$6"\t"$7"\t"$8"\t"$9";Parent="g}else{if($3 ~ /match_part/){print $0}else{print $0}}}' augustus_masked.gff |sed  's/match_part/exon/' > augustus_masked_gene.gff
{% endhighlight %}

Transfer the reformatted annotation files from the Slovenian VM to your personnal computer
{% highlight bash %}
scp -r -P 65034 gaas23@terminal.mf.uni-lj.si:/home/data/byod/Annotation/ARATH/ARATH04_MAKER/ .
scp -r -P 65034 gaas23@terminal.mf.uni-lj.si:/home/data/byod/Annotation/ARATH/ARATH04_EGN .
{% endhighlight %}

<a name="load-art-load-data"></a>
##  Launch artemis & Load data :

* File/Open Tous les fichiers (All files) Chr4

* File/Read An Entry
<img width="20%" src="{{ site.url }}/images/pga/artemis_00_read_entry.png" alt="" />

maker_abinitio_functional.gff

Chr4_egnep.gff3


<a name="art-functionalities"></a>
##  Some Artemis functionalities :

* Goto navigator
<img width="20%" src="{{ site.url }}/images/pga/artemis_01_goto_navigator.png" alt="" />
<img width="20%" src="{{ site.url }}/images/pga/artemis_02_navigator.png" alt="" />
* To change the feature visusalisation mode Click right & tick 'One line per feature' & 'all features on frame line' options
<img width="20%" src="{{ site.url }}/images/pga/artemis_03_one_line_per_entry.png" alt="" />
* Next methionin: click on a CDS in cyan and type the 'cmd Y' (Mac) or 'ctrl Y' (Windows / Linux)

* Undo: clicking on a CDS in cyan and type the 'cmd Y' (Mac) or 'ctrl Y' (Windows / Linux)

<a name="annotate-AT4G32500"></a>
##  Annotate AT4G32500 :

* Shorter an exon & save
<img width="100%" src="{{ site.url }}/images/pga/artemis_04_short_exon.png" alt="" />
* Check the functional annotation
Open the Gene Builder by clicking on a feature and then typing the 'cmd E' (Mac) or 'ctrl E' (Windows / Linux)

<a name="annotate-AT4G32500"></a>
##  Annotate AT4G32510 :

* Set smaller gene as 'obsolete'

* Set the correct boundaries of the first transcript

* Duplicate the transcript and set the correct boundaries of the second alternative transcript
<img width="100%" src="{{ site.url }}/images/pga/artemis_05_new_intron.png" alt="" />

<img width="60%" src="{{ site.url }}/images/pga/artemis_06_alternative_transcript.png" alt="" />
* Write polypeptide sequence, make blastp on uniprot KB to curate the functionnal annotation (product, gene_symbol)
