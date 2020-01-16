---
layout: page
title: "HPC Slurm Practice"
permalink: /hpc/hpcSlurmPractice/
tags: [ linux, HPC, cluster, module load ]
description: HPC Practice page
---

| Description | Hands On Lab Exercises for HPC |
| :------------- | :------------- | :------------- | :------------- |
| Related-course materials | [HPC](https://southgreenplatform.github.io/trainings/HPC/) |
| Authors | Ndomassi TANDO (ndomassi.tando@ird.fr)  |
| Creation Date | 25/11/2019 |
| Last Modified Date | 15/01/2020 |


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
* [Practice 9: Launch a job via sbatch](#practice-9)
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
| <img width="10%" class="img-responsive" src="{{ site.url }}/images/tpLinux/osApple.png"/> <img width="10%" class="img-responsive" src="{{ site.url }}/images/tpLinux/osLinux.png"/> <img width="10%" class="img-responsive" src="{{ site.url }}/images/tpLinux/osWin.png"/>| <img width="10%" class="img-responsive" src="{{ site.url }}/images/tpLinux/filezilla.png"/> filezilla |  FTP and SFTP client  | [Download](https://filezilla-project.org/)  | 


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
3. Type the command `sinfo` and comment the result
4. type the command `sinfo -N` and noticed what have been added

-----------------------


<a name="practice-2"></a>
### Practice 2: Reserve one core of a node using srun and create your working folder


1. Type the command `squeue` and noticed the result
2. Type the command `squeue -u your_login` with your_login to change with your  account and noticed the difference
3. More details with the command: `squeue -O "username,name:40,partition,nodelist,cpus-per-task,state,timeused,timelimit"`
4. Type the command `srun -p short --time=01:00 --pty bash -i ` then `squeue` again 
5. Create your own working folder in the /scratch of your node:
 
 {% highlight bash %}cd /scratch
 mkdir login
 with login : the name of your choice{% endhighlight %}
        
6. Type the following command with the nodeX of your choice expect the one you are already connected to      

  {% highlight bash %}ssh nodeX "ls -al /scratch/"{% endhighlight %}
  


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


1. Using scp, transfer the folder `TPassembly` located in `/data2/formation/Slurm` into your working directory
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

{% highlight bash %}module load bioinfo/abyss/1.9.0{% endhighlight %}

{% highlight bash %}abyss-pe k=35 in='ebola1.fastq ebola2.fastq' name=k35{% endhighlight %}

NB: you can do the same thing using srun directly from the master assuming that the data have been transfer to the /scratch of your node and that you know the nodename:

From the master, type the following commands:

{% highlight bash %}
module load bioinfo/abyss/1.9.0
srun -p partitionname --nodelist=nodename --chdir=/scratch/login/TPassembly/Ebola abyss-pe k=35 -j1 np=1  in='ebola1.fastq ebola2.fastq' name=k35{% endhighlight %}

the -p allows to indicate the partition to use , replace `partitionname`parameter 
the --nodelist allows to indicate the node to use , replace `nodename`parameter 
the `--chdir` allows to change the working directory and to precise in which directory the analysis will be done directly into the node.

-----------------------
<a name="practice-7"></a>
### Practice 7: Transfering data to the nas server


1. Using scp, transfer your results from your `/scratch/login` to your `/home/login` 
2. Check if the transfer is OK with ls
 




-----------------------
<a name="practice-8"></a>
### Practice 8: Deleting your temporary folder

{% highlight bash %} cd /scratch
rm -r login{% endhighlight %}

{% highlight bash %}exit{% endhighlight %}

 -----------------------
<a name="practice-9"></a>
### Practice 9: Launch a job with sbatch


Following the several steps performed during the practice, create a script to launch the analyses made in practice6:

1er step: create the Slurm section in your script 

1) Set  a name for your job

2) Precise your email

3) Choose the short parttion

2nd step: type  the commands you want the script to launch:

1) create a personal folder in /scratch with `mkdir`

2) Using scp, transfer the folder `TPassembly` located in `/data2/formation` into your working directory

3) Launch abyss version 1.9.0 with module load

4) Into the the folder `TPassembly/Ebola`, lanch the following command:

{% highlight bash %}abyss-pe k=35 in='ebola1.fastq ebola2.fastq' name=k35{% endhighlight %}

5) Using scp, transfer your results from your `/scratch/login` to your `/home/login` 


6) Delete the personal folder in the  `/scratch`


Launch the following commands to obtain info on the finished job:

{% highlight bash %}seff <JOB_ID>
sacct --format=JobID,elapsed,ncpus,ntasks,state,node -j <JOB_ID>{% endhighlight %}


Bonus:
-------

We are  going to launch a 4 steps analysis:

1) Perform a multiple alignment with the nucmer  tool

2) Filter these alignments with the delta-filter  tool

3) Generate a tab file easy to parse the with show-coords tools

4) Generate a png image with mummerplot


- Retrieve the script /data2/formation/Slurm/scripts/alignment_slurm.sh into your /home/login

- modify the Slurm section and the variables

- launch the script with sbatch:

{% highlight bash %} sbatch alignment.sh{% endhighlight %}

- Do a `ls -altr` in your `/home/login`. What do you notice?

- Launch the following commands to obtain info on the finished job:

{% highlight bash %}seff <JOB_ID>
sacct --format=JobID,elapsed,ncpus,ntasks,state,node -j <JOB_ID>{% endhighlight %}

- Open filezilla and retrieve the png image to your computer

- Launch the following commande to clear the /scratch of the node

{% highlight bash %}sh /opt/scripts/scratch-scripts/scratch_use.sh{% endhighlight %}

and choose the number of the node used

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
                  
 
