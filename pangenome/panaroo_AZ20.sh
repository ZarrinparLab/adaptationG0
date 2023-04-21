#!/bin/bash
#SBATCH -p long
#SBATCH -J Panaroo_AZ20
#SBATCH -N 1
#SBATCH -n 64
#SBATCH -t 7-00:00:00
#SBATCH --mem=100g 
#SBATCH --mail-user=callaband@ucsd.edu
#SBATCH --mail-type=all
#SBATCH --export=all
#SBATCH -o Output_Files/%x-%N-%j.out 
#SBATCH -e Error_Files/%x-%N-%j.err

source ~/.profile
conda activate panaroo


panaroo-qc -t 64 --graph_type all -i /panfs/callaban/all_AZ20_gff/*.gff --ref_db /panfs/callaban/refseq.genomes.k21s1000.msh -o /panfs/callaban/panaroo_AZ20/preprocessing

panaroo -i /panfs/callaban/all_AZ20_gff/*.gff -o /panfs/callaban/panaroo_AZ20 --clean-mode strict -a core -t 64

#Original took 22hrs

iqtree -s /panfs/callaban/panaroo_AZ20/core_gene_alignment.aln --date /panfs/callaban/panaroo_AZ20/AZ20_date_file.txt --date-root "2017-07-12" -nt 64 --prefix AZ20_date_tree

iqtree -s /panfs/callaban/panaroo_AZ20/core_gene_alignment.aln -m MF -mtree -nt 64 --prefix AZ20_tree


#mkdir /panfs/callaban/panaroo_AZ20/img_results
#panaroo-img --pa /panfs/callaban/panaroo_AZ20/gene_presence_absence.Rtab -o /panfs/callaban/panaroo_AZ20/img_results -tree /panfs/callaban/panaroo_AZ20/dated_phylogeny.newick -t 64

