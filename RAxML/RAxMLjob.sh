#PBS -l nodes=1:ppn=4 -N raxml -j oe

module load RAxML

CPU=$PBS_PPN

if [ ! $CPU ]; then
 CPU=2
fi

 raxmlHPC-PTHREADS-SSE3 -p 12345 -s protein.phy -n out2 -m PROTGAMMAAUTO -T $CPU -f a -x 121 -# 10
