#!/bin/bash
#PBS -l nodes=1:ppn=4,mem=2gb
#PBS -V

cd $PBS_O_WORKDIR

# FORMAT DB
ls /bigdata/zsong/practice/OMApractice/DB/*.fa > dblist
cat dblist | while read f; do formatdb -i $f -p T; done

# local blast
ls /bigdata/zsong/practice/OMApractice/DB/*.fa | cut -f 7 -d '/' > namelist
cat namelist | while read f
do 
  blastall -p blastp -i /bigdata/zsong/practice/OMApractice/querry.fa -d /bigdata/zsong/practice/OMApractice/DB/$f -e 1e-5 -m 7 -o /bigdata/zsong/practice/OMApractice/blast_result/$f.xml
done

ls /bigdata/zsong/practice/OMApractice/blast_result/*.xml | cut -f 1 -d '.' > namelist
cat namelist | while read f; do mv $f.fa.xml $f.xml; done 

# creat new OMA db
for i in /bigdata/zsong/practice/OMApractice/DB/*.fa
do 
  cp $i $i.oma
done

python /bigdata/zsong/practice/OMApractice/select_from_blast_for_OMA.py 

echo "Done" 
