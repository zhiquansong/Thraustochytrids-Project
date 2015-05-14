import glob
from Bio import SeqIO
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
from Bio.Alphabet import generic_protein

def main():
    args=glob.glob('/rhome/zsong/bigdata/practice/OMApractice/star/*.fasta')
    for i in range(len(args)):
        new_records=[]
        records = SeqIO.parse(args[i], "fasta")
	for record in records:
	    if record.seq.find('*'):
	       nseq = str(record.seq).replace('*','')
	    nrecord=SeqRecord(Seq(nseq, generic_protein),id=record.id,description=record.description)   
	    new_records.append(nrecord)
	SeqIO.write(new_records,args[i],"fasta")
    
if __name__ == '__main__':
    main()
