---
layout: page
title: "Utilisation de slurm"
permalink: /hpc/utilisationdeslurm.md/
tags: [ linux, HPC, cluster, OS ]
description:  Page d'utilisation de Slurm
---

| Description | Savoir utiliser Slurm|
| :------------- | :------------- | :------------- | :------------- |
| Cours lié| [HPC Administration Module2](https://southgreenplatform.github.io/trainings/Module2/) |
| Auteur | Ndomassi TANDO (ndomassi.tando@ird.fr)  |
| Date de création |27/09/2019 |
| Date de modification | 27/09/2019 |


-----------------------


### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Objectif](#part-1)
* [Lancer des jobs sous Slurm](#part-2)
* [Superviser des ressources sous Slurm](#part-3)
* [Links](#links)
* [License](#license)


-----------------------
<a name="part-1"></a>
## Objectif

Pouvoir lancer des jobs de différents types sous Slurm.

Monitorer les ressources sous Slurm

-------------------------------------------------------------------------------------

<a name="part-2"></a>
## Lancer des jobs sous Slurm:
       
### Lancer des commandes depuis la machine maître s'exécutant les ressources de calcul

La commande suivante alloue des ressources de calcul (noeuds, cpus, mémoire) et lance la commande immédiatement sur chaque ressource allouée

    {% highlight bash %}$ srun + commande{% endhighlight %} 
    
    Exemple:
   
    {% highlight bash %}$ srun hostname{% endhighlight %} 
    
    Permet d'obtenir le nom de la ressource de calcul utilisé

### Réserver des ressources de calcul pour lancer des commandes avec Slurm

On utilise la commande:

{% highlight bash %}$ salloc{% endhighlight %}

Cette commande permet de réserver une ou pusieurs ressources de calcul tout en continuant à travailler sur la machine maître.

Les commandes à lancer sur le ressources de calcul peuvent être lancées plus tard avec la commande `srun + arguments`.

Il est important quand on utilise cette commande préciser un temps de réservation avec l'option --time 

Exemple: On réserve 2 noeuds de calcul( options -N) à la fois pour 5 minutes et on lance plus tard la commande hostname sur ces 2 noeuds avec srun

{% highlight bash %}$ salloc --time=05:00 -N 2
$ srun hostname{% endhighlight %}

Nous obtiendrons une réponse du type:

{% highlight bash %}$[tando@master0 ~]$ srun hostname
node21.alineos.net
node14.alineos.net
 {% endhighlight %}

### Lancer des commandes après connexion à un noeud de manière interactive:

Pour se connecter de manière intéractive  pendant un temps X à un noeud, on utilise la commande:

{% highlight bash %}$ srun --time=X:00 --pty bash -i{% endhighlight %}

Une fois connecté sur le noeud, on peut lancer les commandes désirées sans le préfixe `srun`qui s'exécuteront sur le noeud

### Les principales options disponibles pour lancer une analyse sous Slurm:

Toutes les commandes `salloc`, `srun` et `sbatch` peuvent être utilisées avec les options suivantes:

| actions | Option 
| :------------- | :------------- | :------------- | :------------- |
|Préciser une partition |	-p [queue]| 
| Nombre de noeuds à utiliser| -N [min[-max]]|
| Nombre de cpus à utiliser | -n [count]| 
| limite de temps|-t [min] ou -t [days-hh:mm:ss] |
| préciser un fichier de sortie| -o [file_name] |
| préciser un fichier d'erreur| -e [file_name] |
| Combiner les fichiers STDOUT er STDERR files| utiliser -o sans -e|
| Copier l'environnement|	--export=[ALL | NONE | variables]|
|Type de notifications à envoyer|	--mail-type=[events]|
|Envoi d'un email|--mail-user=[address]|
|Nom du job	|--job-name=[name]|
| Relancer un job si problème|--requeue|
| Preciser le répertoire de travail|--workdir=[dir_name] |
| Taille de la mémoire à réserver|--mem=[mem][M|G|T] ou-mem-per-cpu=[mem][M|G|T]|
| Préciser un account|	--account=[account]|
|Nombre de tâches par noeud|--tasks-per-node=[count]|
|Nombre de cpus par tâche| --cpus-per-task=[count]|
|Dépendance à un autre noeud|	--depend=[state:job_id]|
| Choisir des hôtes de préférence| --nodelist=[nodes] ET/OU --exclude=[nodes]|
| Job arrays|	--array=[array_spec]|
|Heure de démarrage|--begin=YYYY-MM-DD[THH:MM[:SS]]|

### Lancer des jobs via un script

Lancer est job est l'action de lancer une analyse dont le déroulement est décrite à l'intérieur d'un script.

Slurm permet d'utiliser des scripts de type bash, perl ou python.

Slurm alloue les ressources demandées et lance les analyses sur celles-ci en arrière plan.

Un script créé doit cependant contenir une entête afin que celui-ci soit interprété par Slurm.

Pour que chaque option du script soit interprété par Slurm, il faut les faire précéder par le mot clé `#BATCH`

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

{% highlight bash %}$ sbatch script.sh{% endhighlight %}

Avec `script.sh` le nom du script à utiliser

### Supprimer un job sous Slurm 

{% highlight bash %}$ scancel <job_id>{% endhighlight %}

Avec `<job_id>`: le numéro du job  

----------------------------------------------------------------------------------------------

<a name="part-3"></a>
## Superviser des ressources sous Slurm:


### Avoir des informations sur les jobs :

On utilise la commande

{% highlight bash %}$ squeue {% endhighlight %}

Pour que les informations sur les jobs se rafraichissent toutes les 5 secondes

{% highlight bash %}$ squeue -i 5 {% endhighlight %}

Pour avoir des infos sur un job en particulier

{% highlight bash %}$ scontrol show job <job_id>{% endhighlight %}
  
Avec `<job_id>`: le numéro du job  

Pour avoir des infos sur les jobs d'un utilisateur en particulier

{% highlight bash %}$ squeue -u <user> {% endhighlight %}

Avec `<user>`: le login de l'utilisateur

Pour avoir des informations précises sur tous les jobs:

{% highlight bash %}$ sacct --format=JobID,elapsed,ncpus,ntasks,state,node{% endhighlight %}

Pour avoir des informations sur les ressources utilisées par un job terminé:

{% highlight bash %}$ seff <job_id>  {% endhighlight %}

Avec `<job_id>`: le numéro du job 

### Avoir des infos sur le partitions (files d'attentes)

Taper la commande:

{% highlight bash %}$ sinfo {% endhighlight %}

Cette commande donne des informations sur les partitions et les noeuds qui leur sont rattachés.

Pour des informations plus précises:

{% highlight bash %}$ scontrol show partitions {% endhighlight %}

De manière générale `scontrol show` peut être utiliser avec nodes, user, account etc...

### Avoir des infos sur le noeuds de calcul

Taper le commande:

{% highlight bash %}$ sinfo -N -l {% endhighlight %}

Pour obtenir des informations encore plus précises:

{% highlight bash %}$ scontrol show nodes {% endhighlight %}

  
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
                  
 
