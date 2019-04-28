#!/bin/bash -

# ------------------------------------------------------------------- variables

tmp=$PWD
frogs_dir="/usr/local/Miniconda2-1.0/envs/frogs/share/FROGS-2.0.1/" # pour fichier pynast
samplefile="${tmp}/summary.txt" ####### A MODIFIER/VERIFIER
db="${tmp}/silva_123_16S.fasta" #######
java_mem=20


# ------------------------------------------------------------- set environment

module load bioinfo/FROGS/2.01 && source activate frogs
module load bioinfo/R/3.5.1


# ----------------------------------------------------------------------- usage

## example:
# bash ~/scripts/run_frogs_pipeline.sh \
#      380 \
#      460 \
#      GGCGVACGGGTGAGTAA \
#      GTGCCAGCNGCNGCGG \
#      250 \
#      250 \
#      420 \
#      OUTPUT \
#      /home/orjuela/TEST-FROGS/fromGitExemple/test_dataset.tar.gz
#      4

# from user
minAmpliconSize="${1}"
maxAmpliconSize="${2}"
fivePrimPrimer="${3}"
threePrimPrimer="${4}"
R1size="${5}"
R2size="${6}"
expectedAmpliconSize="${7}"
out_dir="${8}"
datasetTarGz="${9}"
nb_cpu="${10}"

# Check parameters
if [[ "$#" -ne 10 ]] ; then
    echo "ERROR: Illegal number of parameters." 1>&2
    echo "Command usage:" 1>&2
    echo -n "bash ${0} <minAmpliconSize> <maxAmpliconSize> " 1>&2
    echo -n "<fivePrimPrimer> <threePrimPrimer> <R1size> <R2size> " 1>&2
    echo -n "<expectedAmpliconSize> <out_dir> <datasetTarGz>" 1>&2
    exit 1
fi
echo "minAmpliconSize: ${minAmpliconSize}"
echo "maxAmpliconSize: ${maxAmpliconSize}"
echo "fivePrimPrimer: ${fivePrimPrimer}"
echo "threePrimPrimer: ${threePrimPrimer}"
echo "R1size: ${R1size}"
echo "R2size: ${R2size}"
echo "expectedAmpliconSize: ${expectedAmpliconSize}"
echo "out_dir: ${out_dir}"
echo "datasetTarGz: ${datasetTarGz}"
echo "cpu: ${nb_cpu}"

# Create output folder
mkdir -p "${out_dir}"


# ------------------------------------- trim, merge and dereplicate fastq files

echo "Step preprocess $(date)"

if [[ "${fivePrimPrimer}" == "None" && "${threePrimPrimer}" == "None" ]] ; then
    PRIMER_PARAMETERS="--without-primers"
else
    FIVE="--five-prim-primer ${fivePrimPrimer}"
    THREE="--three-prim-primer ${threePrimPrimer}"
    PRIMER_PARAMETERS="${FIVE} ${THREE}"
    unset FIVE THREE
fi

preprocess.py \
    illumina \
    --min-amplicon-size "${minAmpliconSize}" \
    --max-amplicon-size "${maxAmpliconSize}" \
    ${PRIMER_PARAMETERS} \
    --R1-size "${R1size}" \
    --R2-size "${R2size}" \
    --expected-amplicon-size "${expectedAmpliconSize}" \
    --input-archive "${datasetTarGz}" \
    --output-dereplicated "${out_dir}/01-prepro.fasta" \
    --output-count "${out_dir}/01-prepro.tsv" \
    --summary "${out_dir}/01-prepro.html" \
    --log-file "${out_dir}/01-prepro.log" \
    --nb-cpus "${nb_cpu}" \
    --mismatch-rate 0.15 || \
    { echo "Error in preprocess" 1>&2 ; exit 1 ; }


# ------------------------------------------------------- clusterize fasta file

echo "Step clustering $(date)"

clustering.py \
 --distance 1 \
 --input-fasta "${out_dir}/01-prepro.fasta" \
 --input-count "${out_dir}/01-prepro.tsv" \
 --output-biom "${out_dir}/02-clustering.biom" \
 --output-fasta "${out_dir}/02-clustering.fasta" \
 --output-compo "${out_dir}/02-clustering_compo.tsv" \
 --log-file "${out_dir}/02-clustering.log" \
 --nb-cpus "${nb_cpu}" || \
    { echo "Error in clustering" 1>&2 ; exit 1 ; }


# ------------------------------------------------------------- remove chimeras

echo "Step remove_chimera $(date)"

