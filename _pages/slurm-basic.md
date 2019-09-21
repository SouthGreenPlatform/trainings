---
layout: page
title: "SLURM basic commands"
permalink: /slurm/
tags: [ slurm, survival guide ]
description: slurm basic commands
---

| Description | Hands On Lab Exercises for SLURM |
| :------------- | :------------- | :------------- | :------------- |
| Related-course materials | [Linux for Dummies](https://southgreenplatform.github.io/trainings/hpc/) |
| Authors | Julie Orjuela-Bouniol (julie.orjuela@ird.fr)  - i-trop platform (UMR BOREA / DIADE / IPME - IRD) |
| Creation Date | 21/09/2018 |
| Last Modified Date | 22/09/2019 |


# SLURM some basic commands

Slurm offers many commands you can use to interact with the system. 

The `sinfo` command gives an overview of the resources offered by the cluster

```python
sinfo -N -l
```

The `squeue` command shows to jobs those resources are currently allocated (qstat). This command lists currently running jobs (they are in the RUNNING state, noted as ‘R’) or waiting for resources (noted as ‘PD’, short for PENDING).

```python
squeue
```

You can show more complex information with -o option, -i parameter allow lauch squeue every n seconds 
```python
squeue -o "%.18i %.9P %.8j %.8c %.8u %.8T %.10M %.9l %.6D %R %D" -i 5
```

## Allocate resources by using srun command 

 If you need simply to have an interactive Bash session on a compute node, with the same environment set as the batch jobs, use `srun`. srun allows allocate a interactive session with ressources determinated in parameters (similar to qrsh or qhost SGE mode).
``` python
srun --pty bash 
or
srun -p "partition name"--time=4:0:0 --pty bash
```


## How do you create a job?


A job consists in two parts: resource requests and job steps.

Resource requests consist in a number of CPUs, computing expected duration, amounts of RAM or disk space, etc.  Job steps describe tasks that must be done, software which must be run.

The typical way of creating a job is to write a submission script. A submission script is a shell script. If they are prefixed with SBATCH, are understood by Slurm as parameters describing resource requests and other submissions options. You can get the complete list of parameters from the sbatch manpage man sbatch.

in this exemple *job.sh* contains ressources request (lines starting with #SBATCH) and a sleep unix command. 


``` python
#!/bin/bash

#SBATCH --job-name=test
#SBATCH --output=res.txt
#SBATCH --ntasks=1
#SBATCH --time=10:00
#SBATCH --mem-per-cpu=100

sleep 00:03:00 #slepping 3 minuts
```

job.sh request one CPU for 10 minutes, along with 100 MB of RAM, in the default queue. When started, the job would run a sleep unix command.

The `sbatch` command allows submit a script. 

``` python
sbatch job.sh
```

Interestingly, you can get near-realtime information about your running program (memory consumption, etc.) with the `sstat` command
``` python
sstat -j job_id
```

If you want to cancel a job, use `scancel` command (qdel)
```python
scancel job_id 
```

If you want to kwon ressources used by a finished  job, use `seff` command
```python
seff job_id
```

-----------------------

### License
<a name="license"></a>

<div>
The resource material is licensed under the Creative Commons Attribution 4.0 International License (<a href="http://creativecommons.org/licenses/by-nc-sa/4.0/">here</a>).
<center><img width="25%" class="img-responsive" src="http://creativecommons.org.nz/wp-content/uploads/2012/05/by-nc-sa1.png"/>
</center>
</div>



