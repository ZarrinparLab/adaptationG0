#!/bin/bash
#SBATCH -J MA_refine_AZ51
#SBATCH -n 64
#SBATCH -t 5-00:00:00
#SBATCH --mem=100g 
#SBATCH --mail-user=callaband@ucsd.edu
#SBATCH --mail-type=all
#SBATCH --export=all
#SBATCH -o Output_Files/%x-%N-%j.out 
#SBATCH -e Error_Files/%x-%N-%j.err

source ~/.profile
conda activate microbeannotator

microbeannotator -i $(ls /home/callaban/scratch2/prokka_AZ51/**/*_AZ51_mut.faa) -d /home/callaban/miniconda3/envs/microbeannotator/MicrobeAnnotator_DB/ -o /home/callaban/scratch2/microbeannotator_AZ51_refine -m sword -p 8 -t 8 --light --refine

#find ls /home/callaban/scratch2/prokka_AZ51/**/*_AZ51_mut.faa -type f -empty -delete
#to remove any empty files, left with 1594 samples

#took ~45hrs