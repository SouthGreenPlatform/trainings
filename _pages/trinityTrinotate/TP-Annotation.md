| Description | Hands On Lab Exercises for  RNASeq annotation |
| :------------- | :------------- | :------------- | :------------- |
| Related-course materials | [Linux for Dummies](https://southgreenplatform.github.io/trainings/linux/) |
| Authors | Julie Orjuela-Bouniol (julie.orjuela@ird.fr)  - i-trop platform (UMR BOREA / DIADE / IPME - IRD) |
| Creation Date | 03/08/2018 |
| Last Modified Date | 19/09/2019 |
| Modified by | ...|



# TP Annotation des transcrits avec `Trinotate`

## Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Preambule : Connection to the i-Trop cluster - `ssh,srun,scp`](#practice-0)
* [Practice 1: Trinotate pipeline : first part (run_trinotate.slurm script )](#practice-1)
* [Practice 2: Trinotate pipeline : second part (Annotation report script)](#practice-2)
* [License](#license)

-----------------------

## Preambule

Transcrits assembled using Trinity can be easily annotate using trinotate https://github.com/Trinotate/Trinotate.github.io/wiki.

Trinotate use different methods for functional annotation including homology search to known sequence data (BLAST+/SwissProt), protein domain identification (HMMER/PFAM), protein signal peptide and transmembrane domain prediction (signalP/tmHMM), and take advantage from annotation databases (eggNOG/GO/Kegg). These data are integrated into a SQLite database which allows to create an annotation report for a transcriptome.

Two bash scripts were created to obtain the whole of files obligatories to build a Sqlite database and create reports.

-----------------------

<a name="practice-0"></a>
## 0. Connection to the i-Trop Cluster through `ssh` mode

We will work on the i-Trop Cluster with a "supermem" node using SLURM scheduler.

```bash
ssh formationX@bioinfo-master.ird.fr
```

### Connection to supermem partition

Connect you to node25 (supermem partition) without opening an interactive bash session
```bash
ssh node25
```

### Prepare input files
```bash
#make directory to annotation
cd /scratch/formationX/
mkdir ANNOTATION
cd ANNOTATION

# make a symbolic link for fasta assembly. now assembled sequences is called sacharomyces.fasta
ln -s /scratch/formationX/TRINITY_OUT/Trinity.fasta sacharomyces.fasta

#copy script into this ANNOTATION repertory
scp nas:/data2/formation/TP-trinity/scripts/run_trinotate.slurm .

#open script with nano and adapt pathToSratch variable with your formation number
pathToScratch="/tmp/formationX/ANNOTATION/"
```

<a name="practice-1"></a>
## 1. Trinotate pipeline  : first part (run_trinotate.slurm script )

Let's run `run_trinotate.slurm` to obtain ORFs, seach sequence homology and conserved domains and others ...

```bash
# run annotation script in slurm
sbatch run_trinotate.slurm
```

WARNING /!\ : This job can be run for about 12h.

You can scp results from `nas:/data2/formation/TP-trinity/TP/ANNOTATION/` to your `/scratch/formationX` repertory.

What is doing this script ? Most important steps are explained here :


### Determining longest Open Reading Frames (ORFs)

First step of the annotation of transcript is to determine open reading frame (ORFs), they will be then annotated. Use `TransDecoder` to identy likely coding sequences based on the following steps:

Running TransDecoder is a two-step process. First run the TransDecoder step that identifies all long ORFs and then the step that predicts which ORFs are likely to be coding (TransDecoder.LongOrfs, TransDecoder.Predict). Once you have the sequences you can start looking for sequence or domain homologies.


```bash
# 2 generation of peptide file (TransDecoder.LongOrfs)
 
# 2.1 generation of longestOrf with minimum protein length 50aa
TransDecoder.LongOrfs -t $pathToScratch/sacharomyces.fasta \
--gene_trans_map $pathToScratch/results_sacharomyces/sacharomyces.fasta_gene_trans_map\
-m 50 
```


```bash
# 2.2a recherche d’identité parmis les longorfs hmmscan
# Let's run a HMMER search against the Pfam database using the longorfs and identify conserved 
# domains that might be indicative or suggestive of function
hmmscan --cpu 2 --domtblout pfam_longorfs.domtblout\
$pathToScratch/DB/Pfam-A.hmm \
$pathToScratch/results_sacharomyces/sacharomyces.fasta.transdecoder_dir/longest_orfs.pep 
```


```bash
# 2.2b recherche d’identité parmis les longorfs by blastp with diamond
/usr/local/diamond-0.8.29/diamond blastp \
--query $pathToScratch/results_sacharomyces/sacharomyces.fasta.transdecoder_dir/longest_orfs.pep\
--db $pathToScratch/DB/uniprot_sprot \
--out diamP_uniprot_longorfs.outfmt 6\
--outfmt 6 \
--max-target-seqs 1
```

Now, run the step that predicts which ORFs are likely to be coding.


```bash
# #2.3 Prediction peptides (TransDecoder.Predict)
TransDecoder.Predict --cpu 2 \
-t $pathToScratch/sacharomyces.fasta \
--retain_pfam_hits $pathToScratch/results_sacharomyces/pfam_longorfs.domtblout \
--retain_blastp_hits $pathToScratch/results_sacharomyces/diamP_uniprot_longorfs.outfmt6 
```

### Sequence homology searches from predicted protein sequences

Now, let's look for sequence homologies by just searching our predicted protein sequences rather than using the entire transcript as a target


```bash
# 3 Recherche de similarité en utilisant Diamond
 
# blastp diamP_uniprot
/usr/local/diamond-0.8.29/diamond blastp \
--query $pathToScratch/results_sacharomyces/sacharomyces.fasta.transdecoder.pep \
--threads 2 \
--db $pathToScratch/DB/uniprot_sprot \
--out $pathToScratch/results_sacharomyces/diamP_uniprot.outfmt6\
--outfmt 6 \
--max-target-seqs 1\
--more-sensitive 
```


```bash
# blastp diamP_uniref90 
/usr/local/diamond-0.8.29/diamond blastp \
--query $pathToScratch/results_sacharomyces/sacharomyces.fasta.transdecoder.pep \
--threads 2 \
--db $pathToScratch/DB/uniref90.fasta \
--out $pathToScratch/results_sacharomyces/diamP_uniref90.outfmt6 \
--outfmt 6 \
--max-target-seqs 1 \
--more-sensitive 
```


```bash
# blastx diamX_uniprot 
/usr/local/diamond-0.8.29/diamond blastx \
--query $pathToScratch/sacharomyces.fasta \
--threads 2 \
--db $pathToScratch/DB/uniprot_sprot \
--out diamX_uniprot.outfmt6 \
--outfmt 6 \
--max-target-seqs 1 \
--more-sensitive 
```


```bash
# blastx diamX_uniref90 
/usr/local/diamond-0.8.29/diamond blastx \
--query $pathToScratch/sacharomyces.fasta \
--threads 2\
--db $pathToScratch/DB/uniref90.fasta \
--out diamX_uniref90.outfmt6 \
--outfmt 6 \
--max-target-seqs 1 \
--more-sensitive
```

### Search conserved domains

Using our predicted protein sequences, let's also run a HMMER search against the Pfam database, and identify conserved domains that might be indicative or suggestive of function


```bash
# 3 recherche de domaines 
hmmscan --cpu 2 --domtblout $pathToScratch/results_sacharomyces/sacharomyces_PFAM.out\
$pathToScratch/DB/Pfam-A.hmm \
$pathToScratch/results_sacharomyces/sacharomyces.fasta.transdecoder.pep > $pathToScratch/results_sacharomyces/pfam.log
```

### Computational prediction of sequence features


#### Recheche de peptides signaux

The signalP and tmhmm software tools are very useful for predicting signal peptides (secretion signals) and transmembrane domains, respectively.


```bash
# 4 recheche de peptides signaux 
perl /usr/local/signalp-4.1/signalp \
-f short \
-n $pathToScratch/results_sacharomyces/sacharomyces_signalp.out \
$pathToScratch/results_sacharomyces/sacharomyces.fasta.transdecoder.pep 
```


```bash
# 5 recherche de domaines transmembranaires # undetected in this dataset
tmhmm --short <  $pathToScratch/results_sacharomyces/sacharomyces.fasta.transdecoder.pep > $pathToScratch/results_sacharomyces/sacharomyces.tmhmm.out  
```

question : How many of your proteins are predicted to encode signal peptides?

#### ￼Running Rnammer to detected rRNA

The program uses hidden Markov models trained on data from the 5S ribosomal RNA database and the European ribosomal RNA database project


```bash
# 6 recherche de rRNA 
/usr/local/Trinotate-3.0.1/util/rnammer_support/RnammerTranscriptome.pl \
--transcriptome $pathToScratch/sacharomyces.fasta \
--org_type euk \
--path_to_rnammer /usr/local/rnammer-1.2/rnammer
```

--------------------------------------
<a name="practice-1"></a>
# Trinotate pipeline : second part (Annotation report script)

 
 

#### Loading results into a Trinotate SQLite database and generating a report.

Generating a Trinotate annotation report involves first loading all of our bioinformatics computational results into a Trinotate SQLite database. The Trinotate software provides a boilerplate SQLite database called `Trinotate.sqlite` that comes pre-populated with a lot of generic data about SWISSPROT records and Pfam domains. This database is populated with all computes obtained before and the expression data to build a final report.

- Run the second bash script `build_Sqlite_trinotate_database_and_report-JAv1.2.0.sh` . This script needs as input the assembled transcrits and the repertory containing the whole of results obtained by `run_trinotate.slurm` (option -r) and the transcripts assembled by trinity file (option -f).


```bash
#go to annotation results directory
cd /scratch/orjuela/ANNOTATION/results_sacharomyces
#run script
bash ~/scripts_gitlab/itrop_cluster/build_Sqlite_trinotate_database_and_report-JAv1.2.0.sh -f /scratch/orjuela/ANNOTATION/sacharomyces.fasta -r /scratch/orjuela/ANNOTATION/results_sacharomyces/
```


```bash
#7 recuperation de la base Trinotate
echo "7 Recuperation de la base Trinotate"
wget "https://data.broadinstitute.org/Trinity/Trinotate_v3_RESOURCES/Trinotate_v3.sqlite.gz" -O Trinotate.sqlite.gz
gunzip Trinotate.sqlite.gz

#8 chargement des analyses dans la base
echo "8 chargement des analyses dans la base"
/usr/local/Trinotate-3.0.1/Trinotate $resultsDir/Trinotate.sqlite init --gene_trans_map $geneTransMap --transcript_fasta $fasta --transdecoder_pep $transdecoderPep

#charging swissprot/uniprot P and X results
echo " -->charging swissprot/uniprot P and X results"
/usr/local/Trinotate-3.0.1/Trinotate $resultsDir/Trinotate.sqlite LOAD_swissprot_blastp diamP_uniprot.outfmt6
/usr/local/Trinotate-3.0.1/Trinotate $resultsDir/Trinotate.sqlite LOAD_swissprot_blastx diamX_uniprot.outfmt6

#charging uniref90 P and X results
echo " -->charging  uniref90 P and X results" 
/usr/local/Trinotate-3.0.1/Trinotate $resultsDir/Trinotate.sqlite LOAD_custom_blast --outfmt6 diamP_uniref90.outfmt6 --prog blastp --dbtype uniref90
/usr/local/Trinotate-3.0.1/Trinotate $resultsDir/Trinotate.sqlite LOAD_custom_blast --outfmt6 diamX_uniref90.outfmt6 --prog blastx --dbtype uniref90

#charging pfam, tmhmm, signalp and rnammer
echo " -->charging  pfam, tmhmm, signalp and rnammer"
/usr/local/Trinotate-3.0.1/Trinotate $resultsDir/Trinotate.sqlite LOAD_pfam $shortName"_PFAM.out" 
/usr/local/Trinotate-3.0.1/Trinotate $resultsDir/Trinotate.sqlite LOAD_tmhmm $shortName".tmhmm.out"
/usr/local/Trinotate-3.0.1/Trinotate $resultsDir/Trinotate.sqlite LOAD_rnammer $shortName".fasta.rnammer.gff"

if [ -s $signalp ]; then
	#charging signalp
	/usr/local/Trinotate-3.0.1/Trinotate $resultsDir/Trinotate.sqlite LOAD_signalp $shortName".signalp.out"
	ls $signalp
fi

# 9 generation du report
echo "9 generation du report"
/usr/local/Trinotate-3.0.1/Trinotate $resultsDir/Trinotate.sqlite report > $shortName"_annotation_report.xls"

#filtré sur les e-value des annotations
echo " -->filtré sur les e-value des annotations"
/usr/local/Trinotate-3.0.1/Trinotate $resultsDir/Trinotate.sqlite report -E 10e-10 > $shortName"_annotation_report_filtered.xls"

#10 generation de statistiques
echo "10 generation de statistiques"
/usr/local/Trinotate-3.0.1/util/count_table_fields.pl $resultsDir/$shortName"_annotation_report_filtered.xls" > $shortName"_table_fields.txt"

#11 extract GO terms
echo "extract GO terms"
/usr/local/Trinotate-3.0.1/util/extract_GO_assignments_from_Trinotate_xls.pl --Trinotate_xls $shortName"_annotation_report_filtered.xls" -G --include_ancestral_terms > $shortName"_go_annotations.txt"

echo " pour visualiser les GO va sur le site : " 
echo "site wego : http://wego.genomics.org.cn/"
```

```bash
[orjuela@node25 results_sacharomyces]$ more sacharomyces_table_fields.txt
transcript_id	15839
#gene_id	15839
uniref90_BLASTX	15178
prot_id	14898
prot_coords	14898
sprot_Top_BLASTX_hit	14852
uniref90_BLASTP	13086
sprot_Top_BLASTP_hit	12641
gene_ontology_blast	11842
Kegg	11592
Pfam	9327
gene_ontology_pfam	6120
eggnog	2988
SignalP	42
RNAMMER	34
transcript	0
peptide	0
TmHMM	0
```

Report can be found in `sacharomyces_annotation_report_filtered.xls` file. For details of report generated go to https://github.com/Trinotate/Trinotate.github.io/wiki/Loading-generated-results-into-a-Trinotate-SQLite-Database-and-Looking-the-Output-Annotation-Report

if you want to visualise GO go to wego site : http://wego.genomics.org.cn/ and import your `sacharomyces_go_annotations.txt` file.



```bash

```


```bash

```

-----------------------

### License
<a name="license"></a>

<div>
The resource material is licensed under the Creative Commons Attribution 4.0 International License (<a href="http://creativecommons.org/licenses/by-nc-sa/4.0/">here</a>).
<center><img width="25%" class="img-responsive" src="http://creativecommons.org.nz/wp-content/uploads/2012/05/by-nc-sa1.png"/>
</center>
</div>
