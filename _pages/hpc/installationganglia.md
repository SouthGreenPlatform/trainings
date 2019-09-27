---
layout: page
title: "Installation de ganglia"
permalink: /hpc/installationganglia/
tags: [ linux, HPC, cluster, OS ]
description:  Page d'installation de ganglia
---

| Description | Installation de ganglia sous Centos7|
| :------------- | :------------- | :------------- | :------------- |
| Cours lié| [HPC Administration Module2](https://southgreenplatform.github.io/trainings/Module2/) |
| Auteur | Ndomassi TANDO (ndomassi.tando@ird.fr)  |
| Date de création |27/09/2019 |
| Date de modification | 27/09/2019 |


-----------------------


### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Objectif](#part-1)
* [Installation du serveur](#part-2)
* [Configuration du serveur](#part-3)
* [Installation du client](#part-4)
* [Configuration du client](#part-5)
* [Links](#links)
* [License](#license)


-----------------------
<a name="part-1"></a>
## Objectif

Installer l’outil de supervision ganglia sous centos7.

Cela permettra d'avoir une vision d'ensemble de ce qui se passe sur le cluster.

-------------------------------------------------------------------------------------

<a name="part-2"></a>
## Installation du serveur:

Lancer la commande suivante:

{% highlight bash %}$ yum update && yum install epel-release
$ yum install ganglia rrdtool ganglia-gmetad ganglia-gmond ganglia-web {% endhighlight %}

----------------------------------------------------------------------------------------------

<a name="part-3"></a>
## Configuration du serveur:

Dans le fichier  `/etc/ganglia/gmetad.conf`, modifier les paramètres suivants :

{% highlight bash %}gridname « CERAAS »{% endhighlight %}

Modifier les « data-source » avec le nom décrivant le cluster, l’intervalle de polling puis l’adresse IP du master et du noeud monitoré

{% highlight bash %}data_source "Labo" 60 192.168.1.250:8649 # Master node
data_source "Labo" 60 192.168.1.100 # Monitored node{% endhighlight %}


Editer le fichier `/etc/ganglia/gmond.conf` :

S’assurer que le block cluster ressemble à ça :

{% highlight bash %}cluster {
  name = « Labs »# nom defini dans le   gmetad.conf
}{% endhighlight %}

Le block upd_send_channel à

{% highlight bash %}udp_send_channel {
  mcast_join = 192.168.1.250
  port = 8649
}{% endhighlight %}

Le block udp_recv_channel à

{% highlight bash %}udp_recv_channel {
#  mcast_join = 192.168.1.250
  port = 8649
#  bind = 192.168.1.250
}{% endhighlight %}

Activer et redémarrer les services avec les commandes :

{% highlight bash %}$ systemctl restart httpd gmetad gmond
$ systemctl enable httpd gmetad httpd{% endhighlight %}

L’interface web de ganglia est disponible à l’URL : `http://localhost/ganglia`
  
  
---------------------------------------------------------------------------------------------------

<a name="part-4"></a>
## Installation du client:

URL: https://conda.io/docs/

   
Installer conda avec l'installeur:

{% highlight bash %}$ bash Miniconda3-latest-Linux-x86_64.sh{% endhighlight %}


Une fois conda installé,on peut créer un nouvel environnement et installer un package avec la commande:

{% highlight bash %}$ conda create -n software software{% endhighlight %}


Pour activer un environnement:

{% highlight bash %}$ source activate myenv{% endhighlight %}


Pour désactiver un environnement:
          
{% highlight bash %}$ source deactivate{% endhighlight %}
  
---------------------------------------------------------------------------------------------------

<a name="part-5"></a>
## Configuration du client:

Utiliser les commandes suivantes:

{% highlight bash %}$ perl –MCPAN –e shell 	
                 > install <Module>[::<Submodule>]{% endhighlight %}

Ou depuis les sources:
   
{% highlight bash %}$ perl Makefile.PL PREFIX= <INSTALL_PERL_PATH>
$ make
$ make test
$ make install{% endhighlight %}         
    
    
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
                  
 
