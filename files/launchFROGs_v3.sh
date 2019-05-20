#!/bin/sh
############      SGE CONFIGURATION      ###################
#$ -N Metabarcoding
#$ -cwd
#$ -V
#$ -q formation.q
#$ -S /bin/bash
#$ -pe ompi 2
#$ -o frogs_$JOB_ID.log
#$ -j y
#$ -l h_vmem=10G

############################################################

[[ -n ${1} ]] || exit 1

MOI="${1}"
REMOTE_FOLDER="nas:/home/$MOI/TP-FROGS"
READS_SAMPLE='nas:/data2/formation/TPMetabarcoding/FROGS/DATA_s.tar.gz' #### A MODIFIER
TMP_FOLDER="/scratch/$MOI-$JOB_ID"; 
#DB="/usr/local/frogs_databases-2.01/silva_123_16S/*" #### A MODIFIER
DB="/data2/formation/TPMetabarcoding/DB/databases_Frogs_genoweb.toulouse.inra.fr/frogs_databanks/assignation/16S/SILVA/silva_132_16S/*"
summary="/data2/formation/TPMetabarcoding/FROGS/summary.txt" #### A MODIFIER
OUTPUT="OUTPUT_FROGSV3" #### A MODIFIER

############# chargement du module
module load bioinfo/FROGS/3.1

###### Creation du repertoire temporaire sur  la partition /scratch du noeud
mkdir -p $TMP_FOLDER/$OUTPUT

####### copie du repertoire de donnees  vers la partition /scratch du noeud
echo "tranfert donnees master -> noeud (copie du fichier de reads)";
scp $READS_SAMPLE $TMP_FOLDER

####### copie du repertoire de la bd et summary.txt  vers la partition /scratch du noeud
scp $DB $TMP_FOLDER 
scp $summary $TMP_FOLDER
cd $TMP_FOLDER

###### Execution du programme
echo "exec frogs v3"
wget https://raw.githubusercontent.com/SouthGreenPlatform/trainings/gh-pages/files/run_frogs_pipelinev3.sh
echo "bash ./run_frogs_pipelinev3.sh 100 350 None None 250 250 250 $OUTPUT ${READS_SAMPLE/*\//} 2"
bash ./run_frogs_pipelinev3.sh 100 350 None None 250 250 250 $OUTPUT ${READS_SAMPLE/*\//} 2

####### Nettoyage de la partition /scratch du noeud avant rapatriement
echo "supression du fichier des reads"
rm DATA_s.tar.gz silva_132_16S.* *.txt *xml

##### Transfert des donnees du noeud vers master
echo "Transfert donnees node -> master";
scp -r $TMP_FOLDER/$OUTPUT $REMOTE_FOLDER

if [[ $? -ne 0 ]]; then
    echo "transfer failed on $HOSTNAME in $TMP_FOLDER"
else
    echo "Suppression des donnees sur le noeud";
    rm -rf $TMP_FOLDER;
fi
