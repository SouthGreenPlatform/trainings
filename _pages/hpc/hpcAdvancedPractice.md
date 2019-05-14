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
* [Practice 4: Retrieve a Singularity container](#practice-4)
* [Practice 5: Install Singularity](#practice-5)
* [Practice 6: Create your own Singularity container ](#practice-6)
* [Links](#links)
* [License](#license)


-----------------------

<a name="practice-1"></a>
### Practice 1: Install your own packages


-----------------------


<a name="practice-2"></a>
### Practice 2: Create a module environment



-----------------------


<a name="practice-3"></a>
### Practice 3 :  Launch a job array



-----------------------


<a name="practice-4"></a>
### Practice 4: Retrieve a Singularity container



 


-----------------------
<a name="practice-5"></a>
### Practice 5: Install Singularity

#### Install dependencies:

With `apt get`

      $ sudo apt-get update && sudo apt-get install -y \
         build-essential \
         libssl-dev \
         uuid-dev \
         libgpgme11-dev \
         squashfs-tools \
         libseccomp-dev \
         pkg-config


 With `yum`

    $ sudo yum update -y && \
      sudo yum groupinstall -y 'Development Tools' && \
      sudo yum install -y \
      openssl-devel \
      libuuid-devel \
      libseccomp-devel \
      wget \
      squashfs-tools

#### Install The programming  language `Go`:

Go to the [Download Page](https://golang.org/dl/) and choose the archive go.1.12.5.linux-amd64.tar.gz

Launch the following commands:

    # Download the archive
    wget https://dl.google.com/go/go1.12.5.linux-amd64.tar.gz
    # Extract the archive into /usr/local
    sudo tar -C /usr/local -xzvf go1.12.5.linux-amd64.tar.gz

Set up your environment for Go with  the following commands:

    # Create the GOPATH variable into .bashrc
    echo 'export GOPATH=${HOME}/go' >> ~/.bashrc
    # Set the PATH with Go
    echo 'export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin' >> ~/.bashrc
    # Resource your environment to take the modifications into account
    echo 'export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin' >> ~/.bashrc

For Singularity > v3.0.0, we also need to install `dep` for dependency resolution

    echo 'export PATH=/usr/local/go/bin:${PATH}:${GOPATH}/bin' >> ~/.bashrc
    
#### Download and install singularity from repo:

To ensure that the Singularity source code is downloaded to the appropriate directory use these commands.

     go get -d github.com/sylabs/singularity

You will obtain a warning but it will still download Singularity source code to the appropriate directory within the `$GOPATH`
     
     # move to the singularity folder
     cd /go/src/github.com/syslabs/singularity/ 
     # launch the mconfig command ( you can add the option --prefix=path to custom the installation directory)
     ./mconfig
     # Compile into the build directory
     make -C ./buildir
     # Install the binaries into /usr/local/bin by default as superuser
     sudo make -C ./builddir install 
 
Type the following command to  your `.bashrc` file to enable completion in singularity:
 
     echo '. /usr/local/etc/bash_completion.d/singularity' >> ~/.bashrc
     
     

-----------------------

<a name="practice-6"></a>
###  Practice 6 : Create your own Singularity container 


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
                  
 
