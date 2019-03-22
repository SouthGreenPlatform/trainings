#!/bin/bash
frogs_dir="/usr/local/Miniconda2-1.0/envs/frogs/share/FROGS-2.0.1/" # pour fichier pynast
samplefile="/home/orjuela/TEST-FROGS/fromGitExemple/sample_metadata.tsv" ####### A MODIFIER/VERIFIER 
db="/usr/local/frogs_databases-2.01/silva_123_16S/silva_123_16S.fasta"  #######
nb_cpu=4
java_mem=20
# from user
minAmpliconSize=$1
maxAmpliconSize=$2
fivePrimPrimer=$3
threePrimPrimer=$4
R1size=$5
R2size=$6
expectedAmpliconSize=$7
out_dir=$8
datasetTarGz=$9

#bash ~/scripts/run_frogs_pipeline.sh 380 460 GGCGVACGGGTGAGTAA GTGCCAGCNGCNGCGG 250 250 420 OUTPUT /home/orjuela/TEST-FROGS/fromGitExemple/test_dataset.tar.gz

#bash ~/Documents/tools/FROGS/test/run_frogs_pipeline.sh 230 310 CAGCMGCCGCGGTAA GGATTAGATACCCBDGTAGTC 250 250 290 OUT2 ~/Documents/2018/projet_metagenomique_odileBrunnel/data.tar.gz
#TODO: ne marche pas s'il n'y a pas les seq des amorces utilisés pour l'amplicon (methode )

# Check parameters
if [ "$#" -ne 9 ]; then
    echo "ERROR: Illegal number of parameters." ;
    echo 'Command usage: run_frogs_pipeline.sh <minAmpliconSize> <maxAmpliconSize> <fivePrimPrimer> <threePrimPrimer> <R1size> <R2size> <expectedAmpliconSize> <out_dir> <datasetTarGz>' ;
    #echo 'Command usage: run_frogs_pipeline <FROGS_FOLDER> <NB_CPU> <JAVA_MEM> <OUT_FOLDER> <datasetTarGz>' ;
    exit 1 ;
fi
echo $minAmpliconSize;
echo $maxAmpliconSize;
echo $fivePrimPrimer;
echo $threePrimPrimer;
echo $R1size;
echo $R2size;
echo $expectedAmpliconSize;
echo $out_dir;
echo $datasetTarGz;

# Set ENV
export PATH=$frogs_dir/libexec:$frogs_dir/app:$PATH
export PYTHONPATH=$frogs_dir/lib:$PYTHONPATH
#module load bioinfo/FROGS/2.01
#source activate frogs

# Create output folder
if [ ! -d "$out_dir" ]
then
    mkdir $out_dir
fi


echo "Step preprocess `date`"

preprocess.py illumina \
 --min-amplicon-size $minAmpliconSize --max-amplicon-size $maxAmpliconSize \
 --five-prim-primer $fivePrimPrimer --three-prim-primer $threePrimPrimer \
 --R1-size $R1size --R2-size $R2size --expected-amplicon-size $expectedAmpliconSize \
 --input-archive $datasetTarGz \
 --output-dereplicated $out_dir/01-prepro.fasta \
 --output-count $out_dir/01-prepro.tsv \
 --summary $out_dir/01-prepro.html \
 --log-file $out_dir/01-prepro.log \
 --nb-cpus $nb_cpu --mismatch-rate 0.15
 
if [ $? -ne 0 ]
then
	echo "Error in preprocess" >&2
	exit 1;
fi


echo "Step clustering `date`"

clustering.py \
 --distance 1 \
 --input-fasta $out_dir/01-prepro.fasta \
 --input-count $out_dir/01-prepro.tsv \
 --output-biom $out_dir/02-clustering.biom \
 --output-fasta $out_dir/02-clustering.fasta \
 --output-compo $out_dir/02-clustering_compo.tsv \
 --log-file $out_dir/02-clustering.log \
 --nb-cpus $nb_cpu

#clustering.py \
# --distance 3 \
# --denoising \
# --input-fasta $out_dir/01-prepro.fasta \
# --input-count $out_dir/01-prepro.tsv \
# --output-biom $out_dir/02-clustering.biom \
# --output-fasta $out_dir/02-clustering.fasta \
# --output-compo $out_dir/02-clustering_compo.tsv \
# --log-file $out_dir/02-clustering.log \
# --nb-cpus $nb_cpu


