#PBS -l nodes=1:ppn=2
#PBS -l mem=1gb

cd $PBS_O_WORKDIR

mkdir build
module load hmmer

cat ../ko_list| while read f
do 
  hmmbuild build/$f.hmm $f.sto
done
