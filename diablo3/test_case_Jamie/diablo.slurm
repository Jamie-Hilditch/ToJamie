#!/bin/bash

#SBATCH --job-name=diablo3_test
#
#SBATCH --time=2:30:00
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=64
#SBATCH --mem-per-cpu=7G
#SBATCH --partition=serc
#SBATCH --constraint=[CLASS:SH3_CBASE|CLASS:SH3_CPERF]
#SBATCH --output=output.log
#SBATCH --error=error.log
#SBATCH --mail-user=hilditch@stanford.edu
#SBATCH --mail-type=end,fail

ml load hdf5/1.12.2
ml load fftw/3.3.10
# ml load valgrind


$GROUP_HOME/hilditch/scripts/diablo3.4/for/setup_run 4 16 > setup.log

srun -n 64 ./diablo > diablo.log
# srun -n 32 valgrind --log-file=valgrind.log --track-origins=yes --error-limit=no --leak-check=full --show-leak-kinds=all --suppressions=/share/software/user/open/openmpi/4.1.2/share/openmpi/openmpi-valgrind.supp ./diablo > diablo.log

