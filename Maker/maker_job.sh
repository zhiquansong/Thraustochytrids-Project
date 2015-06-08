#!/bin/bash
#PBS -l nodes=1:ppn=2,walltime=96:00:00,mem=16gb
#PBS -N MAKER.Thraus -j oe
module load perl
module load stajichlab
module load maker/2.31.8
module load snap
module load augustus/2.7
module load repeat-masker
module load ncbi-blast
module load tRNAscan-SE
#which augustus
#echo $AUGUSTUS_CONFIG_PATH
#which maker

maker 
