#!/bin/bash -l
#SBATCH -J Trinity
#SBATCH --export=ALL
#SBATCH -e Trinity."%j".err
#SBATCH -o Trinity."%j".out
#SBATCH -p supermem
#SBATCH --cpus-per-task 2
#SBATCH --mem=50G

# loading modules
module load bioinfo/samtools/1.9
module load bioinfo/trinityrnaseq/2.8.5
module load bioinfo/Trimmomatic/0.33

cd /scratch/formationX/RAWDATA/

# changing PATH to current directory in samples file
sed -i 's|PATH|'$PWD'|ig' samples.txt 
 
# Running trinity assembly (only assembly)
# Trinity --seqType fq --max_memory 50G --CPU 2 --samples_file samples.txt --output ../TRINITY_OUT 

# Running Trinity with trimmomatic and normalisation
Trinity --seqType fq --max_memory 50G --CPU 2 --trimmomatic --quality_trimming_params 'ILLUMINACLIP:/usr/local/Trimmomatic-0.33/adapters/TruSeq2-PE.fa:2:30:10 ILLUMINACLIP:/scratch/formation1/RAWDATA/adap
t-125pbLib.txt:2:30:10 SLIDINGWINDOW:5:20 LEADING:5 TRAILING:5 MINLEN:25 HEADCROP:10' --normalize_by_read_set --samples_file samples.txt --output ../TRINITY_OUT