remove_chimera.py \
 --input-fasta "${out_dir}/02-clustering.fasta" \
 --input-biom "${out_dir}/02-clustering.biom" \
 --non-chimera "${out_dir}/03-chimera.fasta" \
 --out-abundance "${out_dir}/03-chimera.biom" \
 --summary "${out_dir}/03-chimera.html" \
 --log-file "${out_dir}/03-chimera.log" \
 --nb-cpus "${nb_cpu}" || \
    { echo "Error in remove_chimera" 1>&2 ; exit 1 ; }


# ------------------------------------------------------------------- filtering

echo "Step filters $(date)"

filters.py \
 --min-abundance 0.00005 \
 --min-sample-presence 2 \
 --input-biom "${out_dir}/03-chimera.biom" \
 --input-fasta "${out_dir}/03-chimera.fasta" \
 --output-fasta "${out_dir}/04-filters.fasta" \
 --output-biom "${out_dir}/04-filters.biom" \
 --excluded "${out_dir}/04-filters.excluded" \
 --summary "${out_dir}/04-filters.html" \
 --log-file "${out_dir}/04-filters.log" || \
    { echo "Error in filtering" 1>&2 ; exit 1 ; }

# remove clusters representing less than 0.005% of the dataset, remove
# clusters that are present in only one sample (what about endemic
# clusters?)


# ------------------------- taxonomic assignment (rdp classifier vs. Silva 16S)

echo "Step affiliation_OTU $(date)"

affiliation_OTU.py \
 --reference "${db}" \
 --input-fasta "${out_dir}/04-filters.fasta" \
 --input-biom "${out_dir}/04-filters.biom" \
 --output-biom "${out_dir}/04-affiliation.biom" \
 --summary "${out_dir}/04-affiliation.html" \
 --log-file "${out_dir}/04-affiliation.log" \
 --nb-cpus "${nb_cpu}" \
 --java-mem "${java_mem}" \
 --rdp || \
    { echo "Error in affiliation_OTU" 1>&2 ; exit 1 ; }


# --------------------------------------------------------------- cluster stats

echo "Step clusters_stat $(date)"

clusters_stat.py \
 --input-biom "${out_dir}/04-affiliation.biom" \
 --output-file "${out_dir}/05-clustersStat.html" \
 --log-file "${out_dir}/05-clustersStat.log" || \
    { echo "Error in clusters_stat" 1>&2 ; exit 1 ; }


# ------------------------------------------------------------- taxonomic stats

echo "Step affiliations_stat $(date)"

affiliations_stat.py \
 --input-biom "${out_dir}/04-affiliation.biom" \
 --output-file "${out_dir}/06-affiliationsStat.html" \
 --log-file "${out_dir}/06-affiliationsStat.log" \
 --tax-consensus-tag "blast_taxonomy" \
 --identity-tag "perc_identity" \
 --coverage-tag "perc_query_coverage" \
 --multiple-tag "blast_affiliations" \
 --rarefaction-ranks Family Genus Species || \
    { echo "Error in affiliations_stat" 1>&2 ; exit 1 ; }


# ---------------------------------------------- convert biom file into a table

echo "Step biom_to_tsv $(date)"

biom_to_tsv.py \
 --input-biom "${out_dir}/04-affiliation.biom" \
 --input-fasta "${out_dir}/04-filters.fasta" \
 --output-tsv "${out_dir}/07-biom2tsv.tsv" \
 --output-multi-affi "${out_dir}/07-biom2tsv.multi" \
 --log-file "${out_dir}/07-biom2tsv.log" || \
    { echo "Error in affiliations_stat" 1>&2 ; exit 1 ; }


# ------------------------------------------------------- standardize biom file

echo "Step biom_to_stdBiom $(date)"

biom_to_stdBiom.py \
 --input-biom "${out_dir}/04-affiliation.biom" \
 --output-biom "${out_dir}/08-affiliation_std.biom" \
 --output-metadata "${out_dir}/08-affiliation_multihit.tsv" \
 --log-file "${out_dir}/08-biom2stdbiom.log" || \
    { echo "Error in biom_to_stdBiom" 1>&2 ; exit 1 ; }


# ---------------------------------- convert taxonomic assignment table to biom

echo "Step tsv_to_biom $(date)"

tsv_to_biom.py \
 --input-tsv "${out_dir}/07-biom2tsv.tsv" \
 --input-multi-affi "${out_dir}/07-biom2tsv.multi" \
 --output-biom "${out_dir}/09-tsv2biom.biom" \
 --output-fasta "${out_dir}/09-tsv2biom.fasta" \
 --log-file "${out_dir}/09-tsv2biom.log" || \
    { echo "Error in tsv_to_biom" 1>&2 ; exit 1 ; }


# ---------------------------------------------------- build a tree with pynast

echo "Step tree (with pynast) $(date)"

