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
# pour utiliser plusieurs processeurs jusqu a 12
#$ -pe ompi 2
# Nom du job
#$ -N test_blast_tando 
############################################################
 
path_to_dir="/data/projects/tp-cluster/training_2018/Blast";
path_to_tmp="/scratch/tando_$JOB_ID"; 
path_to_dest="/home/tando";

############# chargement du module load blast
module load bioinfo/blast/2.4.0+


 
###### Creation du repertoire temporaire sur  la partition /scratch du noeud
mkdir $path_to_tmp

####### copie du repertoire de données  vers la partition /scratch du noeud
scp -r nas2:$path_to_dir $path_to_tmp # choisir nas pour/home, /data2 et /teams ou nas2 pour /data ou nas3 pour /data3
echo "tranfert donnees master -> noeud";
cd $path_to_tmp/Blast/;

###### Execution du programme
cmd="blastn -db All-EST-coffea.fasta -query  sequence-NMT.fasta -num_threads $NSLOTS  -out blastntando.out"; 
echo "commande executee: $cmd";
$cmd;




##### Transfert des données du noeud vers master
scp -rp $path_to_tmp/Blast/blastntando.out  nas:$path_to_dest/;
echo "Transfert donnees node -> master";

#### Suppression du repertoire tmp noeud
#rm -rf $path_to_tmp;
echo "Suppression des donnees sur le noeud";
