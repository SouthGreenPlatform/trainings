---
layout: page
title: " installation de Module environment"
permalink: /hpc/installationmodule/
tags: [ linux, HPC, cluster, OS ]
description: Installation de la page Module Environment 
---

| Description | Installation des Module Environment |
| :------------- | :------------- | :------------- | :------------- |
| Related-course materials | [HPC Administration Module1](https://southgreenplatform.github.io/trainings/Module1/) |
| Authors | Ndomassi TANDO (ndomassi.tando@ird.fr)  |
| Creation Date |23/09/2019 |
| Last Modified Date | 23/09/2019 |


-----------------------


### Sommaire

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Definition](#part-1)
* [Installation](#part-2)
* [Configuration](#part-3)
* [Créer son propre dépôt modulefile](#part-4)
* [Créer un modulefile](#part-5)
* [Commandes module](#part-6)
* [Links](#links)
* [License](#license)


-----------------------
<a name="part-1"></a>
## Definition

URL: https://github.com/cea-hpc/modules

 Les Modules Environment permettent une modification dynamique  de l'environnement utilisateur http://modules.sourceforge.net/
 
 L'utilisateur  peut changer facilement entre différentes versions d'un programme.


-------------------------------------------------------------------------------------

<a name="part-2"></a>
## Installation:

{% highlight bash %}$ yum install tcl tcl-devel -y
$ wget https://github.com/cea-hpc/modules/releases/download/v4.2.1/modules-4.2.1.tar.gz
$ tar xvfz module-4.2.1.tar.gz
$ cd module-4.2.1
$ ./configure --prefix=/usr/local/modules-4.2.1
$ make
$ make install{% endhighlight %}



----------------------------------------------------------------------------------------------

<a name="part-3"></a>
## Configuration:

### Activer les modules au démarrage:

Il faut créer les scripts de démarrage  dans  `/etc/profile.d`.

Faire un lien symbolique entre les fichiers répertoire `init`créé à l'installation de Module environment dans le répertoire `/etc/profile.d` avec les commades suivantes: 


 {% highlight bash %}$ ln -s /usr/local/modules-4.2.1/init/profile.sh /etc/profile.d/modules.sh
 $ ln -s /usr/local/modules-4.2.1/init/profile.csh /etc/profile.d/modules.csh{% endhighlight %}

### Définir le chemin des modules à activer par défaut: 

Editer le fichier de configuration  `/usr/local/modules-4.2.1/modulerc`.

Ajouter ici tous les répertoires modulefiles que l'on veut activer par défaut au démarrage.

Ajouter une ligne mentionnant chaque répertoire de modulefile précédé par la commande `module use`

{% highlight bash %}$ module use /usr/local/modules-4.2.1/modulefiles
$ module use /path/to/other/modulefiles{% endhighlight %}

### Definir les module à charger par défaut:

Editer  `/usr/local/modules-4.2.1/modulerc`.

Ajouter une ligne mentionnant chaque module à charger précédé de la commande `module load` :

{% highlight bash %}$ module load foo
$ module load bar{% endhighlight %}

---------------------------------------------------------------------------------------------------

<a name="part-4"></a>
## Définir un dépôt personnel de module file:

Chaque utilisateur peut  créer son propre dépôt de modulefiles personnel

### Créer son propre dépôt:

{% highlight bash %}mkdir /home/path_to_my_modulefiles{% endhighlight %}

### Ajoout le chemin du dépôt dans votre shell

Dans votre `/home/user/.bashrc`, ajouter la ligne suivante:

 {% highlight bash %}module use –append /home/path_to_my_modulefiles{% endhighlight %}
 
### Définir le module à lancher au démarrage du shell:
 
 Dans votre `/home/user/.bash_profile`, ajouter la ligne suivante:
 
  {% highlight bash %}module load program{% endhighlight %}
  
---------------------------------------------------------------------------------------------------

<a name="part-5"></a>
## Créer un modulefile:

Les modulefiles vont être séparéés en 2 catégories:

system: Pour les logigiels systèmes (ex: python, java)

bioinfo: pour les logiciels bioinformatiques
{% highlight bash %}$ mkdir /usr/local/modules-4.2.1/modulefiles/system
$ mkdir /usr/local/modules-4.2.1/modulefiles/bioinfo {% endhighlight %}
 
 Pour chaque logiciel , créer un répertoire avec le nom du logiciel et un fichier modulefile avec le numéro de version.
 
 Par exemple, le logiciel bioinformatique ncbi-blast v 2.4.0+ aura le fichier de modulefile 2.4.0+ avec le chemin suivant:
 
 {% highlight bash %}/usr/local/modules-4.2.1/modulefiles/bioinfo/ncbi-blast/2.4.0+{% endhighlight %}

### Modèle de Modulefile 

Les modulefiles sont écrits en langage tcl.

Exemple le logiciel  `program 1.0`

{% highlight bash %} #%Module1.0#####################################################################
       ##
       ##

       ## Define the  "module help …" command below:
       proc ModulesHelp { } {
       global name version prefix man_path
       puts stderr "\t[module-info name] - loads the compiler env variables"
       puts stderr "\tThe following env variables are set:"
       puts stderr "\t\t\$COMPILER, \$COMPILER_VER, \$CC, \$FC"
       puts stderr "\tThe following env variables are modified:"
       puts stderr "\t\t\$PATH, \$MANPATH, \$LD_LIBRARY_PATH"
       }
       ## Define the "module whatis …" comman with the line below
      module-whatis   "loads the [module-info name] environment"
       
        ## if some modules interfers with this one you can use conflict
       conflict bioinfo/program/2.0

        ## Set the version nuber of your program
         set     version      "1.0"

        ## Set the install path of your program
         set     topdir          /usr/local/bioinfo/program-1.0

        ## Define the PATH and other variable
        prepend-path   PATH             $topdir/bin
        prepend-path   LD_LIBRARY_PATH $topdir/lib
        setenv  CC     gcc    # setenv attributes only  one value  to the variable{% endhighlight %}
        
  ### Example of modulefile:
  
    {% highlight bash %} #%Module1.0#####################################################################
    ##
    ## modules modulefile
    ##
    ## modulefiles/modules.  Generated from modules.in by configure.
    ##
    proc ModulesHelp { } {
    global version modroot

    puts stderr "blast/2.4.0+ version 2.4.0 of blast"
     }

     module-whatis   "Loads version 2.4.0 of blast. BLAST finds regions of similarity between biological sequences"
     conflict bioinfo/blast/2.3.0+


    # for Tcl script use only
    set     version         2.4.0+
    set     topdir          /usr/local/ncbi-blast-2.4.0+





    prepend-path    PATH            $topdir/bin
    prepend-path    MANPATH         $topdir/man{% endhighlight %}

    
-----------------------------------------------------------------------------------------------------

<a name="part-6"></a>
## Commandes module:
Voir les modules disponibles :

 {% highlight bash %}$ module avail{% endhighlight %}
 
Obtenir des infos sur un logiciel::

{% highlight bash %}$ module whatis + module name{% endhighlight %}

Charger un module :

{% highlight bash %}$ module load + modulename{% endhighlight %}

Lister les modules chargés :

{% highlight bash %}$ module list{% endhighlight %}

Décharger un module :

{% highlight bash %}$ module unload + modulename{% endhighlight %}

Décharger tous les  modules :

{% highlight bash %}$ module purge{% endhighlight %}
    
-----------------------

### Links
<a name="links"></a>

* Related courses : [HPC Trainings](https://southgreenplatform.github.io/trainings/HPC/)


-----------------------

### License
<a name="license"></a>

<div>
The resource material is licensed under the Creative Commons Attribution 4.0 International License (<a href="http://creativecommons.org/licenses/by-nc-sa/4.0/">here</a>).
<center><img width="25%" class="img-responsive" src="http://creativecommons.org.nz/wp-content/uploads/2012/05/by-nc-sa1.png"/>
</center>
</div>
                  
 
