#PBS -l nodes=1:ppn=2
#PBS -l mem=1gb

cd $PBS_O_WORKDIR

module load muscle
module load perl
mkdir MSA
mkdir hmmDB
cat ko_list | while read f
do
  muscle -in DB_filter/$f.filter -out MSA/$f.align
  #perl bp_sreformat -if fasta -of stockholm -i MSA/$f.align > hmmbd/$f.sto
  perl reformat.pl fas sto MSA/$f.align hmmDB/$f.sto
done
