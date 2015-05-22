#!/bin/bash
#PBS -l nodes=1:ppn=4,mem=4gb -j oe -N raxml

cd $PBS_O_WORKDIR

module load RAxML
raxmlHPC-PTHREADS-SSE3 -p 12345 -s  allseq.fasaln -n test -m PROTGAMMAAUTO -T 4 -f a -x 121 -# 100