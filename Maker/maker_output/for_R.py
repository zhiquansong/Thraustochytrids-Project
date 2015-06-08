import sys

def main():
    args=sys.argv
    alist=[]
    for line in open(args[1],"r"):
        alist=[].append(line.strip())
    print ','.join(alist)
    
if __name__ == '__main__':
    main()