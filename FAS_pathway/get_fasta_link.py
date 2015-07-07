import glob
import sys

def main():
    argr=sys.argv
    with open(argr[1],'r') as webfile:
         tn=0
         for line in webfile:
             if line.startswith('<!-- DDI list -->') :
                tn=1
             if line.startswith(' <td><a') and tn==1 :
	        line=line.rstrip()
	        parts=line.split('\'')
		assert parts[0]==' <td><a href='
                print parts[1]


if __name__ == '__main__':
    main()
