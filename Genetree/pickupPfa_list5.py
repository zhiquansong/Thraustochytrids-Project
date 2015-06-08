from Bio import SeqIO
import glob
import sys
from Bio.Alphabet import IUPAC

def main():
    args=glob.glob('DB/*AnnotatedProteins.fasta')
    argo=sys.argv
    with open(argo[1],'r') as sbjctfile:
         sbjcts=[]
         for line in sbjctfile:
             if line.startswith('>'):
	        line=line.rstrip()
	        parts=line.split(' ')
		assert parts[0]=='>'
		for i in range(len(parts)):
		    if i != 0:
		       sbjcts.append(str(parts[i]))
    for i in range(len(args)):
        file_handle = open(args[i])
	for seq_record in SeqIO.parse(file_handle,'fasta'):
            for sbjct in sbjcts:
                if seq_record.id == sbjct :
	           newid=seq_record.id
		   if len(newid) > 10:
		      newid=''
		      newid=sbjct[:3]+sbjct[-7:]
		   idseq=['>',newid]
	           print ''.join(idseq)
	           print seq_record.seq


if __name__ == '__main__':
    main()
