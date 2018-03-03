---
layout: page
title: "Linux Practice"
permalink: /linux/linuxPractice/
tags: [ linux, survival guide ]
description: Linux Practice page
---

Authors: christine Dubreuil

### Learning outcomes

### Date
26/02/2018

-----------------------

### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
- [Preambule: Softwares to install before connecting to a distant linux server ](#preambule)
- [Practice 1: Transferring files](#practice-1)
- [Practice 2: Get Connecting](#practice-2)
- [Practice 3: First steps : prompt & pwd](#practice-3)
- [Practice 4: List the files ](#practice-4)
- [Tuto](#tuto)
- [Link](#link)


-----------------------

<a name="preambule"></a>
### Preambule

##### Getting connected to a Linux servers from Windows with SSH (Secure Shell) protocol 

| Platform | Software  | Description | url | 
| :------------- | :------------- | :------------- | :------------- |
| <img width="10%" class="img-responsive" src="{{ site.url }}/images/tpLinux/osWin.png"/>| putty | Putty allows to  connect to a Linux server from a Windows workstation.   | [Download](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)| 
| <img width="10%" class="img-responsive" src="{{ site.url }}/images/tpLinux/osWin.png"/> | mobaXterm |an enhanced terminal for Windows with an X11 server and a tabbed SSH client | [more](https://mobaxterm.mobatek.net/) |

<br />
##### Transferring and copying files from your computer to a Linux servers with SFTP (SSH File Transfer Protocol) protocol

| Platform | Software  | Description | url | 
| :------------- | :------------- | :------------- | :------------- | 
| <img width="10%" class="img-responsive" src="{{ site.url }}/images/tpLinux/osApple.png"/> <img width="10%" class="img-responsive" src="{{ site.url }}/images/tpLinux/osLinux.png"/> <img width="10%" class="img-responsive" src="{{ site.url }}/images/tpLinux/osWin.png"/>| <img width="10%" class="img-responsive" src="{{ site.url }}/images/tpLinux/filezilla.png"/> filezilla |  FTP and SFTP client  | [Download](http://filezilla.fr/telechargements/)  | 

<br />
##### Viewing and editing files on the distant server

| Type | Software  | url | 
| :------------- | :------------- | :------------- |
| consol mode |  nano | [Tutorial](http://www.howtogeek.com/howto/42980/) |  
| consol mode |  vi | [Tutorial](https://www.washington.edu/computing/unix/vi.html)  |  
| Distant graphic mode| komodo edit | [Download](https://www.activestate.com/komodo-ide/downloads/edit) | 


-----------------------

<a name="practice-1"></a>
### Practice 1 : Transferring files `sftp`

##### Download and install FileZilla

<br />
##### Open FileZilla and save the IRD cluster into the site manager

<img width="50%" class="img-responsive" src="{{ site.url }}/images/tpLinux/tp-filezilla1.png"/>

In the FileZilla menu, go to _File > Site Manager_. Then go through these 5 steps:

1. Click _New Site_.
2. Add a custom name for this site.
3. Add the hostname bioinfo-nas.ird.fr 
4. Set the Logon Type to "Normal" and insert your username and password used to connect on the IRD cluster
5. Press the "Connect" button.

<br />
##### Transferring files

<img width="50%" class="img-responsive" src="{{ site.url }}/images/tpLinux/tp-filezilla2.png"/>

1. From your computer to IRD cluster
2. From the cluster to your computer


-----------------------

<a name="practice-2"></a>
### Practice 2 : Get Connecting on a linux server by `ssh`


-----------------------

<a name="practice-3"></a>
###  Practice 3 : First steps : prompt & `pwd`

* What is the current directory just by looking the prompt?
* Check with pwd comman the name of your working directory ?

<pre><code>
[tranchant@master0 ~]$ pwd
/home/tranchant
</code></pre>


-----------------------

<a name="practice-4"></a>
### Practice 4 : List the files

* image arbo
* list the content of the directory blabla

<pre><code>
[tranchant@master0 ~]$
</code></pre>
