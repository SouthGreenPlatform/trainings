#!/bin/sh
############      SGE CONFIGURATION      ###################
#$ -N Metabarcoding
#$ -cwd
#$ -V
#$ -q formation.q
#$ -S /bin/bash
#$ -pe ompi 4
#$ -o $HOME/frogs_$JOB_ID.log
#$ -j y
#$ -l h_vmem=20G

############################################################
MOI="formationX"
REMOTE_FOLDER="nas:/home/$MOI/TP-FROGS"
READS_SAMPLE='nas:/data2/formation/TPMetabarcoding/DATA'
TMP_FOLDER="/scratch/$MOI-$JOB_ID";
DB="/usr/local/frogs_databases-2.01/silva_123_16S/silva_123_16S.*"

############# chargement du module
module load bioinfo/FROGS/2.01 && source activate frogs
###### Creation du repertoire temporaire sur  la partition /scratch du noeud
mkdir $TMP_FOLDER
####### copie du repertoire de donnees  vers la partition /scratch du noeud
echo "tranfert donnees master -> noeud (copie du fichier de reads)";
scp $READS_SAMPLE $TMP_FOLDER
####### copie du repertoire de la bd  vers la partition /scratch du noeud
scp $DB $TMP_FOLDER 
cd $TMP_FOLDER

###### Execution du programme
echo "exec frogs"
echo "bash /data2/formation/TPMetabarcoding/run_frogs_pipelinev2.sh 100 350 None None 250 250 250 OUTPUT DATA 4"
bash /data2/formation/TPMetabarcoding/run_frogs_pipelinev2.sh 100 350 None None 250 250 250 OUTPUT DATA 4

####### Nettoyage de la partition /scratch du noeud avant rapatriement
echo "supression du fichier des reads"
rm DATA

##### Transfert des donnees du noeud vers master
echo "Transfert donnees node -> master";
scp -r $TMP_FOLDER $REMOTE_FOLDER

if [[ $? -ne 0 ]]; then
    echo "transfer failed on $HOSTNAME in $TMP_FOLDER"
else
    echo "Suppression des donnees sur le noeud";
    rm -rf $TMP_FOLDER;
fi
