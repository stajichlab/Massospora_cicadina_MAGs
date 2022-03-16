#!/bin/bash -l
#
#SBATCH --ntasks 24 #number cores
#SBATCH --mem=98G #memory
#SBATCH -p intel,batch
#SBATCH -o logs/04_metabat.log
#SBATCH -e logs/04_metabat.log


ASSEM=data/Masso_5FC.consensus_round2.scaffolds.fixed.fa
COV=anvio/coverage_anvio/Massospora_2019-06.bam

module unload miniconda2
module unload anaconda3
module load miniconda3
module load metabat/0.32.4

source activate anvio-7

runMetaBat.sh -l -m 2500 $ASSEM $COV

 
