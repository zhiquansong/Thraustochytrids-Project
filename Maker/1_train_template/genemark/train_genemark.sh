#PBS -l nodes=1:ppn=1,walltime=192:00:00,mem=16gb -j oe
module load genemarkHMM
D=`dirname \`pwd\``
D2=`dirname $D`
SPECIES=`basename $D2`
echo $SPECIES

perl /rhome/jstajich/src/genome-scripts/gene_prediction/select_long_ctgs.pl -m 50000 ../../$SPECIES.fasta > $SPECIES.long.fasta
nohup gm_es.pl $SPECIES.long.fasta >& train.log
