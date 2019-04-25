#!/bin/sh
############      SGE CONFIGURATION      ###################
#$ -N dada2
#$ -V
#$ -q bioinfo.q
#$ -pe ompi 8
#$ -S /bin/bash
#$ -o nas:/home/orjuela/TEST-qiime2/dada2$JOB_ID.log
#$ -j y
############################################################

TMP_FOLDER="/scratch/orjuela-$JOB_ID"
REMOTE_FOLDER="nas:/home/orjuela/TEST-qiime2/"

############# chargement du module
module load bioinfo/qiime2/2018.11
source activate qiime2-2018.11

###### Creation du repertoire temporaire sur  la partition /scratch du noeud
mkdir $TMP_FOLDER

####### copie du repertoire de donnees  vers la partition /scratch du noeud
echo "copie fichiers necessaires pour dada2"
scp $REMOTE_FOLDER/paired-end-demux.qza $TMP_FOLDER
cd $TMP_FOLDER

###### Execution du programme
echo "execution dada2 ..."

qiime dada2 denoise-paired \
  --i-demultiplexed-seqs $TMP_FOLDER/paired-end-demux.qza \
  --p-trim-left-f 21 \
  --p-trim-left-r 20 \
  --p-trunc-len-f 220 \
  --p-trunc-len-r 160 \
  --o-table $TMP_FOLDER/16S-table.qza \
  --p-n-threads 8 \
  --o-representative-sequences $TMP_FOLDER/16S-rep-seqs.qza \
  --o-denoising-stats $TMP_FOLDER/16S-denoising-stats.qza \
  --verbose

#removing initial files
rm paired-end-demux.qza

##### Transfert des donnees du noeud vers master
echo "Transfert donnees node -> master";
scp -r $TMP_FOLDER $REMOTE_FOLDER

if [[ $? -ne 0 ]]; then
    echo "transfer failed on $HOSTNAME in $TMP_FOLDER"
else
    echo "Suppression des donnees sur le noeud";
    rm -rf $TMP_FOLDER;
fi

source deactivate

