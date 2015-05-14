for file in jgi/*.fasta
do
 perl -p -e 's/>jgi\|([^\|]+)\|(\d+)\|?/>$1_$2 /' $file > $file.rename
done