tree.py \
 --nb-cpus "${nb_cpu}"  \
 --input-otu "${out_dir}/04-filters.fasta" \
 --biomfile "${out_dir}/04-affiliation.biom" \
 --template-pynast "${frogs_dir}/test/data/otus_pynast.fasta" \
 --out-tree "${out_dir}/10a-tree.nwk" \
 --html "${out_dir}/10a-tree.html" \
 --log-file "${out_dir}/10a-tree.log" || \
    { echo "Error in tree (with pynast)" 1>&2 ; exit 1 ; }


# ----------------------------------------------------- build a tree with mafft

echo "Step tree (with mafft) $(date)"

tree.py \
 --nb-cpus "${nb_cpu}" \
 --input-otu "${out_dir}/04-filters.fasta" \
 --biomfile "${out_dir}/04-affiliation.biom" \
 --out-tree "${out_dir}/10b-tree.nwk" \
 --html "${out_dir}/10b-tree.html" \
 --log-file "${out_dir}/10b-tree.log" || \
    { echo "Error in tree (with mafft)" 1>&2 ; exit 1 ; }


# ------------------------------------------------------------ import data in R

echo "Step r_import_data $(date)"

r_import_data.py  \
 --biomfile "${out_dir}/08-affiliation_std.biom" \
 --samplefile "${samplefile}" \
 --treefile "${out_dir}/10b-tree.nwk" \
 --rdata "${out_dir}/11-phylo_import.Rdata" \
 --html "${out_dir}/11-phylo_import.html" \
 --log-file "${out_dir}/11-phylo_import.log" || \
    { echo "Error in r_import_data" 1>&2 ; exit 1 ; }


# ------------------------------------ make taxonomic barcharts (kingdom level)

echo "Step r_composition $(date)"

r_composition.py  \
    --varExp Color \
    --taxaRank1 Kingdom \
    --taxaSet1 Bacteria \
    --taxaRank2 Phylum \
    --numberOfTaxa 9 \
    --rdata "${out_dir}/11-phylo_import.Rdata" \
    --html "${out_dir}/12-phylo_composition.html" \
    --log-file "${out_dir}/12-phylo_composition.log" || \
    { echo "Error in r_composition" 1>&2 ; exit 1 ; }

# ----------------------------------------------------- compute alpha diversity

echo "Step r_alpha_diversity $(date)"

r_alpha_diversity.py  \
 --varExp Color \
 --rdata "${out_dir}/11-phylo_import.Rdata" \
 --alpha-measures Observed Chao1 Shannon \
 --alpha-out "${out_dir}/13-phylo_alpha_div.tsv" \
 --html "${out_dir}/13-phylo_alpha_div.html" \
 --log-file "${out_dir}/13-phylo_alpha_div.log" || \
    { echo "Error in r_alpha_diversity" 1>&2 ; exit 1 ; }


# ------------------------------------------------------ compute beta diversity

echo "Step r_beta_diversity $(date)"

r_beta_diversity.py  \
    --varExp Color \
    --distance-methods cc,unifrac \
    --rdata "${out_dir}/11-phylo_import.Rdata" \
    --matrix-outdir "${out_dir}" \
    --html "${out_dir}/14-phylo_beta_div.html" \
    --log-file "${out_dir}/14-phylo_beta_div.log" || \
    { echo "Error in r_beta_diversity" 1>&2 ; exit 1 ; }


# -------------------------------------------- compute sample ordination (NMDS)

# echo "Step r_structure $(date)"

# r_structure.py  \
#     --varExp Color \
#     --ordination-method MDS \
#     --rdata "${out_dir}/11-phylo_import.Rdata" \
#     --distance-matrix "${out_dir}/Unifrac.tsv" \
#     --html "${out_dir}/15-phylo_structure.html" \
#     --log-file "${out_dir}/15-phylo_structure.log" || \
#     { echo "Error in r_structure" 1>&2 ; exit 1 ; }


# ------------------------------------------ hierarchical clustering of samples

echo "Step r_clustering $(date)"

r_clustering.py  \
    --varExp Color \
    --rdata "${out_dir}/11-phylo_import.Rdata" \
    --distance-matrix "${out_dir}/Unifrac.tsv" \
    --html "${out_dir}/16-phylo_clutering.html" \
    --log-file "${out_dir}/16-phylo_clustering.log" || \
    { echo "Error in r_clustering" 1>&2 ; exit 1 ; }


# ----------------------------------------------------------------------- anova

echo "Step r_manova $(date)"

r_manova.py  \
    --varExp Color \
    --rdata "${out_dir}/11-phylo_import.Rdata" \
    --distance-matrix "${out_dir}/Unifrac.tsv" \
    --html "${out_dir}/17-phylo_manova.html" \
    --log-file "${out_dir}/17-phylo_manova.log" || \
    { echo "Error in r_manova" 1>&2 ; exit 1 ; }


echo "Completed with success"
source deactivate  # on desactive l'environement FROGS

exit 0
