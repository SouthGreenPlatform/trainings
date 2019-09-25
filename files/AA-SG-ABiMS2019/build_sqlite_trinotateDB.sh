#!/bin/bash -a
# -*- coding: utf-8 -*-
# @author  Julie Orjuela

version=1.2
path=`pwd`
softName="build_Sqlite_trinotate_database_and_report"

##################################################
## Fonctions
##################################################
# module help
function help
{
	printf "\033[36m####################################################################\n";
	printf "#       Run "$softName" on $resultsDir directory ( Version $version )       #\n";
	printf "####################################################################\n";
	printf "
 Input:
	directory with results file from annotation
 Output:
	trinotate results report
 Exemple Usage: ./"$softName"-JAv1.2.sh -f ./fasta -r ./resultatsAnnotation -m julie.orjuela@ird.fr
 Usage: ./"$softName"-JAv1.2.0.sh -f fasta -r resultatsAnnotationDir -m obiwankenobi@jedi.force
	options:
		-r {path/to/directoryResults/} = path to annotation results
		-f {path/to/fastaFile} = path to fasta file
		-m {email} = email to add to qsub job end (not mandatory)
		-h = see help\n\n"
	exit 0
}


##################################################
## Parse command line options
##################################################.
while getopts r:f:m:h: OPT;
	do case $OPT in
		r)	repertory=$OPTARG;;
		f)	fasta=$OPTARG;;
		m)	mail=$OPTARG;;
		h)	help;;
		\?)	help;;
	esac
done

if [ $# -eq 0 ]; then
	help
fi


##################################################
## Main code
##################################################

if [ -z ${mail+x} ]; then
	cmdMail=""
else
	cmdMail="-M $mail -m beas"
fi

if [ $repertory != "" ] ; then
	
	# Charging modules"
	module load system/perl/5.24.0
	module load bioinfo/Trinotate/3.0.1
	module load bioinfo/TransDecoder/3.0.0
	module load bioinfo/hmmer/3.1b2
	module load bioinfo/diamond/0.7.11 #demander la version 0.8 dans les module load
	
	#variables
	resultsDir=$repertory
	cd $resultsDir
	name=$(basename $fasta)
	shortName=$(echo $name | cut -d "." -f 1)
	shortName=$(echo $shortName | cut -d "_" -f 1)
	
	geneTransMap=$shortName".fasta_gene_trans_map"
	transdecoderPep=$shortName".fasta.transdecoder.pep"
	signalp=$shortName"_signalp.out"
	echo $shortName; echo $geneTransMap; echo $transdecoderPep; echo $signalp
	ls -l $geneTransMap $transdecoderPep $signalp;
	ls $shortName"_PFAM.out"  $shortName".tmhmm.out" $shortName".fasta.rnammer.gff"
	
	#7 recuperation de la base Trinotate
	echo "7 Recuperation de la base Trinotate"
	wget "https://data.broadinstitute.org/Trinity/Trinotate_v3_RESOURCES/Trinotate_v3.sqlite.gz" -O Trinotate.sqlite.gz
	gunzip Trinotate.sqlite.gz
	
	#8 chargement des analyses dans la base
	echo "8 chargement des analyses dans la base"
	/usr/local/Trinotate-3.0.1/Trinotate $resultsDir/Trinotate.sqlite init --gene_trans_map $geneTransMap --transcript_fasta $fasta --transdecoder_pep $transdecoderPep
	
	#charging swissprot/uniprot P and X results
	echo " -->charging swissprot/uniprot P and X results"
	/usr/local/Trinotate-3.0.1/Trinotate $resultsDir/Trinotate.sqlite LOAD_swissprot_blastp diamP_uniprot.outfmt6
	/usr/local/Trinotate-3.0.1/Trinotate $resultsDir/Trinotate.sqlite LOAD_swissprot_blastx diamX_uniprot.outfmt6
	
	#charging uniref90 P and X results
	echo " -->charging  uniref90 P and X results" 
	/usr/local/Trinotate-3.0.1/Trinotate $resultsDir/Trinotate.sqlite LOAD_custom_blast --outfmt6 diamP_uniref90.outfmt6 --prog blastp --dbtype uniref90
	/usr/local/Trinotate-3.0.1/Trinotate $resultsDir/Trinotate.sqlite LOAD_custom_blast --outfmt6 diamX_uniref90.outfmt6 --prog blastx --dbtype uniref90
	
	#charging pfam, tmhmm, signalp and rnammer
	echo " -->charging  pfam, tmhmm, signalp and rnammer"
	/usr/local/Trinotate-3.0.1/Trinotate $resultsDir/Trinotate.sqlite LOAD_pfam $shortName"_PFAM.out" 
	/usr/local/Trinotate-3.0.1/Trinotate $resultsDir/Trinotate.sqlite LOAD_tmhmm $shortName".tmhmm.out"
	/usr/local/Trinotate-3.0.1/Trinotate $resultsDir/Trinotate.sqlite LOAD_rnammer $shortName".fasta.rnammer.gff"
	
	if [ -s $signalp ]; then
		#charging signalp
		/usr/local/Trinotate-3.0.1/Trinotate $resultsDir/Trinotate.sqlite LOAD_signalp $signalp
	fi
	
	# 9 generation du report
	echo "9 generation du report"
	/usr/local/Trinotate-3.0.1/Trinotate $resultsDir/Trinotate.sqlite report > $shortName"_annotation_report.xls"
	
	#filtré sur les e-value des annotations
	echo " -->filtré sur les e-value des annotations"
	/usr/local/Trinotate-3.0.1/Trinotate $resultsDir/Trinotate.sqlite report -E 10e-10 > $shortName"_annotation_report_filtered.xls"
	
	#10 generation de statistiques
	echo "10 generation de statistiques"
	/usr/local/Trinotate-3.0.1/util/count_table_fields.pl $resultsDir/$shortName"_annotation_report_filtered.xls" > $shortName"_table_fields.txt"
	
	#11 extract GO terms
	echo "extract GO terms"
	/usr/local/Trinotate-3.0.1/util/extract_GO_assignments_from_Trinotate_xls.pl --Trinotate_xls $shortName"_annotation_report_filtered.xls" -G --include_ancestral_terms > $shortName"_go_annotations.txt"
	
	echo " pour visualiser les GO allez sur le site : " 
	echo "site wego : http://wego.genomics.org.cn/"
fi

