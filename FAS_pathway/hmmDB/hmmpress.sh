#PBS -l nodes=1:ppn=2
#PBS -l mem=2gb

cd $PBS_O_WORKDIR

mkdir db
module load hmmer

cat build/*.hmm > db_scan
hmmpress db_scan
mv db_scan* db
