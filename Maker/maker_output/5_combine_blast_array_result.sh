#PBS -j oe

cd $PBS_O_WORKDIR

D=`dirname \`pwd\``
SPECIES=`basename $D`
PREFIX=$SPECIES

cat $PREFIX.BLAST/*.BLASTP > $SPECIES.all.maker.swissprot.BLASTP
