---
layout: page
title: "Singularity container creation"
permalink: /hpc/containercreation/
tags: [ linux, HPC, cluster, OS ]
description: Singularity installation  page
---

| Description | Installation of Singularity on Centos7 |
| :------------- | :------------- | :------------- | :------------- |
| Related-course materials | [HPC Administration Module2](https://southgreenplatform.github.io/trainings/Module1/) |
| Authors | Ndomassi TANDO (ndomassi.tando@ird.fr)  |
| Creation Date |24/09/2019 |
| Last Modified Date | 24/09/2019 |


-----------------------


### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Install dependencies](#part-1)
* [Install The programming  language Go](#part-2)
* [Download and install singularity from repo](#part-3)
* [Modify Bind path in Singularity](#part-4)
* [Links](#links)
* [License](#license)


-----------------------
<a name="part-1"></a>
## Install dependencies

 {% highlight bash %}$ sudo yum update -y && \
      sudo yum groupinstall -y 'Development Tools' && \
      sudo yum install -y \
      openssl-devel \
      libuuid-devel \
      libseccomp-devel \
      wget \
      squashfs-tools \
      git{% endhighlight %}

-------------------------------------------------------------------------------------

<a name="part-2"></a>
## Install The programming  language Go:

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
     source ~/.bashrc{% endhighlight %}

For Singularity > v3.0.0, we also need to install `dep` for dependency resolution

  {% highlight bash %}go get -u github.com/golang/dep/{% endhighlight %}



----------------------------------------------------------------------------------------------

<a name="part-3"></a>
## Download and install singularity from repo:

To ensure that the Singularity source code is downloaded to the appropriate directory use these commands.

   {% highlight bash %}go get -d github.com/sylabs/singularity{% endhighlight %}

You will obtain a warning but it will still download Singularity source code to the appropriate directory within the `$GOPATH`
     
   {% highlight bash %}# move to the singularity folder
     cd ~/go/src/github.com/sylabs/singularity/ 
     # launch the mconfig command ( you can add the option --prefix=path to custom the installation directory)
     ./mconfig --prefix=/usr/local/singularity
     # Compile into the build directory
     make -C ./builddir
     # Install the binaries into /usr/local/singularity/bin by default as superuser
     sudo make -C ./builddir install{% endhighlight %} 
 
Type the following command to  your `.bashrc` file to enable completion in singularity:
 
   {% highlight bash %}. /usr/local/etc/bash_completion.d/singularity
    # resource your .bashrc
    source ~/.bashrc{% endhighlight %}


---------------------------------------------------------------------------------------------------

<a name="part-4"></a>
## Modify Bind path in Singularity

bind path allows to mount host partitions into the container directly at startup.

Modify the  file `/usr/local/singularity/etc/singularity/singularity.conf`

In BIND PATH part

Add the partitions you want to see in the container:

For example:

{% highlight bash %}bind path = /opt
bind path = /scratch
bind path = /data{% endhighlight %}


Activate the overlay with the line:

{% highlight bash %}enable overlay = yes{% endhighlight %}

  
---------------------------------------------------------------------------------------------------

### Links
<a name="links"></a>

* Related courses : [HPC Trainings](https://southgreenplatform.github.io/trainings/HPC/)


-----------------------

### License
<a name="license"></a>

<div>
The resource material is licensed under the Creative Commons Attribution 4.0 International License (<a href="http://creativecommons.org/licenses/by-nc-sa/4.0/">here</a>).
<center><img width="25%" class="img-responsive" src="http://creativecommons.org.nz/wp-content/uploads/2012/05/by-nc-sa1.png"/>
</center>
</div>
                  
 
