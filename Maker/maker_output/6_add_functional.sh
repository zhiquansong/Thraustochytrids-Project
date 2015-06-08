#PBS -j oe -N addfunctional -l walltime=12:00:00 -l nodes=1:ppn=1
module load stajichlab
module load stajichlab-perl
module load perl
module load maker/2.31.6
cd $PBS_O_WORKDIR
D=`dirname \`pwd\``
SPECIES=`basename $D`
maker_functional_fasta /shared/stajichlab/db/uniprot/uniprot_sprot.fasta $SPECIES.all.maker.swissprot.BLASTP $SPECIES.all.maker.transcripts.fasta > $SPECIES.all.maker.transcripts.functional.fasta
maker_functional_fasta /shared/stajichlab/db/uniprot/uniprot_sprot.fasta $SPECIES.all.maker.swissprot.BLASTP $SPECIES.all.maker.proteins.fasta > $SPECIES.all.maker.proteins.functional.fasta

maker_functional_gff /shared/stajichlab/db/uniprot/uniprot_sprot.fasta $SPECIES.all.maker.swissprot.BLASTP $SPECIES.all.gff > $SPECIES.all.functional.gff
