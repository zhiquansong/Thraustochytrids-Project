import glob
from Bio import SeqIO
from Bio.Seq import Seq

def main():
    args=glob.glob('*.aa')
    for i in range(len(args)):
        n=0
	gname=[]
        records = SeqIO.parse(args[i], "fasta")
	for record in records:
	    prot=[]
            prot=record.id.split('|')
            gname.append(prot[0])
	for gn in gname:
            if (gname.count(gn)!=1):
                n=n+1
	if (n==0) :
	    print args[i]

if __name__ == '__main__':
    main()
