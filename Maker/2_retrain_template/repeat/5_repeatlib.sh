#PBS -j oe 
module load wu-blast

cd $PBS_O_WORKDIR

mkdir lib
cd lib
cp ../*/*_rnd .
nrdb -o repeatlib *_rnd
