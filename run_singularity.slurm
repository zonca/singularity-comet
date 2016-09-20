#!/bin/bash  
#SBATCH --job-name="singularity"  
#SBATCH --output="singularity.%j.%N.out"  
#SBATCH --partition=compute  
#SBATCH --nodes=2  
#SBATCH --ntasks-per-node=24  
#SBATCH --export=ALL  
#SBATCH -t 00:05:00  

module load singularity mvapich2_ib/2.1

source /home/zonca/.bashrc

IMAGE=/oasis/scratch/comet/zonca/temp_project/Centos7_mva21.img

ibrun -v singularity exec $IMAGE /usr/bin/mpi_hello
