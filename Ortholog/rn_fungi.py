import glob
from Bio import SeqIO
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
from Bio.Alphabet import generic_protein

def main():
    args=glob.glob('/rhome/zsong/bigdata/workshop/DB/fungi/*.rename')
    for i in range(len(args)):
        new_records=[]
        records = SeqIO.parse(args[i], "fasta")
	for record in records:
	    parts=record.description.split('|')
	    tit1=parts[1].split('=')
	    title1=tit1[1].split('_')
            firn=title1[0]
	    secn=title1[1]
	    title=firn[0:3]+secn[0:2]
	    newid='|'.join([title,parts[0]])+''+parts[3]
	    if record.seq.find('*'):
	       nseq = str(record.seq).replace('*','')
	    nrecord=SeqRecord(Seq(nseq, generic_protein),id=newid,description='')   
	    new_records.append(nrecord)
	SeqIO.write(new_records,args[i],"fasta")
    
if __name__ == '__main__':
    main()
