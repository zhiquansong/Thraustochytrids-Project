module load hmmer/3.1b1

for file in /bigdata/zsong/practice/thraustochytrid/DB/*.fa
do
 name=`basename $file .fa`
 hmmsearch -E 1e-30 --domtbl HMMSEARCH_results/markers-vs-$name.HMM.domtbl markers_3.hmm $file > HMMSEARCH_results/markers-vs-$name.HMM.hmmsearch
done

