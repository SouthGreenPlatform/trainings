---
layout: page
title: "Assembly and Annotation Course - Montpellier"
permalink: /annotation/MAKER/StructuralAnnotation_mtp/
tags: [ Annotation, MAKER, structural, elixir]
description: Annotation Practice page
author: Jacques Dainat
date: 14/09/2018
---


## Foreword:

We will in this practical session use data from Arabidopsis thaliana, as that is one of the currently best annotated plant organisms and there is plenty of high quality data available. However, working on eukaryotes can be time consuming. Even a small plant genome like Arabidopsis thaliana (135 Mpb) would take too long to run within the time we have for this course. Thus to be sure to perform the practicals in good conditions, we will use the smallest chromosome, (chromosome 4 - 18 Mbp). Nevertheless, this chromosome could take several hours to be proceessed by MAKER on 8 cpu, so in order to work in a managable time, we decided to use only 1 Mbp of the chromosome 4. We will call it `genome` all along the excercices.
An annotation project requires numerous tools and dependencies, which can take easily many days to install for a neophyte. For your convenience and in order to focus on the art of the ANNOTATION most of the tools are ready to use.

## First of all

### Prepare your VM

Before going into the exercises below you need to connect to your Unix virtual machine (VM) following the instruction we provided you (in a terminal: ssh -Y -p <port> <username>@<host>).
Once connected create a new folder for this exercise:
{% highlight bash %}
cd ~
mkdir annotation
cd annotation
mkdir maker
cd maker
cp /home/data/data_lsoler/functional_annotation/data/genome.fa .
export PATH=/home/data/opt-byod/GAAS/annotation/:/home/data/opt-byod/GAAS/annotation/Tools/bin/:$PATH
{% endhighlight %}


### Prepare your aplliance

Once done you will to launch a second virtual machine (Yes twice as much fun !) in a second terminal. This second VM is called `appliance MAKER` and will be used to launch the MAKER annotation.

<a target="_blank" href="{{ site.url }}/annotation/IFBcloud/create_IFB_cloud_user_account">1) Create a user account on the IFB cloud (if not already done)</a>

<a target="_blank" href="{{ site.url }}/annotation/IFBcloud/use_IFB_cloud_appliance">2) Launch a MAKER appliance on the IFB cloud</a>

Part 1 - Check of your Assembly (on VM)
---------------------------------------

Before starting an annotation project, we need to carefully inspect the assembly to identify potential problems before running expensive computes.
You can look at i) the Fragmentation (N50, N90, how many short contigs); ii) the Sanity of the fasta file (Presence of Ns, presence of ambiguous nucleotides, presence of lowercase nucleotides, single line sequences vs multiline sequences); iii) completeness using BUSCO; iv) presence of organelles; v) Others (GC content, How distant the investigated species is from the others annotated species available).
The two next exercices will perform some of these checks.

### 1.1 Checking the gene space of your assembly

BUSCO provides measures for quantitative assessment of genome assembly, gene set, and transcriptome completeness. Genes that make up the BUSCO sets for each major lineage are selected from orthologous groups with genes present as single-copy orthologs in at least 90% of the species.

***Note:*** In a real-world scenario, this step come first and foremost. Indeed, if the result is under your expectation you might be required to enhance your assembly before to go further.

**_Exercise 1_ - BUSCO -:**

Good news, you don't have to do anything here. As you already learned how to use busco during the assembly part of the course. Let's jump directly to the next step.


### 1.2 Various Check of your Assembly (on VM)

**_Exercise 2_ :**
Launching the following script will provide you some useful information.

{% highlight bash %}
fasta_statisticsAndPlot.pl -f genome.fa
{% endhighlight %}

If you don't see any peculiarities, you can then decide to go forward and start to perform your first wonderful annotation.

Part 2 - Understand MAKER and its control files (on appliance)
---------------------------------------

## Overview

**MAKER** is a computational pipeline to automatically generate annotations from a range of input data - including proteins, ESTs, RNA-seq transcripts and ab-initio gene predictions. During this exercise, you will learn how to use Maker with different forms of input data, and how to judge the quality of the resulting annotations.

The Maker pipeline can work with any combination of the following data sets:

* Proteins from the same species or related species  

* Proteins from more distantly related organisms (e.g. Uniprot/Swissprot)  

* Transcriptome sequences from the same species or very closely related species  

