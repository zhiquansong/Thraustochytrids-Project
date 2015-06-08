#PBS -j oe 

cd $PBS_O_WORKDIR

python del_id_judge.py consensi.fa.xml > del_id_judge
#judge the seuences by hand through 'del_id_judge'
grep 'rnd-' del_id_judge > del_id
