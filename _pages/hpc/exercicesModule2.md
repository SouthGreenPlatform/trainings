---
layout: page
title: "Exercices Admin HPC Module2"
permalink: /hpc/exercicesModule2/
tags: [ linux, HPC, cluster, module load ]
description: HPC Practice page
---

| Description | Exercices pour le Module2 du HPC Admin |
| :------------- | :------------- | :------------- | :------------- |
|Cours liés | [Module2 HPC Admin](https://southgreenplatform.github.io/trainings/Module2/) |
| Auteur | Ndomassi TANDO (ndomassi.tando@ird.fr)  |
| Date de création | 27/09/2019 |
| Date de modification | 27/09/2019 |


-----------------------

### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Exercice 1: Installation et configuration de Singularity](#exercice-1)
* [Exercice 2: Créer des conteneurs singularity](#exercice-2)
* [Exercice 3: Création de modulefiles à base de conteneurs singularity](#exercice-3)
* [Exercice 4: Utilisation de Slurm](#exercice-4)
* [Links](#links)
* [License](#license)


-----------------------

<a name="exercice-1"></a>
### Exercice 1: Installation et configuration de Singularity

Installer singularity sur le cluster et sur les VMs

-----------------------


<a name=">Exercice-2"></a>
### Exercice 2: Créer des conteneurs singularity

Créer les conteneurs singularity des logiciels suivants:


-  atropos 1.1.14
-  flash 1.2.11
-  cutadapt 1.2.1
-  spades 3.13.0
-  uclust 1.2.22
-  pear 0.9.11
-  hisat2 2.0.0
-  bedtools 2.26.0



-----------------------


<a name="exercice-3"></a>
### Exercice 3: Création de modulefiles à base de conteneurs singularity

Créer les modulefiles faisant appel aux conteneurs singularity suivants:

-  atropos 1.1.14
-  flash 1.2.11
-  cutadapt 1.2.1
-  spades 3.13.0
-  uclust 1.2.22
-  pear 0.9.11
-  hisat2 2.0.0
-  bedtools 2.26.0

-----------------------


<a name="exercice-4"></a>
### Exercice 4: Utilisation de Slurm

Créer une partition short dans slurm avec une time limit de 1 jour.

Créer un script se lançant sur la partition short avec 2 coeurs qui copie le répertoire tp-cluster dans le /tmp de node0

Puis lancer la commande:

{% highlight bash %}$ blastn -db All-EST-coffea.fasta -query sequence-NMT.fasta -out blastn.out{% endhighlight %} 

et récupérer le fichier blastn.out dans son /home

-----------------------

### Links
<a name="links"></a>

* Cours liés : [Module2 HPC Admin](https://southgreenplatform.github.io/trainings/Module2)


-----------------------

### License
<a name="license"></a>

<div>
The resource material is licensed under the Creative Commons Attribution 4.0 International License (<a href="http://creativecommons.org/licenses/by-nc-sa/4.0/">here</a>).
<center><img width="25%" class="img-responsive" src="http://creativecommons.org.nz/wp-content/uploads/2012/05/by-nc-sa1.png"/>
</center>
</div>
                  
 
