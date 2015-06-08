#PBS -j oe 

cd $PBS_O_WORKDIR

python filtered.py del_id consensi.fa.classified
python rn_id.py consensi.fa.filtered > Sed1_rnd
