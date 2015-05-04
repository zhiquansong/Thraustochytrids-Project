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

def calidentity(I,al): #calculate the identities
    IP=float(I)/al
    return ('%.2f' % IP)

def calcover(cx,ql): #calculate the coverage
    ncx=sorted(cx)
    sn=0
    for i in range(len(ncx)):
        if i == (len(ncx)-1) or ncx[i][1] < ncx[i+1][0]:
	   sn=sn+(ncx[i][1]-ncx[i][0])
	elif ncx[i][1] < ncx[i+1][1] :
	     ncx[i+1][0]=ncx[i][0]
	else :
	     ncx[i+1][1]=ncx[i][1]
    csn=float(sn)/ql	
    return '%.2f'%(csn)

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
        result_matrix=[['QueryID','SbjctID','Coverage','Hsp_number','Identities']]
        for blast_record in blast_records:
            query_id=queryid(blast_record.query)
            for alignment in blast_record.alignments:
	        sbjctID=targetid(alignment.title)
                coverq=[]
	        sum_ident=0
                for hsp in alignment.hsps:
	            ident=calidentity(hsp.identities,hsp.align_length)
	            sum_ident=sum_ident+float(ident)
	            coverq.append([hsp.query_start,hsp.query_end])
	        Hsp_number=len(alignment.hsps)
	        coverage=calcover(coverq,blast_record.query_letters)
	        identities='%.2f'%(float(sum_ident)/Hsp_number)
	        relist=[query_id,sbjctID,coverage,Hsp_number,identities]
                result_matrix.append(relist)
        printMatrix(result_matrix)

if __name__ == '__main__':
    main()
