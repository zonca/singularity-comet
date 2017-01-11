#!/bin/bash
#SBATCH --job-name="singularity"
#SBATCH --output="singularity.%j.%N.out"
#SBATCH --partition=compute
#SBATCH --nodes=2
#SBATCH --ntasks-per-node=24
#SBATCH --export=ALL
#SBATCH -t 00:05:00
#SBATCH --account=sds166

module load singularity/2.2 mvapich2_ib/2.1

IMAGE=/oasis/scratch/comet/$USER/temp_project/debian_julia.img

mpirun singularity exec $IMAGE /usr/bin/hellow
mpirun singularity exec $IMAGE /usr/local/julia/bin/julia 01-hello.jl
