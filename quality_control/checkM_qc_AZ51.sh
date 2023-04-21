#!/bin/bash
#SBATCH -J checkM_AZ51
#SBATCH -n 64
#SBATCH -t 3-00:00:00
#SBATCH --mem=100g 
#SBATCH --mail-user=callaband@ucsd.edu
#SBATCH --mail-type=all
#SBATCH --export=all
#SBATCH -o Output_Files/slurm-AZ51-checkM-%N-%j.out 
#SBATCH -e Error_Files/slurm-AZ51-checkM-%N-%j.err

source ~/.profile
conda activate checkM

checkm taxonomy_wf -t 64 -x fasta -f checkm_AZ51_taxonomy --tab_table domain Bacteria /home/callaban/scratch2/AZ51_assemblies/ /home/callaban/scratch2/checkM_AZ51/

checkm lineage_wf -t 64 -x fasta /home/callaban/scratch2/AZ51_assemblies/ /home/callaban/scratch2/checkM_AZ51_lineage/

#checkm qa ./checkM_AZ51/checkM_AZ51_taxonomy/Bacteria.ms ./checkM_AZ51/checkM_AZ51_taxonomy/ -f checkm_AZ51_taxonomy_summary.txt --tab_table
#checkm tree_qa ./checkM_AZ51/checkM_AZ51_lineage -f checkm_AZ51_lineage_summary.txt --tab_table