---
layout: page
title: "Linux Practice"
permalink: /linux/linuxPractice/
tags: [ linux, survival guide ]
description: Linux Practice page
---

| Authors | christine Tranchant-Dubreuil (christine.tranchant@ird.fr)  |
| :------------- | :------------- | :------------- | :------------- |
| Creation Date | 26/02/2018 |
| Last Modified Date | 3/03/2018 |

### Description

Hands On Lab Exercises for Linux 

Resources associated :  
* Training : [Linux for Dummies](https://southgreenplatform.github.io/trainings/linux/)
* Help : [Linux Command-Line Cheat Sheet](https://southgreenplatform.github.io/trainings/linux/linuxTuto/)

-----------------------

### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
- [Preambule: Softwares to install before connecting to a distant linux server ](#preambule)
- [Practice 1: Transferring files](#practice-1)
- [Practice 2: Get Connecting](#practice-2)
- [Practice 3: First steps : prompt & pwd](#practice-3)
- [Practice 4: List the files ](#practice-4)
- [Tips](#tips)
  - [How to convert between Unix and Windows text files?](#convertFileFormat)
  - [How to open and read a file through a text editor on a distant linux server?](#readFile)
- [Link](#link)
- [License](#license)


-----------------------

<a name="preambule"></a>
### Preambule


##### Getting connected to a Linux servers from Windows with SSH (Secure Shell) protocol 

| Platform | Software  | Description | url | 
| :------------- | :------------- | :------------- | :------------- |
| <img width="10%" class="img-responsive" src="{{ site.url }}/images/tpLinux/osWin.png"/>| putty | Putty allows to  connect to a Linux server from a Windows workstation.   | [Download](https://www.chiark.greenend.org.uk/~sgtatham/putty/latest.html)| 
| <img width="10%" class="img-responsive" src="{{ site.url }}/images/tpLinux/osWin.png"/> | mobaXterm |an enhanced terminal for Windows with an X11 server and a tabbed SSH client | [more](https://mobaxterm.mobatek.net/) |


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
### Practice 1 : Transferring files `sftp`


_Download and install FileZilla_


##### Open FileZilla and save the IRD cluster into the site manager

<img width="50%" class="img-responsive" src="{{ site.url }}/images/tpLinux/tp-filezilla1.png"/>

In the FileZilla menu, go to _File > Site Manager_. Then go through these 5 steps:

1. Click _New Site_.
2. Add a custom name for this site.
3. Add the hostname bioinfo-nas.ird.fr 
4. Set the Logon Type to "Normal" and insert your username and password used to connect on the IRD cluster
5. Press the "Connect" button.


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

{% highlight ruby %}
[tranchant@master0 ~]$ pwd
/home/tranchant
{% endhighlight %}

-----------------------

<a name="practice-4"></a>
### Practice 4 : List the files

* image arbo
* list the content of the directory blabla

<pre><code>
[tranchant@master0 ~]$
</code></pre>

-----------------------

<a name="tips"></a>
### Tips

<a name="convertFileFormat"></a>
##### How to convert between Unix and Windows text files?
The format of Windows and Unix text files differs slightly. In Windows, lines end with both the line feed and carriage return ASCII characters, but Unix uses only a line feed. As a consequence, some Windows applications will not show the line breaks in Unix-format files. Likewise, Unix programs may display the carriage returns in Windows text files with Ctrl-m (^M) characters at the end of each line.

There are many ways to solve this problem as using text file compatible, unix2dos / dos2unix command or vi to do the conversion. To use the two last ones, the files to convert must be on a Linux computer.

###### use notepad as file editor on windows 

When using Unix files on Windows, it is useful to convert the line endings to display text files correclty in other Windows-based or linux-based editors.

In Notepad++: `Edit > EOL Conversion > Windows Format`

<img width="50%" class="img-responsive" src="{{ site.url }}/images/tpLinux/tp-notepadUTF8.png"/>

###### `unix2dos` & `dos2unix`

<pre><code>
# Checking if my fileformat is dos 
[tranchant@master0 ~]$ cat -v test.txt 
jeidjzdjzd^M
djzoidjzedjzed^M
ndzndioezdnezd^M

# Converting from dos to linux format
[tranchant@master0 ~]$ dos2unix test.txt 
dos2unix: converting file test.txt to Unix format ...
[tranchant@master0 ~]$ cat -v test.txt 
jeidjzdjzd
djzoidjzedjzed
ndzndioezdnezd

# Converting from linux to dos format
[tranchant@master0 ~]$ unix2dos test.txt 
unix2dos: converting file test.txt to DOS format ...
[tranchant@master0 ~]$ cat -v test.txt 
jeidjzdjzd^M
djzoidjzedjzed^M
ndzndioezdnezd^M
[tranchant@master0 ~]$
</code></pre>

###### vi

* In vi, you can remove carriage return _^M _ characters with the following command: `:1,$s/^M//g`
* To input the _^M_ character, press _Ctrl-v_, and then press _Enter_ or _return_.
* In vim, use :`set ff=unix` to convert to Unix; use `:set ff=dos` to convert to Windows.

<hr \>

-----------------------

<a name="readFile"></a>

###### vi

###### nano 

###### Komodo Edit

-----------------------

### Links
<a name="links"></a>

* Training : [Linux for Dummies](https://southgreenplatform.github.io/trainings/linux/)
* Help : [Linux Command-Line Cheat Sheet](https://southgreenplatform.github.io/trainings/linux/linuxTuto/)

-----------------------

### License
<a name="license"></a>

<div>
The resource material is licensed under the Creative Commons Attribution 4.0 International License (<a href="http://creativecommons.org/licenses/by-nc-sa/4.0/">here</a>).
<center><img width="50%" class="img-responsive" src="http://creativecommons.org.nz/wp-content/uploads/2012/05/by-nc-sa1.png"/>
</center>
</div>
                  
