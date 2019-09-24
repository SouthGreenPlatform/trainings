---
layout: page
title: "Slurm installation"
permalink: /hpc/slurminstallation/
tags: [ linux, HPC, cluster, OS ]
description: Slurm installation  page
---

| Description | Installation of Slurm on centos 7|
| :------------- | :------------- | :------------- | :------------- |
| Related-course materials | [HPC Administration Module2](https://southgreenplatform.github.io/trainings/Module2/) |
| Authors | Ndomassi TANDO (ndomassi.tando@ird.fr)  |
| Creation Date |23/09/2019 |
| Last Modified Date | 23/09/2019 |


-----------------------


### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Definition](#part-1)
* [Authentication and databases](#part-2)
* [SGE installation](#part-3)
* [Master Server installation](#part-4)
* [Nodes installation](#part-5)
* [Links](#links)
* [License](#license)


-----------------------
<a name="part-1"></a>
## Definition


Slurm is an open source, fault-tolerant, and highly scalable cluster management and job scheduling system for large and small Linux clusters.

https://slurm.schedmd.com/

-------------------------------------------------------------------------------------

<a name="part-2"></a>
## Authentication and databases:

### Create the user for munge and slurm:

Slurm and Munge require consistent UID and GID across every node in the cluster.
For all the nodes, before you install Slurm or Munge:

{% highlight bash %}$ export MUNGEUSER=1001
$ groupadd -g $MUNGEUSER munge
$ useradd  -m -c "MUNGE Uid 'N' Gid Emporium" -d /var/lib/munge -u $MUNGEUSER -g munge  -s /sbin/nologin munge
$ export SLURMUSER=1002
$ groupadd -g $SLURMUSER slurm
$ useradd  -m -c "SLURM workload manager" -d /var/lib/slurm -u $SLURMUSER -g slurm  -s /bin/bash slurm{% endhighlight %}

### Munge Installation for authentication:

{% highlight bash %}$ yum install munge munge-libs munge-devel -y{% endhighlight %}

#### Create a munge authentication key:


{% highlight bash %}$ /usr/sbin/create-munge-key{% endhighlight %}

 #### Copy  the munge authentication key on every node:
 
 {% highlight bash %}$ cp /etc/munge/munge.key /home
$ cexec cp /home/munge.key /etc/munge {% endhighlight %}

#### Set the rights:

 {% highlight bash %}$ chown -R munge: /etc/munge/ /var/log/munge/ /var/lib/munge/ /run/munge/
$ chmod 0700 /etc/munge/ /var/log/munge/ /var/lib/munge/ /run/munge/
$ cexec chown -R munge: /etc/munge/ /var/log/munge/ /var/lib/munge/ /run/munge/
$ cexec chmod 0700 /etc/munge/ /var/log/munge/ /var/lib/munge/ /run/munge/{% endhighlight %}

#### Enable and Start the munge service with:

 {% highlight bash %}$ systemctl enable munge
$ systemctl start munge
$ cexec systemctl enable munge
$ cexec systemctl start munge{% endhighlight %}

#### Test munge from the master node:

 {% highlight bash %}$ munge -n | unmunge
$ munge -n | ssh <somehost_in_cluster> unmunge{% endhighlight %}

### Mariadb installation and configuration

#### Install mariadb with the following command:

 yum install mariadb-server -y

Activate and start the mariadb service:
systemctl start mariadb
systemctl enable mariadb

secure the installation:
Launch the following command to set up the root password an secure mariadb:
  mysql_secure_installation

Modify the innodb configuration:
Setting innodb_lock_wait_timeout,innodb_log_file_size and innodb_buffer_pool_size to larger values than the default is recommended.
To do that, create a the file /etc/my.cnf.d/innodb.cnf with the following lines:
 [mysqld]
 innodb_buffer_pool_size=1024M
 innodb_log_file_size=64M
 innodb_lock_wait_timeout=900
To implement this change you have to shut down the database and move/remove logfiles:
 systemctl stop mariadb
 mv /var/lib/mysql/ib_logfile? /tmp/
 systemctl start mariadb

----------------------------------------------------------------------------------------------

<a name="part-3"></a>
## SGE installation:

 {% highlight bash %}$ wget https://arc.liv.ac.uk/downloads/SGE/releases/8.1.9/sge-8.1.9.tar.gz
 $ cd sge-8.1.9/source/
 $ sh scripts/bootstrap.sh && ./aimk && ./aimk –man
 $ export SGE_ROOT=<NFS_SHARE_DIR> && {% highlight bash %}$ /usr/local/sge  IP_range_nodes/24(rw,no_root_squash){% endhighlight %}mkdir –p $SGE_ROOT
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
                  
 
