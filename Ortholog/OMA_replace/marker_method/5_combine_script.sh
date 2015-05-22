# this should be the combine script
#cat orthologs/*.fa | grep '^>' | awk '{print $1}' | sort | uniq | perl -p -e 's/>//' > expected.ids
cat orthologs/*.fa | grep '^>' | awk -F\| '{print $1}' | sort | uniq | perl -p -e 's/>//' > expected.ids

perl combine_fasaln.pl -if fasta -of fasta -d orthologs -o allseq.fasaln -expected expected.ids