---
layout: page
title: "Create IFB cloud user account - PGAA Montpellier"
permalink: /annotation/IFBcloud/create_IFB_cloud_user_account/
tags: [ IFB cloud, user, account ]
description: Explanation how create an account on the IFB cloud
author: Stéphanie Bocs, Laurent Bouri, Jacques Dainat
date: 15/09/2018
---

# How to create an IFB cloud user account

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->

- [IFB cloud user account](#ifb-cloud-user-account)
- [IFB cloud user ssh-key](#ifb-cloud-user-ssh-key)

<!-- /TOC -->

## IFB cloud user account

### 1) If your institute is not listed in Edugain then ask for the creation of local account fill the form

https://biosphere.france-bioinformatique.fr/cloudweb_account/creation/

<img width="60%" src="{{ site.url }}/images/pga/Excel10.3_IFBcloud_01_account_create.png" alt="" />

### 2) Connect to your local account

https://biosphere.france-bioinformatique.fr/cloudweb/login/?next=/cloud/

<img width="30%" src="{{ site.url }}/images/pga/Excel10.3_IFBcloud_02_account_connect.png" alt="" />

## IFB cloud user ssh-key

### 1) Create your ssh key from your personnal computer 

SSH keys serve as a means of identifying yourself to an SSH server using public-key cryptography and challenge-response authentication. One immediate advantage this method has over traditional password authentication is that you can be authenticated by the server without ever having to send your password over the network. Anyone eavesdropping on your connection will not be able to intercept and crack your password because it is never actually transmitted. 

Execute the command ssh-keygen, for instance, on a terminal of Mac OS X personnal computer

     $ ssh-keygen
     Generating public/private rsa key pair.
     Enter file in which to save the key (/Users/SIDIBEBOCS/.ssh/id_rsa): 
     Enter passphrase (empty for no passphrase): 
     Enter same passphrase again: 
     
```
Your identification has been saved in /Users/SIDIBEBOCS/.ssh/id_rsa.
Your public key has been saved in /Users/SIDIBEBOCS/.ssh/id_rsa.pub.
The key fingerprint is:
SHA256:Kq12lZ67eI7V3lKK2vdZpe09siG9rcM/v8ua2uaCgwk SIDIBEBOCS@SIDIBEB_ST-J058
The key's randomart image is:
+---[RSA 2048]----+
|                 |
|                 |
|                 |
|                 |
|        S.      .|
|     E .o.  o  + |
|    . +o+oo+.oo .|
|    .o.B=++ooB*+.|
|   ...++=+o+OOB*X|
+----[SHA256]-----+
```
A id_rsa.pub file has been created.

### 2) Copy / paste the public ssh key to your IFB cloud local account

     nedit /Users/SIDIBEBOCS/.ssh/id_rsa.pub &
Copy its content into the public key field of your IFB cloud personnal account

<img width="60%" src="{{ site.url }}/images/pga/Excel10.3_IFBcloud_03_ssh-key_copy.png" alt="" />

In case of problem write to support@france-bioinformatique.fr
