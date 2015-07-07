#PBS -l nodes=1:ppn=2
#PBS -l mem=2gb
module load hmmer

cd $PBS_O_WORKDIR

mkdir hmmoutput

cat ../seqlist | while read f
do 
  hmmscan -o hmmoutput/$f.out kegg_db $f.func.fasta
  hmmscan --tblout hmmoutput/$f.tbl kegg_db $f.func.fasta
  hmmscan --domtblout hmmoutput/$f.domtbl kegg_db $f.func.fasta
done
