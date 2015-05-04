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
        finalmatrix=[['QueryID','Sbjct_number','Sbjctlist']]
        for blast_record in blast_records:
            query_id=queryid(blast_record.query)
            slist=[]
            for alignment in blast_record.alignments:
	        sbjctID=targetid(alignment.title)
                slist.append(sbjctID)
            sbjctlist=','.join(slist)
            sbjct_number=len(blast_record.alignments)
            finalist=[query_id,sbjct_number,sbjctlist]
            finalmatrix.append(finalist)
        printMatrix(finalmatrix)

if __name__ == '__main__':
    main()
