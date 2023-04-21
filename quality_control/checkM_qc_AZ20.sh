#!/bin/bash
#SBATCH -J checkM_AZ20
#SBATCH -n 64
#SBATCH -t 3-00:00:00
#SBATCH --mem=100g 
#SBATCH --mail-user=callaband@ucsd.edu
#SBATCH --mail-type=all
#SBATCH --export=all
#SBATCH -o Output_Files/slurm-AZ20-checkM-%N-%j.out 
#SBATCH -e Error_Files/slurm-AZ20-checkM-%N-%j.err

source ~/.profile
conda activate checkM

checkm taxonomy_wf -t 64 -x fasta -f checkm_AZ20_taxonomy --tab_table domain Bacteria /home/callaban/scratch2/AZ20_assemblies/ /home/callaban/scratch2/checkM_AZ20/

checkm lineage_wf -t 64 -x fasta /home/callaban/scratch2/AZ20_assemblies/ /home/callaban/scratch2/checkM_AZ20_lineage/

#checkm qa ./checkM_AZ20/checkM_AZ20_taxonomy/Bacteria.ms ./checkM_AZ20/checkM_AZ20_taxonomy/ -f checkm_AZ20_taxonomy_summary.txt --tab_table
#checkm tree_qa ./checkM_AZ20/checkM_AZ20_lineage -f checkm_AZ20_lineage_summary.txt --tab_table