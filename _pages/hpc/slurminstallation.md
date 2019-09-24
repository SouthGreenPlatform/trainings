---
layout: page
title: "Slurm installation"
permalink: /hpc/slurminstallation/
tags: [ linux, HPC, cluster, OS ]
description: Slurm installation  page
---

| Description | Installation of Slurm|
| :------------- | :------------- | :------------- | :------------- |
| Related-course materials | [HPC Administration Module2](https://southgreenplatform.github.io/trainings/Module2/) |
| Authors | Ndomassi TANDO (ndomassi.tando@ird.fr)  |
| Creation Date |23/09/2019 |
| Last Modified Date | 23/09/2019 |


-----------------------


### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Definition](#part-1)
* [Prerequisites](#part-2)
* [SGE installation](#part-3)
* [Master Server installation](#part-4)
* [Nodes installation](#part-5)
* [Links](#links)
* [License](#license)


-----------------------
<a name="part-1"></a>
## Definition


SGE (SUN Grid Engine) is a linux job scheduler able to handle from 2 to thousands of servers at the same time.

One master server use the resources (CPU or RAM)of  one or several nodes to perform analyses. 

● An opensource tool

● 3 main functions :

 - Allocates ressources (CPU,RAM) to users to allow them to
launch their analyses

 - Provides a frame to launch,execute et monitore the jobs on the
whole allocated nodes

 - Deals with jobs in queue wait

RPMS :	https://copr.fedorainfracloud.org/coprs/loveshack/SGE/

SOURCE :	https://arc.liv.ac.uk/downloads/SGE/releases/

-------------------------------------------------------------------------------------

<a name="part-2"></a>
## Prerequisites:

you have to choose a nfs parttion shared between your master and your node.

{% highlight bash %}$yum -y install epel-release
$ yum -y install jemalloc-devel openssl-devel ncurses-devel pam-devel libXmu-devel hwloc-devel hwloc hwloc-libs java-devel javacc ant-junit libdb-devel motif-devel csh ksh xterm db4-utils perl-XML-Simple perl-Env xorg-x11-fonts- ISO8859-1-100dpi xorg-x11-fonts-ISO8859-1-75dpi
$ yum install –y gcc
$ groupadd -g 490 sgeadmin
$ useradd -u 495 -g 490 -r -m  -d /home/sgeadmin -s /bin/bash sgeadmin {% endhighlight %}

----------------------------------------------------------------------------------------------

<a name="part-3"></a>
## SGE installation:

 {% highlight bash %}$ wget https://arc.liv.ac.uk/downloads/SGE/releases/8.1.9/sge-8.1.9.tar.gz
 $ cd sge-8.1.9/source/
 $ sh scripts/bootstrap.sh && ./aimk && ./aimk –man
 $ export SGE_ROOT=<NFS_SHARE_DIR> && mkdir –p $SGE_ROOT
 $ echo Y | ./scripts/distinst -local -allall -libs –noexit
 $ chown -R sgeadmin.sgeadmin $SGE_ROOT{% endhighlight %}
 

  
---------------------------------------------------------------------------------------------------

<a name="part-4"></a>
## Master server installation:

 On the master server type:
          
{% highlight bash %}$ yum -y install nfs-utils
$ cd $SGE_ROOT
$ ./install_qmaster {% endhighlight %}
  
You will be asked to mention:

*  The Grid Engine administrator name

*  The value of $SGE_ROOT

* The number of the TCP port ( 6444 by default)

* The Grid Engine service Name

*  The number of the TCP port for sge_execd (6445 by default)

*  The Grid Engine cell name (leave default)

*  The spool directory path

* The spooling method

* group ID range for Grid Engine

* Accept the installation of booting scripts

* Do not install shadow server

* The list of administration and submit hosts : put your master server in both

To finish the installation, launch the following commands:

{% highlight bash %}$  cp $SGE_ROOT/default/common/settings.sh /etc/profile.d/SGE.sh
 $ cp $SGE_ROOT/default/common/settings.csh /etc/profile.d/SGE.csh{% endhighlight %}
 
 If you have serveral nodes: allow the nfs export of the SGE PATH to the other nodes of the cluster:

In `/etc/exports` add:

{% highlight bash %}$ /usr/local/sge  IP_range_nodes/24(rw,no_root_squash){% endhighlight %}

Start and enable the nfs service:

{% highlight bash %}$ systemctl start rpcbind nfs-server
$ systemctl enable rpcbind nfs-server {% endhighlight %}
 
---------------------------------------------------------------------------------------------------

<a name="part-5"></a>
## Nodes installation:

if you have several nodes, make sure they appear in the `/etc/hosts` file

Mount the SGE_ROOT path on the node:

{% highlight bash %}$ yum -y install nfs-utils
 $ systemctl start rpcbind
 $ systemctl enable rpcbind
 $ mount –t nfs <master>:/usr/local/sge /usr/local/sge
 $ systemctl start rpcbind nfs-server
 $ systemctl enable rpcbind nfs-server{% endhighlight %}

Launch the installation of the node:

 {% highlight bash %}$ export SGE_ROOT=/usr/local/sge
 $ export SGE_CELL=default
 $ cd $SGE_ROOT
 $ ./install_execd {% endhighlight %}      
    
After answering all the questions:

{% highlight bash %}$ cp $SGE_ROOT/default/common/settings.sh /etc/profile.d/SGE.sh
$ cp $SGE_ROOT/default/common/settings.csh /etc/profile.d/SGE.csh {% endhighlight %}

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
                  
 
