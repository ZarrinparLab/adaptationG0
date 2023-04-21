#!/bin/bash
#SBATCH -J Panaroo_AZ51
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

panaroo-qc -t 64 --graph_type all -i /panfs/callaban/all_AZ51_gff/*.gff --ref_db /panfs/callaban/refseq.genomes.k21s1000.msh -o /panfs/callaban/panaroo_AZ51/preprocessing

panaroo -i /panfs/callaban/all_AZ51_gff/*.gff -o /panfs/callaban/panaroo_AZ51 --clean-mode strict -a core -t 64

#took 400gb and 24hrs

iqtree -s /panfs/callaban/panaroo_AZ51/core_gene_alignment.aln --date /panfs/callaban/panaroo_AZ51/AZ51_date_file.txt --date-root "2017-09-13" -nt 64 --prefix AZ51_date_tree  #23hrs, 65gb

iqtree -s /panfs/callaban/panaroo_AZ51/core_gene_alignment.aln -m MF -mtree -nt 64 --prefix AZ51_tree

#iqtree -s /panfs/callaban/panaroo_AZ51/core_gene_alignment.aln -pre core_tree -nt 8 -fast -m GTR

#mkdir /panfs/callaban/panaroo_AZ51/img_results
#panaroo-img --pa /panfs/callaban/panaroo_AZ51/gene_presence_absence.Rtab -o /panfs/callaban/panaroo_AZ51/img_results -tree /panfs/callaban/panaroo_AZ51/dated_phylogeny.newick -t 64


