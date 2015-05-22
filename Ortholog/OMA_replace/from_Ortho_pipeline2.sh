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
# creat new OMA db
ls /bigdata/zsong/practice/OMApractice/blast_result/*.xml  > xmllist
cat xmllist | while read f
do
  name=`basename $f .xml`
  cp /bigdata/zsong/practice/OMApractice/DB/$name.fa /bigdata/zsong/practice/OMApractice/DB-OMA/$name.ortho
  python /bigdata/zsong/practice/OMApractice/select_from_xml_to_fa.py $f /bigdata/zsong/practice/OMApractice/DB-OMA/$name.ortho 
done > /bigdata/zsong/practice/OMApractice/DB-OMA/test.out 