* Ab-initio predictions from one or more tools (directly supported are: Augustus, Snap, GeneMark, Fgenesh)  

At minimum, most annotation projects will run with a protein data set, possibly complemented by some RNA-seq data. Popular examples of this are most of the traditional model systems, including human. However, a potential shortcoming of such approaches is that the comprehensiveness of the annotation depends directly on the input data. This can become a problem if our genome of interest is taxonomically distant to well-sequenced taxonomic groups so that only few protein matches can be found. Likewise, not all genes will be expressed at all times, making the generation of a comprehensive RNA-seq data set for annotation challenging.

We will therefore first run our annotation project in the traditional way, with proteins and ESTs, and then repeat the process with a well-trained ab-initio gene predictor. You can then compare the output to get an idea of how crucial the use of a gene predictor is. However, before we get our hands dirty, we need to understand Maker a little better...

Maker strings together a range of different tools into a complex pipeline (e.g. blast, exonerate, repeatmasker, augustus...), fortunately all its various dependencies have been already installed for you. 


## Understanding Makers control files (on appliance)

Check that everything is running smoothly by creating the MAKER config files:

{% highlight bash %}
cd ~/annotation/maker
mkdir maker_evidence
cd maker_evidence
maker -CTL
ls -l
{% endhighlight %}

Makers behaviour and information on input data are specified in one of three control files. These are:

- maker_opts.ctl  
- maker_bopts.ctl  
- maker_exe.ctl

What are these files for?

'maker_exe.ctl' holds information on the location of the various binaries required by Maker (including Blast, Repeatmasker etc). Normally, all information in this file will be extracted from $PATH, so if everything is set up correctly, you will never have to look into this file.

Next, 'maker_bopts.ctl' provides access to a number of settings that control the behaviour of evidence aligners (blast, exonerate). The default settings will usually be fine, but if you want to try to annotate species with greater taxonomic distance to well-sequenced species, it may become necessary to decrease stringency of the e.g. blast alignments.

Finally, 'maker_opts.ctl' holds information on the location of input files and some of the parameters controlling the decision making during the gene building.

Part 3 - Create an evidence-based annotation with MAKER (on appliance)
---------------------------------------

To save you some time, you don't need to seek for evidence data, we provide you proteins from uniprot as well as EST from NCBI.

### Overview

The first run of Maker will be done without ab-initio predictions. What are your expectations for the resulting gene build? In essence, we are attempting a purely evidence-based annotation, where the best protein- and EST-alignments are chosen to build the most likely gene models. The purpose of an evidence-based annotation is simple. Basically, you may try to annotate an organism where no usable ab-initio model is available. The evidence-based annotation can then be used to create a set of genes on which a new model could be trained on (using e.g. Snap or Augustus). Selection of genes for training can be based on the annotation edit distance (AED score), which says something about how great the distance between a gene model and the evidence alignments is. A score of 0.0 would essentially say that the final model is in perfect agreement with the evidence.

Let's do this step-by-step:

## Prepare the input data

Link the raw computes you want to use into your folder. The files you will need are:

- the gff file of the pre-computed repeats (coordinates of repeatmasked regions)

{% highlight bash %}
ln -s ~/annotation_course/data/raw_computes/repeatmasker.gff
{% endhighlight %}

In addition, you will also need the genome sequence.
{% highlight bash %}
ln -s ~/annotation_course/data/genome/genome.fa
{% endhighlight %}
Then you will also need EST previously align (gff format) and protein fasta file:  
{% highlight bash %}
ln -s ~/annotation_course/data/evidence/est2genome.gff 
ln -s ~/annotation_course/data/evidence/proteins.fa
{% endhighlight %}

/!\\ Always check that the gff files you provides as protein or EST contains   match / match_part (gff alignment type ) feature types rather than genes/transcripts (gff annotation type) otherwise MAKER will not use the contained data properly. Here all the data are fine.

You should now have 1 repeat file, 1 EST file, 1 protein file and the genome sequence in fasta format in the working directory. 

For Maker to use this information, we need creating the three config files, typing this command:
{% highlight bash %}
maker -CTL
{% endhighlight %}

You can leave the two files controlling external software behaviors untouched. In the actual maker options file called **maker_opts.ctl**, we need to provide:

- name of the genome sequence (genome=)
- name of the 'EST' file in fasta format  (est_gff=)
- name of the 'Protein' set file(s) (protein=)
- name of the repeatmasker file (rm_gff=) 

