!/usr/bin/perl

# Programme : retrieve_accession_length.pl 
# - télécharger 2 séquences au format fasta en donnant l’accession avec le module Bio::DB::GenBank; 
# - calculer la longueur de chaque séquence
# - calcule la longueur totale en pb des 2 séquences
# - calcule la longueur moyenne

# Chargement du module bioperl qui va être utilisé
use Bio::DB::GenBank; 
use strict;
use warnings;


##################################  
#### TELECHARGEMENT SEQUENCE 1
##################################

# Definition variable accession et nom fichier
my $accession1="CK085358.1";
my $file1=$accession1.".fasta";

# Recuperation sequence sur le site NCBI
my $gb=Bio::DB::GenBank->new();
my $seq=$gb->get_Seq_by_version($accession1); #GI Number

# Ecrit la séeuence est dans le fichier $file1
my $out=Bio::SeqIO->new(-file => ">$file1"); #creer le fichier fasta 
$out->write_seq($seq);
#print $seq->seq();

# Recupere la sequence de l objet dans la variable $seq_sequence
my $seq_sequence=$seq->seq();
my $seq_length=length($seq_sequence);

# Message résultat qui dit bien ce qu'il veut dire d'abord 
print "###################################\n";
print "Taille sequence1 : $seq_length pb\n";



################################## 
#### TELECHARGEMENT SEQUENCE 2 
################################## 
my $accession2="AK065885.1";
my $file2=$accession2.".fasta";

my $gb2=Bio::DB::GenBank->new();
my $seq2=$gb->get_Seq_by_version($accession2); #GI Number

# La séquence est sauvée dans un fichier
my $out2=Bio::SeqIO->new(-file => ">$file2"); #creer le fichier fasta 
$out2->write_seq($seq2);
#print $seq->seq();

my $seq2_sequence=$seq2->seq();
my $seq2_length=length($seq2_sequence);
print "Taille sequence2 : $seq2_length pb\n";
print "###################################\n";

### Calcul de la longueurtotale
my $length_total=$seq_length+$seq2_length;
print "Taille sequence1 + sequence2 = $length_total et moyenne =".int($length_total/2)."\n";
print "###################################\n";

################################## 
#### TESTE LONGUEUR SEQUENCE
##################################
if ($seq_length >1000)
{
    print "------> Sequence > 1000 pb";    
}
elsif ($seq_length <1000)
{    
    print "------> Sequence < 1000 pb";   
}
else
{
    print "------> Sequence = 1000 pb";   
}
