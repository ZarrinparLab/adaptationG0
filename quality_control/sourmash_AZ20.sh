#!/bin/bash
#SBATCH -J Sourmash_AZ20_First
#SBATCH -n 12
#SBATCH -t 1-00:00:00
#SBATCH --mem=10g 
#SBATCH --mail-user=callaband@ucsd.edu
#SBATCH --mail-type=all
#SBATCH --export=all
#SBATCH -o Output_Files/slurm-AZ20-%A.%a.out 
#SBATCH -e Error_Files/slurm-AZ20-%A.%a.err

source ~/.profile
conda activate sourmash

sourmash sketch dna /home/callaban/scratch2/AZ20_assemblies/*.fasta --outdir /home/callaban/scratch2/sourmash_AZ20/
#outdir needs to already exist

sourmash index /home/callaban/scratch2/sourmash_AZ20/AZ20_db /home/callaban/scratch2/sourmash_AZ20/*.sig

sourmash compare -p 8 /home/callaban/scratch2/sourmash_AZ20/AZ20_db.sbt.zip -o sourmash_AZ20/AZ20_cmp

sourmash plot --pdf --labels /home/callaban/scratch2/sourmash_AZ20/AZ20_cmp

while read smp r1 r2 rest; do 
	sourmash search /home/callaban/scratch2/sourmash_AZ20/${smp}*.sig /home/callaban/Projects/additional_genomes/refseq-k31.sbt.zip /home/callaban/Projects/additional_genomes/genbank-k31.lca.json.gz -o /home/callaban/scratch2/sourmash_AZ20/${smp}_search_match.csv --dna
done < /home/callaban/Projects/Adaptation/sourmash_full_list.txt
#takes a long time - submitted separately as job

sourmash lca classify --db /home/callaban/Projects/additional_genomes/genbank-k31.lca.json.gz --query /home/callaban/scratch2/*.sig -o /home/callaban/scratch2/AZ20_lca_classify.csv