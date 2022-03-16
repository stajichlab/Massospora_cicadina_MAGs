#!/bin/bash -l
#
#SBATCH -n 24 #number cores
#SBATCH -p intel,batch
#SBATCH -o logs/07_checkm.log
#SBATCH -e logs/07_checkm.log
#SBATCH --mem 96G #memory in Gb
#SBATCH -t 96:00:00 #time in hours:min:sec


module load checkm

ANVDIR=anvio
COVDIR=$ANVDIR/coverage_anvio
CPU=16
MIN=2500
NAME=Masso_5FC.consensus_round2
READ=Massospora_2019-06
BINFOLDER=${ANVDIR}/${NAME}/$READ'_profile'/bin_fasta
OUTPUT=${ANVDIR}/${NAME}/$READ'_profile'/mixed_bins_checkM
CPU=24

checkm lineage_wf -t $CPU -x fa $BINFOLDER $OUTPUT

checkm tree $BINFOLDER -x .fa -t $CPU $OUTPUT/tree

checkm tree_qa $OUTPUT/tree -f $OUTPUT/$OUTPUT.checkm.txt







