#!/bin/bash
#SBATCH -J Panaroo_Both
#SBATCH -N 1
#SBATCH -n 64
#SBATCH -t 7-00:00:00
#SBATCH --mem=400g 
#SBATCH --mail-user=callaband@ucsd.edu
#SBATCH --mail-type=all
#SBATCH --export=all
#SBATCH -o Output_Files/%x-%N-%j.out 
#SBATCH -e Error_Files/%x-%N-%j.err

source ~/.profile
conda activate panaroo

panaroo-qc -t 64 --graph_type all -i /panfs/callaban/all_gff/*.gff --ref_db /panfs/callaban/refseq.genomes.k21s1000.msh -o /panfs/callaban/panaroo_both/preprocessing

panaroo -i /panfs/callaban/all_gff/*.gff -o /panfs/callaban/panaroo_both --clean-mode strict -a core -t 64

#400gb and 40hrs

iqtree -s /panfs/callaban/panaroo_both/core_gene_alignment.aln -m MF -mtree -nt 64 --prefix both_tree

iqtree -s /panfs/callaban/panaroo_both/core_gene_alignment.aln --date /panfs/callaban/panaroo_both/both_date_file.txt --date-root "2017-07-12" -nt 64 --prefix both_date_tree

#400GB and 21 days
