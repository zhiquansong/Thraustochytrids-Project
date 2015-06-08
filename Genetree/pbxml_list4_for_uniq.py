from Bio.Blast import NCBIXML
import sys
import glob

def filename(title): #find the query_id
    parts=title.split('/')
    return parts[-1]

def targetid(title): #find the sbjctID
    parts=title.split('|')
    assert len(parts)==9 and parts[0]=='gnl'  
    id=parts[2]
    idparts=id.split(' ')
    return idparts[1]

def main():
    args=glob.glob('*.xml')
    for i in range(len(args)):
        fname=filename(args[i])
	print 'the file:',fname
	result_handle = open(args[i])
        blast_records = NCBIXML.parse(result_handle)
        print 'CHS GENE:'
	glist=[]
	for blast_record in blast_records:
            for alignment in blast_record.alignments:
	        sbjctID=targetid(alignment.title)
                glist.append(sbjctID)
	glist=list(set(sorted(glist)))
	print '>',' '.join(glist)
	print 'Number:',len(glist)

if __name__ == '__main__':
    main()
