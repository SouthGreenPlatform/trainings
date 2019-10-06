---
layout: page
title: "HPC Ouaga Practice"
permalink: /hpc/HPCOuagaPractice/
tags: [ linux, HPC, cluster, module Environment ]
description: HPC Practice page
---

| Description | Exercices pour utiliser un cluster de calcul |
| :------------- | :------------- | :------------- | :------------- |
| Supports de cours liés | [HPC](https://southgreenplatform.github.io/trainings/HPCOuaga/) |
| Auteur | Ndomassi TANDO (ndomassi.tando@ird.fr)  |
| Date de création | 04/10/2019 |
| Date de modification | 05/10/2019 |


-----------------------

### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Preambule: Logiciels à installer ](#preambule)
* [Exercice 1: Se connecter à un serveur Linux avec `ssh`](#exercice-1)
* [Exercice 2: Reserver un coeur sur le noeud de calcul et créer son répertoire de travail](#exercice-2)
* [Exercice 3: Transférer des fichiers avec Filezilla `sftp`](#exercice-3)
* [Exercice 4: Transférer des fichiers au noeud de calcul avec `scp`](#exercice-4)
* [Exercice 5: Utiliser Module Environment pour charger ses outils](#exercice-5)
* [Exercice 6: Lancer ses analyses ](#exercice-6)
* [Exercice 7: Transférer ses résultats vers son /home  avec `scp` ](#exercice-7)
* [Exercice 8: Supprimer vos répertoires dedonnées d'analyse](#exercice-8)
* [Exercice 9: Lancer un job en mode batch](#exercice-9)
* [Links](#links)
* [License](#license)


-----------------------

<a name="preambule"></a>
### Preambule


##### Se connecter à un serveur Linux en utilisant SSH 

| Platforme | Logiciel  | Description | url | 
| :------------- | :------------- | :------------- | :------------- |
| <img width="10%" class="img-responsive" src="{{ site.url }}/images/tpLinux/osWin.png"/> | mobaXterm |un terminal évolué pour Windows avec un serveur X11 et un client SSH intégrés | [more](https://mobaxterm.mobatek.net/) |
| <img width="10%" class="img-responsive" src="{{ site.url }}/images/tpLinux/osWin.png"/>| putty | Putty permet de se connecter à un serveur Linux depuis une machine Windows .   | [Download](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)| 



##### Transférer des fichiers depuis votre ordinateur vers des serveurs Linux et inversement avec SFTP (SSH File Transfer Protocol) 

| Platforme | Logiciel  | Description | url | 
| :------------- | :------------- | :------------- | :------------- | 
| <img width="10%" class="img-responsive" src="{{ site.url }}/images/tpLinux/osApple.png"/> <img width="10%" class="img-responsive" src="{{ site.url }}/images/tpLinux/osLinux.png"/> <img width="10%" class="img-responsive" src="{{ site.url }}/images/tpLinux/osWin.png"/>| <img width="10%" class="img-responsive" src="{{ site.url }}/images/tpLinux/filezilla.png"/> filezilla |  FTP and SFTP client  | [Download](https://filezilla-project.org/)  | 


##### Editer des fichiers sur une machine windows ou directement sur un serveur Linux 

| Type | Software  | url | 
| :------------- | :------------- | :------------- |
| Distant, consol mode |  nano | [Tutorial](http://www.howtogeek.com/howto/42980/) |  
| Distant, consol mode |  vi | [Tutorial](https://www.washington.edu/computing/unix/vi.html)  |  
| Distant, graphic mode| komodo edit | [Download](https://www.activestate.com/komodo-ide/downloads/edit) | 
| Linux & windows based editor | Notepad++ | [Download](https://notepad-plus-plus.org/download/v7.5.5.html) | 

-----------------------


<a name="exercice-1"></a>
### Exercice 1: Se connecter à un serveur Linux avec `ssh`

Avec mobaXterm:
1. Cliquer sur le bouton `session` puis cliquer SSH.
* Dans le champ `remote host` , taper: 192.168.4.102
* Cocher la case  `specify username` et écrire le compte formationX
2. Dans le champ, entrer le mot de passe fomartionX quand il est demandé.
Une fois connecté, , vous utiliserez cette console pour le reste du cours. 
3. Taper la commande `sinfo` et commenter le resultat
4. Taper la commande `sinfo -N -l` et commenter le resultat

-----------------------


<a name="exercice-2"></a>
### Exercice 2: Reserver un coeur sur le noeud de calcul et créer son répertoire de travail


1. Taper la commande `squeue` et commenter le résultats
2. Taper la commande `srun --time=60:00 -p short --pty bash -i` puis `squeue` une nouvelle fois
3. Taper la commande `squeue` et commenter le résultats
5. Create your own working folder in the /tmp of your node:
 
 `cd /scratch`
 
 `mkdir formationX`
        
6. Type the following command with the nodeX of your choice expect the one you are already connected to      

  `ssh nodeX "ls -al /scratch/"` 
  
  Tip: you can use qlogin instead of qrsh if you want to use graphical software

-----------------------


<a name="exercice-3"></a>
### Exercice 3: Transférer des fichiers avec Filezilla `sftp`


##### Download and install FileZilla


##### Open FileZilla and save the IRD cluster into the site manager

<img width="50%" class="img-responsive" src="{{ site.url }}/images/tpLinux/tp-filezilla1.png"/>

In the FileZilla menu, go to _File > Site Manager_. Then go through these 5 steps:

1. Click _New Site_.
2. Add a custom name for this site.
3. Add the hostname bioinfo-nas.ird.fr to have access to /data2/formation
4. Set the Logon Type to "Normal" and insert your username and password used to connect on the IRD cluster
5. Press the "Connect" button.


##### Transferring files

<img width="50%" class="img-responsive" src="{{ site.url }}/images/tpLinux/tp-filezilla2.png"/>

1. From your computer to the cluster : click and drag an text file item from the left local colum to the right remote column 
2. From the cluster to your computer : click and drag an text file item from he right remote column to the left local column
3. Retrieve the file HPC_french.pdf from the right window into the folder /data/projects/formation/

-----------------------


<a name="exercice-4"></a>
### Exercice 4: Transférer des fichiers au noeud de calcul avec `scp`


1. Using scp, transfer the folder `TPassembly` located in `/data2/formation` into your working directory
2. Check your result with ls
 


-----------------------
<a name="exercice-5"></a>
### Exercice 5: Utiliser Module Environment pour charger ses outils


1. Load ea-utils V2.7 module
2. Check if the tool are loaded
 


-----------------------

<a name="exercice-6"></a>
###  Exercice 6: Lancer ses analyses 

#### Get stats on fastq   

1. Go into  the folder `TPassembly/Ebola`
2. Launch the command `fastq-stats ebola1.fastq`
3. Launch the command `fastq-stats -D ebola1.fastq`

#### Perform an assembly with abyss-pe

With abyss software, we reassembly the sequences using the 2 fastq files ebola1.fastq and ebola2.fastq

Launch the commands

`module load bioinfo/abyss/1.9.0`

`qsub -q formation.q -l hostname=nodeX -cwd -b y abyss-pe k=35 in=\'ebola1.fastq ebola2.fastq\' name=k35`



-----------------------
<a name="exercice-7"></a>
### Exercice 7: Transférer ses résultats vers son /home  avec `scp


1. Using scp, transfer your results from your `/scratch/formationX` to your `/home/login` 
2. Check if the transfer is OK with ls
 




-----------------------
<a name="exercice-8"></a>
### Exercice 8: Supprimer vos répertoires de données d'analyse

`cd /tmp`

`rm -r formationX`

`exit`

 -----------------------
<a name="exercice-9"></a>
### Exercice 9: Lancer un job en mode batch

We are  going to launch a 4 steps analysis:

1) Perform a multiple alignment with the nucmer  tool

2) Filter these alignments with the delta-filter  tool

3) Generate a tab file easy to parse the with show-coords tools

4) Generate a png image with mummerplot


- Retrieve the script /data2/formation/script/alignment.sh into your /home/formation

- launch the script with qsub:

`qsub -q formation.q alignment.sh`

- Do a `ls -altr` in your `/home/formationX`. What do you notice?

- Launch the following command to obtain info on the finished job:

`qacct -j JOB_ID`

- Open filezilla and retrieve the png image to your computer

- Launch the following commande to clear the /scratch of the node

`ssh nodeX rm -r /scratch/formationX*`

-----------------------

### Liens
<a name="liens"></a>

* Cours lié : [Linux for Dummies](https://southgreenplatform.github.io/trainings/linux/)


-----------------------

### License
<a name="license"></a>

<div>
The resource material is licensed under the Creative Commons Attribution 4.0 International License (<a href="http://creativecommons.org/licenses/by-nc-sa/4.0/">here</a>).
<center><img width="25%" class="img-responsive" src="http://creativecommons.org.nz/wp-content/uploads/2012/05/by-nc-sa1.png"/>
</center>
</div>
                  
 
