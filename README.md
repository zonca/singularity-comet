Run singularity containers on SDSC Comet with MPI support
=========================================================

[Singularity](http://singularity.lbl.gov/) is a project by Lawrence Berkeley Labs to bring container technology like Docker to High Performance Computing.

Comet at the San Diego Supercomputer Center is a Supercomputer funded by National Science Foundation that focuses on boosting computing resources of new HPC users.

In [this repository](https://github.com/zonca/singularity-comet) I gathered some information on how to run Singularity on Comet computing nodes.

## Build a container

First of all we need to build a container on a machine where we have `root` access, cannot do this on Comet.

* Install `singularity`, see <http://singularity.lbl.gov/>
* Create an image of potentially 4GB:

        sudo singularity create -s 4096 /tmp/Centos7.img

* Clone this repository and `cd` into the folder
* Bootstrap the image with the CentOS 7 OS and also install MPI support with `mvapich2` version 2.1, the same currently available on Comet. See `centos.def` in this repository for details (it is going to take some time):

        sudo singularity bootstrap /tmp/Centos7.img centos.def

* Test MPI inside the container

        singularity exec mpirun -np 2 /usr/bin/hellow

## Test the container on Comet

* Copy the container on your `scratch` folder:

        scp /tmp/Centos7.img comet.sdsc.edu:/oasis/scratch/comet/$USER/temp_project/

* SSH to Comet
* Clone this repository and `cd` into the folder
* Submit the job to the SLURM scheduler

        sbatch run_singularity.slurm

* Check the output file `singularity.*.out` that the output shows all processes sending a "Hello World" string
