#!/bin/sh


############      SGE CONFIGURATION      ###################
# Ecrit les erreur dans le fichier de sortie standard 
#$ -j y 

# Shell que l'on veut utiliser 
#$ -S /bin/bash

 #$ -b Y


# Email pour suivre l'execution 
#$ -M prenom.nom@ird.fr           ######### Mettre son adresse mail

# Type de massage que l'on reçoit par mail
#    -  (b) un message au demarrage
#    -  (e) a la fin
#    -  (a)  en cas d'abandon
#$ -m bea 

# Queue que l'on veut utiliser
#$ -q bioinfo.q
# Nom du job
#$ -N test_bwa_tando 
############################################################
 
path_to_dir="/data/projects/tp-cluster/training_2018/bwa";
path_to_tmp="/scratch/tando_$JOB_ID"; 
path_to_dest="/home/tando";

################ chargement du module load bwa########"#
module load bioinfo/bwa/0.7.12
 
###### Creation du repertoire temporaire sur  la partition /scratch du noeud
mkdir $path_to_tmp

####### copie du repertoire de données  vers la partition /scratch du noeud
scp -r nas2:$path_to_dir $path_to_tmp # choisir nas pour/home, /data2 et /teams ou nas2 pour /data ou nas3 pour /data3
echo "tranfert donnees master -> noeud";
cd $path_to_tmp/bwa/;

###### Execution du programme
cmd1="bwa index referenceIrigin.fasta"; 
echo "commande executee: $cmd1";
$cmd1;
sleep 30
#cmd2="bwa mem referenceIrigin.fasta irigin1_1.fastq irigin1_2.fastq >& mapping.sam"; 
bwa mem referenceIrigin.fasta irigin1_1.fastq irigin1_2.fastq > mapping.sam 
#echo "commande executee: $cmd2";
##$cmd2;




##### Transfert des données du noeud vers master
scp -rp $path_to_tmp/bwa/mapping.sam  nas:$path_to_dest/;
echo "Transfert donnees node -> master";

#### Suppression du repertoire tmp noeud
#rm -rf $path_to_tmp;
echo "Suppression des donnees sur le noeud";
