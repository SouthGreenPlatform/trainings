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
 
### Récupérer le tarball
 
{% highlight bash %}$ wget https://download.schedmd.com/slurm/slurm-19.05.0.tar.bz2{% endhighlight %}

### Créer les RPMs:

 {% highlight bash %}$ rpmbuild -ta slurm-19.05.0.tar.bz2{% endhighlight %}
 
 Les RPMs sont situés dans  /root/rpmbuild/RPMS/x86_64/

### Installer slurm sur la machine maître et les noeuds

Dans le répertoire des RPMs, lancer la commande: 

 {% highlight bash %}$ yum --nogpgcheck localinstall slurm-*{% endhighlight %}

### Créer et configurer la base de données slurm_acct_db:

{% highlight bash %}$ mysql -u root -p
 mysql> grant all on slurm_acct_db.* TO 'slurm'@'localhost' identified by 'some_pass' with grant option;
 mysql> create database slurm_acct_db;{% endhighlight %}

### Configurer la slurm db backend:

Modifier `/etc/slurm/slurmdbd.conf` avec les paramètres suivants:

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
  
Ensuite activer et lancer le service slurmdbd 

{% highlight bash %}$ systemctl start slurmdbd
$ systemctl enable slurmdbd
$ systemctl status slurmdbd{% endhighlight %}

Cela permettra de créer les tables de la base slurm_acct_db.

### Configuration du fichier /etc/slurm/slurm.conf:

Lancer la commande `lscpu` sur chacun des noeuds pour avoir des informations sur les processeurs.

Aller sur  http://slurm.schedmd.com/configurator.easy.html pour créer un fichier de configuration pour Slurm.

Modifier les paramètres suivants dans `/etc/slurm/slurm.conf` en fonction des caractéristiques de votre cluster:

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
 

Il faut maintenant envoyer les fichiers slurm.conf et slurmdbd.conf sur tous les noeuds de calcul.

{% highlight bash %}$ cp /etc/slurm/slurm.conf /home
$ cp /etc/slurm/slurmdbd.conf /home
$ cexec cp /home/slurm.conf /etc/slurm
$ cexec cp /home/slurmdbd.conf /etc/slurm{% endhighlight %}

### Créer les répertoires pour accueillir les logs 

#### Sur la machine maître:

{% highlight bash %}$ mkdir /var/spool/slurmctld
$ chown slurm:slurm /var/spool/slurmctld
$ chmod 755 /var/spool/slurmctld
$ mkdir  /var/log/slurm
$ touch /var/log/slurm/slurmctld.log
$ touch /var/log/slurm/slurm_jobacct.log /var/log/slurm/slurm_jobcomp.log
$ chown -R slurm:slurm /var/log/slurm/{% endhighlight %}   

#### Sur les noeuds de calcul:

{% highlight bash %}$ mkdir /var/spool/slurmd
$ chown slurm: /var/spool/slurmd
$ chmod 755 /var/spool/slurmd
$ mkdir /var/log/slurm/
$ touch /var/log/slurm/slurmd.log
$ chown -R slurm:slurm /var/log/slurm/slurmd.log{% endhighlight %}

#### tester la configuration:

{% highlight bash %}$ slurmd -C{% endhighlight %}
   
On doit obtenir quellque chose comme:

{% highlight bash %}NodeName=master0 CPUs=16 Boards=1 SocketsPerBoard=2 CoresPerSocket=4 ThreadsPerCore=2 RealMemory=23938 UpTime=22-10:03:46{% endhighlight %} 

#### Lancer le service slurmd sur les noeuds de calcul:

{% highlight bash %}$ systemctl enable slurmd.service
$ systemctl start slurmd.service
$ systemctl status slurmd.service{% endhighlight %}

#### Lancer le service slurmctld sur la machine maître:
{% highlight bash %}$ systemctl enable slurmctld.service
$ systemctl start slurmctld.service
$ systemctl status slurmctld.service{% endhighlight %}

#### Changer l'état d'un noeud de down à idle

{% highlight bash %}$ scontrol update NodeName=nodeX State=RESUME{% endhighlight %}

Où nodeX  est le nom du noeud.

#### Modification du fichier de configuration /etc/slurm/slurm.conf:

Lorsque l'on modifie le fichier `/et/slurm/slurm.conf` il faut propager ce fichier sur tous les noeuds puis taper la commande suivante sur la machine maître:

