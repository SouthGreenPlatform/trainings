
---
layout: page
title: "Git Practice"
permalink: /git
tags: [git]
description: Git Practice page
---

| Description | Hands On Lab Exercises for Linux |
| :------------- | :------------- | :------------- | :------------- |
<!-- | Related-course materials | [Linux for Dummies](https://southgreenplatform.github.io/trainings/linux/) | -->
| Authors | christine Tranchant-Dubreuil (christine.tranchant@ird.fr)  |
| Creation Date | 10/04/2018 |
| Last Modified Date | 11/04/2018 |


-----------------------

### Summary

<!-- TOC depthFrom:2 depthTo:2 withLinks:1 updateOnSave:1 orderedList:0 -->
* [Preambule: Creating a github repository on the South Green github](#preambule)
* [Practice 1: Transferring files with filezilla `sftp`](#practice-1)
* [Practice 2: Get Connecting on a linux server by `ssh`](#practice-2)
* [Practice 3: First steps : prompt & `pwd`command](#practice-3)
* [Practice 4: List the files using `ls` command](#practice-4)



-----------------------

<a name="preambule"></a>
### Preambule


##### Creating a github repository on the South Green github

* Create a repository
* Create a team
* Add members in the team
* Give access to the team
* Add a readme file

-----------------------


<a name="practice-1"></a>
### Practice 1 : Clone the git repository

* Connect on the linux server bioinfo-inter.ird.fr
* Create a directory git-training and go into this directory
* Clone the distant repository 
`git clone https://github.com/SouthGreenPlatform/formation-git.git .`


-----------------------


<a name="practice-2"></a>
### Practice 2 : Add a new file 

* copy the readme file on a new file readmeTAG.md
* Add this new file in the repository 
`
git add readmeCTD.md
git commit -m "message" nom_fichier
git push dépôt branche`

* Don't forget to do a pull action before pushing (if you are several developers)

`git pull https://github.com/SouthGreenPlatform/formation-git.git master`
-----------------------

<a name="practice-3"></a>
### Practice 3 :  Working with the branch

* List the local branch  
`git branch`

* List the distant branch
`git branch -r`

* Create locally a new branch then transfer this branch on the github repository
`# create the branch localy 
git branch branch_name

#Check if the branch has been correctly created
git checkout branch_name

# Do a modification before commiting
git commit -m "mon commentaire"

# Push this new branch on the distant repository
git push  https://github.com/SouthGreenPlatform/formation-git.git branche_name
`

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
                  
 
