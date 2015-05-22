#!/bin/bash
#PBS -l nodes=1:ppn=2,mem=2gb
#PBS -V

cd $PBS_O_WORKDIR

python only-4all.py > list_have_4T
cat list_have_4T | while read f
do
  name=`basename $f .aa`
  cp $f /rhome/zsong/bigdata/practice/thraustochytrid/Phylogenetics_Fungal_Markers/orthologs/$name
done