{% highlight bash %}$ scontrol reconfig{% endhighlight %}

-------------------------------------------------------------------------------------
<a name="part-4"></a>
## Configurer les limites d'utilisation 

### Modifier le fichier /etc/slurm/slurm.conf 


Modifier le paramètre  `AccountingStorageEnforce` avec:

{% highlight bash %} AccountingStorageEnforce=limits {% endhighlight %}

Copier le fichier modifié sur les noeuds

Redémarrer le service slurmctld pour mettre en place ces modifications:

{% highlight bash %}$ systemctl restart slurmctld{% endhighlight %}

### Créer un cluster:

Le  cluster est le nom que l'on veut donner au cluster slurm.

Dans le fichier `/etc/slurm/slurm.conf`, changer la ligne suivante:

{% highlight bash %} ClusterName=ird {% endhighlight %}

Pour mettre en place des limites d'utilisation, il faut créer un `accounting cluster` avec la commande:

 {% highlight bash %}$sacctmgr add cluster ird{% endhighlight %}

### Créer un accounting account

Un `accounting account` est un group créer sous Slurm qui permet à l'administrateur de gérer les droits des utilisateurs pour utiliser Slurm.

Exemple: création d'un groupe pour regrouper les membre de l'équipe bioinfo:     

 {% highlight bash %}$ sacctmgr add account bioinfo Description="bioinfo member"{% endhighlight %} 

 Création d'un groupe pour permettre aux utilisateurs d'utiliser la parttion gpu 

 {% highlight bash %}$ sacctmgr add account gpu_group Description="Members can use the gpu partition"{% endhighlight %} 

### Créer un user account

En positionnant la valeur  limts dans le fichier `/etc/slurm/slurm.conf`, on doit créer des utilisateurs slurm pour que ceux-ci puissent lancer des jobs.

{% highlight bash %}$ sacctmgr create user name=xxx DefaultAccount=yyy{% endhighlight %}

### Modifier un user account pour le rajouter à un nouveau accounting account:

{% highlight bash %}$ sacctmgr add user xxx Account=zzzz{% endhighlight %}

### Modifier la description d'un noeuds de calcul

#### Ajouter le montant  de la partition /scratch 

Dans le fichier `/etc/slurm/slurm.conf`

##### Modifier la variable TmpFS avec la valeur de scratch

{% highlight bash %}$TmpFS=/scratch{% endhighlight %} 

##### Ajouter  la valeur TmpDisk pour /scratch

Le `TmpDisk` est la taille de la partition /scratch en Mo, à rajouter dans la ligne commençant par NodeName 

Par exemple, pour un noeud avec 3To de disque:


{% highlight bash %}$ NodeName=node21 CPUs=16 Sockets=4 RealMemory=32004 TmpDisk=3000 CoresPerSocket=4 ThreadsPerCore=1 State=UNKNOWN{% endhighlight %}

 
### Modifier une définition de partition

Une partition est une file d'attente comportant plusieurs noeuds et de nombreuses caractéristiques en terme de limites de temps, de mémoire disponible etc...

Une partition permet de prioriser les jobs entre utilisateurs.

Modifier la ligne commençant par `PartitionName` dans le fichier `/etc/slurm/slurm.conf` .

Plusieurs options sont disponibles selon ce qu'on veut faire

#### Ajouter une limitation de temps pour les running jobs (MaxTime)

Une limitation de temps sur les partitions permet à Slurm de gérer les priorités entre les jobs sur le même noeud.

On peut l'ajouter à la ligne commençant par `PartitionName` avec le montant en minutes

Par exemple pour une partition avec 1 jour maximum, la définition de la partition sera:

{% highlight bash %}PartitionName=short Nodes=node21,node[12-15]  MaxTime=1440 State=UP{% endhighlight %}


#### Ajouter une mémoire maximum par CPU (MaxMemPerCPU)

Comme la mémoire est une ressource consommable, MaxMemPerCPU sert non seulement à protéger la mémoire du noeud mais augmentera automatiquement le nombre de coeurs maximum quan c'est possible.

On doit l'ajouter sur la ligne `PartitionName` avec le montant de la mémoire en Mo.  

MaxMemPerCPU est normalement fixé avec le rapport MaxMem/NumCores

Par exemple 2Go/CPU, la définition de la  partition sera

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
                  
 
