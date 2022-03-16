#!/bin/bash -l
#
#SBATCH --ntasks 16 #number cores
#SBATCH --mem=25G #memory
#SBATCH -p intel,batch
#SBATCH -o logs/06_summarize.log
#SBATCH -e logs/06_summarize.log
#SBATCH -J Mass_summarize

ANVDIR=anvio
COVDIR=$ANVDIR/coverage_anvio
CPU=16
MIN=2500

NAME=Masso_5FC.consensus_round2



module unload miniconda2
module unload anaconda3
module load miniconda3

source activate anvio-7

READ=Massospora_2019-06


anvi-summarize -p ${ANVDIR}/${NAME}/$READ'_profile'/PROFILE.db -c ${ANVDIR}/${NAME}/$NAME.db -o ${ANVDIR}/${NAME}/$READ'_profile'/sample_summary_METABAT -C METABAT2

