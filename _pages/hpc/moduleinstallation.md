---
layout: page
title: "Module environment installation"
permalink: /hpc/moduleinstallation/
tags: [ linux, HPC, cluster, OS ]
description: Module Environment installation  page
---

| Description | Installation of Module Environment |
| :------------- | :------------- | :------------- | :------------- |
| Related-course materials | [HPC Administration Module1](https://southgreenplatform.github.io/trainings/Module1/) |
| Authors | Ndomassi TANDO (ndomassi.tando@ird.fr)  |
| Creation Date |20/09/2019 |
| Last Modified Date | 20/09/2019 |


-----------------------


### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Definition](#part-1)
* [Installation](#part-2)
* [Configuration](#part-3)
* [Create a personal modulefile repository](#part-4)
* [Create a module file](#part-5)
* [Module commands](#part-6)
* [Links](#links)
* [License](#license)


-----------------------
<a name="part-1"></a>
## Definition

URL: https://github.com/cea-hpc/modules

Environment Modules: provides dynamic modification of a user's environment http://modules.sourceforge.net/

It allows the user to switch between several version of a program

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

### Activate the Modules at  shell startup:

Enable Modules initialization at shell startup. An easy way to get module function defined and its associated configuration setup
at shell startup is to make the initialization scripts part of the system-wide environment setup in `/etc/profile.d`. To do so, make a
link in this directory to the profile scripts that can be found in your Modules installation init directory:

 {% highlight bash %}$ ln -s /usr/local/modules-4.2.1/init/profile.sh /etc/profile.d/modules.sh
 $ ln -s /usr/local/modules-4.2.1/init/profile.csh /etc/profile.d/modules.csh{% endhighlight %}

### Define module path to enable by default:

Edit `/usr/local/modules-4.2.1/modulerc` configuration file.

Add there all the modulefile    directories you want to activate by default at Modules initialization time.

Add one line mentioning each modulefile directory prefixed by the `module use` command:

{% highlight bash %}$ module use /usr/local/modules-4.2.1/modulefiles
$ module use /path/to/other/modulefiles{% endhighlight %}

### Define the modulefiles to load by default

Edit `/usr/local/modules-4.2.1/modulerc` configuration file.

Add one line mentioning each modulefile to load prefixed by the `module load` command:

{% highlight bash %}$ module load foo
$ module load bar{% endhighlight %}

---------------------------------------------------------------------------------------------------

<a name="part-4"></a>
## Define a personal module file repository:

Each user can create his personal module file repository

### create  your  own repository

{% highlight bash %}mkdir /home/path_to_my_modulefiles{% endhighlight %}

### Add the repository in your shell:

In your `/home/user/.bashrc`, add the following line:

 {% highlight bash %}module use –append /home/path_to_my_modulefiles{% endhighlight %}
 
 ### Define the module to  launch at shell startup:
 
 In your `/home/user/.bash_profile`, add the following line:
 
  {% highlight bash %}module load program{% endhighlight %}
  
---------------------------------------------------------------------------------------------------

<a name="part-5"></a>
## Create a modulefile:

We are going to split the modulefiles in two categories:

system: corresponding to the system programs

bioinfo: corresponding to the bioinformatics programs

  {% highlight bash %}$ mkdir /usr/local/modules-4.2.1/modulefiles/system
 $ mkdir /usr/local/modules-4.2.1/modulefiles/bioinfo {% endhighlight %}
 
 For  each program you  will have to create a directory with the name of the program and a modulefile with the version number.
 
 For example, the bioinformatics software ncbi-blast v 2.4.0+  will have the modulefile 2.4.0+ according to this path:
 
 {% highlight bash %}/usr/local/modules-4.2.1/modulefiles/bioinfo/ncbi-blast/2.4.0+{% endhighlight %}

### Module file template

Modulefiles are written in tcl language.

Here is  a example for the program `program 1.0`

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
## Module commands:

See the available modules :

 {% highlight bash %}$ module avail{% endhighlight %}
 
Obtain infos on a particular module:

{% highlight bash %}$ module whatis + module name{% endhighlight %}

Load a module :

{% highlight bash %}$ module load + modulename{% endhighlight %}

List the loaded module :

{% highlight bash %}$ module list{% endhighlight %}

Unload a module :

{% highlight bash %}$ module unload + modulename{% endhighlight %}

Unload all  modules :

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
                  
 
