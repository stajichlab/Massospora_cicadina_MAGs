#!/bin/bash -l
#
#SBATCH --ntasks 24 #number cores
#SBATCH -p intel,batch
#SBATCH -o logs/02_kaiju.log
#SBATCH -e logs/02_kaiju.log
#SBATCH --mem=48G #memory



ANVDIR=anvio
DB=/rhome/cassande/bigdata/software/databases/kaiju
CPU=24

ASSEM=data/Masso_5FC.consensus_round2.fasta
PREFIX=Masso_5FC.consensus_round2

module load kaiju
module unload miniconda2
module unload anaconda3

module load miniconda3

source activate anvio-7


kaiju -z $CPU -t $DB/nodes.dmp -f $DB/kaiju_db_nr_euk.fmi -i  ${ANVDIR}/${PREFIX}/$PREFIX.gene.calls.fa -o ${ANVDIR}/${PREFIX}/$PREFIX.kaiju.out -v

kaiju-addTaxonNames -t $DB/nodes.dmp -n $DB/names.dmp -i ${ANVDIR}/${PREFIX}/$PREFIX.kaiju.out -o ${ANVDIR}/${PREFIX}/$PREFIX.kaiju.names.out -r superkingdom,phylum,class,order,family,genus,species

anvi-import-taxonomy-for-genes -i ${ANVDIR}/${PREFIX}/$PREFIX.kaiju.names.out -c ${ANVDIR}/${PREFIX}/$PREFIX.db -p kaiju --just-do-it
	

