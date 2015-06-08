import sys
from Bio import SeqIO
from Bio.Seq import Seq

def main():
    args=sys.argv
    del_id=[]
    newrec=[]
    for line in open(args[1],"r"):
        del_id.append(line.strip())
    records = SeqIO.parse(args[2],"fasta")
    for rec in records:
        if rec.id not in del_id:
           newrec.append(rec)
    SeqIO.write(newrec,"consensi.fa.filtered","fasta")

    
if __name__ == '__main__':
    main()
