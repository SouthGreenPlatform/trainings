#!/bin/bash -l
#SBATCH -J Trinotate
#SBATCH --export=ALL
#SBATCH -e Trinotate."%j".err
#SBATCH -o Trinotate."%j".out
#SBATCH -p supermem
#SBATCH --cpus-per-task 2
#SBATCH --mem=50G


# Charging modules
module purge
module load bioinfo/Trinotate/3.0.1
module load bioinfo/TransDecoder/3.0.0
module load bioinfo/hmmer/3.1b2
module load bioinfo/diamond/0.7.11
module load system/perl/5.24.0
 
# Defining scratch and destination repertories\n
pathToScratch="/tmp/formationX/ANNOTATION/"

# Mise à disposition des bases de données directement sur le node25
DB="/tmp/DB/" 

cd $pathToScratch/ 
mkdir $pathToScratch/results_sacharomyces
cd $pathToScratch/results_sacharomyces/
 
# Running tool
 
# Calculing trinity_component_distribution
perl /usr/local/trinityrnaseq-2.5.1/util/misc/trinity_component_distribution.pl $pathToScratch/sacharomyces.fasta 
cmd=" perl /usr/local/trinityrnaseq-2.5.1/util/misc/trinity_component_distribution.pl $pathToScratch/sacharomyces.fasta "
echo "commande executee: $cmd"
 
# 1 getting gene to trans map
perl /usr/local/trinityrnaseq-2.5.1/util/support_scripts/get_Trinity_gene_to_trans_map.pl $pathToScratch/sacharomyces.fasta > $pathToScratch/results_sacharomyces/sacharomyces.fasta_gene_trans_map 
cmd=" perl /usr/local/trinityrnaseq-2.5.1/util/support_scripts/get_Trinity_gene_to_trans_map.pl $pathToScratch/sacharomyces.fasta \> $pathToScratch/results_sacharomyces/sacharomyces.fasta_gene_trans_map "
echo "commande executee: $cmd"
 
# 2 generation of peptide file
 
# 2.1 generation of longestOrf
TransDecoder.LongOrfs -t $pathToScratch/sacharomyces.fasta --gene_trans_map $pathToScratch/results_sacharomyces/sacharomyces.fasta_gene_trans_map -m 50 
cmd=" TransDecoder.LongOrfs -t $pathToScratch/sacharomyces.fasta --gene_trans_map $pathToScratch/results_sacharomyces/sacharomyces.fasta_gene_trans_map -m 50  "
echo "commande executee: $cmd"
 
# 2.2a recherche d’identité parmis les longorfs hmmscan
hmmscan --cpu 2 --domtblout pfam_longorfs.domtblout $DB/Pfam-A.hmm $pathToScratch/results_sacharomyces/sacharomyces.fasta.transdecoder_dir/longest_orfs.pep 
cmd=" hmmscan --cpu 2 --domtblout pfam_longorfs.domtblout $DB/Pfam-A.hmm $pathToScratch/results_sacharomyces/sacharomyces.fasta.transdecoder_dir/longest_orfs.pep  "
echo "commande executee: $cmd"
 
# 2.2b recherche d’identité parmis les longorfs diamond
/usr/local/diamond-0.8.29/diamond blastp --query $pathToScratch/results_sacharomyces/sacharomyces.fasta.transdecoder_dir/longest_orfs.pep --threads 2 --db $DB/uniprot_sprot --out diamP_uniprot_longorfs.outfmt6 --outfmt 6 --max-target-seqs 1 
cmd=" /usr/local/diamond-0.8.29/diamond blastp --query $pathToScratch/results_sacharomyces/sacharomyces.fasta.transdecoder_dir/longest_orfs.pep --threads 2 --db $DB/uniprot_sprot.pep --out diamP_uniprot_longorfs.outfmt6 --outfmt 6 --max-target-seqs 1  "
echo "commande executee: $cmd"
 
# #2.3 Prediction peptides
TransDecoder.Predict --cpu 2 -t $pathToScratch/sacharomyces.fasta --retain_pfam_hits $pathToScratch/results_sacharomyces/pfam_longorfs.domtblout --retain_blastp_hits $pathToScratch/results_sacharomyces/diamP_uniprot_longorfs.outfmt6 
cmd=" TransDecoder.Predict --cpu 2 -t $pathToScratch/sacharomyces.fasta --retain_pfam_hits pfam_longorfs.domtblout --retain_blastp_hits diamP_uniprot_longorfs.outfmt6  "
echo "commande executee: $cmd"
 
# 3 Recherche de similarité en utilisant Diamond
 
