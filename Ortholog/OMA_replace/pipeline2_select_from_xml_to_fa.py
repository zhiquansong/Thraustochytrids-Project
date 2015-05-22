from Bio.Blast import NCBIXML
from Bio import SeqIO
from Bio.Seq import Seq
from Bio.SeqRecord import SeqRecord
from Bio.Alphabet import generic_protein
import sys

def filename(title): #find the query_id
    parts=title.split('/')
    separts=parts[-1].split('.')
    return separts[0]

def targetid(title): #find the sbjctID
    parts=title.split(' ')
    return parts[1]

def main():
    sbjcts=[]
    new_records=[]
    if len(sys.argv) < 2:  
       print 'No action specified.'  
       sys.exit()
    xmlfile=sys.argv[1]
    fastafile=sys.argv[2]    
    fname=filename(xmlfile)
    result_handle = open(xmlfile)
    blast_records = NCBIXML.parse(result_handle)
    for blast_record in blast_records:
        for alignment in blast_record.alignments:
	    sbjctID=targetid(alignment.title)
	    sbjcts.append(sbjctID)
    sbjcts=list(set(sorted(sbjcts)))    
    records = SeqIO.parse(fastafile, "fasta")
    for record in records:
        for sbjct in sbjcts:
            if (record.id == sbjct):
	        nrecord=SeqRecord(Seq(str(record.seq), generic_protein),id=record.id,description=record.description)
                new_records.append(nrecord)
    SeqIO.write(new_records,fastafile,"fasta")



if __name__ == '__main__':
    main()
