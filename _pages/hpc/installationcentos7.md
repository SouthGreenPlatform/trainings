---
layout: page
title: " installation de centos7"
permalink: /hpc/installationcentos7/
tags: [ linux, HPC, cluster, OS ]
description: page d'installation de centos 7
---

| Description | Installation de centos 7 |
| :------------- | :------------- | :------------- | :------------- |
| Page d'accueil | [HPC Administration Module1](https://southgreenplatform.github.io/trainings/Module1/) |
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
* [Mot de passe Root et utilisateurs](#part-7)
* [Configuration du nom de serveur](#part-8)
* [Configuration du stockage](#part-9)
* [Configuration du réseau](#part-10)
* [Installer des  paquets avec la commande yum](#part-11)
* [Gestions des quotas](#part-12)
* [Creéer un repository de paquets llocal](#part-13)
* [Links](#links)
* [License](#license)


-----------------------

# INSTALLATION  DE CENTOS 7

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

{% highlight bash %}*  2 avec 300 Go
*  5 avec 4To{% endhighlight %}

On créera un RAID1 avec les  2 disques de 300Go: Ils seront utilisés pour installer le système.

On créera un RAID6 avec les 5 disques restants de 4To: ils seront utilisés pour stocker les données.


###  Créer les Virtual disks:

Surligner la ligne `PERC H730P Adapter (Bus 0x19, Dev 0x00)` et taper `F2`

Choisir `create new VD`

Dans `RAID Level` , choisir RAID-1 
 
Surligner les 2 premiers disques et presser `entrée` pour les sélectionner. 

Presser `OK` quand vous avez fini.

Réaliser la même opération avec les 5 disques restants en choissisant `RAID-6` 

-------------------------------------------------------------------------------------

<a name="part-2"></a>
## Pré-requis:

Besoin d'une clé USB ou d'un CD

Les sources peuvent être trouvées ici: https://www.centos.org/

## Installation:

*  Choisir `Ìnstall Centos 7` sur l'écran suivant:

<img width="50%" class="img-responsive" src="{{ site.url }}/images/centos1.png"/>


*   Cet écran apparait:

<img width="50%" class="img-responsive" src="{{ site.url }}/images/centos2.png"/>


## Choix du langage:

* Choisir votre langue et cliquer sur `continue`

----------------------------------------------------------------------------------------------

<a name="part-3"></a>
## Choix des logiciels:

<img width="50%" class="img-responsive" src="{{ site.url }}/images/centos3.png"/>


Dans `Software selection`, choisir `compute node` avec les logiciels suivants:

 <img width="50%" class="img-responsive" src="{{ site.url }}/images/centos4.png"/>


Ensuite choisir `Infrastructure Server` avec les logiciels suivants:


<img width="50%" class="img-responsive" src="{{ site.url }}/images/centos5.png"/>

---------------------------------------------------------------------------------------------------

<a name="part-4"></a>
## Partitionnement des disques:


Nous allons créer 4 parttions sur le nouveau système:

{% highlight bash %}• /home : hosts users personal data
• /usr/local/bioinfo : hosts bioinformatics software
• /data : hosts project data
• /: hosts system configuration files{% endhighlight %}


Pour mettre en place le partitionnement des disques, choisir `System` puis `Ìnstallation Destination` 

<img width="50%" class="img-responsive" src="{{ site.url }}/images/centos6.png"/>

Selectionner le disque dur sur lequel on veut installer centos7 et choisir  `I will configure the partitioning`:

 <img width="50%" class="img-responsive" src="{{ site.url }}/images/centos7.png"/>


Les partitions vous être crées en LVM.
 
Cliquer sur `+` pour ajouter une nouvelle partition:

<img width="50%" class="img-responsive" src="{{ site.url }}/images/centos8.png"/>


 Créer les parttions avec les caractéristiques suivantes:

 {% highlight bash %} *  /boot: 200Mo, mount point: /boot, type de partition: boot cocher le bouton `Reformat`
            
  *  swap: 4000Mo, mount point: swap, type de partition: swap  cocher le bouton `Reformat`

  *  /home: taille à définir, mount point: /home, type de partition: xfs  cocher le bouton `Reformat`

  *  /data: taille à définir, mount point: /data, type de partition: xfs  cocher le bouton `Reformat`
            
  *  /usr/local: taille à définir, mount point: /usr/local, type de partition: xfs  cocher le bouton `Reformat`
  
  * /: avec la  taille restante{% endhighlight %}

Une fois les partitions définies, cliquer sur `done`pour continuer


Une fenêtre apparait et cliquer sur `Accept changes`

<img width="50%" class="img-responsive" src="{{ site.url }}/images/centos9.png"/>

-----------------------------------------------------------------------------------------------------

<a name="part-5"></a>
## Réglage de la date et de l'heure:

Cliquer sur l'icône de l'horloge en dessous du menu localisation et sélectionner la time zone fr depuis la carte du monde et cliquer sur`Done`

<img width="50%" class="img-responsive" src="{{ site.url }}/images/centos10.png"/>


-------------------------------------------------------------------------------------------------------

<a name="part-6"></a>

## Début d' installation:

Cliquer sur `Begin Installation button`.

<img width="50%" class="img-responsive" src="{{ site.url }}/images/centos11.png"/>

--------------------------------------------------------------------------------------------------------

<a name="part-7"></a>

## Mot de passe Root et utilisateurs:

L'installation commence et l'on peut créer un utilisateur et choisir un mot de passe root.



### Choisir un mot de passe root:

<img width="50%" class="img-responsive" src="{{ site.url }}/images/centos12.png"/>

Puis cliquer sur `Done`

### Créer un utilisateur:

Si l'on veut que l'utilisateur ait des droits superutilisateur, cocher ` Make this user administrator`:

<img width="50%" class="img-responsive" src="{{ site.url }}/images/centos13.png"/>

-------------------------------------------------------------------------------------------------------
<a name="part-8"></a>
## Configuration du nom:

Pour modifier le nom, lancer la commande suivante:


{% highlight bash %}$ hostnamectl set-hostname name-server{% endhighlight %}
               
-------------------------------------------------------------------------------------------------------
<a name="part-9"></a>
## Configuration du stockage:

On doit configurer les disques en RAID-6 pour être capable de les monter dans la partition  /data.

### Vérifier le nom du disque:

{% highlight bash %}$ fdisk -l{% endhighlight %}

Cette commande nous montre la list des disques dur et leur nom

Par exemple, `/dev/sdb`

 
### Formater le disque en GPT:

{% highlight bash %} $ parted /dev/sdb mklabel gpt
       $ parted /dev/sdb
       $ mkpart primary xfs 1 -1
       $ quit{% endhighlight %}

 La partition /dev/sdb1 a été créé.

### Formater la partition en xfs:

{% highlight bash %}$ mkfs.xfs -L data /dev/sdb1{% endhighlight %}

### Monter le contenu de /dev/sdb1 dans /data et activer le quota

Créer le répertoire `/data`:

{% highlight bash %}$ mkdir /data{% endhighlight %}

Modifier le fichier `/etc/fstab` avec:


{% highlight bash %}/dev/sdb1          /data  xfs     pquota        1 2{% endhighlight %}


lancer les commandes suivantes pour prendre en compte les modifications:


{% highlight bash %}$ mount -a{% endhighlight %}

---------------------------------------------------------------------------------------------------
<a name="part-10"></a>
## Configuration du réseau:

### Désactiver de selinux:

Le système de sécurité selinux doit être désactivé pour empécher les ports essentiels d'être bloqués.

Dans un terminal, ouvrir le fichier `/etc/selinux/config` et mettre `SELINUX` à `disabled`

Rebooter le serveur.


### Désactiver firewalld:


{% highlight bash %}$ systemctl stop firewalld
     $ systemctl disable firewalld{% endhighlight %}
     

### Configurer l'adresse IP:

Determiner le nom de la carte réseau avec la commande:


{% highlight bash %}$ ifconfig -a{% endhighlight %}


Dans l'exemple suivant,l'interface à configurer est `enp0s3`

<img width="50%" class="img-responsive" src="{{ site.url }}/images/centos14.png"/>


Les fichiers de configuration des cartes réseaux se trouve dans: `/etc/sysconfig/network-scripts/`

Généralement les fichiers sont nommés : `ifcfg-interface-name` par exemple: `ìfcfg-em1`

Ouvrir le fichier de configuration et le modifier de cette manière:

{% highlight bash %} TYPE=Ethernet
BOOTPROTO=static
DEFROUTE=yes
NAME=enp0s3
ONBOOT=yes
IPADDR0= * IP_Adress *
PREFIX0= * netmask *
GATEWAY0= * gateway_ip *
DNS1=* DNS_Ip_server * {% endhighlight %}



Lancer la commande suivante pour mettre en place la nouvelle configuration:

{% highlight bash %}$ service network restart {% endhighlight %}

###  Rajouter une route par défaut:

{% highlight bash %}$ route add default gw GATEWAY_IP_ADDRESS INTERFACE_NAME{% endhighlight %}


--------------------------------------------------------------------------------------------------------

<a name="part-11"></a>
## Installer des paquets avec yum 

yum permet d' installer des  paquets sur Centos depuis plusieurs repositories disponible sur  Internet ou localement.

Afin que tous les paquets installés soient à jour, il fat taper la commande:

{% highlight bash %}$ yum update{% endhighlight %}


Pour rechercher un paquet en particulier:


{% highlight bash %}$ yum search package {% endhighlight %}


Pour installer un paquet en particulier:


{% highlight bash %}$ yum install package{% endhighlight %}


Pour afficher la version d'un paquet:


{% highlight bash %}$ yum list package{% endhighlight %}


Ajouter un nouveau dépôt de logiciels:

Un dépôt de logiciels permet d'avoir accès à d'autres logiciels contenus sur un répertoire distant.

Pour avoir accès à un répertoire distant, il faut rajouter un fichier .repo dans le fichier `/etc/yum.repos.d`

-----------------------------------------------------------------------------------------------------------------

<a name="part-12"></a>
## Gestions des quotas 

### Mettre en place les quotas sur une partition XFS 

1.Dans le fichier `/etc/fstab` file ajouter les options uquota et pquota sur chacune des partitions:

* uquota: quota par utilisateur sur la partition xfs 
* pquota: quota par projet sur la partition xfs 


{% highlight bash %}/dev/sdb1       /data   xfs     uquota,pquota        1 2{% endhighlight %}



2.Sauvegarder le fichier puis taper la commande suivante pour valider les modifications:

{% highlight bash %}$ mount -a{% endhighlight %}
                 


       
### **Création de projet**

1.Compléter les fichiers:

* /etc/projects avec id_project:/path/project_name
* /etc/projid avec project_name:id

\_with id: le numéro de projet à incrémenter à chaque fois
avec project_name: le nom du projet


2.Mettre en place le quota avec les commandes suivantes:


{% highlight bash %}$ xfs_quota -x -c "project -s project_name" 
$ xfs_quota -x -c "limit -p bsoft=199g bhard=200g project_name" /partition {% endhighlight %}


* with bsoft la limite à laquelle l'utilisateur recevra un warning. l'utilisateur a 7 jours pour effacer des données
* bhard: limite effective


### **Monitorer les  quotas de projet**

 {% highlight bash %}$ xfs_quota -xc 'report -hp' /partition 
  $ xfs_quota -xc 'report -hp' /data{% endhighlight %}


### **creation de quotas utilisateurs**


{% highlight bash %}$ xfs_quota -x -c "limit -u bsoft=99g bhard=100g user" /home {% endhighlight %}


### **Monitorer les  quota utilisateurs**

{% highlight bash %}$ xfs_quota -xc 'report -hu' /partition {% endhighlight %}


{% highlight bash %}$ xfs_quota -xc 'report -hu' /home {% endhighlight %}

### **Supprimer les quotas**

Mettre les limites à 0

{% highlight bash %}$ xfs_quota -x -c "limit -p bsoft=0g bhard=0g projet" {% endhighlight %}

{% highlight bash %}$ xfs_quota -x -c "limit -u bsoft=0g bhard=0g user" /home {% endhighlight %}

-----------------------------------------------------------------------------------------------------
<a name="part-13"></a>
## Créer un repository de paquets local:


Quand un serveur n'est pas connecté à  Internet, on peut avoir besoin d'un repository de paquets local. 
   

### copier la clé USB  ou le DVD:

Lancer la commande suivante


 {% highlight bash %}$ mkdir /opt/Centos7
        $ mount /dev/sdc /mnt  # /dev/sdc being the DVDROM or USB key device path
        $ cp -r /mnt/* /opt/Centos7{% endhighlight %}

     
### Modifier le fichier `/etc/yum/repos.d/Centos-Base.repo`

Dans la section `[base]`, commenter la  ligne  `mirrolist`et remplacer la ligne `baseurl` avec:

{% highlight bash %}baseurl=file:/opt/Centos7{% endhighlight %}

Dans les sections `[updates]`, `[extras]` et `[centosplus]` ajouter la ligne suivante:


{% highlight bash %}enabled=0{% endhighlight %}

     
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
                  
 
