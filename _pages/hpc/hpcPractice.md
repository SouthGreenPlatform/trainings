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
| Last Modified Date | 20/03/2019 |


-----------------------

### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Preambule: Softwares to install before connecting to a distant linux server ](#preambule)
* [Practice 1: Get connecting on a linux server by `ssh`](#practice-1)
* [Practice 2: Reserve one core of a node using qrsh and create your working folder](#practice-2)
* [Practice 3: Transfering files with filezilla `sftp`](#practice-3)
* [Practice 4: Transfering data to the node `scp`](#practice-4)
* [Practice 5: Use module environment to  load your tool](#practice-5)
* [Practice 6: Launch analyses ](#practice-6)
* [Practice 7: Transfering data to the nas servers `scp` ](#practice-7)
* [Practice 8: Deleting your temporary folder ](#practice-8)
* [Practice 9: Launch a job via qsub](#practice-9)
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
### Practice 2: Reserve one core of a node using qrsh and create your working folder


1. Type the command `qstat` and noticed the result
2. Type the command `qstat -u "*"`and noticed the difference
3. Type the command `qrsh -q formation.q` then `qstat`again
4. Type the command `qstat` and noticed what have been added
5. Create your own working folder in the /scratch of your node:
 
 `cd /scratch`
 
 `mkdir formationX`
        
 6. Type the following command with the nodeX of your choice expect the one you are already connected to      

  `ssh nodeX "ls -al /scratch"` 
  
  Tip: you can use qlogin instead of qrsh if you want to use graphical software

-----------------------


<a name="practice-3"></a>
### Practice 3 : Transferring files with filezilla `sftp`


##### Download and install FileZilla


##### Open FileZilla and save the IRD cluster into the site manager

<img width="50%" class="img-responsive" src="{{ site.url }}/images/tpLinux/tp-filezilla1.png"/>

In the FileZilla menu, go to _File > Site Manager_. Then go through these 5 steps:

1. Click _New Site_.
2. Add a custom name for this site.
3. Add the hostname bioinfo-nas.ird.fr to have access to /data2/formation
4. Set the Logon Type to "Normal" and insert your username and password used to connect on the IRD cluster
5. Press the "Connect" button.


##### Transferring files

<img width="50%" class="img-responsive" src="{{ site.url }}/images/tpLinux/tp-filezilla2.png"/>

1. From your computer to the cluster : click and drag an text file item from the left local colum to the right remote column 
2. From the cluster to your computer : click and drag an text file item from he right remote column to the left local column
3. Retrieve the file HPC_french.pdf from the right window into the folder /data/projects/formation/

-----------------------


<a name="practice-4"></a>
### Practice 4: Transfer your data from the nas server to the node


1. Using scp, transfer the folder `TPassembly` located in `/data2/formation` into your working directory
2. Check your result with ls
 


-----------------------
<a name="practice-5"></a>
### Practice 5: Use module environment to  load your tools


1. Load ea-utils V2.7 module
2. Check if the tool are loaded
 


-----------------------

<a name="practice-6"></a>
###  Practice 6 : Launch analyses

#### Get stats on fastq   

1. Go into  the folder `TPassembly/Ebola`
2. Launch the command `fastq-stats ebola1.fastq`
3. Launch the command `fastq-stats -D ebola1.fastq`

#### Perform an assembly with abyss-pe

With abyss software, we reassembly the sequences using the 2 fastq files ebola1.fastq and ebola2.fastq

Launch the commands

`module load bioinfo/abyss/1.9.0`

`qsub -q formation.q -l hostname=nodeX -cwd -b y abyss-pe k=35 in=\'ebola1.fastq ebola2.fastq\' name=k35 -N jobname`



-----------------------
<a name="practice-7"></a>
### Practice 7: Transfering data to the nas server


1. Using scp, transfer your results from your `/scratch/formationX` to your `/home/login` 
2. Check if the transfer is OK with ls
 




-----------------------
<a name="practice-8"></a>
### Practice 8: Deleting your temporary folder

`cd /scratch`

`rm -r formationX`

`exit`

 -----------------------
<a name="practice-9"></a>
### Practice 9: Launch a job with qsub

We are  going to launch a 4 steps analysis:

1) Perform a multiple alignment with the nucmer  tool

2) Filter these alignments with the delta-filter  tool

3) Generate a tab file easy to parse the with show-coords tools

4) Generate a png image with mummerplot


- Retrieve the script /data2/formation/script/alignment.sh into your /home/formation

- launch the script with qsub:

`qsub -q formation.q alignment.sh`

- Do a `ls -altr` in your `/home/formationX`. What do you notice?

- Launch the following command to obtain info on the finished job:

`qacct -j JOB_ID`

- Open filezilla and retrieve the png image to your computer

- Launch the following commande to clear the /scratch of the node

`ssh nodeX rm -r /scratch/formationX*`

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
                  
 
