#!/bin/bash
#SBATCH -J Roary_AZ20_plasmid
#SBATCH -N 1
#SBATCH -n 32
#SBATCH -p long
#SBATCH -t 10-00:00:00
#SBATCH --mem=50g 
#SBATCH --mail-user=callaband@ucsd.edu
#SBATCH --mail-type=all
#SBATCH --export=all
#SBATCH -o Output_Files/%x-%N-%j.out 
#SBATCH -e Error_Files/%x-%N-%j.err

source ~/.profile
conda activate roary

roary -f /home/callaban/scratch2/plasmid_roary_AZ20 -e -r -p 32 /home/callaban/scratch2/plasmid_AZ20_gff/*.gff