if [ $? -ne 0 ]
then
	echo "Error in clustering" >&2
	exit 1;
fi


echo "Step remove_chimera `date`"

remove_chimera.py \
 --input-fasta $out_dir/02-clustering.fasta \
 --input-biom $out_dir/02-clustering.biom \
 --non-chimera $out_dir/03-chimera.fasta \
 --out-abundance $out_dir/03-chimera.biom \
 --summary $out_dir/03-chimera.html \
 --log-file $out_dir/03-chimera.log \
 --nb-cpus $nb_cpu
 
if [ $? -ne 0 ]
then
	echo "Error in remove_chimera" >&2
	exit 1;
fi


echo "Step filters `date`"

filters.py \
 --min-abundance 0.00005 \
 --min-sample-presence 2\
 --input-biom $out_dir/03-chimera.biom \
 --input-fasta $out_dir/03-chimera.fasta \
 --output-fasta $out_dir/04-filters.fasta \
 --output-biom $out_dir/04-filters.biom \
 --excluded $out_dir/04-filters.excluded \
 --summary $out_dir/04-filters.html \
 --log-file $out_dir/04-filters.log 

if [ $? -ne 0 ]
then
	echo "Error in filters" >&2
	exit 1;
fi


echo "Step affiliation_OTU `date`"

affiliation_OTU.py \
 --reference $db \
 --input-fasta $out_dir/04-filters.fasta \
 --input-biom $out_dir/04-filters.biom \
 --output-biom $out_dir/04-affiliation.biom \
 --summary $out_dir/04-affiliation.html \
 --log-file $out_dir/04-affiliation.log \
 --nb-cpus $nb_cpu --java-mem $java_mem \
 --rdp

if [ $? -ne 0 ]
then
	echo "Error in affiliation_OTU" >&2
	exit 1;
fi


echo "Step clusters_stat `date`"

clusters_stat.py \
 --input-biom $out_dir/04-affiliation.biom \
 --output-file $out_dir/05-clustersStat.html \
 --log-file $out_dir/05-clustersStat.log

if [ $? -ne 0 ]
then
	echo "Error in clusters_stat" >&2
	exit 1;
fi


echo "Step affiliations_stat `date`"

affiliations_stat.py \
 --input-biom $out_dir/04-affiliation.biom \
 --output-file $out_dir/06-affiliationsStat.html \
 --log-file $out_dir/06-affiliationsStat.log \
 --tax-consensus-tag "blast_taxonomy" \
 --identity-tag "perc_identity" \
 --coverage-tag "perc_query_coverage" \
 --multiple-tag "blast_affiliations" \
 --rarefaction-ranks Family Genus Species

if [ $? -ne 0 ]
then
	echo "Error in affiliations_stat" >&2
	exit 1;
fi


echo "Step biom_to_tsv `date`"

biom_to_tsv.py \
 --input-biom $out_dir/04-affiliation.biom \
 --input-fasta $out_dir/04-filters.fasta \
 --output-tsv $out_dir/07-biom2tsv.tsv \
 --output-multi-affi $out_dir/07-biom2tsv.multi \
 --log-file $out_dir/07-biom2tsv.log

if [ $? -ne 0 ]
then
	echo "Error in biom_to_tsv" >&2
	exit 1;
fi

echo "Step biom_to_stdBiom `date`"


biom_to_stdBiom.py \
 --input-biom $out_dir/04-affiliation.biom \
 --output-biom $out_dir/08-affiliation_std.biom \
 --output-metadata $out_dir/08-affiliation_multihit.tsv \
 --log-file $out_dir/08-biom2stdbiom.log

if [ $? -ne 0 ]
then
	echo "Error in biom_to_stdBiom" >&2
	exit 1;
fi

echo "Step tsv_to_biom `date`"


tsv_to_biom.py \
 --input-tsv $out_dir/07-biom2tsv.tsv \
 --input-multi-affi $out_dir/07-biom2tsv.multi \
 --output-biom $out_dir/09-tsv2biom.biom \
 --output-fasta $out_dir/09-tsv2biom.fasta \
 --log-file $out_dir/09-tsv2biom.log 

if [ $? -ne 0 ]
then
	echo "Error in tsv_to_biom" >&2
	exit 1;
fi

#echo "Step tree : pynast `date`"

