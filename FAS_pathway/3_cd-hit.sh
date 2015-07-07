#PBS -l nodes=1:ppn=4
#PBS -l mem=4gb

cd $PBS_O_WORKDIR

mkdir DB_filter
module load cd-hit
cat ko_list | while read f
do
  cd-hit -i DB/$f.fa -o DB_filter/$f.filter -c 0.90 -n 5 -M 4000
done
