#!/bin/bash -l
#
#SBATCH --ntasks 16 #number cores
#SBATCH --mem=25G #memory
#SBATCH -p intel,batch
#SBATCH -o logs/05_import.log
#SBATCH -e logs/05_import.log


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

#generated a tab delim text file of contig names, bin IDs to import to anvio from metabat2

BINS=metabat2/Masso_5FC.consensus_round2.scaffolds.fixed.fa.metabat-bins2500/metabat2_bin_info.txt

anvi-import-collection -C METABAT2 -p ${ANVDIR}/${NAME}/$READ'_profile'/PROFILE.db -c  ${ANVDIR}/${NAME}/$NAME.db --contigs-mode $BINS
