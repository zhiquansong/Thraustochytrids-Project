#PBS -l nodes=1:ppn=4,walltime=192:00:00,mem=16gb -j oe
module load genemarkHMM/4.21
module load perl/5.16.3

D=`dirname \`pwd\``
D2=`dirname $D`
SPECIES=`basename $D2`
echo $SPECIES

CPU=1
if [ $PBS_PPN ]; then
 CPU=$PBS_PPN
fi

perl /rhome/jstajich/src/genome-scripts/gene_prediction/select_long_ctgs.pl --min 10000 ../../$SPECIES.fasta > $SPECIES.long.fasta
gmes_petap.pl --cores $CPU --pbs --ES  --fungus --sequence $SPECIES.long.fasta
