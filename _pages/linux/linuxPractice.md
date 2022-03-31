---
layout: page
title: "Linux Practice"
permalink: /linux/linuxPractice/
tags: [ linux, survival guide ]
description: Linux Practice page
---

| Description | Hands On Lab Exercises for Linux |
| :------------- | :------------- | :------------- | :------------- |
| Related-course materials | [Linux for Dummies](https://southgreenplatform.github.io/trainings/linux/) |
| Authors | Christine Tranchant-Dubreuil (christine.tranchant@ird.fr)  |
| Creation Date | 26/02/2018 |
| Last Modified Date | 31/03/2022 |
|Modified by | Gautier Sarah (gautier.sarah@inra.fr), Christine Tranchant (christine.tranchant@ird.fr)|

-----------------------

### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Preambule: Softwares to install before connecting to a distant linux server ](#preambule)
* [Practice 1: Transferring files with filezilla `sftp`](#practice-1)
* [Practice 2: Get Connecting on a linux server by `ssh`](#practice-2)
* [Practice 3: First steps : prompt & `pwd`command](#practice-3)
* [Practice 4: List the files using `ls` command](#practice-4)
* [Practice 5 : List the files using `ls` command and metacharacter _*_](#practice-5)
* [practice-6 : Moving into file system using `cd`and `ls` commands](#practice-6)
* [practice-7 : Manipulating Files and Folders](#practice-7)
* [practice-8 : Searching with `grep`](#practice-8)
* [practice-9 : Blast analysis](#practice-9)
* [Practice-10: Redirecting a command output to a File with `>`](#practice-10)
* [Practice-11: Sending data from one command to another (piping) with `|`](#practice-11)
* [practice-12 : Dealing with VCF files](#practice-12)
* [practice-13 : Filtering VCF files](#practice-13)
* [Practice-14 : Getting basic stats](#practice-14)
* [Tips](#tips)
  - [How to convert between Unix and Windows text files?](#convertFileFormat)
  - [How to open and read a file through a text editor on a distant linux server?](#readFile)
  - [Getting Help on any command-line](#help)
* [Links](#links)
* [License](#license)


-----------------------

<a name="preambule"></a>
### Preambule


##### Getting connected to a Linux servers from Windows with SSH (Secure Shell) protocol

| Platform | Software  | Description | url |
| :------------- | :------------- | :------------- | :------------- |
| <img width="10%" class="img-responsive" src="{{ site.url }}/images/tpLinux/osWin.png"/> | mobaXterm |An enhanced terminal for Windows with an X11 server and a tabbed SSH client | [More](https://mobaxterm.mobatek.net/) |



##### Transferring and copying files from your computer to a Linux servers with SFTP (SSH File Transfer Protocol) protocol

| Platform | Software  | Description | url |
| :------------- | :------------- | :------------- | :------------- |
| <img width="10%" class="img-responsive" src="{{ site.url }}/images/tpLinux/osApple.png"/> <img width="10%" class="img-responsive" src="{{ site.url }}/images/tpLinux/osLinux.png"/> <img width="10%" class="img-responsive" src="{{ site.url }}/images/tpLinux/osWin.png"/>| <img width="10%" class="img-responsive" src="{{ site.url }}/images/tpLinux/filezilla.png"/> filezilla |  FTP and SFTP client  | [Download](https://filezilla-project.org/download.php?type=client)  |


##### Viewing and editing files on your computer before transferring on the linux server or directly on the distant server

| Type | Software  | url |
| :------------- | :------------- | :------------- |
| Distant, consol mode |  nano | [Tutorial](http://www.howtogeek.com/howto/42980/) |  
| Distant, consol mode |  vi | [Tutorial](https://www.washington.edu/computing/unix/vi.html)  |  
| Distant, graphic mode| komodo edit | [Download](https://www.activestate.com/komodo-ide/downloads/edit) |
| Linux & windows based editor | Notepad++ | [Download](https://notepad-plus-plus.org/download/v7.5.5.html) |

-----------------------


<a name="practice-1"></a>
### Practice 1 : Transferring files with filezilla `sftp`


##### Download and install FileZilla


##### Open FileZilla and save the cluster adress into the site manager

<img width="50%" class="img-responsive" src="{{ site.url }}/images/tpLinux/tp-filezilla1.png"/>

In the FileZilla menu, go to _File > Site Manager_. Then go through these 5 steps:

1. Click _New Site_.
2. Add a CUSTOM NAME for this site such as IRD_HPC or AGAP_HPC.
3. Add the HOSTNAME (see table below).
4. Set the Logon Type to "Normal" and insert your username and password used to connect on the IRD/CIRAD HPC
5. Press the "Connect" button.

| Cluster HPC | hostname| 
| :------------- | :------------- | 
| IRD HPC |  bioinfo-nas.ird.fr | 


##### Transferring files

<img width="50%" class="img-responsive" src="{{ site.url }}/images/tpLinux/tp-filezilla2.png"/>

1. From your computer to the cluster : click and drag an text file item from the left local colum to the right remote column
2. From the cluster to your computer : click and drag an text file item from he right remote column to the left local column

-----------------------


<a name="practice-2"></a>
### Practice 2 : Get Connecting on a linux server by `ssh`

In mobaXterm:
1. Click the session button, then click SSH.
  * In the remote host text box, type: HOSTNAME (see table below)
  * Check the specify username box and enter your user name
2. In the console, enter the password when prompted.
Once you are successfully logged in, you will use this console for the rest of the lecture.

| Cluster HPC | hostname| 
| :------------- | :------------- | 
| IRD HPC |  bioinfo-inter.ird.fr | 

-----------------------

<a name="practice-3"></a>
###  Practice 3 : First steps : prompt & `pwd`

* What is the current/working directory just by looking the prompt?
* Check the name of your working directory with `pwd` command?
* On the console, type your 2 first linux commands to get data necessary for the next (we will explain the two commands latter):

{% highlight bash %}
# get the file on the web
wget http://itrop.ird.fr/LINUX-TP/LINUX-TP.tar.gz

# decompress the gzip file
tar -xzvf LINUX-TP.tar.gz
{% endhighlight %}

* Check through filezilla the content of your home directory on the server now (cf. filetree just below)
* Delete through filezilla the file LINUX-TP.tar.gz on the server

<img width="50%" class="img-responsive" src="{{ site.url }}/images/tpLinux/tp-arbo.png"/>

-----------------------

<a name="practice-4"></a>
### Practice 4 : List the files using `ls` command

* List the content of your home directory
* List the content of the directory `Fasta` by using its absolute path in first then its relative path - `ls` command
* List the content of the directory `Data` with the `ls`command and the option `-R`
* List the content of the directory `Bank` with the `ls`command and the option `-al` or `-a -l`

-----------------------

<a name="practice-5"></a>
### Practice 5 : List the files using `ls` command and metacharacter _*_

* List the content of the directory `T-coffee`. Are there only fasta files ? - `ls` command
* List only the files starting by sample (in the directory `T-coffee` ) -  `ls` command & _*_
* List only the files with the fasta extension (in the directory `T-coffee` ) -  `ls` command & _*_

-----------------------

<a name="practice-6"></a>
### Practice 6 : Moving into file system using `cd`and `ls` command

* Go to the directory `Script` and check in the prompt you have changed correctly your working directory (`pwd`).
* List the dir content with `ls`.
* Go to the `Fasta` directory using `../`
* Go to the `Fastq` directory . From  this directory, and without any change in your working dir, list what's in `samBam` directory
* List `vcf`directory using -R option. What is there in this dir ?
* Come back to the home directory.

---
**NOTE**

Test the command `tree`

<details>

{% highlight bash %}
[tranchant@node6 LINUX-TP]$ tree
.
├── AllEst.fasta
├── Bank
│   ├── referenceArcad.fasta
│   ├── referenceIrigin.dict
│   ├── referenceIrigin.fasta
│   ├── referenceIrigin.fasta.fai
│   ├── referencePindelChr1.fasta
│   ├── referencePindelChr1.fasta.fai
│   ├── referenceRnaseq.fa
│   └── referenceRnaseqGFF.gff3
├── Data
│   ├── fastq
│   │   ├── assembly
│   │   │   ├── ebolaAssembly
│   │   │   │   ├── ebola1.fastq
│   │   │   │   ├── ebola1.fq
│   │   │   │   ├── ebola2.fastq
│   │   │   │   └── ebola2.fq
│   │   │   └── pairedOneIndivuPacaya
│   │   │       ├── g02L5Mapped_R1.fq
│   │   │       └── g02L5Mapped_R2.fq
...
│   │   ├── tlara_tRNA_aln10.output.gz
│   │   ├── tlara_tRNA_aln50.output.gz
│   │   ├── tlara_tRNA_aln51.output.gz
│   │   ├── two_profiles.template_file
│   │   └── x.gz
│   └── vcf
│       ├── duplicVCF
│       │   ├── smallDuplic-filtered.vcf
│       │   └── smallDuplic.vcf
│       ├── singleVCF
│       │   └── GATKVARIANTFILTRATION.vcf
│       ├── testsnmf.geno
│       ├── vcfForRecalibration
│       │   └── control.vcf
│       └── vcfForSNiPlay
│           └── testsnmf.vcf
├── Fasta
│   ├── C_AllContigs.fasta
│   ├── contig_tgicl.fasta
│   ├── enterobacteries.fasta
│   ├── sequence.fasta
│   └── uniprot_sprot.fasta
├── Script
│   ├── array.pl
│   ├── codon_usage.pl
│   ├── hash.pl
│   ├── helloWorld.pl
│   ├── loops-for.pl
│   ├── matching.pl
│   ├── readFasta.pl
│   ├── retrieve-accession.pl
│   ├── sorting-array.pl
│   ├── string-array.pl
│   └── transliterate.pl
└── transcritsAssembly.fasta

29 directories, 253 files
[tranchant@node6 LINUX-TP]$ 
{% endhighlight %}

</details>
---

-----------------------

<a name="practice-7"></a>
### Practice 7 : Manipulating Files and Folders

We will prepare our blast analysis performed after by creating directory and moving files as showing in the image just below :
<img width="50%" class="img-responsive" src="{{ site.url }}/images/tpLinux/tp-arbo-blast.png"/>

* Create a directory called `BlastAnalysis` with `mkdir`command.
* Move `transcritsAssembly.fasta`  into this new directory with `mv` command.
* List the content of `LINUX-TP`and `BlastAnalysis` with `ls` command.
* Copy `AllEst.fasta` in `Bank` directory with `cp` command.
* List the content of `LINUX-TP`and `Bank` directories. What are the differences between mv and cp?
* Remove the file `AllEst.fasta` in `LINUX-TP` directory with `rm` command.
* Copy the whole directory `T-coffee` with the name `T-coffee-copy`into `LINUX-TP`directory.
* After checking the content of `LINUX-TP`directory, remove the directory `T-coffee-copy`. How to remove a directory ?
* Remove all the files into the directory  `T-coffee-copy` with `rm *` command.
* Remove the directory `T-coffee-copy`.




<a name="practice-8"></a>

### Practice 8 : Searching with `grep`

* Go on the following page : https://plants.ensembl.org/Oryza_sativa/Info/Index
* Copy the url of the rice genome annotation file (gff format, all chromosomes) that we will use to download the file directly on the server
* Go to the `Bank`directory and type the following command :

{% highlight bash %}wget gff_url{% endhighlight %}

* After checking the content of your current directory, what have you done with the `wget`command?
* Decompress the gff with the command `gzip -d file.gz`
* Display the firsts and lasts lines of the gff file
* Print the number of lines with the word genes in the gff file
* Count the number of genes
* Search for the nbs-lrr genes
* Count lines without the word "putative" 


-----------------------

<a name="practice-9"></a>
### Practice 9 : Blast analysis

##### Preparing working environment 

Before launching your blast, you have to prepare your working environment :
* go into the directory /scratch2
* create a directory called 'formation_PUT_YOUR_ID' into the directory `/scratch2` and move into this new drectory
* download the directory with the data that will be used to perform a blast -  `wget http://itrop.ird.fr/LINUX-TP/BlastAnalysis.tar.gz`
* decompress the gzip file `tar -xzvf BlastAnalysis.tar.gz`
* go into the directory BlastAnalysis


##### Creating a custom database with `makeblastdb`
As we use a custom database for the first time, If we have a fasta format file of these sequences we have to create a database from our fasta format file `AllEst.fasta` with the `makeblastdb` command.
* Load the module blast 
* {% highlight bash %}module load bioinfo/blast/2.12.0+{% endhighlight %}

* Go into the `Bank` directory and create a nucleotide database by typing:
{% highlight bash %}
makeblastdb -in AllEst.fasta -dbtype nucl -parse_seqids{% endhighlight %}

* List the content of the directory to check if the database has been indexed

##### BLASTing against our remote database

* Go into the `blastAnalysis` directory
* Run the blast by typing the following command with the outfmt equals to 6 :

{% highlight bash %}blastn –query fastaFile -db databaseFile –outfmt [0-11]  -out resultFile{% endhighlight %}

* Output formats

{% highlight bash %}
The flag for the output format is -outfmt followed by a number which denotes the format request :

0 = pairwise,
1 = query-anchored showing identities,
2 = query-anchored no identities,
3 = flat query-anchored, show identities,
4 = flat query-anchored, no identities,
5 = XML Blast output,
6 = tabular,
7 = tabular with comment lines,
8 = Text ASN.1,
9 = Binary ASN.1,
10 = Comma-separated values,
11 = BLAST archive format (ASN.1)
</pre>
{% endhighlight %}

* Output tabular format (6 or 7): one line per results splitted in 12 fields.

{% highlight bash %}
1. query id
2. subject id
3. percent identity
4. alignment length
5. number of mismatche-
6. number of gap openings
7. query start
8. query end
9. subject start
10. subject end
11. expect value
12. bit score
{% endhighlight %}


##### Parsing the results file
* Display  the  first  10  lines  of  the  file  - `head`
* Display  the  first  15  lines  of  the  file  - `head`
* Display  it  last  15  lines  - `tail`
* Count  the  number  of  line - `wc`
* Sort the lines using the second field (subject  id) by alphabetical order, ascending then descending   - `sort`
* Sort lines by e‐value (ascending) and by “alignment length” (descending) - `sort`
* Extract the first 4 fields - `cut`
* Extract query id, subject id, evalue, alignment length `cut`

-----------------------

<a name="practice-10"></a>
### Practice 10 : Redirecting a command output to a File with `>`
* Extract all ESTs identifiers and print them in the file  ESTs_accession.list - `cut >`

-----------------------

<a name="practice-11"></a>
### Practice 11 :  Sending data from one command to another (piping) with `|`
* How many sequences have a homology with EST sequences ? (TIPs: `cut` command with `sort -u` (uniq) or `uniq` command ))
* Extract ESTs sequences from database with `seqtk` by typing :

{% highlight bash %}
module load bioinfo/seqtk/1.3-r106
seqtk 
seqtk subseq
seqtk subseq bank.fasta ests.id | head
seqtk subseq bank.fasta ests.id > ests.fasta

{% endhighlight %}

{% highlight bash %}
ests.id the file containing the sequence names 
bank.fasta the file containig the sequences that we want to extract
{% endhighlight %}

* Count the number of sequences extracted - `grep ">" c `
* Get the help of `seqtk comp` program - `seqtk comp`
* Run seqtk comp program on your fasta file created just before
{% highlight bash %}
seqtk comp  FASTA_FILE | head
{% endhighlight %}
* Display only accession, length with cut command or directly with infosee
* What is the shorthest sequence (Accession and length)?
* What is the longuest sequence (Accession and length)?

-----------------------

<a name="practice-12"></a>
### Practice 12 : Dealing with vcf Files 

* List the content of the directory `/scratch2/VCF_LINUX`
* Before creating your directory `/scratch2/VCF_LINUX_FORMATIONX`, displays the amount of disk space available on the file system with the command `df`
* Create your directory the directory `/scratch2/VCF_LINUX_FORMATIONX`and go into it.
* Create a shortcut of the different vcf file in the directory `/scratch2/VCF_LINUX`  with the command `ln -s source_file myfile`

For example
{% highlight bash %}
ln -s /scratch2/VCF_LINUX_FORMATIONX/OgOb-all-MSU7-CHR6.GATKVARIANTFILTRATION.vcf OgOb-all-MSU7-CHR6.GATKVARIANTFILTRATION.LINK.vcf
{% endhighlight %}

Thus, OgOb-all-MSU7-CHR6.GATKVARIANTFILTRATION.LINK.vcf is the name of the new file containing the reference to the file named OgOb-all-MSU7-CHR6.GATKVARIANTFILTRATION.vcf.

* Repeat the same operation with the other vcf files
* List the content of the directory `VCF_LINUX_FORMATIONX` with `ls -l`
* Display the size of each vcf files in the directory `/scratch2/VCF_LINUX` then in your directory `/scratch2/VCF_LINUX_FORMATIONX` - `du`
* Display the size of the directory `/scratch2/VCF_LINUX` and the directory `/scratch/VCF_LINUX_FORMATIONX` - `du`
* Displays the first lines of the vcf files - `zcat, head` commands
* Displays the last lines of the vcf files - `zcat, tail` commands
* Count the lines of the vcf files - `zcat, wc -l` command

-----------------------

<a name="practice-13"></a>
### Practice 13 :  Filtering VCF files `|` - `zgrep` 
To get some basics stats of the output VCF files, let's use linux command!
* How many polymorphisms were detected (Displaying all the lines which does not start with # / header lines) in the different vcf files ?
* How many polymorphisms were considered "good" after filtering steps by GATK VARIANTFILTRATION (ie marked `PASS`)?
* How many polyporphisms were considered "bad" and filtered out (Displaying all the lines without the `PASS` tag )?
* Save only the "good" polymorphisms detected that were considered "good" in a new file called `OgOb-all-MSU7-CHR6.GATKVARIANTFILTRATION.GOOD.vcf`
* Display the size of this new vcf files

-----------------------

<a name="practice-14"></a>
### Practice 14 : Getting basic stats
* Go into the directory `LINUX-TP/Data/fastq/pairedTwoIndividusGzippedIrigin` - `cd`
* List the directory content
* Run fastq-stats program ( [more](http://manpages.ubuntu.com/manpages/xenial/man1/fastq-stats.1.html) to get stats about the fastq file `irigin1_1.fastq.gz`
{% highlight bash %}
fastq-stats -D irigin1_1.fastq.gz
{% endhighlight %}
* BONUS :
Use a `for` loop to run fastq-stats with every fastq file in the directory
{% highlight bash %}
for file in *fastq; do 
  fastq-stats -D $file > $file.fastq-stats ; 
done;
{% endhighlight %}


-----------------------

<a name="tips"></a>
### Tips

<a name="convertFileFormat"></a>
##### How to convert between Unix and Windows text files?
The format of Windows and Unix text files differs slightly. In Windows, lines end with both the line feed and carriage return ASCII characters, but Unix uses only a line feed. As a consequence, some Windows applications will not show the line breaks in Unix-format files. Likewise, Unix programs may display the carriage returns in Windows text files with Ctrl-m (^M) characters at the end of each line.

There are many ways to solve this problem as using text file compatible, unix2dos / dos2unix command or vi to do the conversion. To use the two last ones, the files to convert must be on a Linux computer.

###### use notepad as file editor on windows

When using Unix files on Windows, it is useful to convert the line endings to display text files correclty in other Windows-based or linux-based editors.

In Notepad++: `Edit > EOL Conversion > Windows Format`

<img width="50%" class="img-responsive" src="{{ site.url }}/images/tpLinux/tp-notepadUTF8.png"/>

###### `unix2dos` & `dos2unix`

<pre><code>
# Checking if my fileformat is dos
[tranchant@master0 ~]$ cat -v test.txt
jeidjzdjzd^M
djzoidjzedjzed^M
ndzndioezdnezd^M

# Converting from dos to linux format
[tranchant@master0 ~]$ dos2unix test.txt
dos2unix: converting file test.txt to Unix format ...
[tranchant@master0 ~]$ cat -v test.txt
jeidjzdjzd
djzoidjzedjzed
ndzndioezdnezd

# Converting from linux to dos format
[tranchant@master0 ~]$ unix2dos test.txt
unix2dos: converting file test.txt to DOS format ...
[tranchant@master0 ~]$ cat -v test.txt
jeidjzdjzd^M
djzoidjzedjzed^M
ndzndioezdnezd^M
[tranchant@master0 ~]$
</code></pre>

###### vi

* In vi, you can remove carriage return _^M _ characters with the following command: `:1,$s/^M//g`
* To input the _^M_ character, press _Ctrl-v_, and then press _Enter_ or _return_.
* In vim, use :`set ff=unix` to convert to Unix; use `:set ff=dos` to convert to Windows.

-----------------------

<a name="readFile"></a>
##### How to open and read a file through a text editor on a distant linux server?

###### vi
[Manual](https://www.washington.edu/computing/unix/vi.html/)

###### nano
[Manual](https://www.howtogeek.com/howto/42980/)

###### Komodo Edit

After installing Komodo Edit, open it and click on _Edit –> Preferences_
<img width="50%" class="img-responsive" src="{{ site.url }}/images/tpLinux/tp-komodoEdit1.png"/>

Select Servers from the left and enter sftp account information, then save it.
<img width="50%" class="img-responsive" src="{{ site.url }}/images/tpLinux/tp-komodoEdit2.png"/>

To edit a distant content, click on _File –> Open –> Remote File_
<img width="50%" class="img-responsive" src="{{ site.url }}/images/tpLinux/tp-komodoEdit3.png"/>

-----------------------

<a name="help"></a>
#### Getting Help on any command-line

###### with the option `--help`
Virtually all commands understand the `-h` (or `--help`) option, which produces a short usage description of the command and its options.
<pre>
<code>
[tranchant@master0 ~]$ ls --help
Utilisation : ls [OPTION]... [FILE]...
Afficher des renseignements sur les FILEs (du répertoire actuel par défaut).
Trier les entrées alphabétiquement si aucune des options -cftuvSUX ou --sort
ne sont utilisées.

Les arguments obligatoires pour les options longues le sont aussi pour les
options courtes.
  -a, --all                  ne pas ignorer les entrées débutant par .
  -A, --almost-all           ne pas inclure . ou .. dans la liste
      --author               avec -l, afficher l'auteur de chaque fichier
  -b, --escape               afficher les caractères non graphiques avec des
                               protections selon le style C
      --block-size=SIZE      convertir les tailles en SIZE avant de les
                               afficher. Par exemple, « --block-size=M » affiche
                               les tailles en unités de 1 048 576 octets ;
                               consultez le format SIZE ci-dessous
  -B, --ignore-backups       ne pas inclure les entrées se terminant par ~ dans
                               la liste
  -c                         avec -lt : afficher et trier selon ctime (date de
                               dernière modification provenant des informations
                               d'état du fichier) ;
                               avec -l : afficher ctime et trier selon le nom ;
                               autrement : trier selon ctime
  -C                         afficher les noms en colonnes
      --color[=WHEN]         colorier la sortie ; par défaut, WHEN peut être
                               « never » (jamais), « auto » (automatique) ou
                               « always » (toujours, valeur par défaut) ; des
                               renseignements complémentaires sont ci-dessous
  -d, --directory            afficher les noms de répertoires, pas leur contenu
...

</code>
</pre>

###### with the `man` command
Every command and nearly every application in Linux has a man (manual) file, so finding such a file is as simple as typing man command to bring up a longer manual entry for the specified command.

<pre>
<code>
# Type man ls to display the related manual

LS(1)                                      Manuel de l'utilisateur Linux                                      LS(1)

NOM
       ls, dir, vdir - Afficher le contenu d'un répertoire

SYNOPSIS
       ls [options] [fichier...]
       dir [fichier...]
       vdir [fichier...]

       Options POSIX : [-CFRacdilqrtu1] [--]

       Options  GNU  (forme  courte)  :  [-1abcdfgiklmnopqrstuvwxABCDFGHLNQRSUX]  [-w  cols]  [-T  cols] [-I motif]
       [--full-time]  [--show-control-chars]   [--block-size=taille]   [--format={long,verbose,commas,across,verti‐
       cal,single-column}]       [--sort={none,time,size,extension}]       [--time={atime,access,use,ctime,status}]
       [--color[={none,auto,always}]] [--help] [--version] [--]

DESCRIPTION
       La commande ls affiche tout d'abord l'ensemble de ses arguments fichiers autres que des répertoires. Puis ls
       affiche  l'ensemble  des  fichiers  contenus  dans chaque répertoire indiqué. Si aucun argument autre qu'une
       option n'est fourni, l'argument « . » (répertoire en cours) est pris  par  défaut.  Avec  l'option  -d,  les
       répertoires  fournis  en argument ne sont pas considérés comme des répertoires (on affiche leurs noms et pas
       leurs contenus). Un fichier n'est affiché que si son nom ne commence pas par un point, ou si l'option -a est
       fournie.

       Chacune  des  listes  de fichiers (fichiers autres que des répertoires, et contenu de chaque répertoire) est
       triée séparément en fonction de la séquence d'ordre de la localisation en cours.  Lorsque  l'option  -l  est
       .....
</code>
</pre>

Some helpful tips for using the man command :
* `Arrow keys`: Move up and down the man file by using the arrow keys.
* `q`: Quit back to the command prompt by typing q.

-----------------------

### Links
<a name="links"></a>

* Related courses : [Linux for Dummies](https://southgreenplatform.github.io/trainings/linux/)
* Tutorials : [Linux Command-Line Cheat Sheet](https://southgreenplatform.github.io/trainings/linux/linuxTuto/)

-----------------------

### License
<a name="license"></a>

<div>
The resource material is licensed under the Creative Commons Attribution 4.0 International License (<a href="http://creativecommons.org/licenses/by-nc-sa/4.0/">here</a>).
<center><img width="25%" class="img-responsive" src="http://creativecommons.org.nz/wp-content/uploads/2012/05/by-nc-sa1.png"/>
</center>
</div>
