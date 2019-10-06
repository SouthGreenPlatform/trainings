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
| Date de modification | 06/10/2019 |


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
* Cocher la case  `specify username` et écrire le compte `formationX`
2. Dans le champ, entrer le mot de passe `formationX` quand il est demandé.
3 taper la commande suivante: 

{% highlight bash %}ssh master{% endhighlight %}

4. Taper la commande `sinfo` et commenter le resultat
5. Taper la commande `scontrol shown nodes` et commenter le resultat

-----------------------


<a name="exercice-2"></a>
### Exercice 2: Reserver un coeur sur le noeud de calcul et créer son répertoire de travail


1. Taper la commande `squeue` et commenter le résultat
2. Taper la commande

{% highlight bash %}srun --time=60:00 -p short --pty bash -i{% endhighlight %}

puis {% highlight bash %}squeue{% endhighlight %} une nouvelle fois
3. Taper la commande `squeue -u` et commenter le résultats
4. Créer votre répertoire de travail dans  `/tmp` du noeud:


 
 {% highlight bash %}cd /tmp
 mkdir formationX{% endhighlight %}
        

-----------------------


<a name="exercice-3"></a>
### Exercice 3: Transférer des fichiers avec Filezilla `sftp`


##### Télécharger et installer filezilla


##### Ouvrir FileZilla et sauvegarder la connexion au cluster dans le  site manager

<img width="50%" class="img-responsive" src="{{ site.url }}/images/tpLinux/tp-filezilla1.png"/>

Dans le menu de FileZilla, aller dans  _Fichier > Gestionnaire de Site_. puis effectuer ces 5 étapes:

1. Cliquer _Nouveau Site_.
2. Ajouter un nom pour ce site.
3. Ajouter le hostname 192.168.4.102 pour avoir accès au répertoire `/opt/HPC`
4. Mettre le Type d'authentification à "Normal" et rentrer vos logins: `formationX` et mot de passe `formationX`
5. Presser le bouton "Connexion" 


##### Transférer le fichier

<img width="50%" class="img-responsive" src="{{ site.url }}/images/tpLinux/tp-filezilla2.png"/>

1.Depuis votre ordinateur vers le cluster : cliquer et déposer le  fichier depuis la colonne de gauche vers la colonne de droite 
2. Du cluster vers votre ordinateur  : cliquer et déposer le  fichier depuis la colonne de droite vers la colonne de gauche 
3. Récupérer le fichier HPC_ouaga_oct2019.pdf situé dans le répertoire `/opt/HPC`

-----------------------


<a name="exercice-4"></a>
### Exercice 4: Transférer des fichiers au noeud de calcul avec `scp`


1. En utilisant scp, transférer le répertoire `tp-cluster` situé dans `/opt` dans votre répertoire de travail

2. Vérifier que le transfert s'est bien déroulé avec la commande ls.
 


-----------------------
<a name="exercice-5"></a>
### Exercice 5: Utiliser Module Environment pour charger ses outils


1. Charger le module  blast+ vers 2.7.1
2. Vérifier que le module soit chargé.
 


-----------------------

<a name="exercice-6"></a>
###  Exercice 6: Lancer ses analyses 

Aller dans le répertoire `Blast` et taper la commande suivante:


{% highlight bash %}$ blastn -db All-EST-coffea.fasta -query sequence-NMT.fasta -out blastn.out{% endhighlight %} 


Bonus:

Aller dans le répertoire `/tmp/formationX/BWA`

Charger le module bwa v 0.7.17 

Puis lancer les commandes suivantes:

{% highlight bash %} bwa index Reference.fasta
bwa mem reference.fasta RC1_1_CUTADAPT_forwardRepaired.fastq RC1_2_CUTADAPT_reverseRepaired.fastq > mapping.sam{% endhighlight %} 


-----------------------
<a name="exercice-7"></a>
### Exercice 7: Transférer ses résultats vers son /home  avec `scp`


1. En utilisant scp, transférer vos résultatx depuis votre `/tmp/formationX` vers votre `/home/formationX` 
2. Vérifier que le transfert est OK avec la commande `ls`
 




-----------------------
<a name="exercice-8"></a>
### Exercice 8: Supprimer vos répertoires de données d'analyse

{% highlight bash %} cd /tmp
rm -r formationX
exit{% endhighlight %}

 -----------------------
<a name="exercice-9"></a>
### Exercice 9: Lancer un job en mode batch

S'inspirer du script suivant pour lancer une analyse blast :

Exemple  de script slurm:

{% highlight bash %}#!/bin/bash
## On définit le nom du job
#SBATCH --job-name=test
## On définit le nom du fichier de sortie
#SBATCH --output=res.txt
## On définit le nombre de tâches
#SBATCH --ntasks=1
## On définit le temps limit d'éxécution
#SBATCH --time=10:00
## On définit 100Mo de mémoire par cpu
#SBATCH --mem-per-cpu=100
sleep 00:03:00 #on lance un sleep de 3 minutes{% endhighlight %}

Une analyse sera lancé grâce à la commande:

{% highlight bash %}sbatch script.sh{% endhighlight %}

Avec `script.sh` le nom du script à utiliser

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
                  
 
