#!/bin/bash -l
#
#SBATCH --ntasks 16 #number cores
#SBATCH --mem=250G #memory
#SBATCH -p intel,batch
#SBATCH -o logs/03_prof.log
#SBATCH -e logs/03_prof.log

ANVDIR=anvio
COVDIR=$ANVDIR/coverage_anvio
CPU=16
MIN=2500

ASSEM=data/Masso_5FC.consensus_round2.fasta
NAME=Masso_5FC.consensus_round2


READ=Massospora_2019-06


module unload miniconda2
module unload anaconda3
module load miniconda3

source activate anvio-7

anvi-profile -i ${COVDIR}/$READ'.bam' -c ${ANVDIR}/${NAME}/$NAME.db --num-threads $CPU --min-contig-length $MIN --cluster-contigs --output-dir ${ANVDIR}/${NAME}/$READ'_profile'


