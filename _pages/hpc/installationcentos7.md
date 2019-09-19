---
layout: page
title: " installation de centos7"
permalink: /hpc/installationcentos7/
tags: [ linux, HPC, cluster, OS ]
description: page d'installation de centos 7
---

| Description | Hands On Lab Exercises for HPC |
| :------------- | :------------- | :------------- | :------------- |
| Related-course materials | [HPC Administration Module1](https://southgreenplatform.github.io/trainings/Module1/) |
| Auteur | Ndomassi TANDO (ndomassi.tando@ird.fr)  |
|  Date de création |19/09/2019 |
| Dernière  date de modification   | 19/09/2019 |


-----------------------


### Sommaire

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Configuration RAID pour un serveur dell](#part-1)
* [Pré-requis](#part-2)
* [Choix des logiciels](#part-3)
* [Partitionnement du disque](#part-4)
* [Réglages de la date et de l'heure](#part-5)
* [Début de l'installation ](#part-6)
* [Mot de passe Root et urilisateurs](#part-7)
* [Configuration du nom de serveur](#part-8)
* [Configuration du stockage](#part-9)
* [Configuration du réseau](#part-10)
* [Installer des  paquets avec la commande yum](#part-11)
* [Gestions des quotas](#part-12)
* [Creéer un repository de paquets llocal](#part-13)
* [Links](#links)
* [License](#license)


-----------------------

# INSTALLATION  DECENTOS 7

<a name="part-1"></a>
##  Configuration RAID pour un serveur DELL

### modifier les réglages du boot pour démarrer en mode BIOS:


Démarrer le serveur et taper `F2 system setup`.

Choisir `system BIOS`

Choisir `Boot Settings`

Ensuite dans `Boot Mode` choisir `BIOS` and choisir `exit and finish` pour démarrer normalement

Taper `CTRL +R` pour aller dans le `PERC H730P RAID configuration utility`

Choisir `Create new VD`

### Créer les disques RAID

Les disques RAID  vous permettent de regrouper un groupe de disques physiques dans un disque virtuel.

Ex: Il y a 7 disks disponibles:

    *  2 avec 300 Go
    *  5 avec 4To

On créera un RAID1 avec les  2 disques de 300Go: Ils seront utilisés pour installer le système.

On créera un RAID6 avec les 5 disques restants de 4To: ils seront utilisés pour stocker les données.


###  Créer les Virtual disks:

Souligner la ligne `PERC H730P Adapter (Bus 0x19, Dev 0x00)` et taper `F2`

Choose `create new VD`

In `RAID Level` , choose RAID-1 
 
Underline the 2 first disks and press enter to select them.


Press `OK` when your are done

Perform the same operation with the 5 remaings disks choosing `RAID-6` 

-------------------------------------------------------------------------------------

<a name="part-2"></a>
## Prerequisites:

A USB key or a CD is needed

Sources can be found here : https://www.centos.org/

## Installation:

*  Choose `Ìnstall Centos 7` on the following screen:

<img width="50%" class="img-responsive" src="{{ site.url }}/images/centos1.png"/>


*   This screen appears:

<img width="50%" class="img-responsive" src="{{ site.url }}/images/centos2.png"/>


## Language choice:

* Choose your language and click on `continue`

----------------------------------------------------------------------------------------------

<a name="part-3"></a>
## Softwares choice:

<img width="50%" class="img-responsive" src="{{ site.url }}/images/centos3.png"/>


In `Software selection`, choose `compute node` with the following softwares:

 <img width="50%" class="img-responsive" src="{{ site.url }}/images/centos4.png"/>


Then choose `Infrastructure Server` with the following softwares:


<img width="50%" class="img-responsive" src="{{ site.url }}/images/centos5.png"/>

---------------------------------------------------------------------------------------------------

<a name="part-4"></a>
## Disk partitioning:


We are going to create 4 partitions on the new system:

            • /home : hosts users personal data
            • /usr/local/bioinfo : hosts bioinformatics software
            • /data : hosts project data
            • /: hosts system configuration files


To implement the disk partitioning, choose `System` then `Ìnstallation Destination` 

<img width="50%" class="img-responsive" src="{{ site.url }}/images/centos6.png"/>

Select the hard drive on which you want to install Centos7 anc chose `I will configure the partitioning`:

 <img width="50%" class="img-responsive" src="{{ site.url }}/images/centos7.png"/>


The partitions are going to be made in LVM.
 
Click on `+` to add a new partition:

<img width="50%" class="img-responsive" src="{{ site.url }}/images/centos8.png"/>


Create the following partitions with the specified features:

            *  /boot: 200Mo, mount point: /boot, type of partition: boot check the `Reformat`box
            
            *  swap: 4000Mo, mount point: swap, type of partition: swap  check the `Reformat`box

            *  /home: size to define, mount point: /home, type of partition: xfs  check the `Reformat`box

            *  /data: size to define, mount point: /data, type of partition: xfs  check the `Reformat`box
            
            *  /usr/local: size to define, mount point: /usr/local, type of partition: xfs  check the `Reformat`box


Once all the partitions are defined click on `done` to continue

A windows appears and click `Accept changes`

<img width="50%" class="img-responsive" src="{{ site.url }}/images/centos9.png"/>

-----------------------------------------------------------------------------------------------------

<a name="part-5"></a>
## Set Date and Time:

Click on the clock icon under the localization menu and select a time zone from the map of the world, then click `Done`

<img width="50%" class="img-responsive" src="{{ site.url }}/images/centos10.png"/>


-------------------------------------------------------------------------------------------------------

<a name="part-6"></a>

## Begin Installation:

click on the `Begin Installation button`.

<img width="50%" class="img-responsive" src="{{ site.url }}/images/centos11.png"/>

--------------------------------------------------------------------------------------------------------

<a name="part-7"></a>

## Root and user password:

The installation begins and you can create a user and choose a root password.



### Choose a root password:

<img width="50%" class="img-responsive" src="{{ site.url }}/images/centos12.png"/>

Then click `Done`

### Create a user:

If you want this user to have admin rights tick ` Make this user administrator`:

<img width="50%" class="img-responsive" src="{{ site.url }}/images/centos13.png"/>

-------------------------------------------------------------------------------------------------------
<a name="part-8"></a>
## Name configuration:

To modify the name, launch the following command:


{% highlight bash %}$ hostnamectl set-hostname name-server{% endhighlight %}
               
-------------------------------------------------------------------------------------------------------
<a name="part-9"></a>
## storage configuration:

We have to configure the RAID-6 disk to be able to mount them in the /data partition.

### check the name of your device:

{% highlight bash %}$ fdisk -l{% endhighlight %}


Shows you the list of the hardrives and their names

On this server, it is `/dev/sdb`

 
### Format the disk in GPT:

{% highlight bash %} $ parted /dev/sdb mklabel gpt
       $ parted /dev/sdb
       $ mkpart primary xfs 1 -1
       $ quit{% endhighlight %}

 /dev/sdb1 partition has been created.

### Format partition in xfs:

{% highlight bash %}$ mkfs.xfs -L data /dev/sdb1{% endhighlight %}

### Mount the content of the device /dev/sdb1 into /data and enable the quota

Create the folder `/data`:

{% highlight bash %}$ mkdir /data{% endhighlight %}

Modify the file `/etc/fstab` with:


       /dev/sdb1          /data  xfs     pquota        1 2


launch the following command to take into account the modifications:


{% highlight bash %}$ mount -a{% endhighlight %}

---------------------------------------------------------------------------------------------------
<a name="part-10"></a>
## Network configuration:

### Deactivate selinux:

The security system selinux has to be deactivated to prevent essentials port to be blocked.

In a console, open the configuration file `/etc/selinux/config` and  set `SELINUX`to  `disabled`

Reboot the server to make the change permanent.


### Disable firewalld:


{% highlight bash %}$ systemctl stop firewalld
     $ systemctl disable firewalld{% endhighlight %}
     

### Set the IP address:

Determine the name of the network interfaces with the command:


{% highlight bash %}$ ifconfig -a{% endhighlight %}


In the following example, the interface to  configure is `enp0s3`

![image](/uploads/1e908d297ede2f72eea59d5b6fb06644/image.png)


The configuration files for the network interfaces are located in : `/etc/sysconfig/network-scripts/`

Usually a network file is named : `ifcfg-interface-name` for example here it will be: `ìfcfg-em1`

Open the configuration file corresponding to the interface you want to configure and modify it like this:

{% highlight bash %} TYPE=Ethernet
BOOTPROTO=static
DEFROUTE=yes
NAME=enp0s3
ONBOOT=yes
IPADDR0= * IP_Adress *
PREFIX0= * netmask *
GATEWAY0= * gateway_ip *
DNS1=* DNS_Ip_server * {% endhighlight %}



Launch the following command to  implement the new configuration:

{% highlight bash %} service network restart {% endhighlight %}

###  Add default route:

{% highlight bash %}$ route add default gw GATEWAY_IP_ADDRESS INTERFACE_NAME{% endhighlight %}


--------------------------------------------------------------------------------------------------------

<a name="part-11"></a>
## Install packages with yum command

yum allows you to install packages on Centos from multiple repositories available on the Internet or locally.


To search for a particular package:


{% highlight bash %}$ yum search package {% endhighlight %}


To install a particular package:


{% highlight bash %}$ yum install package{% endhighlight %}


To list the version of a package:


{% highlight bash %}$ yum list package{% endhighlight %}

-----------------------------------------------------------------------------------------------------------------

<a name="part-12"></a>
## quotas management

### **Set up quotas on a  XFS partition **

1.in the `/etc/fstab` file for each xfs partition add uquota and pquota option:

* uquota: quota per user on the xfs partition 
* pquota: quota per project on the xfs partition 

```
/dev/sdb1       /data   xfs     uquota,pquota        1 2

```

2.Save the file, then type this command to validate modifications:

{% highlight bash %}$ mount -a{% endhighlight %}
                 


       
### **Project creation**

1.Complete the files:

* /etc/projects with id_project:/path/project_name
* /etc/projid with project_name:id

\_with id: the project number to increment each time
avec project_name: the project_name_


2.Set up the quota with the following commands:


{% highlight bash %}$ xfs_quota -x -c "project -s project_name" 
$ xfs_quota -x -c "limit -p bsoft=199g bhard=200g project_name" /partition {% endhighlight %}


* with bsoft being the limit when the user is going to receive a warning. User has 7 days to remove data
* bhard: effective limit


### **Monitor quotas project**

    $ xfs_quota -xc 'report -hp' /partition 
    $ xfs_quota -xc 'report -hp' /data


### **User quota creation**


{% highlight bash %}$ xfs_quota -x -c "limit -u bsoft=99g bhard=100g user" /home {% endhighlight %}


### **Monitor quota user**

{% highlight bash %}$ xfs_quota -xc 'report -hu' /partition {% endhighlight %}


{% highlight bash %}$ xfs_quota -xc 'report -hu' /home {% endhighlight %}

### **Delete a quota**

Set the limits to 0

{% highlight bash %}$ xfs_quota -x -c "limit -p bsoft=0g bhard=0g projet" {% endhighlight %}

{% highlight bash %}$ xfs_quota -x -c "limit -u bsoft=0g bhard=0g user" /home {% endhighlight %}

-----------------------------------------------------------------------------------------------------
<a name="part-13"></a>
## Create a local package  repository


When a server is not connected to the Internet, it is sometimes convenient to be able to install packages from a local repository. 
   

      ### copy the USB key or DVD:

launch the following command:


 {% highlight bash %}$ mkdir /opt/Centos7
        $ mount /dev/sdc /mnt  # /dev/sdc being the DVDROM or USB key device path
        $ cp -r /mnt/* /opt/Centos7{% endhighlight %}

     
### Modify the file `/etc/yum/repos.d/Centos-Base.repo`

In the `[base]`section, comment the  ligne  `mirrolist`and replace `baseurl` line with:

            baseurl=file:/opt/Centos7

 In the sections `[updates]`, `[extras]` and `[centosplus]` add the follwing line:


             enabled=0

     
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
                  
 
