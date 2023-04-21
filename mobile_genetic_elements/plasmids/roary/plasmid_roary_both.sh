#!/bin/bash
#SBATCH -J Roary_both_plasmid
#SBATCH -p long
#SBATCH -N 1
#SBATCH -n 32
#SBATCH -t 20-00:00:00
#SBATCH --mem=100g 
#SBATCH --mail-user=callaband@ucsd.edu
#SBATCH --mail-type=all
#SBATCH --export=all
#SBATCH -o Output_Files/%x-%N-%j.out 
#SBATCH -e Error_Files/%x-%N-%j.err

source ~/.profile
conda activate roary

roary -f /home/callaban/scratch2/plasmid_roary_both -e -r -p 64 /home/callaban/scratch2/all_plasmid_gff/*.gff