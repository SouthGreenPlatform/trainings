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

l'agent bootstrap `docker va lui récupérer les couches docker depuis le Docker Hub comme OS de base pour démarrer notre image.

Les principaux BootStrap sont les suivants:

- library (images hébergées sur le Container Library)
- docker (images hébergées sur Docker Hub)
- shub (images hébergées sur Singularity Hub)
- oras (images des registres OCI)
- scratch (pour construire des conteneurs from scratch)


----------------------------------------------------------------------------------------------

<a name="part-3"></a>
## Construire son conteneur:


{% highlight bash %}$ scontrol show nodes {% endhighlight %}

----------------------------------------------------------------------------------------------

<a name="part-4"></a>
## Tester son conteneur:



{% highlight bash %}$ sacctmgr modify  account bioinfo set GrpTRES=cpu=-1{% endhighlight %}
  
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
                  
 
