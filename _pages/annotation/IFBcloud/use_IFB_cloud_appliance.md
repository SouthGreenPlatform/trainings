---
layout: page
title: "Create IFB cloud user account - PGAA Montpellier"
permalink: /annotation/IFBcloud/use_IFB_cloud_appliance/
tags: [ appliance, run, use, IFB cloud ]
description: Explanation how to run and use an IFB cloud appliance
author: Stéphanie Bocs, Laurent Bouri, Jacques Dainat
date: 15/09/2018
---

# How to run an IFB cloud appliance

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->

- [IFB cloud appliance start](#ifb-cloud-appliance-start)
- [IFB cloud appliance connection](#ifb-cloud-appliance-connection)

<!-- /TOC -->

## Prerequisite

1. You need an account on the IFB could. If you don't have any please refer to the following documentation:
[How to create an account on the IFB cloud](create_IFB_cloud_user_account)

## IFB cloud appliance start

### 1) Look for your appliance

[IFB catalogue](https://biosphere.france-bioinformatique.fr/catalogue/)

<img width="85%" src="{{ site.url }}/images/pga/Excel10.3_IFBcloud_04_rainbio_catalog_search.png" alt="" />

### 2) Configure your VM with the adapted size

Click on advanced deployment then choose the corresponding amount of CPU and RAM needed for your purpose.

<img width="70%" src="{{ site.url }}/images/pga/Excel10.3_IFBcloud_05_eugene_appli_config.png" alt="" />

## IFB cloud appliance connection

### 1) Look for your VM

Click on myVM tab, wait for the deployment to finish corectly (green light), then click on the interrogation point in order to obtain the IP address of your VM 

[IFB cloud](https://biosphere.france-bioinformatique.fr/cloud/)

<img width="70%" src="{{ site.url }}/images/pga/Excel10.3_IFBcloud_06_eugene_appli_myVM.png" alt="" />

### 2) Connect to your VM
{% highlight bash %}
SIDIBEB_ST-J058:~ SIDIBEBOCS$ ssh -Y root@134.158.247.40
Welcome to Ubuntu 16.04.3 LTS (GNU/Linux 4.4.0-104-generic x86_64)

 * Documentation:  https://help.ubuntu.com
 * Management:     https://landscape.canonical.com
 * Support:        https://ubuntu.com/advantage

  Get cloud support with Ubuntu Advantage Cloud Guest:
    http://www.ubuntu.com/business/services/cloud

75 packages can be updated.
1 update is a security update.

*** System restart required ***

First, make sure you are root user (sudo su)

Then, read the readme file ReadmeEugen.txt and ReadmeBUSCO.txt for more details on running eugen-EP and BUSCO (/root)

You will find sequence data to try Eugene-EP, located at /root

If you need to launch myGenomeBrowser, run the script script_myGenomeBrowser.sh (/root) (login/password generated)

Then, type 'firefox &' to start the firefox browser (You must have used the -XY arguments in your ssh connection)

Finally, enter the following URL in firefox to connect to the MyGenomeBrowser portal: http://localhost/myGenomeBrowser

And use the login and password provided in the terminal to log in to myGenomeBrowser

Last login: Fri Sep  7 15:18:07 2018 from 195.221.174.11
root@machine1a957191-dcc3-4d5e-83d7-e97d29f17266:~# ls
bank_tair  bank_tair.zip  input_dir  output_dir  ReadmeBusco.txt  ReadmeEugen.txt  script_myGenomeBrowser.sh  work_dir
{% endhighlight %}
In case of problem write to support@france-bioinformatique.fr
