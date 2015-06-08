grep ">" Mn35.all.maker.proteins.fasta | awk '{print $3}' | perl -p -e 's/AED://' > aed.dat
