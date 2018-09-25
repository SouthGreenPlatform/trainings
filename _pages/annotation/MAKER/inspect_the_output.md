---
layout: page
title: "Assembly and Annotation Course - Montpellier"
permalink: /annotation/MAKER/inspect_the_output/
tags: [ Annotation, MAKER, structural, elixir]
description: Annotation Practice page
author: Jacques Dainat
date: 14/09/2018
---

## Inspect the output

### Finding your way around

By default, Maker will write the output of its different analyses into a folder named:

**&lt;name\_of\_genome\_fasta&gt;.maker.output**

In our case:

**genome.maker.output**

Within the main output directory, Maker keeps a copy of the config files, a database (here: 4.db), directories for the blast databases created from your evidence data and a file called genome\_master\_datastore\_index.log.

Out of these files, only the genome\_master\_datastore\_index is really interesting to us. It includes a log of all the contigs included in the genome fasta file - together with their processing status (ideally: FINISHED) and the location of the output files. Since Maker can technically run in parallel on a large number of contigs, it creates separate folders for each of these input data. For larger genomes, this can generate a very deep and confusing folder tree. The genome\_master\_datastore\_index.log helps you make sense of it:
{% highlight bash %}
chr4    genome_datastore/27/AC/chr4/    STARTED
chr4    genome_datastore/27/AC/chr4/    FINISHED
{% endhighlight %}
This meens the sequence **chr4** was started - and finished, with all data (annotation, protein predictions etc) written to the subfolder genome\_datastore/27/AC/chr4/.

If you look into that folder, you will find the finished Maker annotation for this contig.
{% highlight bash %}
rw-rw-r- 1 student student 472193 Mar 24 10:16 chr4.gff <br/>
\*rw-rw-r- 1 student student 3599 Mar 24 10:16 chr4.maker.augustus\_masked.proteins.fasta <br/>
\*rw-rw-r- 1 student student 10388 Mar 24 10:16 chr4.maker.augustus\_masked.transcripts.fasta  <br/>
\*rw-rw-r- 1 student student 176 Mar 24 10:16 chr4.maker.non\_overlapping\_ab\_initio.proteins.fasta <br/>
\*rw-rw-r- 1 student student 328 Mar 24 10:16 chr4.maker.non\_overlapping\_ab\_initio.transcripts.fasta  <br/>
rw-rw-r- 1 student student 3931 Mar 24 10:16 chr4.maker.proteins.fasta  <br/>
rw-rw-r- 1 student student 20865 Mar 24 10:16 chr4.maker.transcripts.fasta  <br/>
rw-rw-r- 1 student student 4248 Mar 24 10:15 run.log  <br/>
drwxrwsr-x 3 student student 4096 Mar 24 10:16 theVoid.chr4
{% endhighlight %}

\* only if an abinitio tool has been activated

The main annotation file is 'chr4.gff' - including both the finished gene models and all the raw compute data. The other files include fasta files for the different sequence features that have been annotated - based on ab-initio predictions through augustus as well as on the finished gene models. The folder 'theVoid' include all the raw computations that Maker has performed to synthesize the evidence into gene models.
