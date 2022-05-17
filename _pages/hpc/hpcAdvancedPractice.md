---
layout: page
title: "Advanced HPC Practice"
permalink: /hpc/hpcAdvancedPractice/
tags: [ linux, HPC, cluster, module load ]
description: Advanced HPC Practice page
---

| Description | Hands On Lab Exercises for HPC |
| :------------- | :------------- | :------------- | :------------- |
| Related-course materials | [AdvancedHPC](https://southgreenplatform.github.io/trainings/Advanced_HPC/) |
| Authors | Ndomassi TANDO (ndomassi.tando@ird.fr)  |
| Creation Date |10/05/2019 |
| Last Modified Date | 17/05/2022 |


-----------------------

### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Practice 1: Install you own packages](#practice-1)
* [Practice 2: Create a module environment](#practice-2)
* [Practice 3:  Launch a job array ](#practice-3)
* [Practice 4: Install Singularity](#practice-4)
* [Practice 5: Create your own Singularity container ](#practice-5)
* [Practice 6: Use your own Singularity container with sbatch ](#practice-6)
* [Links](#links)
* [License](#license)


-----------------------

<a name="practice-1"></a>
### Practice 1: Install your own packages

1) Prepare your work environment

Create 3 folders:

  - ~/sources
  - ~/softs
  - ~/results

2)  Install bwa

Go to the  [download page of bwa](https://github.com/lh3/bwa/releases)

Download the 0.7.17 version in your ~/sources folder using `wget`

Read the instructions in the archive and install it into  ~/softs/bwa-0.7.17 folder

Configure your .bashrc to use your version by default with adding the following line to  your  .bashrc:

`export PATH=~/softs/bwa-0.7.17/:$PATH`

`source ~/.bashrc`

Test your installation with  the command:

`which bwa`


3)  Install samtools

Go to the  [download page of samtools](http://www.htslib.org/download/)

Download the 1.15 version in your ~/sources folder

Read the instruction in the archive and install it into  ~/softs/samtools-1.15 folder

Configure your .bashrc to use your version by default  with adding the following line to  your  .bashrc:

`export PATH=~/softs/samtools-1.15/bin:$PATH`

`source ~/.bashrc`

Test your installation with  the command:

`which samtools`

-----------------------


<a name="practice-2"></a>
### Practice 2: Create a module environment

1) Prepare your work environment

Create the folder `~/privatemodules`

Modify your .basrc with the  following:

`module use --append $HOME/privatemodules`

Place it after the if loop.

Comment the following lines:

`export PATH=~/softs/bwa-0.7.17/:$PATH`

`export PATH=~/softs/samtools-1.15/bin:$PATH`

Retrieve the following  modulefile as example and modify  it to your needs: `/data2/formation/TP-advanced-hpc/modulefile-blast-2.4.0+`


 2) Create a modulefile for bwa 0.7.17
 
 Create a folder  `~/privatemodules/bwa`
 
 Into that folder create a modulefile `0.7.17` 
 
 Don't forget the conflict line
 
 3) Create a modulefile for samtools-1.15

 Create a folder  `~/privatemodules/samtools`
 
 Into that folder create a modulefile `1.15` 
 
  Don't forget the conflict line
 
 
 4) Check that you can see your modulefiles with `module avail`
 
 They will appear under a new session `/home/<your_login>/privatemodules`
 
 5) Load your modules and test them with the commands:
 
 {% highlight bash %} $ whereis bwa
 
 $ whereis samtools{% endhighlight %}
 
 6) Try  to load the following softwares and notice what happen:
 
 {% highlight bash %} $ module load bwa/0.7.17
 
 $ module load samtools/1.15{% endhighlight %} 

-----------------------


<a name="practice-3"></a>
### Practice 3 :  Launch a job array

A job array allows you to launch several computations at the same time in one script.

You can imagine launch up to 10000 jobs as the same time.

That is why is very important to launch your job array with `%5` to launch it with 5 running jobs at the same time maximum.

In this exercise, we are going to launch a bwa mem on 15 different individuals in one job array script on several nodes at the same time.

At the end, we will receive 15 results files directly into our /home.

1) Have a look of the data you are going to use in `/data2/formation/TP-advanced-hpc/bwa/fastqDir`

The 2 pairs of read files for individual X are named as follow: `CloneX.1.fastq` and `CloneX.2.fastq`

With `X` for 1 to 15. `X` will be replaced in our script by `SLURM_ARRAY_TASK_ID`

2) Using a job array create a script to perform a bwa-mem on the 15 individuals

You can use the template script here: `/data2/formation/TP-advanced-hpc/exemple-batch.sh`

The script should transfer the  `/data2/formation/TP-advanced-hpc/bwa/` folder into the `/scratch` of the node.

The command to use for the transfer is:

{% highlight bash %}scp -r nas:/data2/formation/TP-advanced-hpc/bwa  /scratch/your_directory{% endhighlight %}

Use your own module environment for bwa


The command to launch on every individual is

  {% highlight bash %}bwa mem bwa/reference.fasta bwa/fastqDir/CloneX.1.fastq bwa/fastqDir/CloneX.2.fastq > bwa/results/mapping-X.sam{% endhighlight %}



 


-----------------------
<a name="practice-4"></a>
### Practice 4: Install Singularity

#### Install dependencies:

With `apt get`