You can list multiple files in one field by separating their names by a **comma** ','.

This time, we do not specify a reference species to be used by augustus, which will disable ab-initio gene finding. Instead we set:
  
  <i>protein2genome=1</i>  
  <i>est2genome=1</i>

This will enable gene building directly from the evidence alignments.

To edit the **maker_opts.ctl** file you can use the nano text editor:
{% highlight bash %}
nano maker_opts.ctl
{% endhighlight %}

Before running MAKER you can check you have modified the maker_opts.ctl file properly <a target="_blank" href="{{ site.url }}/annotation/MAKER/practical2_supl_maker">here</a><br/>
/!\ Be sure to have deactivated the parameters **model\_org= #** and **repeat\_protein= #** to avoid the heavy work of repeatmasker.

## Run Maker

If your maker\_opts.ctl is configured correctly, you should be able to run maker:
{% highlight bash %}
mpirun -n 8 maker
{% endhighlight %}
This will start Maker on 8 cores, if everything is configured correctly.
This will take a little while and process a lot of output to the screen. Luckily, much of the heavy work - such as repeat masking - are already done, so the total running time is quite manageable, even on a small number of cores.

## While Maker is running (1):

/home/data/opt-byod/GAAS/annotation/BILS/Handler/Benchmark/gff_ben

## Inspect the output

<a target="_blank" href="{{ site.url }}/annotation/MAKER/inspect_the_output">Here you can find details about the MAKER output.</a><br/>

## Compile the output

Once Maker is finished, you need gathering all the outputs in some usable form.
You have two options: copy select files by hand to wherever you want them; or you can use scripts that do the job for you.

