import glob
from Bio import SeqIO
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
from Bio.Alphabet import generic_protein

def main():
    args=glob.glob('/rhome/zsong/bigdata/workshop/DB/jgi/*.fasta')
    for i in range(len(args)):
        new_records=[]
        records = SeqIO.parse(args[i], "fasta")
	for record in records:
	    parts=record.id.split('|')
	    if len(parts)== 4:
	       newid='|'.join([parts[1],'_'.join([parts[1],parts[2]])])+' '+parts[3]
	    else:
	        newid='|'.join([parts[1],'_'.join([parts[1],parts[2]])])
	    if record.seq.find('*'):
	       nseq = str(record.seq).replace('*','')
	    nrecord=SeqRecord(Seq(nseq, generic_protein),id=newid,description='')   
	    new_records.append(nrecord)
	SeqIO.write(new_records,args[i],"fasta")
    
if __name__ == '__main__':
    main()
