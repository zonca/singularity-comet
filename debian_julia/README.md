Build Debian/Julia container with MPI support for Comet
=============================================

## Prebuilt image

You can also test the container I have already built, it is available on Comet at:

    /oasis/scratch/comet/zonca/temp_project/julia.img
    
## Create image on your laptop

Choose a location:

	IMAGE=/tmp/julia.img

Make sure to have singularity 2.2 installed, create an empty image:

	sudo singularity create -s 4096 $IMAGE

First use the official Docker image for Julia based on Debian Jessie to inizialize it:

	sudo singularity import $IMAGE docker://julia

Then run the bootstrap file to install `mvapich`, more `Julia` packages, including `MPI.jl`:

	sudo singularity bootstrap $IMAGE debian_julia.def

`Julia` packages are not installed in the home of the user as usual but in `/usr/local/julia`.

## Test on comet

Copy the image to Comet

	scp $IMAGE comet.sdsc.edu:/oasis/scratch/comet/$USER/temp_project/

Modify the `run_singularity.slrm` script to test your job.

## Troubleshooting

In case of `MPI` errors, install the `MPI` package in your home folder,
get a shell inside the container:

	singularity shell $IMAGE

Open the `Julia` terminal:

	/usr/local/julia/bin/julia

Install and build `MPI.jl`:

	julia> Pkg.add("MPI")
	julia> Pkg.build("MPI")
