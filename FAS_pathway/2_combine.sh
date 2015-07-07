#PBS -l nodes=1:ppn=4
#PBS -l mem=2gb

cd $PBS_O_WORKDIR

mkdir hmmDB
cat ko_list | while read f
do
  cat $f-db/*.fasta > DB/$f.fa
done
