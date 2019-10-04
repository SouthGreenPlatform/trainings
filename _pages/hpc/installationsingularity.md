---
layout: page
title: "Installation de Singularity"
permalink: /hpc/installationsingularity/
tags: [ linux, HPC, cluster, OS ]
description: Page d'installation de Singularity  
---

| Description | Installation de Singularity sur Centos7 |
| :------------- | :------------- | :------------- | :------------- |
| Support de cours liés| [HPC Administration Module2](https://southgreenplatform.github.io/trainings/Module2/) |
| Auteur | Ndomassi TANDO (ndomassi.tando@ird.fr)  |
| Date de création |24/09/2019 |
| Date de modification | 24/09/2019 |


-----------------------


### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Installer les  dépendances](#part-1)
* [Installer le langage de programmation Go](#part-2)
* [Télécharger et installer Singularity 3.X depuis le repo](#part-3)
* [Télécharger et installer Singularity 2.6](#part-4)
* [Modifier les Bind path dans Singularity](#part-5)
* [Links](#links)
* [License](#license)


-----------------------
<a name="part-1"></a>
## Installer les  dépendances

 {% highlight bash %}$ sudo yum update -y && \
      sudo yum groupinstall -y 'Development Tools' && \
      sudo yum install -y \
      openssl-devel \
      libuuid-devel \
      libseccomp-devel \
      wget \
      squashfs-tools \
      git{% endhighlight %}

-------------------------------------------------------------------------------------

<a name="part-2"></a>
## Installer le langage de programmation Go:

Aller  sur  [Download Page](https://golang.org/dl/) et choisir l'archive go.1.12.5.linux-amd64.tar.gz

Lancer les commandes suivantes:

  {% highlight bash %}# Télécharger l'archive
    wget https://dl.google.com/go/go1.12.5.linux-amd64.tar.gz
    # Extraire l'archive dans /usr/local
    sudo tar -C /usr/local -xzvf go1.12.5.linux-amd64.tar.gz{% endhighlight %}

Mettre en place votre  environnement pour Go avec les commandes suivantes:

  {% highlight bash %}# Créer la variable GOPATH  dans /etc/profile
    echo 'export GOPATH=${HOME}/go' >> /etc/profile
    # Posttionner  le PATH avec Go
    echo 'export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin' >> /etc/profile
    # Resource /etc/profile pour prendre e compte les modifs
     source /etc/profile {% endhighlight %}

Pour Singularity > v3.0.0, on a aussi besoin d'installer `dep` pour la résolution de dépendances

  {% highlight bash %}go get -u github.com/golang/dep/{% endhighlight %}



----------------------------------------------------------------------------------------------

<a name="part-3"></a>
## Télécharger et installer singularity depuis le repo:

Télécharger le code source de  singularity avec:

   {% highlight bash %}go get -d github.com/sylabs/singularity{% endhighlight %}

On obtient  un warning mais  ça télécharge quand même  le code source de Singularity dans le répertoire approprié dans `$GOPATH`
     
   {% highlight bash %}# aller dans le répertoire singularity
     cd ~/go/src/github.com/sylabs/singularity/ 
     # lancer la commande mconfig ( avec --prefix=path pour fixer le répertoire d'installation)
     ./mconfig --prefix=/usr/local/singularity
     # Compiler dans le répertoire de build 
     make -C ./builddir
     # Installer les binaires dans /usr/local/singularity/bin en tant que  superuser
     sudo make -C ./builddir install{% endhighlight %} 
 
Taper les commandes suivantes dans /etc/profile  pour permettre la  completion dans Singularity:
 
   {% highlight bash %}. /usr/local/etc/bash_completion.d/singularity
    # resourcer /etc/profile
    source /etc/profile{% endhighlight %}


----------------------------------------------------------------------------------------------

<a name="part-4"></a>
## Télécharger et installer singularity 2.6:

 {% highlight bash %}$ sudo yum update && \

$ sudo yum groupinstall 'Development Tools' && \

$ sudo yum install libarchive-devel squashfs-tools

$ git clone https://github.com/sylabs/singularity.git

$ cd singularity

$ git fetch --all

$ git checkout 2.6.0

$ ./autogen.sh

$ ./configure --prefix=/usr/local/singularity-2.6

$ make

$ sudo make install{% endhighlight %}



---------------------------------------------------------------------------------------------------

<a name="part-5></a>
## Modifier les  Bind path dans Singularity

Les bind path sont les partitions de l'hôte qui sont directement montées dans un conteneur lorsqu'on le lance.

Modifier le fichier `/usr/local/singularity/etc/singularity/singularity.conf`

Dans la rubrique BIND PATH

Rajouter les lignes:

Par exemple:

{% highlight bash %}bind path = /opt
bind path = /scratch
bind path = /data{% endhighlight %}


Il faut également activer l'overlay avec la ligne:

{% highlight bash %}enable overlay = yes{% endhighlight %}

  
---------------------------------------------------------------------------------------------------

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
                  
 
