#PBS -l nodes=1:ppn=4
#PBS -l mem=2gb

cd $PBS_O_WORKDIR

cat ko_list | while read f
do
  wget http://www.genome.jp/kegg-bin/uniprot_list?ko=$f
  python get_fasta_link.py uniprot_list?ko=$f > $f-list
  mkdir $f-db
  mv uniprot_list?ko=$f $f-db
  mv $f-list $f-db
  cat $f-db/$f-list | while read i
  do
    #wget $i.fasta
    n=`basename $i`
    wget $i.fasta?version=1 -O $f-db/$n.fasta
  done
done

