#!/bin/bash
#SBATCH -J Quast_AZ51
#SBATCH -n 64
#SBATCH -t 3-00:00:00
#SBATCH --mem=50g 
#SBATCH --mail-user=callaband@ucsd.edu
#SBATCH --mail-type=all
#SBATCH --export=all
#SBATCH -o Output_Files/slurm-AZ51-quast-%N-%j.out 
#SBATCH -e Error_Files/slurm-AZ51-quast-%N-%j.err

source ~/.profile

/home/callaban/quast-5.0.2/quast.py -t 64 /home/callaban/scratch2/AZ51_assemblies/* -r /home/callaban/Projects/AZ51_minION.fasta -g /home/callaban/Projects/AZ51_annotated.gff --circos -o /home/callaban/scratch2/quast_AZ51/