#PBS -j oe -l walltime=2:00:00
PEPDIR=../DB
perl gather_besthmm_build_markerfasta.pl -pep $PEPDIR -o outgroup_markers -i HMMSEARCH_results 
