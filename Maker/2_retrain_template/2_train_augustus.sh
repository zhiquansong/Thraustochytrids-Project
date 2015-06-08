#PBS -l nodes=1:ppn=1 -j oe -n augTrain 
module load stajichlab
module load augustus/2.7

cd $PBS_O_WORKDIR

SPECIES=Mn35.retrain
echo $SPECIES

perl /rhome/jstajich/src/genome-scripts/gene_prediction/zff2augustus_gbk.pl ../snap/export.ann ../snap/export.dna > $SPECIES.train.gbk
autoAugTrain.pl --CRF --trainingset=$SPECIES.train.gbk --species=$SPECIES"_CEGMA_CRF" --optrounds=2