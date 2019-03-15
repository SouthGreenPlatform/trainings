---
layout: page
title: "HPC Practice"
permalink: /hpc/hpcPractice/
tags: [ linux, HPC, cluster, module load ]
description: HPC Practice page
---

| Description | Hands On Lab Exercises for HPC |
| :------------- | :------------- | :------------- | :------------- |
| Related-course materials | [HPC](https://southgreenplatform.github.io/trainings/HPC/) |
| Authors | Ndomassi TANDO (ndomassi.tando@ird.fr)  |
| Creation Date | 14/03/2018 |
| Last Modified Date | 15/03/2019 |


-----------------------

### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Preambule: Softwares to install before connecting to a distant linux server ](#preambule)
* [Practice 1: Get connecting on a linux server by `ssh`](#practice-1)
* [Practice 2: Transfering files with filezilla `sftp`](#practice-2)
* [Practice 3: Launch a bwa analysis interactively ](#practice-3)
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
| Distant, consol mode |  nano | [Tutorial](http://www.howtogeek.com/howto/42980/) |  
| Distant, consol mode |  vi | [Tutorial](https://www.washington.edu/computing/unix/vi.html)  |  
| Distant, graphic mode| komodo edit | [Download](https://www.activestate.com/komodo-ide/downloads/edit) | 
| Linux & windows based editor | Notepad++ | [Download](https://notepad-plus-plus.org/download/v7.5.5.html) | 

-----------------------


<a name="practice-1"></a>
### Practice 1: Get Connecting on a linux server by `ssh`

In mobaXterm:
1. Click the session button, then click SSH.
* In the remote host text box, type: bioinfo-master.ird.fr
* Check the specify username box and enter your user name
2. In the console, enter the password when prompted.
Once you are successfully logged in, you will be use this console for the rest of the lecture. 
3. Type the command `qhost` and comment the result
4. type the command `qhost -q` and noticed what have been added




-----------------------


<a name="practice-2"></a>
### Practice 2 : Transferring files with filezilla `sftp`


##### Download and install FileZilla


##### Open FileZilla and save the IRD cluster into the site manager

<img width="50%" class="img-responsive" src="{{ site.url }}/images/tpLinux/tp-filezilla1.png"/>

In the FileZilla menu, go to _File > Site Manager_. Then go through these 5 steps:

1. Click _New Site_.
2. Add a custom name for this site.
3. Add the hostname bioinfo-nas.ird.fr to have access to /data2/project/
4. Set the Logon Type to "Normal" and insert your username and password used to connect on the IRD cluster
5. Press the "Connect" button.


##### Transferring files

<img width="50%" class="img-responsive" src="{{ site.url }}/images/tpLinux/tp-filezilla2.png"/>

1. From your computer to the cluster : click and drag an text file item from the left local colum to the right remote column 
2. From the cluster to your computer : click and drag an text file item from he right remote column to the left local column

Retrieve the file HPC_french.pdf from the right window into the folder /data/projects/formation/


-----------------------

<a name="practice-3"></a>
###  Practice 3 : Launch a bwa analysis interactively 

* Reserve a processor from a node with qrsh (if needed)
* Create your result folder and copy the /data/projects/training_2018/bwa folder with scp command

{% highlight bash %} 
# create your result directory
mkdir /scratch/login-bwa

# Copy the folder from nas2
scp -r nas2:/data/projects/training_2018/bwa /scratch/login-bwa
{% endhighlight %}

* Load the version 0.7.12 of bwa
{% highlight bash %} 
# load bwa-0.7.12
module load bioinfo/bwa/0.7.12
{% endhighlight %}

* Launch your bwa analysis with the following commands
{% highlight bash %} 
# Go into the  /scratch/login-bwa folder
cd /scratch/login-bwa
# Index the reference
bwa index referenceIrigin.fasta
# create the mapping file
bwa mem referenceIrigin.fasta irigin1_1.fastq irigin1-2.fastq >mapping.sam
{% endhighlight %}

* Retrieve mapping.sam into your home
{% highlight bash %} 
scp /scratch/login-bwa/mapping.sam nas:/home/login
{% endhighlight %}

* Delete the /scratch/login-sam folder
{% highlight bash %} 
cd /scratch
rm -rf login-bwa

{% endhighlight %}

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
                  
 
