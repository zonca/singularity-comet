Run singularity containers on SDSC Comet with MPI support
=========================================================

[Singularity](http://singularity.lbl.gov/) is a project by Lawrence Berkeley Labs to bring container technology like Docker to High Performance Computing.

Comet at the San Diego Supercomputer Center is a Supercomputer funded by National Science Foundation that focuses on boosting computing resources of new HPC users.

In [this repository](https://github.com/zonca/singularity-comet) I gathered some information on how to run Singularity on Comet computing nodes.

## Requirements on the Host

First of all we need to build a container on a machine where we have `root` access, we cannot do this on Comet.
I tested the following on Ubuntu 16.04.

If are interested in testing MPI locally on the Host, you'll need to install `mvapich2` on the Host machine, you can follow the commands inside `ubuntu.def`.

## Build a CentOS 7 container

You can also test the container I have already built, it is available on Comet at:

    /oasis/scratch/comet/zonca/temp_project/Centos7.img

* Install `singularity`, see <http://singularity.lbl.gov/>
* Create an image of potentially 4GB:

        sudo singularity create -s 4096 /tmp/Centos7.img

* Clone this repository and `cd` into the folder
* Singularity on Ubuntu cannot bootstrap Centos, see [the documentation](http://singularity.lbl.gov/building-centos-image), however very conveniently we can initialize the image from Docker with `singularity import`:

        sudo singularity import /tmp/Centos7.img docker://centos:7

* Bootstrap the image with the CentOS 7 OS and also install MPI support with `mvapich2` version 2.1, the same currently available on Comet. See `centos.def` in this repository for details (it is going to take some time):

        sudo singularity bootstrap /tmp/Centos7.img centos.def

* If you installed `mvapich2` on the host, you can check that you can execute the hello world command using the Host MPI installation:

        mpirun -np 2 singularity exec /tmp/Centos7.img /usr/bin/hellow

## Build a Ubuntu 16.04 container

You can also test the container I have already built, it is available on Comet at:

    /oasis/scratch/comet/zonca/temp_project/Ubuntu.img

Install the `debootstrap` package into the Host machine.
Same procedure of CentOS, use `ubuntu.def` instead of `centos.def` and skip the `singularity import` command.

## Test the container on Comet

* Copy the container on your `scratch` folder:

        scp /tmp/Centos7.img comet.sdsc.edu:/oasis/scratch/comet/$USER/temp_project/

* SSH to Comet
* Clone this repository and `cd` into the folder
* Submit the job to the SLURM scheduler

        sbatch run_singularity.slurm

* Check the output file `singularity.*.out` that the output shows all processes sending a "Hello World" string
