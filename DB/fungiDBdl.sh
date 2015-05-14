#!/bin/bash
#PBS -l mem=2gb
#PBS -V

cat fungiDBlist | while read f
do 
  if [ ! -f $f.fa ];
  then
      echo $f 
      wget http://fungidb.org/common/downloads/release-3.2/$f/fasta/data/FungiDB-3.2_$f\_AnnotatedProteins.fasta 
      mv FungiDB-3.2_$f\_AnnotatedProteins.fasta $f.fa 
  fi 
done

echo "Done" 
