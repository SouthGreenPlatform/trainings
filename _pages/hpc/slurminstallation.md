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
* [Slurm installation](#part-3)
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

 {% highlight bash %}$ yum install mariadb-server -y{% endhighlight %}

#### Activate and start the mariadb service:

{% highlight bash %}$ systemctl start mariadb
systemctl enable mariadb{% endhighlight %}

#### secure the installation:

Launch the following command to set up the root password an secure mariadb:

  {% highlight bash %}$ mysql_secure_installation{% endhighlight %}

#### Modify the innodb configuration:

Setting innodb_lock_wait_timeout,innodb_log_file_size and innodb_buffer_pool_size to larger values than the default is recommended.

To do that, create a the file `/etc/my.cnf.d/innodb.cnf` with the following lines:

 {% highlight bash %}[mysqld]
 innodb_buffer_pool_size=1024M
 innodb_log_file_size=64M
 innodb_lock_wait_timeout=900{% endhighlight %}
 
To implement this change you have to shut down the database and move/remove logfiles:

 {% highlight bash %}$ systemctl stop mariadb
 mv /var/lib/mysql/ib_logfile? /tmp/
 systemctl start mariadb{% endhighlight %}

----------------------------------------------------------------------------------------------

<a name="part-3"></a>
## Slurm installation:

### Install the following prerequisites:


 {% highlight bash %}$ yum install openssl openssl-devel pam-devel rpmbuild numactl numactl-devel hwloc hwloc-devel lua lua-devel readline-devel rrdtool-devel ncurses-devel man2html libibmad libibumad -y{% endhighlight %}
 
 ### Retrieve the tarball
 
{% highlight bash %}$ wget https://download.schedmd.com/slurm/slurm-19.05.0.tar.bz2{% endhighlight %}

### Create the RPMs:

 {% highlight bash %}$ rpmbuild -ta slurm-19.05.0.tar.bz2{% endhighlight %}
 
 RPMs are located in /root/rpmbuild/RPMS/x86_64/

### Install slurm on master and nodes
In the RPMs'folder, launch the following command:

 {% highlight bash %}$ yum --nogpgcheck localinstall slurm-*{% endhighlight %}

### Create and configure the slurm_acct_db database:

{% highlight bash %}$ mysql -u root -p
 mysql> grant all on slurm_acct_db.* TO 'slurm'@'localhost' identified by 'some_pass' with grant option;
 mysql> create database slurm_acct_db;{% endhighlight %}

### Configure the slurm db backend:

Modify the `/etc/slurm/slurmdbd.conf` with the following parameters:

 {% highlight bash %}$AuthType=auth/munge
  DbdAddr=192.168.1.250
  DbdHost=master0
  SlurmUser=slurm
  DebugLevel=4
  LogFile=/var/log/slurm/slurmdbd.log
  PidFile=/var/run/slurmdbd.pid
  StorageType=accounting_storage/mysql
  StorageHost=master0
  StoragePass=some_pass
  StorageUser=slurm
  StorageLoc=slurm_acct_db{% endhighlight %}
  
Then enable and start the slurmdbd service

{% highlight bash %}$ systemctl start slurmdbd
$ systemctl enable slurmdbd
$ systemctl status slurmdbd{% endhighlight %}

This will populate the slurm_acct_db with tables

### Configuration file /etc/slurm/slurm.conf:

using the command `lscpu` on each node to get processors' informations.

Visit http://slurm.schedmd.com/configurator.easy.html to make a configuration file for Slurm.

Modify the following parameters in `/etc/slurm/slurm.conf` to match with your cluster:

{% highlight bash %} ClusterName=IRD
 ControlMachine=master0
 ControlAddr=192.168.1.250
 SlurmUser=slurm
 AuthType=auth/munge
 StateSaveLocation=/var/spool/slurmd
 SlurmdSpoolDir=/var/spool/slurmd
 SlurmctldLogFile=/var/log/slurm/slurmctld.log
 SlurmdDebug=3
 SlurmdLogFile=/var/log/slurm/slurmd.log
 AccountingStorageHost=master0
 AccountingStoragePass=3devslu!!
 AccountingStorageUser=slurm
 NodeName=node21 CPUs=16 Sockets=4 RealMemory=32004 CoresPerSocket=4 ThreadsPerCore=1 State=UNKNOWN
 PartitionName=r900 Nodes=node21 Default=YES MaxTime=INFINITE State=UP{% endhighlight %}
 

Now that the server node has the slurm.conf and slurmdbd.conf correctly filled, we need to send these filse to the other compute nodes.

{% highlight bash %}$ cp /etc/slurm/slurm.conf /home
$ cp /etc/slurm/slurmdbd.conf /home
$ cexec cp /home/slurm.conf /etc/slurm
$ cexec cp /home/slurmdbd.conf /etc/slurm{% endhighlight %}

### Create the folders to host  the logs

#### On the master node:

{% highlight bash %}$ mkdir /var/spool/slurmctld
$ chown slurm:slurm /var/spool/slurmctld
$ chmod 755 /var/spool/slurmctld
$ mkdir  /var/log/slurm
$ touch /var/log/slurm/slurmctld.log
$ touch /var/log/slurm/slurm_jobacct.log /var/log/slurm/slurm_jobcomp.log
$ chown -R slurm:slurm /var/log/slurm/{% endhighlight %}   

On the compute nodes:

{% highlight bash %}$ mkdir /var/spool/slurmd
$ chown slurm: /var/spool/slurmd
$ chmod 755 /var/spool/slurmd
$ mkdir /var/log/slurm/
$ touch /var/log/slurm/slurmd.log
$ chown -R slurm:slurm /var/log/slurm/slurmd.log{% endhighlight %}

#### test the configuration:

{% highlight bash %}$ slurmd -C{% endhighlight %}
   
You should get something like:

{% highlight bash %}NodeName=master0 CPUs=16 Boards=1 SocketsPerBoard=2 CoresPerSocket=4 ThreadsPerCore=2 RealMemory=23938 UpTime=22-10:03:46{% endhighlight %} 

#### Launch the slurmd service on the compute nodes:

{% highlight bash %}$ systemctl enable slurmd.service
$ systemctl start slurmd.service
$ systemctl status slurmd.service{% endhighlight %}

#### Launch the slurmctld service on the master node:
{% highlight bash %}$ systemctl enable slurmctld.service
$ systemctl start slurmctld.service
$ systemctl status slurmctld.service{% endhighlight %}

#### Change the state of a node from down to idle

{% highlight bash %}$ scontrol update NodeName=nodeX State=RESUME{% endhighlight %}

Where nodeX is  the name of your node



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
                  
 
