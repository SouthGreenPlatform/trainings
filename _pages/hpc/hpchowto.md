---
layout: page
title: "HPC Howto"
permalink: /hpc/hpcHowto/
tags: [ linux, HPC, cluster, module load ]
description: HPC Howto page
---

| Description | HowTos for HPC cluster itrop |
| :------------- | :------------- | :------------- | :------------- |
| Related-course materials | [HPC](https://southgreenplatform.github.io/trainings/HPC/) |
| Authors | Ndomassi TANDO (ndomassi.tando@ird.fr)  |
| Creation Date | 11/06/2018 |
| Last Modified Date | 11/06/2018 |


-----------------------

### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Preambule: Softwares to install before connecting to a distant linux server ](#preambule)
* [How to: Transfer files with filezilla `sftp` on the Itrop cluster](#howto-1)
* [How to: Connect to a linux server via `ssh`](#howto-2)
* [How to: Use the Module Environment ](#howto-3)
* [How to: Ask for a software, an account or a project space ](#howto-4)
* [Links](#links)
* [License](#license)


-----------------------

<a name="preambule"></a>
### Preambule


##### Getting connected to a Linux servers from Windows with SSH (Secure Shell) protocol 

| Platform | Software  | Description | url | 
| :------------- | :------------- | :------------- | :------------- |
| <img width="10%" class="img-responsive" src="{{ site.url }}/images/tpLinux/osWin.png"/> | mobaXterm |an enhanced terminal for Windows with an X11 server and a tabbed SSH client | [more](https://mobaxterm.mobatek.net/) |
| <img width="10%" class="img-responsive" src="{{ site.url }}/images/tpLinux/osWin.png"/>| putty | Putty allows to  connect to a Linux server from a Windows workstation.   | [Download](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)| 



##### Transferring and copying files from your computer to a Linux servers with SFTP (SSH File Transfer Protocol) protocol

| Platform | Software  | Description | url | 
| :------------- | :------------- | :------------- | :------------- | 
| <img width="10%" class="img-responsive" src="{{ site.url }}/images/tpLinux/osApple.png"/> <img width="10%" class="img-responsive" src="{{ site.url }}/images/tpLinux/osLinux.png"/> <img width="10%" class="img-responsive" src="{{ site.url }}/images/tpLinux/osWin.png"/>| <img width="10%" class="img-responsive" src="{{ site.url }}/images/tpLinux/filezilla.png"/> filezilla |  FTP and SFTP client  | [Download](http://filezilla.fr/telechargements/)  | 


##### Viewing and editing files on your computer before transferring on the linux server or directly on the distant server

| Type | Software  | url | 
| :------------- | :------------- | :------------- |
| Distant, console mode |  nano | [Tutorial](http://www.howtogeek.com/howto/42980/) |  
| Distant, console mode |  vi | [Tutorial](https://www.washington.edu/computing/unix/vi.html)  |  
| Distant, graphic mode| komodo edit | [Download](https://www.activestate.com/komodo-ide/downloads/edit) | 
| Linux & windows based editor | Notepad++ | [Download](https://notepad-plus-plus.org/download/v7.5.5.html) | 

-----------------------


<a name="howto-1"></a>
### How to : Transfer files with filezilla `sftp` on the Itrop cluster


##### Download and install FileZilla


##### Open FileZilla and save the IRD cluster into the site manager

<img width="50%" class="img-responsive" src="{{ site.url }}/images/tpLinux/tp-filezilla1.png"/>

In the FileZilla menu, go to _File > Site Manager_. Then go through these 5 steps:

1. Click _New Site_.
2. Add a custom name for this site.
3. You have 3 possible choices:
    - bioinfo-nas2.ird.fr to transfer  to /data/project
    - bioinfo-nas.ird.fr to transfer to /home/user, /data2/projects or /teams
    - bioinfo-nas3.ird.fr to transfer to /data3/project
4. Set the Logon Type to "Normal" and insert your username and password used to connect on the IRD cluster
5. Press the "Connect" button.


##### Transferring files

<img width="50%" class="img-responsive" src="{{ site.url }}/images/tpLinux/tp-filezilla2.png"/>

1. From your computer to the cluster : click and drag an text file item from the left local colum to the right remote column 
2. From the cluster to your computer : click and drag an text file item from he right remote column to the left local column




-----------------------


<a name="howto-2"></a>
### How to : Connect a linux server via `ssh`

In mobaXterm:
1. Click the session button, then click SSH.
* In the remote host text box, type: bioinfo-master.ird.fr
* Check the specify username box and enter your user name
2. In the console, enter the password when prompted.
Once you are successfully logged in, you will be use this console for the rest of the lecture. 

-----------------------

<a name="howto-3"></a>
###  How to : Use the module Environnement 

Module Environment allows you to dynamically change your environment variable(PATH, LD_LIBRARY_PATH) and then choose your version software.
The nomenclature use for modules is <package_name>/<package_version>.
Software are divided in 2 groups:
    - bioinfo: list all the bioinformatics softwares
    - system: list all the system softwares such as python, perl etc...

#### Display the available softwares

`module avail`

#### Display the description of a particular software

`module whatis module_type/module_name/version`

with module_type: bioinfo or system
with module_name: the name of the module.

For example : for the version 1.7 of the bioinformatic software samtools:

`module whatis bioinfo/samtools/1.7`

#### Load a particular software version

`module load module_type/module_name/version`

with module_type: bioinfo or system
with module_name: the name of the module.

For example : for the version 1.7 of the bioinformatic software samtools:

`module load bioinfo/samtools/1.7`

#### Unload a particular software version

`module unload module_type/module_name/version`

with module_type: bioinfo or system
with module_name: the name of the module.

For example : for the version 1.7 of the bioinformatic software samtools:

`module unload bioinfo/samtools/1.7`

#### Display all the modules loaded

`module list`

#### unload all the modules loaded

`module unload`

-----------------------

<a name="howto-4"></a>
### How to : ask for a software, an account or a project space

    *Go to [https://bioinfo.ird.fr](https://bioinfo.ird.fr)
    *Use you IRD lpad login and your IRD mail password
#### Ask for a software:
    Choose "Platform"--> "Ask for Software Install"

#### Ask for an account:
    Choose "Platform"--> "Ask for cluster account"
    
#### Ask for a projet space:
    Choose "Platform"--> "Ask for projet"

-----------------------

### Links
<a name="links"></a>

* Related courses : [Linux for Dummies](https://southgreenplatform.github.io/trainings/linux/)
* Tutorials : [Linux Command-Line Cheat Sheet](https://southgreenplatform.github.io/trainings/linux/linuxTuto/)

-----------------------

### License
<a name="license"></a>

<div>
The resource material is licensed under the Creative Commons Attribution 4.0 International License (<a href="http://creativecommons.org/licenses/by-nc-sa/4.0/">here</a>).
<center><img width="25%" class="img-responsive" src="http://creativecommons.org.nz/wp-content/uploads/2012/05/by-nc-sa1.png"/>
</center>
</div>
                  
 
