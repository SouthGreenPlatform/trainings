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
| Last Modified Date | 14/05/2019 |


-----------------------

### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Practice 1: Install you own packages](#practice-1)
* [Practice 2: Create a module environment](#practice-2)
* [Practice 3:  Launch a job array ](#practice-3)
* [Practice 4: Install Singularity](#practice-4)
* [Practice 5: Create your own Singularity container ](#practice-5)
* [Links](#links)
* [License](#license)


-----------------------

<a name="practice-1"></a>
### Practice 1: Install your own packages

1) Prepare your work environment

Create 2 folders:

  - ~/sources
  - ~/softs

2)  Install bwa

Go to the  [download page of bwa](https://github.com/lh3/bwa/releases)

Download the 0.7.17 version in your ~/sources folder using `wget`

Read the instructions in the archive and install it into  ~/softs/bwa-0.7.17 folder

Configure your .basrc to use your version by default with adding the following line to  your  .bashrc:

`export PATH=~/softs/bwa-0.7.17/:$PATH`

`source ~/.bashrc`

Test your installation with  the command:

`which bwa`


3)  Install samtools

Go to the  [download page of samtools](http://www.htslib.org/download/)

Download the 1.9 version in your ~/sources folder

Read the instruction in the archive and install it into  ~/softs/samtools-1.9 folder

Configure your .basrc to use your version by default  with adding the following line to  your  .bashrc:

`export PATH=~/softs/samtools-1.9/bin:$PATH`

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

`export PATH=~/softs/samtools-1.9/bin:$PATH`

Retrieve the following  modulefile as example and modify  it to your needs: `/data2/formation/TP-advanced-hpc/modulefile-blast-2.4.0+`


 2) Create a modulefile for bwa 0.7.17
 
 Create a folder  `~/privatemodules/bwa`
 
 Into that folder create a modulefile `0.7.17` 
 
 Don't forget the conflict line
 
 3) Create a modulefile for samtools-1.9

 Create a folder  `~/privatemodules/samtools`
 
 Into that folder create a modulefile `1.9` 
 
  Don't forget the conflict line
 
 
 4) Check that you can see your modulefiles with `module avail`
 
 5) Load your modules and test them with the commands:
 
 {% highlight bash %} $ whereis bwa
 
 $ whereis samtools{% endhighlight %}
 
 6) Try  to load the following softwares and notice what happen:
 
 {% highlight bash %} $ module load bwa/0.7.17
 
 $ module load samtools/1.9{% endhighlight %} 

-----------------------


<a name="practice-3"></a>
### Practice 3 :  Launch a job array

A job array allows you to launch several computations at the same time in one script.

You can imagine launch up to 10000 jobs as the same time.

That is why is very important to launch your job array on one node only to avoid reserving all the cores of the cluster.

In this exercise, we are going to launch a bwa mem on 15 different individuals in one job array script on one node at the same time.

At the end, we will receive 15 results files directly in our /home.

1) Have a look of the data your going to use in `/data2/formation/TP-advanced-hpc/bwa/fastqDir`

The 2 pairs of  individuals are named such as: `CloneX_1.fastq_1` and `CloneX_2.fastq_2`

With `X` for 1 to 15. `X` will be/data2/formation/TP-advanced-hpc/bwa/ replaced in our script by `SGE_TASK_ID`

2) Using a job array create a script to perform a bwa-mem on the 15 individuals

The script should transfer the `/data2/formation/TP-advanced-hpc/bwa/` folder in the `/scratch` of the node.

Use your own module environment for bwa

The command to launch on every individual is

  {% highlight bash %}bwa mem bwa/reference.fasta bwa/fastqDir/CloneX-1.fastq bwa/fastqDir/CloneX-2.fastq > bwa/results/mapping-X.sam{% endhighlight %}



 


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
         
 pkg-config{% endhighlight %}


 With `yum`

 {% highlight bash %}$ sudo yum update -y && \
      sudo yum groupinstall -y 'Development Tools' && \
      sudo yum install -y \
      openssl-devel \
      libuuid-devel \
      libseccomp-devel \
      wget \
      squashfs-tools{% endhighlight %}

#### Install The programming  language `Go`:

Go to the [Download Page](https://golang.org/dl/) and choose the archive go.1.12.5.linux-amd64.tar.gz

Launch the following commands:

  {% highlight bash %}# Download the archive
    wget https://dl.google.com/go/go1.12.5.linux-amd64.tar.gz
    # Extract the archive into /usr/local
    sudo tar -C /usr/local -xzvf go1.12.5.linux-amd64.tar.gz{% endhighlight %}

Set up your environment for Go with  the following commands:

  {% highlight bash %}# Create the GOPATH variable into .bashrc
    echo 'export GOPATH=${HOME}/go' >> ~/.bashrc
    # Set the PATH with Go
    echo 'export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin' >> ~/.bashrc
    # Resource your environment to take the modifications into account
    echo 'export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin' >> ~/.bashrc{% endhighlight %}

For Singularity > v3.0.0, we also need to install `dep` for dependency resolution

  {% highlight bash %}echo 'export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin' >> ~/.bashrc{% endhighlight %}
    
#### Download and install singularity from repo:

To ensure that the Singularity source code is downloaded to the appropriate directory use these commands.

   {% highlight bash %}go get -d github.com/sylabs/singularity{% endhighlight %}

You will obtain a warning but it will still download Singularity source code to the appropriate directory within the `$GOPATH`
     
   {% highlight bash %}# move to the singularity folder
     cd /go/src/github.com/syslabs/singularity/ 
     # launch the mconfig command ( you can add the option --prefix=path to custom the installation directory)
     ./mconfig
     # Compile into the build directory
     make -C ./buildir
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

2) Build  your singularity image from your recipe file

{% highlight bash %} singularity build bwa-0.7.17.simg bwa-0.7.17.def {% endhighlight %}

It will produce a singularity image called bwa-0.7.17.simg

3) Test your container

{% highlight bash %} singularity exec bwa-0.7.17.simg bwa  exec --help{% endhighlight %}


4) Transfer your container to the cluster into your  `/home` and run it 

{% highlight bash %} qrsh -q formation.q

cd /scratch

mkdir formationX

cd formationX

scp -r /data2/formation/TP-advanced-hpc/bwa .

scp  ~/bwa-0.7.17.simg .

module load system/singularity/2.4.2

mkdir bwa/results

singularity exec bwa-0.7.17.simg bwa mem bwa/reference.fasta bwa/fastqDir/Clone1-1.fastq bwa/fastqDir/Clone2-2.fastq > bwa/results/mapping-1.sam

{% endhighlight %}







      
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
                  
 
