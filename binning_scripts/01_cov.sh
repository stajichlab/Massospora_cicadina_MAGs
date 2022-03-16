#!/bin/bash -l
#
#SBATCH --ntasks 24 #number cores
#SBATCH -o logs/01_cov_anvio.log
#SBATCH -e logs/01_cov_anvio.log
#SBATCH --mem=48G #memory
#SBATCH -p intel,batch

module unload miniconda2
module unload anaconda3

module load miniconda3

source activate anvio-7

ANVDIR=anvio
COVDIR=coverage_anvio
CPU=24

mkdir $ANVDIR/$COVDIR


ASSEM=data/Masso_5FC.consensus_round2.fasta
PREFIX=Masso_5FC.consensus_round2
LOC=data
READ=Massospora_2019-06
LOCATION=$LOC

anvi-script-reformat-fasta $ASSEM -o $LOC/$PREFIX.scaffolds.fixed.fa -l 0 --simplify-names

bowtie2-build $LOC/$PREFIX.scaffolds.fixed.fa ${ANVDIR}/${COVDIR}/$PREFIX

bowtie2 --threads $CPU -x  ${ANVDIR}/${COVDIR}/$PREFIX -1 ${LOCATION}/$READ'_R1.fastq.gz' -2 ${LOCATION}/$READ'_R2.fastq.gz' -S ${ANVDIR}/${COVDIR}/$READ'.sam'
samtools view -F 4 -bS ${ANVDIR}/${COVDIR}/$READ'.sam' > ${ANVDIR}/${COVDIR}/$READ'-RAW.bam'
anvi-init-bam ${ANVDIR}/${COVDIR}/$READ'-RAW.bam' -o ${ANVDIR}/${COVDIR}/$READ'.bam'

mkdir ${ANVDIR}/$PREFIX

anvi-gen-contigs-database -f ${LOC}/$PREFIX.scaffolds.fixed.fa -o ${ANVDIR}/${PREFIX}/$PREFIX.db
anvi-run-hmms -c ${ANVDIR}/${PREFIX}/$PREFIX.db --num-threads $CPU
anvi-get-sequences-for-gene-calls -c ${ANVDIR}/${PREFIX}/$PREFIX.db -o ${ANVDIR}/${PREFIX}/$PREFIX.gene.calls.fa
anvi-get-sequences-for-gene-calls -c ${ANVDIR}/${PREFIX}/$PREFIX.db --get-aa-sequences -o ${ANVDIR}/${PREFIX}/$PREFIX.amino.acid.sequences.fa