{% highlight bash %}$ sudo apt-get update && sudo apt-get install -y \

 build-essential \
         
 libssl-dev \
         
 uuid-dev \
         
 libgpgme11-dev \
         
 squashfs-tools \
         
 libseccomp-dev \
 
 git \
         
 pkg-config{% endhighlight %}


 With `yum`

 {% highlight bash %}$ sudo yum update -y && \
      sudo yum groupinstall -y 'Development Tools' && \
      sudo yum install -y \
      openssl-devel \
      libuuid-devel \
      libseccomp-devel \
      wget \
      squashfs-tools \
      git{% endhighlight %}

#### Install The programming  language `Go`:

Go to the [Download Page](https://golang.org/dl/) and choose the archive go.1.18.1linux-amd64.tar.gz

Launch the following commands:

  {% highlight bash %}export VERSION=1.17.2 OS=linux ARCH=amd64 
  wget https://dl.google.com/go/go$VERSION.$OS-$ARCH.tar.gz 
  sudo tar -C /usr/local -xzvf go$VERSION.$OS-$ARCH.tar.gz 
  rm go$VERSION.$OS-$ARCH.tar.gz    {% endhighlight %}

Set up your environment for Go with  the following commands:

  {% highlight bash %}echo 'export PATH=/usr/local/go/bin:$PATH' >> ~/.bashrc
  source ~/.bashrc{% endhighlight %}


    
#### Download and install singularity from repo:

Launch the following command to install singularity
     
   {% highlight bash %}# move to the singularity folder
     cd /usr/local
     wget https://github.com/sylabs/singularity/releases/download/v3.8.0/singularity-ce-3.8.0.tar.gz
     tar xvfz singularity-ce-3.8.0.tar.gz
     cd singularity-ce-3.8.0
     # launch the mconfig command ( you can add the option --prefix=path to custom the installation directory)
     ./mconfig
     # Compile into the build directory
     make -C ./builddir
     # Install the binaries into /usr/local/bin by default as superuser
     sudo make -C ./builddir install{% endhighlight %} 
 
Type the following command to  your `.bashrc` file to enable completion in singularity:
 
   {% highlight bash %}. /usr/local/etc/bash_completion.d/singularity
    # resource your .bashrc
    source ~/.bashrc{% endhighlight %}
    
     
     

-----------------------

<a name="practice-5"></a>
###  Practice 5 : Create your own Singularity container 

In your home user, create 2 folders:

- `def`to host your singularity definition files
- `containers`to host your containers

{% highlight bash %}mkdir ~/def

mkdir ~/containers{% endhighlight %}

1) Create a recipe file:

A Singularity Recipe includes specifics about installation software, environment variables, files to add, and container metadata.

Retrieve the singularity.def file `/data2/formation/TP-advanced-hpc/singularity.def`

Modify it to create a recipe file for bwa 0.7.17 named `bwa-0.7.17.def`

2) On your own PC, Build  your singularity image from your recipe file as superuser

{% highlight bash %} sudo singularity build bwa-0.7.17.simg bwa-0.7.17.def {% endhighlight %}

It will produce a singularity image called bwa-0.7.17.simg

3) Test your container

{% highlight bash %} singularity run bwa-0.7.17.simg {% endhighlight %}


4) Transfer your container from your PC to bioinfo-nas.ird.fr into your  `/home` using `filezilla` or scp 

{% highlight bash %} scp bwa-0.7.17.simg  formationX@bioinfo-nas.ird.fr:~{% endhighlight %}
 
 Then , connect to bioinfo-master.ird.fr and run the following commands:

{% highlight bash %} srun -p short --pty bash -i

cd /scratch

mkdir formationX

cd formationX

scp -r nas:/data2/formation/TP-advanced-hpc/bwa .

scp  ~/bwa-0.7.17.simg .

module load system/singularity/3.6.0

mkdir bwa/results

singularity run ~/bwa-0.7.17.simg mem bwa/reference.fasta bwa/fastqDir/Clone1.1.fastq bwa/fastqDir/Clone1.2.fastq > bwa/results/mapping-1.sam

{% endhighlight %}

Check if you get a mapping-1.sam file then erase your folder and go back to master0

{% highlight bash %} cd 

rm -rf /scratch/formationX

exit
{% endhighlight %}


<a name="practice-6"></a>
###  Practice 6 : Use your own Singularity container  with sbatch


- On the cluster, create a modulefile called 0.7.17-singu to use bwa-0.7.17.simg as a module

You have to add `module load system/singularity/3.6.0` in your modulefile and point to the location of your container

- Create a folder `~/results2`
 
- Copy your script made in practice3 and modify it to use your singularity modulefile of 0.7.17-singu, place your results into `~/results2`


      
-----------------------

### Links
<a name="links"></a>

* Related courses : [HPC Trainings](https://southgreenplatform.github.io/trainings/HPC/)
* Tutorials : [How tos](https://southgreenplatform.github.io/trainings/HPC/hpcHowto/)

-----------------------

### License
<a name="license"></a>

<div>
The resource material is licensed under the Creative Commons Attribution 4.0 International License (<a href="http://creativecommons.org/licenses/by-nc-sa/4.0/">here</a>).
<center><img width="25%" class="img-responsive" src="http://creativecommons.org.nz/wp-content/uploads/2012/05/by-nc-sa1.png"/>
</center>
</div>
                  
 
