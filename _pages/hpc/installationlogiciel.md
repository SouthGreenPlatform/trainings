---
layout: page
title: "Installation de logiciels"
permalink: /hpc/installationlogiciel/
tags: [ linux, HPC, cluster, OS ]
description:  Page d'installation de logiciels
---

| Description | Types d'installation de logiciels sous Linux (Centos7)|
| :------------- | :------------- | :------------- | :------------- |
| Cours lié| [HPC Administration Module1](https://southgreenplatform.github.io/trainings/Module1/) |
| Auteur | Ndomassi TANDO (ndomassi.tando@ird.fr)  |
| Date de création |23/09/2019 |
| Date de modification | 23/09/2019 |


-----------------------


### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Les paquets RPM](#part-1)
* [Installation à  partir des sources](#part-2)
* [Installation d'un package python](#part-3)
* [Installation via  Conda](#part-4)
* [Installation de modules Perl](#part-5)
* [Logiciels système essentiels](#part-6)
* [Links](#links)
* [License](#license)


-----------------------
<a name="part-1"></a>
## Les paquets RPM

Les Rpms sont utilisés pour les  distributions de type Centos, Redhat ou fedora.

On peut les installer avec la commande:

{% highlight bash %}$ rpm -ivh rpm_package.rpm{% endhighlight %}

Pour utiliser la commande du dessus, les dépendances du paquet doivent être installées en premier.

Pour éviter d'avoir à lancer cette commande pour toutes les dépendances et si l'on a les rpms des dépendances, on peut directement taper la commande:

{% highlight bash %}$ yum install rpm_package.rpm{% endhighlight %}

-------------------------------------------------------------------------------------

<a name="part-2"></a>
## Installation à  partir des sources:


Les sources permettent de compiler le logiciel en s'accordant à l'architecture du serveur.

Habituellement, les sources sont compressées dans un tarball.

On doit d'abord décompresser le tarball avec la commande:

{% highlight bash %}$ tar xvfz package.tar.gz{% endhighlight %}

Dans le répertoire des sources se trouvent généralement un README.md ou un INSTALL.md qui explique comment utiliser le logiciel.

Utiliser les lignes suivantes pour compiler le package:

{% highlight bash %}$  cd package/
  $ ./configure --prefix=/PATH_WHERE_TO install it
 $ make                   # do the compilation
 $ make test             # check that the compilation is OK with a set of test files
 $  make install           # to install the binaries to  the precised path
{% endhighlight %}

----------------------------------------------------------------------------------------------

<a name="part-3"></a>
## Installation d'un package python:

Utiliser la commande :

 {% highlight bash %}$ pip install python_package {% endhighlight %}
 
 Depuis les sources, après  avoir décompresser le tarball:

 {% highlight bash %}$ python setup.py install{% endhighlight %}
 
 Si l'on travaille avec plusieurs versions de python ou sur un cluster, on peut utiliser les environnnements virtuels pour installer un paquet python.
 
Les environnements virtuels encapsulent un environnement python pour caque packages python pour éviter les interférences avec les autres:

Créer un répertoire pour le paquet python ans `/usr/local`
 
 {% highlight bash %}$ mkdir /usr/local/python_package-version{% endhighlight %}
 
 Créer l'environnement virtuel:
 
  {% highlight bash %}$ virtualenv venv{% endhighlight %}
  
  Activer l' environnement virtuel pour installer les paquets python:
  
    {% highlight bash %}$     source venv/bin/activate
    pip install package or python setup.py install{% endhighlight %}
    
Désactiver l'environnement:    

  {% highlight bash %}$ deactivate{% endhighlight %}
  
  
---------------------------------------------------------------------------------------------------

<a name="part-4"></a>
## Installation via  Conda:

URL: https://conda.io/docs/

   
Installer conda avec l'installeur:

{% highlight bash %}$ bash Miniconda3-latest-Linux-x86_64.sh{% endhighlight %}


Une fois conda installé,on peut créer un nouvel environnement et installer un package avec la commande:

{% highlight bash %}$ conda create -n software software{% endhighlight %}


Pour activer un environnement:

{% highlight bash %}$ source activate myenv{% endhighlight %}


Pour désactiver un environnement:
          
{% highlight bash %}$ source deactivate{% endhighlight %}
  
---------------------------------------------------------------------------------------------------

<a name="part-5"></a>
## Installation de modules Perl:

Utiliser les commandes suivantes:

{% highlight bash %}$ perl –MCPAN –e shell 	
                 > install <Module>[::<Submodule>]{% endhighlight %}

Ou depuis les sources:
   
{% highlight bash %}$ perl Makefile.PL PREFIX= <INSTALL_PERL_PATH>
$ make
$ make test
$ make install{% endhighlight %}         
    
-----------------------------------------------------------------------------------------------------

<a name="part-6"></a>
## Logiciels système essentiels:

### Python:

Python est un langage de programmation
      
URL : https://www.python.org/

### Installation :

 {% highlight bash %}$ yum install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel 
      libpcap-devel xz-devel
 $ wget  https://www.python.org/ftp/python/3.7.1/Python-3.7.1.tar.xz
 $ tar xf Python-3.7.1.tar.xz
 $ cd Python-3.7.1
 $ ./configure --prefix=/usr/local/python-3.7.1 --enable-shared LDFLAGS="-Wl,-rpath /usr/local/python-3.7.1/lib"
 $ make
 $ make altinstall{% endhighlight %} 

Ajouter `/usr/local/python-3.7.1` au path :

{% highlight bash %}$ echo  'export PATH=$PATH:/usr/local/python-3.7.1/bin' >>/etc/profile
$ echo  'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/python-3.7.1/lib' >>/etc/profile
$ echo  'export PYTHONPATH=/usr/local/python-3.7.1/bin' >>/etc/profile
$ source /etc/profile{% endhighlight %} 

### Usage :

{% highlight bash %}$ python3 + arguments{% endhighlight %}     

### Perl:


Perl 5 est un langage de programmation 

       
URL : https://www.perl.org/about.html

#### Installation :

      
{% highlight bash %}$ wget  https://www.cpan.org/src/5.0/perl-5.28.1.tar.gz
$ tar xvfz perl-5.28.1.tar.gz
$ cd perl-5.28.1
$ ./configure -des -Dprefix=/usr/local/perl-5.28.1
$ make test
$ make install{% endhighlight %} 
      

Ajouter `/usr/local/perl-5.28.1` au path :

{% highlight bash %}$ echo  'export PATH=$PATH:/usr/local/perl-5.28.1/bin' >>/etc/profile
$ echo  'export PERL5LIB=$PERL5LIB:/usr/local/perl-5.28.1/lib/perl5' >>/etc/profile
$ source /etc/profile{% endhighlight %} 

#### Usage :
          
         perl + scripts

### Perlbrew  (optional):


perlbrew est un outil de gestion d'installation perl admin-free perl installation .

L'outil permet de gérer plusieurs installations de perl.

       
URL : https://perlbrew.pl/

#### Installation :

      
{% highlight bash %}$ export PERLBREW_ROOT=/usr/local/perlbrew-0.84
      \wget -O - https://install.perlbrew.pl | bash{% endhighlight %} 
     
      

Ajouter `/usr/local/perl-5.28.1` au path :

{% highlight bash %}$ echo  'export PATH=$PATH:/usr/local/perlbrew-0.84' >>/etc/profile{% endhighlight %} 
      
       source /etc/profile

#### Usage :
          
{% highlight bash %}# Initialize
           $ perlbrew init
 
         # See what is available
           $ perlbrew available
 
        #  Install some Perls
           $ perlbrew install 5.18.2
           $ perlbrew install perl-5.8.1
           $ perlbrew install perl-5.19.9
 
        # See what were installed
           $ perlbrew list
 
        # Swith to an installation and set it as default
           $ perlbrew switch perl-5.18.2
 
        # Temporarily use another version only in current shell.
           $ perlbrew use perl-5.8.1
           $ perl -v
 
        # Or turn it off completely. Useful when you messed up too deep.
        # Or want to go back to the system Perl.
           $ perlbrew off
 
        # Use 'switch' command to turn it back on.
           $ perlbrew switch perl-5.12.2
 
        # Exec something with all perlbrew-ed perls
           $ perlbrew exec -- perl -E 'say $]'{% endhighlight %} 
       

### java:

Java est un langage de programmation orienté web.

       
URL : https://www.java.com/fr/download/linux_manual.jsp

#### Installation :

Télécharger le tarball depuis l'interface (jre ou  jdk)
      
{% highlight bash %}$ cd /usr/java
$ tar zxvf jre-8u191-linux-x64.tar.gz{% endhighlight %} 
   

Ajouter `/usr/java/jre-8u191/` au path :

{% highlight bash %}$ echo  'export PATH=$PATH:/usr/java/jre-8u191/bin' >>/etc/profile
$ echo  'export PATH=$PATH:/usr/java/jre-8u191/lib' >>/etc/profile
$ source /etc/profile{% endhighlight %} 

#### Usage :
          
{% highlight bash %}$ java -jar + file.jar{% endhighlight %} 


### gcc:

Gcc est un compilateur pour les systèmes d'exploitation GNU


URL : http://gcc.gnu.org/install/

#### Installation :

            
{% highlight bash %}$ wget  ftp://ftp.lip6.fr/pub/gcc/releases/gcc-7.4.0/gcc-7.4.0.tar.gz
 $ tar zxvf gcc-7.4.0.tar.gz
 $ cd gcc-7.4.0
 $ mkdir build
 $ cd build
 $ ../configure --prefix=/usr/local/gcc-7.4.0
 $ make --disable-werror
 $ make install{% endhighlight %} 
   

Ajouter `/usr/local/gcc-7.4.0` au path :

{% highlight bash %}$ echo  'export PATH=$PATH/usr/local/gcc-7.4.0/bin' >>/etc/profile
$ echo  'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/gcc-7.4.0/lib' >>/etc/profile
$ source /etc/profile{% endhighlight %} 


### Bioperl:

#### Installation

{% highlight bash %}$ cpan
      cpan>d /bioperl/{% endhighlight %} 


Choisir la version la plus  récente:

{% highlight bash %} cpan>install C/CJ/CJFIELDS/BioPerl-1.007001.tar.gz{% endhighlight %} 


    
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
                  
 
