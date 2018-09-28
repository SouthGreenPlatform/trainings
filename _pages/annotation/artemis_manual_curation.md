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
| Authors | Stéphanie Bocs (stephanie.sidibe-bocs@cirad.fr)<br/>Lucile Soler (lucile.soler@nbis.se)  |
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

Annotate two genes (AT4G32500 and AT4G32510) of the whole Arabidopsis chromosome 4 from the MAKER gene prediction with functionnal annotation

<a name="install-configure-artemis"></a>
##  Install & configure artemis :

Download Artemis from [github.io](http://sanger-pathogens.github.io/Artemis/) (e.g. v17 20180928).

Increase the memory allocated to Artemis following the [FAQ recommandations](http://sanger-pathogens.github.io/Artemis/Artemis/)
For instance -Xmx8g (Java max heap size) instead of -Xmx2g in Artemis.cfg if you have 16Gb of RAM on your personnal computer

<a name="get-annotation-evidence-gff3-file"></a>
##  Get annotation and evidence gff3 files :

From your MAKER and EGN-EP IFB Appliance or from the Slovenian VM

For instance from EGN-EP IFB Appliance
{% highlight bash %}
/root/work_dir/0001/Chr4/
{% endhighlight %}

Slovenian VM
{% highlight bash %}
scp -r -P 65034 gaas23@terminal.mf.uni-lj.si:/home/data/byod/Annotation/ARATH/ARATH04_MAKER/ .
scp -r -P 65034 gaas23@terminal.mf.uni-lj.si:/home/data/byod/Annotation/ARATH/ARATH04_EGN .
{% endhighlight %}

<a name="load-art-load-data"></a>
##  Launch artemis & Load data :

File/Open

File/Read An Entry

maker_abinitio_functional.gff

Chr4_egnep.gff3

<img width="60%" src="{{ site.url }}/images/Excel10.3_IFBcloud_account_create.png" alt="" />

<a name="art-functionalities"></a>
##  Some Artemis functionalities :

Goto navigator

One line per feature & all feature on frame line

gene builder

export sequence

Next methionin

<img width="60%" src="{{ site.url }}/images/Excel10.3_IFBcloud_account_create.png" alt="" />
