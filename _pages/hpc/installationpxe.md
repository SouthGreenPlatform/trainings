---
layout: page
title: " installation d'un serveur pxe"
permalink: /hpc/installationpxe/
tags: [ linux, HPC, cluster, OS ]
description: page d'installation d'un serveur pxe
---

| Description | Installation d'un serveur pxe sous centos 7 pour permettre une installation automatisée de serveur|
| :------------- | :------------- | :------------- | :------------- |
| Page d'accueil | [HPC Administration Module1](https://southgreenplatform.github.io/trainings/Module1/) |
| Auteur | Ndomassi TANDO (ndomassi.tando@ird.fr)  |
|  Date de création |20/09/2019 |
| Dernière  date de modification   | 20/09/2019 |


-----------------------


### Sommaire

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Pré-requis](#part-1)
* [Configuration du serveur DHCP](#part-2)
* [Configurer le serveur tftp](#part-3)
* [Links](#links)
* [License](#license)


-----------------------

# INSTALLATION  D'UN SERVEUR PXE

<a name="part-1"></a>
##  Pré-requis

-  Un serveur DHCP
-  Un serveur NFS
-  Un serveur TFTP
-  Un dépôt FTP, NFS ou un serveur HTTP pour stocker les fichiers d’installation

Lancer les commandes suivantes en tant que superutilisateur:

{% highlight bash %}$ yum install dhcp tftp tftp-server syslinux wget vsftpd  httpd xinetd  nfs-utils -y{% endhighlight %}

-------------------------------------------------------------------------------------

<a name="part-2"></a>
## Configuration du serveur DHCP:

Démarrer le serveur à installer et noter son adresse MAC.

Il faut ensuite  modifier le fichier /etc/dhcp/dhcp.conf avec les valeurs suivantes :

{% highlight bash %}option domain-name "intraceraas";

default-lease-time 86400;
max-lease-time 86400;
ddns-update-style none;

allow bootp;
allow booting;

option ip-forwarding    false;
option mask-supplier    false;

subnet 192.168.1.0 netmask 255.255.255.0 {
        range 192.168.1.100 192.168.1.249;
}


group {
        next-server     192.168.1.250;
        filename "pxelinux.0";

        host node0 {
                hardware ethernet @MAC à renseigner;
                fixed-address   192.168.1.100;
        		      }
	}{% endhighlight %}
  
  Redémarrer ensuite le service avec la commande :
  
{% highlight bash %}$ service dhcpd restart{% endhighlight %}

----------------------------------------------------------------------------------------------

<a name="part-3"></a>
## Configurer le serveur tftp:

Il faut activer le service tftp en mettant la variable disable à « no ».

Le fichier de configuration `/etc/xinetd.d/tftp` doit contenir les lignes suivantes :

{% highlight bash %}service tftp
{
        disable = no
        socket_type             = dgram
        protocol                = udp
        wait                    = yes
        user                    = root
        server                  = /usr/sbin/in.tftpd
        server_args             = -v -s /tftpboot -r blksize
        per_source              = 11
        cps                     = 100 2
        flags                   = IPv4
}{% endhighlight %}

Redémarrer le service avec la commande:

{% highlight bash %}$ systemctl restart xinetd{% endhighlight %}

### Installation des fichiers de boot réseau :

Créer le répertoire /tftpboot avec tous les droits

{% highlight bash %}$ mkdir -p /tftpboot
$ chmod 777 /tftpboot{% endhighlight %}

Copier les fichiers pour pouvoir démarrer au boot :

{% highlight bash %}$ cp -v /usr/share/syslinux/pxelinux.0 /tftpboot
$ cp -v /usr/share/syslinux/menu.c32 /tftpboot
$ cp -v /usr/share/syslinux/memdisk /tftpboot
$ cp -v /usr/share/syslinux/mboot.c32 /tftpboot
$ cp -v /usr/share/syslinux/chain.c32 /tftpboot
$ mkdir  /tftpboot/pxelinux.cfg
$ mkdir /tftpboot/netboot/{% endhighlight %}

### Monter l’ISO de centos 7 dans /mnt

Taper la commande:

{% highlight bash %}$ mount -o loop CentOS-7.0-1406-x86_64-DVD.iso /mnt/{% endhighlight %}

### Copier le contenu de l’iso dans /tftpboot/centos7 :


{% highlight bash %}$ cp -fr /tftpboot/centos7
$ chmod -R 755 /tftpboot/centos7{% endhighlight %}

### Copie des fichiers initrd.img et vmlinuz dans  /tftpboot/netboot/

Taper les commandes suivantes :

{% highlight bash %}$ cp /mnt/images/pxeboot/vmlinuz /tftpboot/netboot/
$ cp /mnt/images/pxeboot/initrd.img /tftpboot/netboot/{% endhighlight %}

### Configuration du serveur nfs :

Lancer la commande suivante pour éviter les problèmes de démarrage du service rpc :


{% highlight bash %}$ dracut -f -v{% endhighlight %}

Modifier le fichier /etc/exports pour permettre l’ accès à `/tftpboot` aux noeuds :

{% highlight bash %}$ /tftpboot 192.168.1.0/24(rw,no_root_squash,async){% endhighlight %}

Activer et démarrer les services RPC et NFS :

{% highlight bash %}$ systemctl enable rpcbind
systemctl enable nfs-server
systemctl start rpcbind
systemctl start nfs-server
{% endhighlight %}

### Configuration du serveur apache :

Créer un fichier `/etc/httpd/conf.d/pxeboot.conf` et rajouter les lignes suivantes :

{% highlight bash %}Alias /centos7 /tftpboot/centos7
<Directory /tftpboot/centos7>
Options Indexes FollowSymLinks
Order Deny,Allow
Deny from all
Allow from 127.0.0.1 192.168.1.0/24
</Directory>{% endhighlight %}

Redémarrer le service apache :


{% highlight bash %}$ service httpd restart {% endhighlight %}

### Créer le fichier de configuration du serveur pxe :

Créer le fichier  `/tfpboot/pxelinux.cfg/default`


{% highlight bash %}default menu.c32
prompt 0
timeout 30
MENU TITLE PXE Menu

LABEL centos7_x64
MENU LABEL CentOS 7 X64
        KERNEL netboot/vmlinuz
        APPEND initrd=netboot/initrd.img  ks=nfs:192.168.1.250:/tftpboot/ks.cfg inst.repo=http://192.168.1.150/centos7/7.2/os/x86_64{% endhighlight %}
	
### 	Créer le fichier kickstart /tftpboot/ks.cfg:

On crypte au préalable le mot de passe root avec la commande suivante :

{% highlight bash %}$ openssl passwd -1 "thies2018"{% endhighlight %}

Le kickstart est un fichier qui permet de paramétrer l’installation automatique de centos.

{% highlight bash %}
install
text
lang fr_FR.UTF-8
keyboard fr-latin1
skipx
network --device eth7 --bootproto dhcp --netmask 255.255.255.0
nfs --server 192.168.1.250 --dir /tftpboot/Centos7


rootpw --iscrypted $1$QJl5rL0s$ShDwIpBVfqLTD3KhKkpuf0

firewall --disabled
selinux --disabled
authconfig --enableshadow --enablemd5
graphical
timezone Afrique/Dakar
bootloader
reboot
 zerombr
clearpart --linux --initlabel
part /boot --fstype ext3 --size 500 --ondisk=sda
part / --fstype ext3 --size 50000 --ondisk=sda
part swap --size 8192 --ondisk=sda
part /scratch --fstype ext4 --size 100 --grow –ondisk=sda
%packages
@base
@core
@network-server
@fonts
@compat-libraries
@network-file-system-client
@Compatibility libraries
@development
@System administration tools
kernel-devel
rsync
ntp
libcap
rsh-server
rsh
xorg-x11-xauth
xz-lzma-compact
bzip2-devel
zlib
ncurses
ncurses-devel
tcl
%end
%post
mkdir /data
chmod -R 777 /scratch
%end{% endhighlight %}



     
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
                  
 
