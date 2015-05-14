import glob
import sys
import fileinput

def replaceAll(infile,searchExp,replaceExp):
    for line in fileinput.input(infile, inplace=1):
        if line.find(searchExp):
	   line = line.replace(searchExp,replaceExp)
	if line.startswith(searchExp):
	   line = ''
	sys.stdout.write(line)

def main():
    args=glob.glob('/rhome/zsong/bigdata/practice/OMApractice/DB/*.fa')
    for i in range(len(args)):
        replaceAll(args[i],"*","")
      
    
if __name__ == '__main__':
    main()
