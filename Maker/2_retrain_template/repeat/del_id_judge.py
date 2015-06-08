from Bio.Blast import NCBIXML
import sys

def queryid(title): #find the query_id
    parts=title.split('(')
    return parts[0]

def targetid(title): #find the sbjctID
    parts=title.split('|')
    assert len(parts)==2 and parts[0]=='lcl'  
    return parts[1]

def main():
    args=sys.argv
    print 'the file:',args[1]
    result_handle = open(args[1])
    blast_records = NCBIXML.parse(result_handle)
    for blast_record in blast_records:
        if len(blast_record.alignments) != 0 :
           query_id=queryid(blast_record.query)
           print '*****************************************************************************************'
           print query_id
           for alignment in blast_record.alignments:
	       #sbjctID=targetid(alignment.title)
               print alignment.title

if __name__ == '__main__':
    main()