#tree.py \
# --nb-cpus $nb_cpu  \
# --input-otu $out_dir/04-filters.fasta \
# --biomfile $out_dir/04-affiliation.biom \
# --template-pynast $frogs_dir/test/data/otus_pynast.fasta \
# --out-tree $out_dir/10a-tree.nwk \
# --html $out_dir/10a-tree.html \
# --log-file $out_dir/10a-tree.log
 
#if [ $? -ne 0 ]
#then
#	echo "Error in tree : pynast" >&2
#	exit 1;
#fi

echo "Step tree : mafft `date`"

tree.py \
 --nb-cpus $nb_cpu \
 --input-otu $out_dir/04-filters.fasta \
 --biomfile $out_dir/04-affiliation.biom \
 --out-tree $out_dir/10b-tree.nwk \
 --html $out_dir/10b-tree.html \
 --log-file $out_dir/10b-tree.log

if [ $? -ne 0 ]
then
	echo "Error in tree : mafft" >&2
	exit 1;
fi

echo "Step r_import_data `date`"

r_import_data.py  \
 --biomfile $out_dir/08-affiliation_std.biom \
 --samplefile $samplefile \
 --treefile $out_dir/10b-tree.nwk \
 --rdata $out_dir/11-phylo_import.Rdata --html $out_dir/11-phylo_import.html --log-file $out_dir/11-phylo_import.log

 
if [ $? -ne 0 ]
then
	echo "Error in r_import_data " >&2
	exit 1;
fi

echo "Step r_composition `date`"

r_composition.py  \
 --varExp Color --taxaRank1 Kingdom --taxaSet1 Bacteria --taxaRank2 Phylum --numberOfTaxa 9 \
 --rdata $out_dir/11-phylo_import.Rdata \
 --html $out_dir/12-phylo_composition.html --log-file $out_dir/12-phylo_composition.log

 
if [ $? -ne 0 ]
then
	echo "Error in r_composition " >&2
	exit 1;
fi

echo "Step r_alpha_diversity `date`"

r_alpha_diversity.py  \
 --varExp Color \
 --rdata $out_dir/11-phylo_import.Rdata --alpha-measures Observed Chao1 Shannon \
 --alpha-out $out_dir/13-phylo_alpha_div.tsv --html $out_dir/13-phylo_alpha_div.html --log-file $out_dir/13-phylo_alpha_div.log

 
if [ $? -ne 0 ]
then
	echo "Error in r_alpha_diversity " >&2
	exit 1;
fi

echo "Step r_beta_diversity `date`"

r_beta_diversity.py  \
 --varExp Color --distance-methods cc,unifrac \
 --rdata $out_dir/11-phylo_import.Rdata \
 --matrix-outdir $out_dir --html $out_dir/14-phylo_beta_div.html --log-file $out_dir/14-phylo_beta_div.log

 
if [ $? -ne 0 ]
then
	echo "Error in r_beta_diversity " >&2
	exit 1;
fi

#~ echo "Step r_structure `date`"
#~ 
#~ r_structure.py  \
 #~ --varExp Color --ordination-method MDS \
 #~ --rdata $out_dir/11-phylo_import.Rdata --distance-matrix $out_dir/Unifrac.tsv \
 #~ --html $out_dir/15-phylo_structure.html --log-file $out_dir/15-phylo_structure.log
#~ 
 #~ 
#~ if [ $? -ne 0 ]
#~ then
	#~ echo "Error in r_structure " >&2
	#~ exit 1;
#~ fi

echo "Step r_clustering `date`"

r_clustering.py  \
 --varExp Color \
 --rdata $out_dir/11-phylo_import.Rdata --distance-matrix $out_dir/Unifrac.tsv \
 --html $out_dir/16-phylo_clutering.html --log-file $out_dir/16-phylo_clustering.log

 
if [ $? -ne 0 ]
then
	echo "Error in r_clustering " >&2
	exit 1;
fi

echo "Step r_manova `date`"

r_manova.py  \
 --varExp Color \
 --rdata $out_dir/11-phylo_import.Rdata --distance-matrix $out_dir/Unifrac.tsv \
 --html $out_dir/17-phylo_manova.html --log-file $out_dir/17-phylo_manova.log

 
if [ $? -ne 0 ]
then
	echo "Error in r_manova " >&2
	exit 1;
fi

echo "Completed with success"
#on desactive l'environement FROGS
source deactivate
