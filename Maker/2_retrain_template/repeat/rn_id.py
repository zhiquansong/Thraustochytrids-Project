import sys

def main():
    args=sys.argv
    del_id=[]
    newrec=[]
    for line in open(args[1],"r"):
        if line.startswith('>'):
           print line.replace('rnd','SW8_rnd').strip('\n')
        else:
            print line.strip('\n') 
  
if __name__ == '__main__':
    main()