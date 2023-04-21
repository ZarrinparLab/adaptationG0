#!/bin/bash
#SBATCH -J Sourmash_AZ51
#SBATCH -n 16
#SBATCH -t 5-00:00:00
#SBATCH --mem=10g 
#SBATCH --mail-user=callaband@ucsd.edu
#SBATCH --mail-type=all
#SBATCH --export=all
#SBATCH -o Output_Files/slurm-AZ51-sourmash-%N-%j.out 
#SBATCH -e Error_Files/slurm-AZ51-sourmash-%N-%j.err

source ~/.profile
conda activate sourmash

while read smp r1 r2 rest; do 
	sourmash search /home/callaban/scratch2/sourmash_AZ51/${smp}*.sig /home/callaban/Projects/additional_genomes/refseq-k31.sbt.zip /home/callaban/Projects/additional_genomes/genbank-k31.lca.json.gz -o /home/callaban/scratch2/sourmash_AZ51/${smp}_search_match.csv --dna
done < /home/callaban/Projects/Adaptation/sourmash_full_list.txt
#couldn't get to run on slurm, did Tmux