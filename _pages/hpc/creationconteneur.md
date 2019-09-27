---
layout: page
title: "Création de conteneurs Singularity"
permalink: /hpc/creationconteneur/
tags: [ linux, HPC, cluster, OS ]
description:  Page de création de conteneurs Singularity
---

| Description | Savoir créer des conteneurs Singularity|
| :------------- | :------------- | :------------- | :------------- |
| Cours lié| [HPC Administration Module2](https://southgreenplatform.github.io/trainings/Module2/) |
| Auteur | Ndomassi TANDO (ndomassi.tando@ird.fr)  |
| Date de création |27/09/2019 |
| Date de modification | 27/09/2019 |


-----------------------


### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Préparer son environnement](#part-1)
* [Créer un fichier de recette](#part-2)
* [Construire son conteneur](#part-3)
* [Tester son conteneur](#part-3)
* [Links](#links)
* [License](#license)


-----------------------
<a name="part-1"></a>
## Préparer son environnement

Il faut créer sur le cluster dans une partition partagée les deux répertoires suivantes:

- def: destiner à accueillir les fichiers de recettes 
- conteneurs: destiner à accueillir les conteneurs Singularity générés

On pourra par exemple les créer dans `/usr/local/singularity`:

    {% highlight bash %}$ mkdir /usr/local/singularity/def
    $ mkdir /usr/local/singularity/conteneurs{% endhighlight %} 

-------------------------------------------------------------------------------------

<a name="part-2"></a>
## Créer un fichier de recette:
       
Un fichier de recette est un fichier dans lequel on va écrire toutes les lignes de commandes nécessaires pour créer un conteneur singularity.

Il s'agit d'un fichier avec l'extension `.def`

On va en  retrouver dans ce fichier plusieurs sections obligatoires:

### l'entête

Il doit être écrit au début du fichier et donne les informations à Singularity sur le système d'exploitation à utiliser dans le conteneur. 

`BootStrap` va determiner l'agent bootstrap agent qui va être utilisé por créer le système d'exploitation de base base. 

Par exemple,l'agent bootstrap `library` bootstrap va  récupérér un conteneur de base depuis les Container`Library`. 

l'agent bootstrap `docker` va lui récupérer les couches docker depuis le Docker Hub comme OS de base pour démarrer notre image.

Les principaux BootStrap sont les suivants:

- library (images hébergées sur le Container Library)
- docker (images hébergées sur Docker Hub)
- shub (images hébergées sur Singularity Hub)
- oras (images des registres OCI)
- scratch (pour construire des conteneurs from scratch)

Le mot clé `From` permet des choisir l'OS et la version que l'on veut utiliser exemple: `From: ubuntu:18.04`

### les sections:

`%labels`permet de rajouter des  metadata au fichier `/.singularity.d/labels.json` à l'intérieur du conteneur. 

Il donne des informations générales sur le conteneur et son auteur.

`%help` permet d'écrire une aide à destination des utilisateurs quand il vont taper la commande `singularity help nom_conteneur.simg`

`%environment`permet de définir des variables d'environnement à l'intérieur du conteneur. Ces variables seront prises en compte dès le build du conteneur.

`%post` dans cette section on va lister les commandes à passer à l'OS de base. Typiquement c'est là que l'on écrit les commandes pour installer notre logiciels

`%runscript`dans cette section ce sont les commandes qui font être exécuter au lancement du conteneur `singularity run mon_conteneur.simg` ou `singularity exec mon_conteneur.simg`. Quand le conteneur est appele, les arguments suivants le nom du conteneur sont passés en arguments.


### Exemple de fichier de recette:

Ci-dessous un exemple de fichier de recette `bwa-0.7.17.def`pour la construction du conteneur `bwa-0.7.17.simg`


{% highlight bash %}BootStrap: docker
From: ubuntu:18.04
%labels
Maintainer Ndomassi Tando - IRD Itrop Cluster, DIADE Unit
base.image="ubuntu:18.04"
version="1"
software="bwa"
software.version="0.7.17"
%help
URL: http://bio-bwa.sourceforge.net/
Description: BWA is a software package for mapping low-divergent sequences against a large reference genome, such as the human genome
Launch the command: singularity run bwa-0.7.17.simg + arguments to use bwa
%environment
export PATH=$PATH:/usr/local/bwa-0.7.17/
%post
apt-get update
apt-get install -y build-essential wget gcc zlib1g-dev
mkdir -p /opt/sources/
cd /opt/sources/
wget https://github.com/lh3/bwa/archive/v0.7.17.tar.gz
tar xvfz v0.7.17.tar.gz
cd bwa-0.7.17
make
cp -r /opt/sources/bwa-0.7.17 /usr/local/bwa-0.7.17
chmod +x -R /usr/local/bwa-0.7.17
%runscript
exec /usr/local/bwa-0.7.17/bwa "$@"{% endhighlight %} 






----------------------------------------------------------------------------------------------

<a name="part-3"></a>
## Construire son conteneur:

Une fois le fichier de recette créé, on va pouvoir le conteneur singularity avec la commande 


{% highlight bash %}$ singularity build nom_conteneur.simg nom_fichier_recette.def{% endhighlight %}

exemple pour le conteneur bwa-0.7.17:

{% highlight bash %}$ singularity build bwa-0.7.17.simg bwa-0.7.17.def{% endhighlight %}

----------------------------------------------------------------------------------------------

<a name="part-4"></a>
## Tester son conteneur:


{% highlight bash %}$ singularity run nom_conteneur.simg{% endhighlight %}

Permettra de lancer le runscript du conteneur à l'intérieur du conteneur.

Exemple:

{% highlight bash %}$ singularity run bwa-0.7.17.simg -h{% endhighlight %}

lancer la commande bwa -h

{% highlight bash %}$ singularity exec nom_conteneur.simg commande{% endhighlight %}

Permettra de lancer la commande précisée à l'intérieur du conteneur.

Exemple:

singularity exec /usr/local/singularity-2.4/containers/bwa-0.7.17.simg cat /etc/profile

Permettra d'afficher le contenu du fichier `/etc/profile`du conteneur


  
-----------------------

### Links
<a name="links"></a>

* Cours liés : [HPC Trainings](https://southgreenplatform.github.io/trainings/HPC/)


-----------------------

### License
<a name="license"></a>

<div>
The resource material is licensed under the Creative Commons Attribution 4.0 International License (<a href="http://creativecommons.org/licenses/by-nc-sa/4.0/">here</a>).
<center><img width="25%" class="img-responsive" src="http://creativecommons.org.nz/wp-content/uploads/2012/05/by-nc-sa1.png"/>
</center>
</div>
                  
 
