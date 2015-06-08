#PBS -l nodes=1:ppn=4,mem=8gb -N blastx -j oe 

cd $PBS_O_WORKDIR

blastall -p blastx -d /srv/projects/db/uniprot/2015_05/uniprot_sprot_nopipes.fasta -i consensi.fa.classified -o consensi.fa.blastout -e 1e-5
blastall -p blastx -d /srv/projects/db/uniprot/2015_05/uniprot_sprot_nopipes.fasta -i consensi.fa.classified -o consensi.fa.xml -e 1e-5 -m 7


echo "Done"
