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
| Last Modified Date | 22/01/19 |


-----------------------

### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Preambule: Architecture of the Itrop Cluster and Softwares to install before connecting to the cluster ](#preambule)
* [How to: Transfer files with filezilla `sftp` on the Itrop cluster](#howto-1)
* [How to: Connect to the Itrop cluster via `ssh`](#howto-2)
* [How to: Reserve one or several cores of a node ](#howto-3)
* [How to: Transfer my data from the nas servers to the node ](#howto-4)
* [How to: Use the Module Environment ](#howto-5)
* [How to: Launch a job with qsub ](#howto-6)
* [How to: Choose a particular queue ](#howto-7)
* [How to: Ask for a software, an account or a project space ](#howto-8)
* [How to: See or delete your data on the /scratch partition of the nodes](#howto-9)
* [How to: Use a singularity container](#howto-10)
* [How to: Cite the Itrop platform in your publications](#howto-11)
* [Links](#links)
* [License](#license)


-----------------------

<a name="preambule"></a>
### Preambule

##### Architecture of the Itrop cluster:

The IRD Bioinformatic Cluster is composed of a pool of machines reachable through a single entry point. The connections to the internal machines are managed by a master node that tries to ensure that proper balancing is made across the available nodes at a given moment: bioinfo-master.ird.fr

The cluster is composed of:

-  1 master 
-  3 nas servers for a 105To data storage
-  25 nodes servers : 19 nodes with 12 cores, 2 nodes with 16 cores, 4 nodes with 20  cores and with RAM from 48Go to 144Go

Here is the architecture:

<img width="100%" class="img-responsive" src="{{ site.url }}/images/schema_cluster_160119.png"/>

##### Getting connected to a Linux server from Windows with SSH (Secure Shell) protocol 

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

  - bioinfo-nas2.ird.fr (nas2) to transfer  to /data/project
  - bioinfo-nas.ird.fr (nas) to transfer to /home/user, /data2/projects or /teams
  - bioinfo-nas3.ird.fr  (nas3)to transfer to /data3/project
  
<img width="50%" class="img-responsive" src="{{ site.url }}/images/transfert_cluster.png"/>

      
4. Set the Logon Type to "Normal" and insert your username and password used to connect on the IRD cluster
5. Choose port 22 and press the "Connect" button.


##### Transferring files

<img width="50%" class="img-responsive" src="{{ site.url }}/images/tpLinux/tp-filezilla2.png"/>

1. From your computer to the cluster : click and drag an text file item from the left local colum to the right remote column 
2. From the cluster to your computer : click and drag an text file item from he right remote column to the left local column




-----------------------


<a name="howto-2"></a>
### How to : Connect to the cluster via `ssh`

#### First connection:

Your password has to be changed at your first connection.

"Mot de passe UNIX (actuel)":   you are asked to type the password provided in the account creation email.

Then type your new password twice.

The session will be automatically closed.

You will need to open a new session with your new password.

#### From a windows computer:
 
In mobaXterm:
1. Click the session button, then click SSH.
* In the remote host text box, type: bioinfo-master.ird.fr
* Check the specify username box and enter your user name
2. In the console, enter the password when prompted.
Once you are successfully logged in, you will be use this console for the rest of the lecture. 

#### From a mac or a linux computer:

Open the terminal application and type the following command:

`ssh login@bioinfo-master.ird.fr`

with login: your cluster account

-----------------------

<a name="howto-3"></a>
### How to : Reserve one or several cores of a node

The cluster uses the scheduler Sun Grid Engine (S.G.E) to manage and prioritize the use jobs.

It checks the ressources availables (CPU and RAM ) and allocate them to the users to perform their analyses.

 When you are connected on bioinfo-master.ird.fr, you have the possibily to reserve one or serveral cores among them of the 25 nodes available.
 
#### Reserving one core 
 
 type the following command:

`qrsh -q bioinfo.q`

You will be randomly connected to one of the 25 nodes and one core will be reserved for you.


#### Reserving several cores at the same time 
 
 type the following command:

`qrsh -pe ompi X -q bioinfo.q`

With X the number of cores chosen between 2 to 12

You will be randomly connected to one of the 25 nodes and X cores will be reserved for you.

#### Reserving on core of a specific node:
 
 type the following command:

`qrsh -l hostname=nodeX`

With nodeX from node0 to node24

You will be randomly connected to one of the 25 nodes and X cores will be reserved for you.

-----------------------
<a name="howto-4"></a>
### How to : Transfer my data from the nas server to nodes

  On the cluster, every node has its own local partition called /scratch.
  
  **/scratch is used to receive data to  analyse, perform analyses on them and produces data results temporarly.**
  
  **It is mandatory to transfer your data to the node partition /scratch before launching any analyses.** 
  
  /scratch volume can be from 1Tb  up to 5To depending on the chosen node.
  
  Data from /scratch are temporary, they can be erases after 3 weeks without use.
  
  When your analyses are done, you can then retrieve your data.
  
  Please pay attention to the following section to determine which nas server you want to use.
  
#### the scp command:

To transfer data, we can use the scp command:

`scp -r source destination`

##### Retrieve files  from  on a  remote server:

`scp -r remote_server_name:path_to_files/file local_destination`
  
##### Copy files to a remote server:

`scp -r /local_path_to_files/file remote_server_name:remote_destination`
   
     
#### Transfer to or from /home, /data2 or /teams:

Partitions /home, /data2 and /teams are located on bioinfo-nas.ird.fr (nas)


##### Retrieve files  from  nas :

syntaxes to use: 

`scp -r nas:/home/login/file local_destination`

`scp -r nas:/data2/project/project_name/file local_destination`

`scp -r nas:/teams/team_name/file local_destination`
  
##### Copy files to nas:
 
 syntaxes to use: 

`scp -r /local_path_to_files/file nas:/home/login`

`scp -r /local_path_to_files/file nas:/data2/project/project_name`

`scp -r /local_path_to_files/file nas:/teams/team_name`
 
#### Transfer to or from  /data :

Partition /data are located on bioinfo-nas2.ird.fr (nas2)


##### Retrieve files from nas2 :


 syntaxe to use: 

`scp -r nas2:/data/project/project_name/file local_destination`

  
##### Copy files to nas2:
 
 
 syntaxe to use: 

`scp -r /local_path_to_files/file nas2:/data/project/project_name`


#### Transfer to or from  /data3 :

Partition /data3 are located on bioinfo-nas3.ird.fr (nas3)


##### Retrieve files from nas3 :


 syntaxe to use: 

`scp -r nas3:/data3/project/project_name/file local_destination`

  
##### Copy files to nas3:
 
 
 syntaxe to use: 

`scp -r /local_path_to_files/file nas3:/data3/project/project_name`


-----------------------

<a name="howto-5"></a>
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
<a name="howto-6"></a>
### How to : Launch a job with qsub
The cluster uses the scheduler Sun Grid Engine (S.G.E) to manage and prioritize the use jobs.

It checks the ressources availables (CPU and RAM ) and allocate them to the users to perform their analyses.

When you are connected on bioinfo-master.ird.fr,  You can lauch a command or a script using the command qsub.

It allows you to launch your analyses in background process on the cluster.

Then you can kill your ssh session and retrieve your analyses results later.


#### Use qsub with a command:

If you simply want to launch a command that will be executed on a node:

`qsub -b y command`

With command the command to launch

For example 

`qsub -b y hostname`

will launch the command hostname on the node choose by SGE.

The result of the command will be stored into a file in your personal home  with the following syntax:

`command_launched.oJOBID`

for example with the commande hostname, the result file will be :

`hostname.o001`

#### Use qsub with a script:

You can directly launch a script with several commands to launch into the chosen node.

##### Set SGE parameters into the script

The beginning of the script should contain the parameters to provides to SGE.

All the parameters should be written with the syntax  `#$` before.

Here are the main parameters to add at the begininig of the script:

  `#$ -j y` : to add the error in a standard output file
  `#$ -S /bin/bash` : to choose the shell bash
  `#$ -M own_email`: to receice mail from the job with `own_email`: your personal email          
  `#$ -m bea`: type of email to receive, (b) stands for begining of the job, (e) for end of the job, (a) for abortion of the script
  `#$ -q queuename.q`: to choose on which queue tou want to launch the job with `queuename.q`the name of the queu to use 
  `#$ -pe ompi X`: to reserve several cores on a node with `X`the number of core from 2 to 12
  `#$ -N jobname`: to choose a name for the job with `jobname`the chosen name.

#### examples of shell scripts:

[template for a blast script](https://southgreenplatform.github.io/trainings//files/hpc/template_job_cluster_blast.txt) 

[template for a bwa script](https://southgreenplatform.github.io/trainings//files/hpc/template_job_cluster_bwa.txt) 


#### Command to launch a job via qsub:

`qsub script.sh`

With `script.sh` the shell script to launch.

-----------------------

<a name="howto-7"></a>
### How to:  Choose a particular queue

 Depending on the type of jobs you want to launch you have the choice between several queues.
 
 Choose the convenient queue according to this scheme:
 
 <img width="50%" class="img-responsive" src="{{ site.url }}/images/queue_choice.png"/>
 
 By default, when you don't specifify a particular queue the `bioinfo.q` is used
 
 Pay attention, highmem.q has to be used for jobs that need at least 35-40GB of memory 
 
 To choose a particular queue, use the `-q` option.
 
   `qsub -q queue.q`   
   `qrsh -q queue.q`
 
 
 With `queue.q` the chosen queue.
 
 Here are the queues available:
 
 <img width="50%" class="img-responsive" src="{{ site.url }}/images/queues.png"/>
 
 The queues in green provide a priority on nodes used in the defaut common queue `bioinfo.q`
 
 The node in the red queues are not used in the commun queue `bioinfo.q`

-----------------------

<a name="howto-8"></a>
### How to : ask for a software, an account or a project space

   - Go to [https://bioinfo.ird.fr](https://bioinfo.ird.fr)
   - Use you IRD lpad login and your IRD mail password
   
#### Ask for a software:
   Choose "Platform"--> "Ask for Software Install"

#### Ask for an account:
   Choose "Platform"--> "Ask for cluster account"
    
#### Ask for a projet space:
   Choose "Platform"--> "Ask for projet"
   
 
#### Ask for a galaxy account:
   Choose "Platform"--> "Ask for galaxy account"  
   
   -----------------------



<a name="howto-9"></a>
### How to : see or delete your data contained in the /scratch partition of the nodes

   Both scripts are contained in `/opt/scripts/scratch-scripts/`
   
   - To see your data contained in the /scratch partition of the nodes: launch the following command:
        
        `sh /opt/scripts/scratch-scripts/scratch_use.sh`
        
        and follow the instructions
        
   - To delete your data contained in the /scratch partition of the nodes: launch the following command:
        
      `sh /opt/scripts/scratch-scripts/clean_scratch.sh`  
      
       and follow the instructions
        



-----------------------
<a name="howto-10"></a>
### How to : Use a singularity container

Singularity enables users to have full control of their environment. Singularity containers can be used to package entire scientific workflows, software and libraries, and even data. This means that you don’t have to ask your cluster admin to install anything for you - you can put it in a Singularity container and run.

Singularity is installed on the Itrop Cluster.

The containers are located into `/usr/local/singularity-2.4/containers`

You first need to load the environment with the command:

`module load system/singularity/2.4`
           


##### Get help:

You have the possibility to get help on every container made on the cluster using the following command 

`singularity help /usr/local/singularity-2.4/containers/container.simg` 
              
with container.simg the name of the container you want to use.              

##### Shell connection to a container:

`singularity shell /usr/local/singularity-2.4/containers/container.simg`

#####  Launch a container with only one application:

`singularity run /usr/local/singularity-2.4/containers/container.simg + arguments`

##### Launch a container with serveral applications:

`singularity exec /usr/local/singularity-2.4/containers/container.simg + tools + arguments`

##### Bind a host folder to a singularity container.

We use the option `--bind /host_partition:/container_partition`

Example:

`singularity exec --bind /scratch:/tmp /usr/local/singularity-2.4/containers/conteneur.simg + tools + arguments`


The container will have access to  the file of the partition `/scratch` of the host in its `/tmp` partition 

By default, partitions /home, /opt, /data, /data2 and /data3 are already binded. 

-----------------------
<a name="howto-11"></a>
### How to : Cite the Itrop platform in your publications

Please just copy the following sentence:

`The authors acknowledge the IRD itrop HPC (South Green Platform) at IRD montpellier for providing HPC  resources that have contributed to the research results reported within this paper.
    URL: https://bioinfo.ird.fr/- http://www.southgreen.fr` 

-----------------------

### Links
<a name="links"></a>

* Related courses : [Linux for Dummies](https://southgreenplatform.github.io/trainings/linux/)
* Related courses : [HPC](https://southgreenplatform.github.io/trainings/HPC/)
* Tutorials : [Linux Command-Line Cheat Sheet](https://southgreenplatform.github.io/trainings/linux/linuxTuto/)

-----------------------

### License
<a name="license"></a>

<div>
The resource material is licensed under the Creative Commons Attribution 4.0 International License (<a href="http://creativecommons.org/licenses/by-nc-sa/4.0/">here</a>).
<center><img width="25%" class="img-responsive" src="http://creativecommons.org.nz/wp-content/uploads/2012/05/by-nc-sa1.png"/>
</center>
</div>
                  
 
