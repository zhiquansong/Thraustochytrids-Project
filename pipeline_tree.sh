#!/bin/bash
#PBS -l nodes=1:ppn=4 -j oe
#PBS -l mem=2gb
#PBS -V

CPU=$PBS_PPN

if [ ! $CPU ]; then
 CPU=2
fi

cd $PBS_O_WORKDIR

# FORMAT DB
ls DB/*Proteins.fasta > dblist
cat dblist | while read f; do formatdb -i $f -p T; done

# local blast
ls DB/*Proteins.fasta | cut -f 2,3,4 -d '_' > namelist
cat namelist | while read f; do blastall -p blastp -i chsproteinseq.fasta -d /rhome/zsong/bigdata/practice/chspractice/pipeline_script/DB/FungiDB-3.2_$f -e 1e-5 -m 7 -o $f.xml; done
rm namelist
ls *.fasta.xml | cut -f 1 -d '.' > namelist
cat namelist | while read f; do mv $f.fasta.xml $f.xml; done 

# get the information for every hsp,contain:
#python pbxml_list1.py > parseblastxmllist1.txt
# get the information for every hit,contain:
#python pbxml_list2.py > parseblastxmllist2.txt
# get the information for every alignment,contain:
#python pbxml_list3.py > parseblastxmllist3.txt
# calculate the number of chs genes for every species,inputfile for list5, contain: 
python pbxml_list4_for_uniq.py > pbxml_list4_for_uniq.txt
# pick up the protein sequences from DB for building a phylogenetic tree
python pickupPfa_list5.py pbxml_list4_for_uniq.txt > list5_align_for_tree.fasta
# combine the query and target sequences for alignment
cat chsproteinseq.fasta list5_align_for_tree.fasta > align_chs_tree.fasta

# use Muscle for Multiple Alignments
muscle -in align_chs_tree.fasta -phyiout align_i_done.phy

# trim the alignments
module load trimal
trimal -in align_i_done.phy -out align_trim_done.phy -phylip -automated1

# RAxML
module load RAxML
raxmlHPC-PTHREADS-SSE3 -p 12345 -s align_trim_done.phy -n out -m PROTGAMMAAUTO -T $CPU -f a -x 121 -# 10
 
echo "Done" 
