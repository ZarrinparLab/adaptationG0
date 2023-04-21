#!/bin/bash
#SBATCH -J blastn_vMAG3
#SBATCH -n 32
#SBATCH -t 0-03:00:00
#SBATCH --mem=1g 
#SBATCH --mail-user=callaband@ucsd.edu
#SBATCH --mail-type=all
#SBATCH --export=all
#SBATCH -o /home/callaban/Output_Files/%x-%N-%j.out 
#SBATCH -e /home/callaban/Error_Files/%x-%N-%j.err

source ~/.profile

blastn -query /panfs/callaban/Phage/AZ51/vs2-pass2/AZ51ref/for-dramv/1__1_partial_1-cat_1.fasta -db /panfs/callaban/AZ51_assemblies/AZ51_isolate_db -outfmt 7 -out AZ51_phage_query_vMAG3.txt -max_target_seqs 5000 -num_threads 32
#took <1min