MAKER comes with fasta_merge and gff3_merge scripts but we promote to use the script called 'maker\_merge\_outputs\_from\_datastore' from the [GAAS](https://github.com/NBISweden/GAAS) git repository already include in your VM (not with the appliance). Consequently you need to copy (rsync or scp) the genome.maker.output folder on your VM first. Then, in your VM, if you are in the same folder where genome.maker.output is located you should be able to use this command:
{% highlight bash %}
maker_merge_outputs_from_datastore.pl --output maker_output_processed_evidence
{% endhighlight %}
We have specified a name for the output directory since we will be creating more than one annotation and need to be able to tell them apart.  

<a target="_blank" href="{{ site.url }}/annotation/MAKER/inspect_the_result">Here you can find details about the MAKER result.</a><br/>

The **maker.gff** is the result to keep from this analysis. 

=> You could sym-link the maker.gff file to another folder called e.g. maker\_results, so everything is in the same place in the end. Just make sure to call the link something other than maker.gff (e.g maker_evidence.gff), since any maker output will be called like that.


## Inspect the gene models

To get some statistics of your annotation you could launch :
{% highlight bash %}
gff3_sp_statistics.pl --gff maker_output_processed_abinitio/gff_by_type/maker.gff
{% endhighlight %}

We could now also visualise the annotation in a genome browser (IGV).


Part 4 - Create an abinitio evidence-driven annotation with MAKER
---------------------------------------

The recommended way of running Maker is in combination with one or more ab-initio profile models. Maker natively supports input from several tools, including augustus, snap and genemark. The choice of tool depends a bit on the organism that you are annotating - for example, GeneMark-ES is mostly recommended for fungi, whereas augustus and snap have a more general use.

The biggest problem with ab-initio models is the process of training them. It is usually recommended to have somewhere around 500-1000 curated gene models for this purpose. Naturally, this is a bit of a contradiction for a not-yet annotated genome.

However, if one or more good ab-initio profiles are available, they can potentially greatly enhance the quality of an annotation by filling in the blanks left by missing evidence. Interestingly, Maker even works with ab-initio profiles from somewhat distantly related species since it can create so-called hints from the evidence alignments, which the gene predictor can take into account to fine-tune the predictions.

Usually when no close ab-initio profile exists for the investigated species, we use the first round of annotation (evidence based) to create one. We first filter the best gene models from this annotation, which are used then to train the abinitio tools of our choice.

In order to compare the performance of Maker with and without ab-initio predictions in a real-world scenario, we have first run a gene build without ab-initio predictions. Now, we run a similar analysis but enable ab-initio predictions through augustus.

## Prepare the input data

No need to re-compute the mapping/alignment of the different lines of evidence. Indeed, this time consuming task has already been performed during the previous round of annotation (evidence based). So, we will use the corresponding gff files previously produced by MAKER.

Link the gff files you want to use into your folder:

 - repeatmasker.gff (already present)
 - genome.fa (already present) 
 - est2genome.gff (already present) 
 - protein2genome.gff 

{% highlight bash %}
ln -s maker_output_processed_evidence/gff_by_type/protein2genome.gff
{% endhighlight %}

This time, we do specify a reference species to be used by augustus, which will enable ab-initio gene finding.
To see which species have already a hmm profile included in augustus launch:
{% highlight bash %}
augustus --species=help
{% endhighlight %}
Select the appropriate species and inform MAKER in the maker_opt.ctl file (replace **my_species** by your choice:

*augustus\_species=**my_species*** #Augustus gene prediction species model  (this is where you can call the database you trained for augustus)
...  
<i>protein2genome=0</i>  
<i>est2genome=0</i>

If you want to keep abinitio prediction not supported by any evidences you can as well activate the keep_pred option:

*keep_preds=1*

/!\\ keep_preds is not recommended for plant genomes.

With these settings, Maker will run augustus to predict gene loci, but inform these predictions with information from the protein and est alignments.

Before running MAKER you can check you have modified the maker_opts.ctl file properly <a target="_blank" href="{{ site.url }}/annotation/MAKER/practical2_supl3_maker">here.</a><br/>

## Run Maker with ab-initio predictions

With everything configured, run Maker as you did for the previous analysis:
{% highlight bash %}
mpirun -n 8 maker
{% endhighlight %}

## While Maker is running (2):

## Compile the output

When Maker has finished, copy past the genome.maker.output on your VM and then compile the output:
{% highlight bash %}
maker_merge_outputs_from_datastore.pl --output maker_output_processed_abinitio 
{% endhighlight %}
And again, it is probably best to link the resulting output (maker.gff) to a result folder (the same as defined in the previous exercise e.g. maker\_results), under a descriptive name (e.g maker_abinitio.gff).

## Inspect the gene models

To get some statistics of your annotation you could launch :
```
gff3_sp_statistics.pl --gff maker_output_processed_abinitio/gff_by_type/maker.gff
```

**Question:** Do you have more or less gene models compare to the evidence-based annotation ?

We could now also visualise the annotation in a genome browser.


Part 5 - Complete the annotation
---------------------------------------

You prabably have now the two maker annotation (maker_evidence.gff and maker_abinitio.gff) in one folder. If not create a folder with a link to those two annotation. Now move into this folder.
We will take one of these annotation as reference, and the other as target. We will complement the reference annotation with loci that are annotated in the target but absent in the reference like that:

{% endhighlight bash %}
./gff3_sp_complement_annotations.pl --ref annotation_ref.gff --add=target.gff --out=final_annotation.gff
{% endhighlight %}

Get some statistics of your new annotation:
{% highlight bash %}
gff3_sp_statistics.pl --gff final_annotation.gff
{% endhighlight %}

**Question:** How many genes did you succed to catch from your target annotation ?

**Remark**: Launchung BUSCO on the proteins resulting of your annotation and comparing the result against the BUSCO you should have launched on the assembly will provide you nice hints about the quality of your annotation. In case of a huge drop of the `complete BUSCOs`, something went probably wrong during your annotation (paramters ? Hints provided ? hmm profile use ?).


## Closing remarks

This concludes the gene building part. We have learned how to use the Maker annotation pipeline and have created gene builds with and without ab-initio predictions. We showed you that the running of an annotation pipeline like Maker is not very hard. Actually the complicated work comes after. How to we best inspect the gene builds? Count features? Visualize it? Most importantly, what steps do we need to take to create a 'finished' annotation that we can use for scientific analyses ? 
In oder to assess the quality of an annotation the use of simple statistics like done here or BUSCO as mentioned several times are good choices. On top of that, an inspection of the annotation in genome browser is really important. We will approach this in another session (Manual curation). But assessing the annotation quality is in any case an easy task.
With that being said, the structural annotation was just a step. Now you will have to make an attempt at functional inference for the predicted gene models. Thus will be approach in another session (functional curation).

 Keep in mind that the exercices have been modeled to fit in the provided time. Many other important aspects of the structural annotation work haven't been approached (e.g Gathering evidence data for annotation (Protein, EST and RNA-seq data), Assembling transcripts based on RNA-seq data, how to train ab-initio tools, Comparing and evaluating annotations, etc).
