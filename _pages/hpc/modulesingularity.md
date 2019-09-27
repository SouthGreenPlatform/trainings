---
layout: page
title: "Utiliser des modules Environnement avec des conteneurs Singularity"
permalink: /hpc/modulesingularity/
tags: [ linux, HPC, cluster, OS ]
description:  Page d' utilisation des modules Environnement avec des conteneurs Singularity
---

| Description | Utiliser des modules Environnement avec des conteneurs Singularity|
| :------------- | :------------- | :------------- | :------------- |
| Cours lié| [HPC Administration Module2](https://southgreenplatform.github.io/trainings/Module2/) |
| Auteur | Ndomassi TANDO (ndomassi.tando@ird.fr)  |
| Date de création |27/09/2019 |
| Date de modification | 27/09/2019 |


-----------------------


### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Objectifs](#part-1)
* [Créer son modulefile](#part-2)
* [Charger le module environment pour lancer des commandes depuis un Conteneur Singularity ](#part-3)
* [Links](#links)
* [License](#license)


-----------------------
<a name="part-1"></a>
## Objectifs
La création d'un modulefile va nous permettre de créer des alias de commandes pour lancer des `singularity run` ou des `singularity exec`.

Ainsi, les utilisateurs ne se rendront pas compte qu'ils utilisent un conteneur Singularity et cela facilitera l'installation des logiciels pour les administrateurs systèmes. 


-------------------------------------------------------------------------------------

<a name="part-2"></a>
## Créer son modulefile:
       
Comme vu au Module1: https://southgreenplatform.github.io/trainings/hpc/installationmodule/#part-5

Nous pouvons créer nos propres environnements logiciels en créant des modulefiles.

Pour utiliser les conteneurs singularity dans ces modulefiles, nous allons créer un modulefile classique et cére des alias de commandes singularity avec le mot clé set-alias

Par exemple si l'on veut utiliser le conteneur singularity `bwa-0.7.17.simg` créé précédemment, on va créer un modulefile de ce type:

{% highlight bash %}#%Module1.0#####################################################################
##
## modules modulefile
##
## modulefiles/modules.  Generated from modules.in by configure.
##
proc ModulesHelp { } {
        global version modroot
        puts stderr "module [module-info name]"
}
module-whatis   "load the module [module-info name]
BWA is a program for aligning sequencing reads against a large reference genome (e.g. human genome)
Use the bwa-0.7.17.simg singularity container"
conflict bwa
# On charge le module singularity    
module load system/singularity/2.4
# for Tcl script use only
set     version         0.7.17
# on préciser comme répertoire de travail l'endroit où sont stockés les conteneurs
set     topdir          /usr/local/singularity/conteneurs/
set-alias bwa "singularity run $topdir/bwa-0.7.17.simg "{% endhighlight %} 





----------------------------------------------------------------------------------------------

<a name="part-3"></a>
## Charger le module environment pour lancer des commandes depuis un Conteneur Singularity :

Une fois le modulefile créer avec l'alias de commande, il suffit de le charger avec la commande

{% highlight bash %}$ module load logiciel/version{% endhighlight %} 

Puis de lancer l'alias de la commande.

Par exemple pour lancer un bwa, on charge l'envrionnement

{% highlight bash %}$ module load bwa/0.7.17{% endhighlight %} 

Puis on lance le bwa:

{% highlight bash %}$ bwa + argument{% endhighlight %} 

La commande lancée est en fait:

{% highlight bash %}$ singularity run /usr/local/singularity/conteneurs/bwa-0.7.17.simg + argument{% endhighlight %} 
  
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
                  
 
