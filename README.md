Run singularity containers on SDSC Comet with MPI support
=========================================================

[![https://www.singularity-hub.org/static/img/hosted-singularity--hub-%23e32929.svg](https://www.singularity-hub.org/static/img/hosted-singularity--hub-%23e32929.svg)](https://singularity-hub.org/collections/1309)

[Singularity](http://singularity.lbl.gov/) is a project by Lawrence Berkeley Labs to bring container technology like Docker to High Performance Computing.

Comet at the San Diego Supercomputer Center is a Supercomputer funded by National Science Foundation that focuses on boosting computing resources of new HPC users.

In [this repository](https://github.com/zonca/singularity-comet) I gathered some information on how to run Singularity on Comet computing nodes.

See an introduction to this tutorial on my blog: <https://zonca.github.io/2017/01/singularity-hpc-comet.html>

## Use a pre-made Singularity container

Available on Comet at:

    /oasis/scratch/comet/zonca/temp_project/ubuntu_anaconda_2018.simg

Available on DockerHub, see the `Dockerfile` in `jupyter_datascience_docker/`, see <https://hub.docker.com/r/zonca/jupyter-datascience-comet/>, you can transform it into a singularity container directly on Comet with:

    module load singularity
    singularity pull docker://zonca/jupyter-datascience-comet

Available on SingularityHub at <https://www.singularity-hub.org/collections/1309>:

    module load singularity
    singularity pull shub://zonca/singularity-comet

## Build a Ubuntu 16.04 container

### Requirements on the Host

First of all we need to build a container on a machine where we have `root` access, we cannot do this on Comet.
I tested the following on Ubuntu 16.04.

If are interested in testing MPI locally on the Host, you'll need to install `mvapich2` on the Host machine, you can follow the commands inside `ubuntu.def`.

### How to build the container with singularity

Currently the kernel on Comet does not support Ubuntu 18.04.

Install the `debootstrap` package into the Host machine.

* Install `singularity`, see <http://singularity.lbl.gov/>
* Create an image of potentially 4GB:

        export IMAGE=/tmp/ubuntu_anaconda_2018.simg
        sudo singularity create -s 4096 $IMAGE

* Clone this repository and `cd` into the folder

* Bootstrap the image with the Ubuntu 16.04 OS and also install MPI support with `mvapich2` version 2.1, the same currently available on Comet. See `ubuntu_anaconda/Singularity` in this repository for details (it is going to take some time):

        sudo singularity build $IMAGE ubuntu_anaconda

* If you installed `mvapich2` on the host, you can check that you can execute the hello world command using the Host MPI installation:

        mpirun -np 2 singularity exec $IMAGE /usr/bin/hellow

## Test the container on Comet

* Copy the container on your `scratch` folder:

        scp $IMAGE comet.sdsc.edu:/oasis/scratch/comet/$USER/temp_project/

* SSH to Comet
* Clone this repository and `cd` into the folder
* Submit the job to the SLURM scheduler

        sbatch run_singularity.slurm

* Check the output file `singularity.*.out` that the output shows all processes sending a "Hello World" string
