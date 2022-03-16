#!/bin/bash -l
#SBATCH --ntasks=16 # Number of cores
#SBATCH --mem=400G # Memory pool for all cores (see also --mem-per-cpu)
#SBATCH -p intel,batch
#SBATCH -o logs/08_gtdbtk.log
#SBATCH -e logs/08_gtdbtk.log


module unload miniconda2
module load miniconda3

conda activate gtdbtk-1.5.0

ANVDIR=anvio
READ=Massospora_2019-06
NAME=Masso_5FC.consensus_round2
INPUT=${ANVDIR}/${NAME}/$READ'_profile'/bin_fasta
OUTPUT=${ANVDIR}/${NAME}/$READ'_profile'/gtbdk_mixed_bins_results_v1_5_0
CPU=16


gtdbtk classify_wf --genome_dir $INPUT --out_dir $OUTPUT -x .fa --cpus $CPU --prefix $NAME.gtbdk


INPUT=${ANVDIR}/${NAME}/$READ'_profile'/manual_bin
OUTPUT=${ANVDIR}/${NAME}/$READ'_profile'/gtbdk_manual_bin_results_v1_5_0

gtdbtk classify_wf --genome_dir $INPUT --out_dir $OUTPUT -x .fa --cpus $CPU --prefix $NAME.gtbdk