# blastp diamP_uniprott 
/usr/local/diamond-0.8.29/diamond blastp --query $pathToScratch/results_sacharomyces/sacharomyces.fasta.transdecoder.pep --threads 2 --db $DB/uniprot_sprot --out $pathToScratch/results_sacharomyces/diamP_uniprot.outfmt6 --outfmt 6 --max-target-seqs 1 --more-sensitive 
cmd=" /usr/local/diamond-0.8.29/diamond blastp --query $pathToScratch/results_sacharomyces/sacharomyces.fasta.transdecoder.pep --threads 2 --db $DB//uniprot_sprot --out $pathToScratch/results_sacharomyces/diamP_uniprot.outfmt6 --outfmt 6 --max-target-seqs 1 --more-sensitive  "
echo "commande executee: $cmd"
 
# blastp diamP_uniref90 
 /usr/local/diamond-0.8.29/diamond blastp --query $pathToScratch/results_sacharomyces/sacharomyces.fasta.transdecoder.pep --threads 2 --db $DB/uniref90.fasta --out $pathToScratch/results_sacharomyces/diamP_uniref90.outfmt6 --outfmt 6 --max-target-seqs 1 --more-sensitive 
cmd=" /usr/local/diamond-0.8.29/diamond blastp --query $pathToScratch/results_sacharomyces/sacharomyces.fasta.transdecoder.pep --threads 2 --db $DB/uniref90.fasta --out $pathToScratch/results_sacharomyces/diamP_uniref90.outfmt6 --outfmt 6 --max-target-seqs 1 --more-sensitive  "
echo "commande executee: $cmd"
 
# blastx diamX_uniprot 
 /usr/local/diamond-0.8.29/diamond blastx --query $pathToScratch/sacharomyces.fasta --threads 2 --db $DB/uniprot_sprot --out diamX_uniprot.outfmt6 --outfmt 6 --max-target-seqs 1 --more-sensitive 
cmd="  /usr/local/diamond-0.8.29/diamond blastx --query $pathToScratch/sacharomyces.fasta --threads 2 --db $DB//uniprot_sprot --out diamX_uniprot.outfmt6 --outfmt 6 --max-target-seqs 1 --more-sensitive "
echo "commande executee: $cmd"
 
# blastx diamX_uniref90 
 /usr/local/diamond-0.8.29/diamond blastx --query $pathToScratch/sacharomyces.fasta --threads 2 --db $DB/uniref90.fasta --out diamX_uniref90.outfmt6 --outfmt 6 --max-target-seqs 1 --more-sensitive 
cmd=" /usr/local/diamond-0.8.29/diamond blastx --query $pathToScratch/sacharomyces.fasta --threads 2 --db $DB/uniref90.fasta --out  diamX_uniref90.outfmt6 --outfmt 6 --max-target-seqs 1  --more-sensitive "
echo "commande executee: $cmd"
 
# 3 recherche de dommaines 
hmmscan --cpu 2 --domtblout $pathToScratch/results_sacharomyces/sacharomyces_PFAM.out $DB/Pfam-A.hmm $pathToScratch/results_sacharomyces/sacharomyces.fasta.transdecoder.pep > $pathToScratch/results_sacharomyces/pfam.log 
cmd=" hmmscan --cpu 2 --domtblout $pathToScratch/results_sacharomyces/sacharomyces_PFAM.out $DB/Pfam-A.hmm $pathToScratch/results_sacharomyces/sacharomyces.fasta.transdecoder.pep  "
echo "commande executee: $cmd"
 
# 4 recheche de peptides signaux 
perl /usr/local/signalp-4.1/signalp -f short -n $pathToScratch/results_sacharomyces/sacharomyces_signalp.out $pathToScratch/results_sacharomyces/sacharomyces.fasta.transdecoder.pep 
cmd="perl /usr/local/signalp-4.1/signalp -f short -n $pathToScratch/results_sacharomyces/sacharomyces_signalp.out $pathToScratch/results_sacharomyces/sacharomyces.fasta.transdecoder.pep   "
echo "commande executee: $cmd"

# 5 recherche de domaines transmembranaires # undetected in this dataset
/usr/local/tmhmm-2.0c/bin/tmhmm --short <  $pathToScratch/results_sacharomyces/sacharomyces.fasta.transdecoder.pep > $pathToScratch/results_sacharomyces/sacharomyces.fasta.tmhmm.out 
cmd="/usr/local/tmhmm-2.0c/bin/tmhmm --short <  $pathToScratch/results_sacharomyces/sacharomyces.fasta.transdecoder.pep > $pathToScratch/results_sacharomyces/sacharomyces.fasta.tmhmm.out "
echo "commande executee: $cmd"
 
# 6 recherche de rRNA 
/usr/local/Trinotate-3.0.1/util/rnammer_support/RnammerTranscriptome.pl --transcriptome $pathToScratch/sacharomyces.fasta --org_type euk --path_to_rnammer /usr/local/rnammer-1.2/rnammer
cmd=" /usr/local/Trinotate-3.0.1/util/rnammer_support/RnammerTranscriptome.pl --transcriptome $pathToScratch/sacharomyces.fasta --org_type euk --path_to_rnammer /usr/local/rnammer-1.2/rnammer   "
echo "commande executee: $cmd"

#FIN 
