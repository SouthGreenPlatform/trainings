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

* [Install & configure Artemis](#install-configure-artemis)
* [Get annotation and evidence gff3 files](#get-annotation-evidence-gff3-file)
* [Launch Artemis & Load data](#load-art-load-data)
* [Some Artemis functionalities](#art-functionalities)
* [Annotate AT4G32500](#annotate-AT4G32500)

-----------------------

<a name="install-configure-artemis"></a>
##  Install & configure artemis :

Download Artemis from [github.io](http://sanger-pathogens.github.io/Artemis/) (e.g. v17 20180928).

Increase the memory allocated to Artemis following the [FAQ recommandations](http://sanger-pathogens.github.io/Artemis/Artemis/) (e.g. -Xmx2g in Artemis.cfg)

<a name="get-annotation-evidence-gff3-file"></a>
##  Get annotation and evidence gff3 files :

From your MAKER and EGN-EP IFB Appliance or from the Slovenian VM
For instance
{% highlight bash %}
scp -r -P 65034 gaas23@terminal.mf.uni-lj.si:/home/data/byod/Annotation/ARATH/ARATH04_MAKER/chr4/maker_output_processed_evidence/ .
scp -r -P 65034 gaas23@terminal.mf.uni-lj.si:/home/data/byod/Annotation/ARATH/ARATH04_MAKER/chr4/maker_output_processed_abinitio/ .
scp -r -P 65034 gaas23@terminal.mf.uni-lj.si:/home/data/byod/Annotation/ARATH/ARATH04_EGN .
{% endhighlight %}

<a name="load-art-load-data"></a>
##  Launch artemis & Load data :

<a name="art-functionalities"></a>
##  Some Artemis functionalities :


<img width="60%" src="{{ site.url }}/images/Excel10.3_IFBcloud_account_create.png" alt="" />
