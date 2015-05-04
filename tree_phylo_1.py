from Bio import Phylo

def main():
    tree = Phylo.read("align_trim_done.phy", "newick")
    Phylo.draw(tree)

if __name__ == '__main__':
    main()
