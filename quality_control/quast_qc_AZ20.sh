#!/bin/bash
#SBATCH -J Quast_AZ20
#SBATCH -n 64
#SBATCH -t 3-00:00:00
#SBATCH --mem=50g 
#SBATCH --mail-user=callaband@ucsd.edu
#SBATCH --mail-type=all
#SBATCH --export=all
#SBATCH -o Output_Files/slurm-AZ20-quast-%N-%j.out 
#SBATCH -e Error_Files/slurm-AZ20-quast-%N-%j.err

source ~/.profile

/home/callaban/quast-5.0.2/quast.py -t 64 /home/callaban/scratch2/AZ20_assemblies/* -r /home/callaban/Projects/AZ20_annotated_assembly.fna -g /home/callaban/Projects/AZ20_annotated.gff --circos --no-read-stats -o /home/callaban/scratch2/quast_AZ20/