---
layout: page
title: "Metabarcoding Practice"
permalink: /linux/metabarcodingPractice/
tags: [ Metabarcoding, survival guide ]
description: Metabarcoding Practice page
---

| Description | Hands On Lab Exercises for Metabarcoding |
| :------------- | :------------- | :------------- | :------------- |
| Authors | J Orjuela (julie.orjuela@ird.fr), A Dereeper (alexis.dereeper@ird.fr), F Constancias (florentin.constancias@cirad.fr), J Reveilleud (JR) (julie.reveillaud@inra.fr), M Simonin (marie.simonin@ird.fr), F Mahé (frederic.mahe@cirad.fr), A Comte (aurore.comte@ird.fr=| 
| Creation Date | 18/04/2018 |
| Last Modified Date | 22/05/2019 |

-----------------------

### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Practice 1: Obtaining an OTU table with FROGS in Galaxy](#practice-1)
  * [Practice 1.1: Preprocessing](#preprocess)
  * [Practice 1.2: Clustering](#clustering)
  * [Practice 1.3: Stats on clustering (optional)](#statsClustering1)
  * [Practice 1.4: Remove chimera](#chimera)
  * [Practice 1.5 OTU Filtrering](#filtering)
  * [Practice 1.6: Stats on clustering (optional)](#statsClustering2)
  * [Practice 1.7: Taxonomic affiliation](#afiliation)
  * [Practice 1.8: Affiliation stats](#affiliationStats)
  * [Practice 1.9: BIOM format standarization](#standarizationBIOM)
  * [Practice 1.10: Building a Tree](#tree)
  * [Practice 1.12: Workflow in Galaxy](#workflow)
* [Practice 2: FROGs in command line](#practice-2)
* [Practice 3: Handling and visualizing OTU table using PhyloSeq R package](#practice-3)
  * [3.1 Setup your environment](#env)
  * [3.2 Building a Phyloseq object](#phyloseqobjet)
  * [3.3 Distribution per OTU and per sample](#distribution)
  * [3.4 Rarefaction curves](#rarefaction)
  * [3.5 OTU table Filtering ](#phyloseqfiltering)
  * [3.6 Normalisation to minumum sequencing depth](#normalisation)
  * [3.7 alpha-diversity](#alpha)
  * [3.8 beta-diversity](#beta)
  * [3.9 Composition plot](#Compositionplot)
  * [3.10 Some exercises](#exercises)
* [Links](#links)
* [License](#license)


<table class="table-contact">
<tr>
<td width="25%"><img width="60%" src="{{ site.url }}/images/trainings-galaxy.png" alt="" />
</td>
<td width="25%"><img width="30%" src="{{ site.url }}/images/FROGS_logo.png" alt="" />
</td>
<td width="25%"><img width="70%" src="{{ site.url }}/images/bioconductor.png" alt="" />
</td> 
</tr>
</table>

-----------------------

<a name="practice-1"></a>
## Practice 1 : Obtaining an OTU table with FROGS in Galaxy

In this training we will first performed metabarcoding analysis with the FROGS v3.1 pipeline in the Galaxy environment `https://github.com/geraldinepascal/FROGS `. In a second time, we will perform similar analysis in command line on HPC i-Trop cluster.

* Connect to [Galaxy i-Trop](http://http://bioinfo-inter.ird.fr:8080/) with formationN account.
* Create a new history and import Metabarcoding sample datasets (paired-end fastq files compressed by tar ) from  
`Shared Data / Data libraries /formation Galaxy 2019 / Metabarcoding`. Recovery  `DATA_s.tar.gz` and `Summary.txt`
  - Fastq files used here are a subset of reads obtained in a metagenomic study of Edwards et al 2015 containing 4 soil compartments:  Rhizosphere, Rhizoplane, Endosphere and Bulk_Soil of a rice culture.
  
We will launch every step of a metabarcoding analysis as follow :

-----------------------

<a name="preprocess"></a>
#### 1.1 Preprocess

* Merge paired reads and dereplicate using the Preprocessing tool with FLASH as merge software - `FROGS Pre-process`
  - => Read size is 250 pb, expected, minimum and maximun amplicon size are 250,100,350 pb respectively. Use custom sequencing protocol. Use a mistmach rate of 0.15.
  - How many sequences have been overlapped? 
  - How many sequences remain after dereplication?
  - What amplicon size is obtained in the majority of merged sequences?  

-----------------------

<a name="clustering"></a>
#### 1.2 Clustering

* Build Clustering using swarm - `FROGS Clustering swarm`
  - => Use an aggregation distance of 1. Don't use denoising option.
  - The biom file shows the abundance of each cluster.
  - The fasta file contains the cluster (OTU) representative sequences.
  - The tsv file shows what sequences are contained in each cluster.

-----------------------

<a name="statsClustering1"></a>
#### 1.3 Stats on clustering (optional)

* Obtain statistics about abundance of sequences in clusters - `FROGS Clusters stat`
  - How many clusters were obtained by swarm?
  - How many sequences are contained in the biggest cluster?
  - How many clusters contain only one sequence?
  - Observe the cumulative sequence proportion by cluster size
  - Observe cluster sharing between samples through hierarchical clustering tree

-----------------------

<a name="chimera"></a>
#### 1.4 Remove chimera

* Remove chimera using biom obtained from swarm - `FROGS Remove chimera`
  - What proportion of clusters were kept in this step?
  
-----------------------

<a name="filtering"></a>
#### 1.5 OTU Filtrering 

* Filters OTUs on several criteria. - `FROGS Filters`
  - Eliminate OTUs with a low number of sequences (abundance at 0.005%) and keep OTUs present in at least two samples.
  - How many OTUs were removed in this step?
  - How many OTUs were removed because of low abundance?
* Relauch OTU Filtering but using abundance at 0.01%.  How many OTUs were removed because of low abundance?

-----------------------

<a name="statsClustering2"></a>
#### 1.6 Stats on clustering (optional)

* Rerun statistics of clusters after filtering - `FROGS Clusters stat`
  - Look the effect of the cumulative proportion by cluster size.

-----------------------

<a name="afiliation"></a>
#### 1.7 Taxonomic affiliation

* Perform taxonomic affiliation of each OTU by BLAST - `FROGS Affiliation OTU`
  - Use the SILVA 132 16S database for taxonomic assignation by BLAST.
  - Activate RDP assignation.
  - How many OTU were taxonomically assigned to species?
  - Visualize the biom file enriched with taxomonic information.

-----------------------

<a name="affiliationStats"></a>
#### 1.8 Affiliation stats
 
* Obtain statistics of affiliation - `FROGS Affiliation stat`
  - Use rarefaction ranks : Family Genus Species
  - Observe global distribution of taxonomies by sample.
  - Look the rarefaction curve, which is a measure of samples vs diversity.

-----------------------

<a name="standarizationBIOM"></a>
#### 1.9 BIOM format standarization 

Retrieve a standardize biom file using - `FROGS BIOM to std BIOM `
  - You have now a standard BIOM file to phyloseq analysis. 

-----------------------
<a name="tree"></a>
####  1.10 Building a Tree

* Build a tree with mafft `FROGS Tree` using filter.fasta and filter.biom

-----------------------
<a name="phyloseq"></a>
####  1.11 Phyloseq stats in FROGSTAT

* Import data in R `FROGSSTAT Phyloseq Import`  using the standard BIOM file and the `summary.txt` file without normalisation. 

* Make taxonomic barcharts (kingdom level) `FROGSSTAT Phyloseq Composition Visualisation` using `env_material` as grouping variable and the R data objet.

* Compute alpha diversity `FROGSSTAT Phyloseq Alpha Diversity` Calculate Observed, Chao1 and Shannon diversity indices. Use `env_material` as enviroment variable. 

* Compute beta diversity `FROGSSTAT Phyloseq Beta Diversity`.  Use `env_material` as grouping variable and the R data objet and 'Other methods': cc, unifrac.

* Build a head map plot and ordination `FROGSSTAT Phyloseq Structure Visualisation` : Use `env_material` as grouping variable,  the R data objet and the beta-diversity unifrac.tsv output.

* Hierarchical clustering of samples using Unifrac distance matrix `FROGSSTAT Phyloseq Sample Clustering` : Use `env_material` as grouping variable, the R data objet and the beta-diversity unifrac.tsv output.

* Calculate a anova using unifrac distance matrix with `FROGSSTAT Phyloseq Anova`

-----------------------

<a name="workflow"></a>
#### 1. 12 Workflow in Galaxy

Import a preformated FROGS workflow from Galaxy. Go to `Shared Data / Workflows /FROGS` and import it. This workflow contains the whole of steps used before. Be free of modified it and lauch it if you want.

-----------------------

<a name="practice-2"></a>
## Practice 2 : Launch FROGs in command line

* Connection to account in *IRD i-Trop cluster* in ssh mode `ssh formationX@bioinfo-master.ird.fr`

* Input data `DATA_s.tar.gz` and `summary.txt` are accessible from nas:/data2/formation/TPMetabarcoding/FROGS/ folder.

* Create a TP-FROGS directory in your $HOME and go inside
{% highlight bash %}
mkdir ~/TP-FROGS 
cd ~/TP-FROGS 
{% endhighlight %}

* Download `LaunchFROGs_v3.sh` script and give execution rights 
{% highlight bash %}
wget https://raw.githubusercontent.com/SouthGreenPlatform/trainings/gh-pages/files/launchFROGs_v3.sh 
chmod +x launchFROGs_v3.sh
{% endhighlight %}

* Visualise `LaunchFROGs_v3.sh` script 

* Launch `LaunchFROGsv3.sh` in qsub mode. Give your user name to this script as parametter.
{% highlight bash %}
qsub ./launchFROGs_v3.sh formationX
{% endhighlight %}

* Recovery output repertory and transfer it to your local machine using Fillezila or `scp `

  - if `scp` mode transfert from your local machine terminal as follow

{% highlight bash %}
scp -r formationX@bioinfo-master.ird.fr:/home/formationX/OUTPUT_FROGSV3/ .
{% endhighlight %}

-----------------------
<a name="practice-3"></a>
## Practice 3 : Tutoriel Phyloseq Formation Metabarcoding

<a name="env"></a>
#### 3.1 Setup your environment

Start with a clean session
{% highlight r %}
rm(list=ls())
{% endhighlight %}

load the packages
{% highlight bash %}
require(phyloseq)
require(tidyverse)
require(reshape2)
require(gridExtra)
require(scales)
require(parallel)
require(permute)
require(lattice)
{% endhighlight %}

Let's define the working directory on your local computer
{% highlight r %}
setwd("your path")
{% endhighlight %}

<a name="phyloseqobjet"></a>
#### 3.2 Building a Phyloseq object

... and load the data generated using FROGS
{% highlight r %}
load("11-phylo_import.Rdata")
{% endhighlight %}

Data is a phyloseq object 
{% highlight r %}
data
{% endhighlight %}

We can access the 'OTU' / sample occurence table with the follwing command
{% highlight r %}
head(otu_table(data))
{% endhighlight %}

You can also use tidyr syntax to make your code net and tidy
{% highlight r %}
data %>% 
  otu_table() %>%
    head()
{% endhighlight %}

in R, type ? and the function name to some help
{% highlight r %}
?otu_table
{% endhighlight %}

*Question1* : What is the sequencing depth of the samples
{% highlight r %}
data %>% 
  otu_table() %>%
  colSums()
{% endhighlight %}

Phyloseq has some built-in functions to explore the data
{% highlight r %}
data %>% sample_sums
{% endhighlight %}

Let's plot the sorted sequencing depth 
{% highlight r %}
data %>% 
  otu_table() %>%
  colSums() %>%
  sort() %>% 
  barplot(las=2)
{% endhighlight %}

*Question2* :  How many reads are representing each of the first 10 OTU (i.e., swarm's clusters)
{% highlight r %}
sort(rowSums(otu_table(data)), decreasing = T)[1:10]
{% endhighlight %}

We can access the taxonomical information of the different OTU with the follwing command
{% highlight r %}
data %>% 
  tax_table() %>%
  head()
{% endhighlight %}

Metadata are also stored in data phyloseq object
{% highlight r %}
sample_data(data)$env_material
{% endhighlight %}

Phyloseq has some built-in functions 
{% highlight r %}
rank_names(data) # taxonimcal ranks
nsamples(data) # number of samples
ntaxa(data) # number of OTU
sample_variables(data) # metadata
{% endhighlight %}

-----------------------
<a name="distribution"></a>
#### 3.3 Distribution per OTU and per sample

Let's plot the sequence distribution per OTU and per sample
First, create a dataframe with nreads : the sorted number of reads per OTU, sorted : the index of the sorted OTU and type : OTU
{% highlight r %}
readsumsdf <- data.frame(nreads = sort(taxa_sums(data), TRUE),
                        sorted = 1:ntaxa(data), 
                        type = "OTU")
{% endhighlight %}

These are the first rows of our dataframe
{% highlight r %}
readsumsdf %>% head()
{% endhighlight %}

We can plot this dataframe using ggplot
{% highlight r %}
ggplot(readsumsdf, 
       aes(x = sorted, y = nreads)) + 
  geom_bar(stat = "identity") + 
  scale_y_log10() 
{% endhighlight %}

Now we are going to create another dataframe with the sequencing depth per sample sample_sums()
{% highlight r %}
readsumsdf2 <- data.frame(nreads = sort(sample_sums(data), TRUE), 
                          sorted = 1:nsamples(data), 
                          type = "Samples")
{% endhighlight %}

Let's bind the two tables 
{% highlight r %}
readsumsdf3 <- rbind(readsumsdf,readsumsdf2)
{% endhighlight %}

Check the first rows
{% highlight r %}
readsumsdf3 %>% head()
{% endhighlight %}

Check the last rows
{% highlight r %}
readsumsdf3 %>% tail()
{% endhighlight %}

We can plot the data using ggplot and wrap the data according to type column (that's why we specified OTU and Samples )
{% highlight r %}
p  <-  ggplot(readsumsdf3, 
              aes(x = sorted, y = nreads)) + 
  geom_bar(stat = "identity")
p + ggtitle("Total number of reads before Preprocessing") + scale_y_log10() + facet_wrap(~type, 1, scales = "free")
{% endhighlight %}


-----------------------
<a name="rarefaction"></a>
#### 3.4 Rarefaction curves

Let's explore the rarefaction curves i.e., OTU richness vs sequencing depth
{% highlight r %}
data %>%
  otu_table() %>%
  t() %>%
  vegan::rarecurve()
{% endhighlight %}

We can do something nicer with ggplot
{% highlight r %}
source("https://raw.githubusercontent.com/mahendra-mariadassou/phyloseq-extended/master/load-extra-functions.R")
{% endhighlight %}

{% highlight r %}
p <- ggrare(data,
            step = 500,
            color = "env_material",
            plot = T,
            parallel = T,
            se = F)
p <- p + 
  facet_wrap(~ env_material ) + 
  geom_vline(xintercept = min(sample_sums(data)), 
             color = "gray60")
plot(p)
{% endhighlight %}

-----------------------
<a name="phyloseqfiltering"></a>
#### 3.5 OTU table Filtering 

We are now going to filter the OTU table

Explore the Taxonomy at the Kingdom level
{% highlight r %}
tax_table(data)[,c("Kingdom")] %>% unique()
{% endhighlight %}

Remove untargeted OTU (we consider Unclassified OTU at the Kingdom level as noise) using subset_taxa
{% highlight r %}
data <- subset_taxa(data, 
                    Kingdom != "Unclassified" &
                    Order !="Chloroplast" &
                    Family != "Mitochondria")
{% endhighlight %}

Remove low occurence / abundance OTU i.e.,  more than 10 sequences in total and appearing in more than 1 sample
{% highlight r %}
data <-  filter_taxa(data, 
                     function(x) sum(x >= 10) > (1), 
                     prune =  TRUE) 
{% endhighlight %}

-----------------------
<a name="normalisation"></a>
#### 3.6 Normalisation to minumum sequencing depth

Rarefy to en even sequencing depth (i.e., min(colSums(otu_table(data)))
{% highlight r %}
data_rare <- rarefy_even_depth(data, 
                              sample.size = min(colSums(otu_table(data))), 
                              rngseed = 63)
{% endhighlight %}

Rarefaction curves on filtered data
{% highlight r %}
p <- ggrare(data_rare, step = 50, color = "env_material", plot = T, parallel = T, se = F)
p 
{% endhighlight %}

One can export the filtered OTU table
{% highlight r %}
write.csv(cbind(data.frame(otu_table(data_rare)),
                tax_table(data_rare)), 
          file="filtered_otu_table.csv")
{% endhighlight %}

-----------------------
<a name="alpha"></a>
#### 3.7 alpha-diversity

We can now explore the alpha-dviersity on the filtered and rarefied data
{% highlight r %}
p <- plot_richness(data_rare, 
                   x="sample", 
                   color="env_material", 
                   measures=c("Observed","Shannon","ACE"), 
                   nrow = 1)
print(p)
{% endhighlight %}

That plot could be nicer
Data to plot are stored in p$data
{% highlight r %}
p$data %>% head()
{% endhighlight %}

boxplot using ggplot 
{% highlight r %}
ggplot(p$data,aes(env_material,value,colour=env_material)) +
  facet_grid(variable ~ env_material, drop=T,scale="free",space="fixed") +
  geom_boxplot(outlier.colour = NA,alpha=1)
{% endhighlight %}

More Complex
{% highlight r %}
ggplot(p$data,aes(env_material,value,colour=env_material,shape=env_material)) +
  facet_grid(variable ~ env_material, drop=T,scale="free",space="fixed") +
  geom_boxplot(outlier.colour = NA,alpha=0.8, 
               position = position_dodge(width=0.9)) + 
  geom_point(size=2,position=position_jitterdodge(dodge.width=0.9)) +
  ylab("Diversity index")  + xlab(NULL) + theme_bw()
{% endhighlight %}

Export the alpha div values into a dataframe in short format
{% highlight r %}
rich.plus <- dcast(p$data,  samples + env_material ~ variable)
write.csv(rich.plus, file="alpha_div.csv")
{% endhighlight %}

Alpha-div Stats using TukeyHSD on ANOVA
{% highlight r %}
TukeyHSD_Observed <- TukeyHSD(aov(Observed ~ env_material, data =  rich.plus))
TukeyHSD_Observed_df <- data.frame(TukeyHSD_Observed$env_material)
TukeyHSD_Observed_df$measure = "Observed"
TukeyHSD_Observed_df$shapiro_test_pval = (shapiro.test(residuals(aov(Observed ~ env_material, data =  rich.plus))))$p.value
TukeyHSD_Observed_df
{% endhighlight %}

-----------------------
<a name="beta"></a>
#### 3.8 beta-diversity

Compute dissimilarity
{% highlight r %}
data_rare %>% transform_sample_counts(function(x) x/sum(x)) %>%
  otu_table() %>%
  t() %>%
  sqrt() %>%
  as.data.frame() %>%
  vegdist(binary=F, method = "bray") -> dist
{% endhighlight %}

##### Ordination

run PCoA ordination on the generated distance
{% highlight r %}
ord <- ordinate(data_rare,"PCoA",dist)
{% endhighlight %}

Samples coordinate on the PCoA vecotrs are stored in but plot_ordination can make use of ord object easily
{% highlight r %}
ord$vectors
{% endhighlight %}

{% highlight r %}
plot_ordination(data_rare, 
                ord,
                color = "env_material", 
                shape="env_material", 
                title = "PCoA sqrt Bray curtis", 
                label= "SampleID" ) + 
  geom_point(aes(size=rich.plus$Observed)) +
  theme_bw()
{% endhighlight %}

Let's see if the observed pattern is significant using PERMANOVA i.e., adonis function from vegan
{% highlight r %}
adonis(dist ~ get_variable(data_rare, "env_material"), permutations = 1000)$aov.tab
{% endhighlight %}

##### dispersion

Let's see if there are difference in dispersion (i.e., variance)
{% highlight r %}
boxplot(betadisper(dist, 
                   get_variable(data_rare, "env_material")),las=2, 
        main=paste0("Multivariate Dispersion Test Bray-Curtis "," pvalue = ", 
                    permutest(betadisper(dist, get_variable(data_rare, "env_material")))$tab$`Pr(>F)`[1]))
{% endhighlight %}



##### ANOSIM

ANOSIM test can also test for differences among group 
{% highlight r %}
plot(anosim(dist, get_variable(data_rare, "env_material"))
     ,main="ANOSIM Bray-Curtis "
     ,las=2)
{% endhighlight %}

-----------------------
<a name="Compositionplot"></a>
#### 3.9 Composition plot
Now, we would like to plot the distribution of phylum transformed in %
{% highlight r %}
data_rare %>% transform_sample_counts(function(x) x/sum(x)) %>%
  plot_bar(fill="Phylum") +
  facet_wrap(~ env_material, scales = "free_x", nrow = 1) +
  ggtitle("Bar plot colored by Phylum ") +
  theme(plot.title = element_text(hjust = 0.5))
{% endhighlight %}

We can generate a nicer plot using plot_composition function
{% highlight r %}
p <- plot_composition(data_rare,
                      taxaRank1 = "Kingdom",
                      taxaSet1 ="Bacteria",
                      taxaRank2 = "Phylum", 
                      numberOfTaxa = 20, 
                      fill= "Phylum") +
  facet_wrap(~env_material, scales = "free_x", nrow = 1) + 
  theme(plot.title = element_text(hjust = 0.5)) 

plot(p)
{% endhighlight %}


-----------------------
<a name="exercises"></a>
#### 3.10 Some exercises

1. How many OTUs belong to Archaea (in two commands using `%>%`)

2. Plot OTU richness (and only richness = 'Observed' in phyloseq) of Alphaproteobacteria among samples 

3. Explore  beta diversity of Alphaproteobacteria using "morisita" distance without data transformation and without considering endosphere samples (subset_samples). Are sample from Bulk_Soil and  Rhizosphere different in terms of beta-diversity (use  %in% c("Soil", "Prank") in order to subset from several categories

4. Plot proportion Chloroplasts 

5. Plot proportion of OTU belonging to Mitochondria and facet the plot according to Site (i.e., env_material) 
some surprises ?

6. a Plot beta-diversity of Mitochondria and Chloroplasts OTU using Bray-Curtis distance on untransformed table
6 b. what is the percentage of Mitochondria and Chloroplasts OTU
6 c. plot a basic barplot of it 

7. Do the filterd-out OTU display alpha / beta diversity patterns?

-----------------------

### Links
<a name="links"></a>
* Related courses : [Metabarcoding](http://sepsis-omics.github.io/tutorials/modules/frogs/)

-----------------------

### License
<a name="license"></a>

<div>
The resource material is licensed under the Creative Commons Attribution 4.0 International License (<a href="http://creativecommons.org/licenses/by-nc-sa/4.0/">here</a>).
<center><img width="25%" class="img-responsive" src="http://creativecommons.org.nz/wp-content/uploads/2012/05/by-nc-sa1.png"/>
</center>
</div>
