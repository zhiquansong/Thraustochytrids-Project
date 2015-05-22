from Bio.Blast import NCBIXML
from Bio import SeqIO
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
from Bio.Alphabet import generic_protein
import glob

def filename(title): #find the query_id
    parts=title.split('/')
    separts=parts[-1].split('.')
    return separts[0]

def targetid(title): #find the sbjctID
    parts=title.split(' ')
    return ' '.join(parts[1])

def main():
    args=glob.glob('/bigdata/zsong/practice/OMApractice/xml/*.xml')
    for i in range(len(args)):
        fname=filename(args[i])
        fpath=''.join(['/bigdata/zsong/practice/OMApractice/DB/',fname,'.fa.oma'])
        result_handle = open(args[i])
        blast_records = NCBIXML.parse(result_handle)
	sbjcts=[]
	for blast_record in blast_records:
            for alignment in blast_record.alignments:
		sbjctID=targetid(alignment.title)
		sbjcts.append(sbjctID)
	sbjcts=list(set(sorted(sbjcts)))
        new_records=[]
        records = SeqIO.parse(fpath, "fasta")
	for record in records:
            for sbjct in sbjcts:
                if (record.id == sbjct):
	           nrecord=SeqRecord(Seq(str(record.seq), generic_protein),id=record.id,description=record.description)
                   new_records.append(nrecord)
        SeqIO.write(new_records,fpath,"fasta")



if __name__ == '__main__':
    main()