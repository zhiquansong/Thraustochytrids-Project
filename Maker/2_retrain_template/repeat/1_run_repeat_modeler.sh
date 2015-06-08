#PBS -l nodes=1:ppn=1 -j oe -N repeatModeler

cd $PBS_O_WORKDIR
module load RepeatModeler

if [ ! -f Mn35.nni ]; then 
 BuildDatabase -name Mn35 Mn35.fasta
fi

RepeatModeler -database Mn35 -engine ncbi
