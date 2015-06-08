from Bio.Blast import NCBIXML
import sys
import glob

def queryid(title): #find the query_id
    parts=title.split('|')
    assert len(parts)==5 and parts[0]=='gi' and (parts[2]=='emb' or 'gb')
    return parts[3]

def targetid(title): #find the sbjctID
    parts=title.split('|')
    assert len(parts)==9 and parts[0]=='gnl'  
    id=parts[2]
    idparts=id.split(' ')
    return idparts[1]

def targetlen(title): #find the sbjctlength 
    parts=title.split('|')
    assert len(parts)==9 and parts[0]=='gnl'           
    length=parts[6]
    lenparts=length.split('=')
    return lenparts[1]

def calidentity(I,al): #calculate the identities
    IP=float(I)/(al)
    return ('%.2f' % IP)

def seqrange(start,end): #find query and sbjct range
    m=[str(start),':',str(end)]
    return ''.join(m)

def printMatrix(result):
    print ' '
    for i,x in enumerate(result):
        print i,' '.join([str(y) for y in x])

def main():
    args=glob.glob('*.xml')
    for i in range(len(args)):
        print '*****************************************************************************************'
        print 'the file:',args[i]
	result_handle = open(args[i])
        blast_records = NCBIXML.parse(result_handle)
        result_matrix=[['QueryID','Query_length','SbjctID','Sbjct_length','Alignment_length','Bitscore','Expect','Identities','Query_range','Sbjct_range']]
        for blast_record in blast_records:
            query_id=queryid(blast_record.query)
            querylength=blast_record.query_letters
            for alignment in blast_record.alignments:
	        sbjctID=targetid(alignment.title)
	        sbjctlength=targetlen(alignment.title)
                for hsp in alignment.hsps:
	            identities=calidentity(hsp.identities,hsp.align_length)
	            query_range=seqrange(hsp.query_start,hsp.query_end)
	            sbjct_range=seqrange(hsp.sbjct_start,hsp.sbjct_end)
        	    relist=[query_id,querylength,sbjctID,sbjctlength,hsp.align_length,hsp.bits,hsp.expect,identities,query_range,sbjct_range]
                    result_matrix.append(relist)
        printMatrix(result_matrix)

if __name__ == '__main__':
    main()

