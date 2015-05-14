#!/bin/bash
#PBS -l mem=2gb
#PBS -V

for file in test/*.fasta
do
  cp $file  $file.rename
  python JGI_rename_szq.py $file.rename
done
