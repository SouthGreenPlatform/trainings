---
layout: page
title: "Softwares installation"
permalink: /hpc/softwareinstallation/
tags: [ linux, HPC, cluster, OS ]
description: Sotwares installation  page
---

| Description | Ways to install softwares under Linux (Centos7)|
| :------------- | :------------- | :------------- | :------------- |
| Related-course materials | [HPC Administration Module1](https://southgreenplatform.github.io/trainings/Module1/) |
| Authors | Ndomassi TANDO (ndomassi.tando@ird.fr)  |
| Creation Date |23/09/2019 |
| Last Modified Date | 23/09/2019 |


-----------------------


### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [RPM packages](#part-1)
* [Installation from sources](#part-2)
* [Installation of a python package](#part-3)
* [Installation via  Conda](#part-4)
* [Perl Modules installation](#part-5)
* [Essential system softwares](#part-6)
* [Links](#links)
* [License](#license)


-----------------------
<a name="part-1"></a>
## RPM packages

Rpm are used for distribution such as Centos, Redhat or fedora.

You can install them with  several commands:

{% highlight bash %}$ rpm -ivh rpm_package.rpm{% endhighlight %}

To use the command above, the dependencies of the package to install have to be installed first.

To avoid that and if you have of the rpms of the deendencies , just use:

{% highlight bash %}$ yum install rpm_package.rpm{% endhighlight %}

-------------------------------------------------------------------------------------

<a name="part-2"></a>
## Installation from sources:

A lot of linux softwares have their sources available.

It allows to compile the software to match with the server architecture.

Usually, the sources are compressed into a tarball.

You  first have to decompress the tarball with the command:

{% highlight bash %}$ tar xvfz package.tar.gz{% endhighlight %}

Into the source package, you should find a README.md or INSTALL.md file that explain to you how to install the software.

Use the following lines to  compile the package:

{% highlight bash %}$  cd package/
  $ ./configure --prefix=/PATH_WHERE_TO install it
 $ make                   # do the compilation
 $ make test             # check that the compilation is OK with a set of test files
 $  make install           # to install the binaries to  the precised path
{% endhighlight %}

----------------------------------------------------------------------------------------------

<a name="part-3"></a>
## Installation of a python package:

We can use the command :


 {% highlight bash %}$ pip install python_package {% endhighlight %}
 
 From source, after decompressing the tarball:

 {% highlight bash %}$ python setup.py install{% endhighlight %}
 
 If you work with several versions of python or a cluster, you should use a virtual environment to install your python package.
 
The virtual environnement encapsulates a python environment for each python packages avoiding interferences with the other:

Create a folder for your python package in `/usr/local`
 
 {% highlight bash %}$ mkdir /usr/local/python_package-version{% endhighlight %}
 
 Create the virtual environment:
 
  {% highlight bash %}$ virtualenv venv{% endhighlight %}
  
  Activate the virtual environment to  install the python package:
  
    {% highlight bash %}$     source venv/bin/activate
    pip install package or python setup.py install{% endhighlight %}
    
Deactivate the environment:    

  {% highlight bash %}$ deactivate{% endhighlight %}
  
  
---------------------------------------------------------------------------------------------------

<a name="part-4"></a>
## Installation via  Conda:

URL: https://conda.io/docs/

Conda quickly installs, runs and updates packages and their dependencies. Conda easily creates, saves, loads and switches between environments on your local computer. It was created for Python programs, but it can package and distribute software for any language.
   
Install conda running the installer:

{% highlight bash %}$ bash Miniconda3-latest-Linux-x86_64.sh{% endhighlight %}


Once conda installed, you can create a new environment and install a package with the command:

{% highlight bash %}$ conda create -n software software{% endhighlight %}


To activate a environment:

{% highlight bash %}$ source activate myenv{% endhighlight %}


To deactivate a environment:
          
{% highlight bash %}$ source deactivate{% endhighlight %}
  
---------------------------------------------------------------------------------------------------

<a name="part-5"></a>
## Perl Modules installation:

Use the following commands:

{% highlight bash %}$ perl –MCPAN –e shell 	
                 > install <Module>[::<Submodule>]{% endhighlight %}

or from the source:
   
{% highlight bash %}$ perl Makefile.PL PREFIX= <INSTALL_PERL_PATH>
$ make
$ make test
$ make install{% endhighlight %}         
    
-----------------------------------------------------------------------------------------------------

<a name="part-6"></a>
## Essential system softwares:

### Python:

Python is a programming language
      
URL : https://www.python.org/

### Installation :

 {% highlight bash %}$ yum install zlib-devel bzip2-devel openssl-devel ncurses-devel sqlite-devel readline-devel tk-devel gdbm-devel db4-devel 
      libpcap-devel xz-devel
 $ wget  https://www.python.org/ftp/python/3.7.1/Python-3.7.1.tar.xz
 $ tar xf Python-3.7.1.tar.xz
 $ cd Python-3.7.1
 $ ./configure --prefix=/usr/local/python-3.7.1 --enable-shared LDFLAGS="-Wl,-rpath /usr/local/python-3.7.1/lib"
 $ make
 $ make altinstall{% endhighlight %} 

Add `/usr/local/python-3.7.1` to the path :

{% highlight bash %}$ echo  'export PATH=$PATH:/usr/local/python-3.7.1/bin' >>/etc/profile
$ echo  'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/python-3.7.1/lib' >>/etc/profile
$ echo  'export PYTHONPATH=/usr/local/python-3.7.1/bin' >>/etc/profile
$ source /etc/profile{% endhighlight %} 

### Usage :

{% highlight bash %}$ python3 + arguments{% endhighlight %}     

### Perl:


Perl 5 is a highly capable, feature-rich programming language with over 30 years of development

       
URL : https://www.perl.org/about.html

#### Installation :

      
{% highlight bash %}$ wget  https://www.cpan.org/src/5.0/perl-5.28.1.tar.gz
$ tar xvfz perl-5.28.1.tar.gz
$ cd perl-5.28.1
$ ./configure -des -Dprefix=/usr/local/perl-5.28.1
$ make test
$ make install{% endhighlight %} 
      

Add `/usr/local/perl-5.28.1` to the path :

{% highlight bash %}$ echo  'export PATH=$PATH:/usr/local/perl-5.28.1/bin' >>/etc/profile
$ echo  'export PERL5LIB=$PERL5LIB:/usr/local/perl-5.28.1/lib/perl5' >>/etc/profile
$ source /etc/profile{% endhighlight %} 

#### Usage :
          
{% highlight bash %}$ perl + scripts{% endhighlight %} 

### Perlbrew  (optional):


perlbrew is an admin-free perl installation management tool.

It is a tool to manage multiple perl installations.

       
URL : https://perlbrew.pl/

#### Installation :

      
{% highlight bash %}$ export PERLBREW_ROOT=/usr/local/perlbrew-0.84
      \wget -O - https://install.perlbrew.pl | bash{% endhighlight %} 
     
      

Add `/usr/local/perl-5.28.1` to the path :

{% highlight bash %}$ echo  'export PATH=$PATH:/usr/local/perlbrew-0.84' >>/etc/profile{% endhighlight %} 
      
       source /etc/profile

#### Usage :
          
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

Java is a  programming language web oriented.

       
URL : https://www.java.com/fr/download/linux_manual.jsp

#### Installation :

Download the tarball form the interface (jre ou  jdk)
      
{% highlight bash %}$ cd /usr/java
$ tar zxvf jre-8u191-linux-x64.tar.gz{% endhighlight %} 
   

Add `/usr/java/jre-8u191/`  to the path :

{% highlight bash %}$ echo  'export PATH=$PATH:/usr/java/jre-8u191/bin' >>/etc/profile
$ echo  'export PATH=$PATH:/usr/java/jre-8u191/lib' >>/etc/profile
$ source /etc/profile{% endhighlight %} 

#### Usage :
          
{% highlight bash %}$ java -jar + file.jar{% endhighlight %} 


### gcc:

The GNU Compiler Collection includes front ends for C, C++, Objective-C, Fortran, Ada, Go, and D, as well as libraries for these languages (libstdc++,...). GCC was originally written as the compiler for the GNU operating system.

URL : http://gcc.gnu.org/install/

#### Installation :

            
{% highlight bash %}$ wget  ftp://ftp.lip6.fr/pub/gcc/releases/gcc-7.4.0/gcc-7.4.0.tar.gz
 $ tar zxvf gcc-7.4.0.tar.gz
 $ cd gcc-7.4.0
 $ mkdir build
 $ cd build
 $ ../configure --prefix=/usr/local/gcc-7.4.0
 $ make --disable-werror
 $ make install{% endhighlight %} 
   

Add `/usr/local/gcc-7.4.0` to the path :

{% highlight bash %}$ echo  'export PATH=$PATH/usr/local/gcc-7.4.0/bin' >>/etc/profile
$ echo  'export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/usr/local/gcc-7.4.0/lib' >>/etc/profile
$ source /etc/profile{% endhighlight %} 


### Bioperl:

#### Installation

{% highlight bash %}$ cpan
      cpan>d /bioperl/{% endhighlight %} 


Choose the most recent version:

{% highlight bash %} cpan>install C/CJ/CJFIELDS/BioPerl-1.007001.tar.gz{% endhighlight %} 


    
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
                  
 
