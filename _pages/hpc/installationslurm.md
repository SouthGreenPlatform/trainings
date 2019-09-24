---
layout: page
title: "installation de Slurm"
permalink: /hpc/installationslurm/
tags: [ linux, HPC, cluster, OS ]
description: Page d'installation de slurm
---

| Description | Installation de Slurm sur centos 7|
| :------------- | :------------- | :------------- | :------------- |
| Supports de cours liés | [HPC Administration Module2](https://southgreenplatform.github.io/trainings/Module2/) |
| Authors | Ndomassi TANDO (ndomassi.tando@ird.fr)  |
| Creation Date |23/09/2019 |
| Last Modified Date | 23/09/2019 |


-----------------------


### Sommaire

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Definition](#part-1)
* [Authentification et bases de données](#part-2)
* [Installation de Slurm](#part-3)
* [Configuration des limites d'utilisation](#part-4)
* [Liens](#links)
* [License](#license)


-----------------------
<a name="part-1"></a>
## Definition


Slurm is an open source, fault-tolerant, and highly scalable cluster management and job scheduling system for large and small Linux clusters.

https://slurm.schedmd.com/

-------------------------------------------------------------------------------------

<a name="part-2"></a>
## Authentification et bases de données:

### Créer les utilisateurs pour munge et slurm:

Slurm et Munge requièrent d'avoir les mêmes UID et GID sur chaque noeud du cluster.
Pour tous les noeuds, lancer les commandes suivantes avant d'installer Slurm ou Munge:

{% highlight bash %}$ export MUNGEUSER=1001
$ groupadd -g $MUNGEUSER munge
$ useradd  -m -c "MUNGE Uid 'N' Gid Emporium" -d /var/lib/munge -u $MUNGEUSER -g munge  -s /sbin/nologin munge
$ export SLURMUSER=1002
$ groupadd -g $SLURMUSER slurm
$ useradd  -m -c "SLURM workload manager" -d /var/lib/slurm -u $SLURMUSER -g slurm  -s /bin/bash slurm{% endhighlight %}

### Installation de Munge pour l'authentification:

{% highlight bash %}$ yum install munge munge-libs munge-devel -y{% endhighlight %}

#### Créer une clé d'authentification Munge:


{% highlight bash %}$ /usr/sbin/create-munge-key{% endhighlight %}

#### Copier la clé d'authentification sur chaque noeud:
 
 {% highlight bash %}$ cp /etc/munge/munge.key /home
$ cexec cp /home/munge.key /etc/munge {% endhighlight %}

#### Mettre les droits:

 {% highlight bash %}$ chown -R munge: /etc/munge/ /var/log/munge/ /var/lib/munge/ /run/munge/
$ chmod 0700 /etc/munge/ /var/log/munge/ /var/lib/munge/ /run/munge/
$ cexec chown -R munge: /etc/munge/ /var/log/munge/ /var/lib/munge/ /run/munge/
$ cexec chmod 0700 /etc/munge/ /var/log/munge/ /var/lib/munge/ /run/munge/{% endhighlight %}

#### Activer et démarrer le service munge service:

 {% highlight bash %}$ systemctl enable munge
$ systemctl start munge
$ cexec systemctl enable munge
$ cexec systemctl start munge{% endhighlight %}

#### Tester munge depuis la machine maître:

 {% highlight bash %}$ munge -n | unmunge
$ munge -n | ssh <somehost_in_cluster> unmunge{% endhighlight %}

### installation et configuration de Mariadb 

#### Installer mariadb avec la commande:

 {% highlight bash %}$ yum install mariadb-server -y{% endhighlight %}

#### Activer et démarrer le service mariadb:

{% highlight bash %}$ systemctl start mariadb
systemctl enable mariadb{% endhighlight %}

#### sécuriser l'installation:

Mettre en place un mot de passe root pour mariadb:

  {% highlight bash %}$ mysql_secure_installation{% endhighlight %}

#### Modifier la configuration innodb :

Mettre des valeurs plus importantes pour innodb_lock_wait_timeout,innodb_log_file_size:

Créer le fichier `/etc/my.cnf.d/innodb.cnf` avec les lignes suivantes:

 {% highlight bash %}[mysqld]
 innodb_buffer_pool_size=1024M
 innodb_log_file_size=64M
 innodb_lock_wait_timeout=900{% endhighlight %}
 
Pour mettre en place ces changements, il faut redémarrer et supprimer les fichiers de logs:

 {% highlight bash %}$ systemctl stop mariadb
 mv /var/lib/mysql/ib_logfile? /tmp/
 systemctl start mariadb{% endhighlight %}

----------------------------------------------------------------------------------------------

<a name="part-3"></a>
## Installation de Slurm:

### Installer les pré-requis:


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

 {% highlight bash %} AuthType=auth/munge
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

-------------------------------------------------------------------------------------
<a name="part-4"></a>
## Configure usage limits 

### Modify the /etc/slurm/slurm.conf file


Modify the `AccountingStorageEnforce`parameter with:

{% highlight bash %} AccountingStorageEnforce=limits {% endhighlight %}

Copy the modified file to the several nodes

Restart the slurmctld service to validate the modifications:

{% highlight bash %}$ systemctl restart slurmctld{% endhighlight %}

### Create a cluster:

The cluster is the name we want for your slurm cluster.

It  is defined in the `/etc/slurm/slurm.conf` file with the line 

{% highlight bash %} ClusterName=ird {% endhighlight %}

To set usage limitations for your users, you  first have to create an accounting cluster with the command:

 {% highlight bash %}$sacctmgr add cluster ird{% endhighlight %}

### Create an accounting account

An accounting account is a group under slurm that allows the administrator to manage the users rights to use slurm.

Example: you can create a account to group the bioinfo teams members     

 {% highlight bash %}$ sacctmgr add account bioinfo Description="bioinfo member"{% endhighlight %} 

 You can create a account to  group the peaople allow to use the gpu partition

 {% highlight bash %}$ sacctmgr add account gpu_group Description="Members can use the gpu partition"{% endhighlight %} 

### Create a user account

You have to create slurm user to make them be able to launch slurm jobs.

{% highlight bash %}$ sacctmgr create user name=xxx DefaultAccount=yyy{% endhighlight %}

### Modify a user account to add it to another accounting account:

{% highlight bash %}$ sacctmgr add user xxx Account=zzzz{% endhighlight %}

### Modify a node definition

#### Add the amount of /scratch partition

In the file `/etc/slurm/slurm.conf`

##### Modify the TmpFS file system

{% highlight bash %}$TmpFS=/scratch{% endhighlight %} 

##### Add the TmpDisk value for /scratch

The TmpDisk is the size of the scratch in MB , you have to add in the line starting with  NodeName 

For example for a node with a 3TB disk:


{% highlight bash %}$ NodeName=node21 CPUs=16 Sockets=4 RealMemory=32004 TmpDisk=3000 CoresPerSocket=4 ThreadsPerCore=1 State=UNKNOWN{% endhighlight %}


 
### Modify a partition definition

You have to modify the line starting with PartitionName in the file `/etc/slurm/slurm.conf` .

Several options are available according to what you want 

#### Add  a time limit for running jobs (MaxTime)

A limitation time on partitions allows slurm to manage priorities between jobs on the same node.

You have to add it in the PartitionName line with the amount of time  in minutes.

For example a partition with a 1 day max time the partition definition  will be:

{% highlight bash %}PartitionName=short Nodes=node21,node[12-15]  MaxTime=1440 State=UP{% endhighlight %}


#### Add  a Max Memory per CPU (MaxMemPerCPU)

 As memory is a consumable resource  MaxMemPerCPU serves not only to protect the node’s memory but will also automatically increase a job’s core count on submission where possible

You have to add it in the PartitionName line with the amount of memory in Mb.

This is normally set to MaxMem/NumCores

for example  2GB/CPU, the partition definition  will be

{% highlight bash %} PartitionName=normal Nodes=node21,node[12-15] MaxMemPerCPU=2000 MaxTime=4320 State=UP{% endhighlight %}
     


-----------------------

### Liens
<a name="liens"></a>

* Related courses : [HPC Trainings](https://southgreenplatform.github.io/trainings/HPC/)


-----------------------

### License
<a name="license"></a>

<div>
The resource material is licensed under the Creative Commons Attribution 4.0 International License (<a href="http://creativecommons.org/licenses/by-nc-sa/4.0/">here</a>).
<center><img width="25%" class="img-responsive" src="http://creativecommons.org.nz/wp-content/uploads/2012/05/by-nc-sa1.png"/>
</center>
</div>
                  
 
