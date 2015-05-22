# this should be the align script
module load muscle
module load trimal
for i in orthologs/*.fa
do 
  muscle -in $i -out $i.fasaln
  trimal -in $i.fasaln -out $i.fasaln.trim -automated1
done