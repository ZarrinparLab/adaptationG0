#!/bin/bash
#SBATCH -J Sourmash_AZ51_First
#SBATCH -n 12
#SBATCH -t 1-00:00:00
#SBATCH --mem=10g 
#SBATCH --mail-user=callaband@ucsd.edu
#SBATCH --mail-type=all
#SBATCH --export=all
#SBATCH -o Output_Files/slurm-AZ51-%A.%a.out 
#SBATCH -e Error_Files/slurm-AZ51-%A.%a.err

source ~/.profile
conda activate sourmash

sourmash sketch dna /home/callaban/scratch2/AZ51_assemblies/*.fasta --outdir /home/callaban/scratch2/sourmash_AZ51/
#outdir needs to already exist

sourmash index AZ51_db /home/callaban/scratch2/sourmash_AZ51/*.sig

sourmash compare -p 16 /home/callaban/scratch2/sourmash/sourmash_AZ51/AZ51_db.sbt.zip -o /home/callaban/scratch2/sourmash/sourmash_AZ51/AZ51_cmp

sourmash plot --pdf --labels /home/callaban/scratch2/sourmashsourmash_AZ51/AZ51_cmp

while read smp nme rest; do 
	sourmash search /home/callaban/scratch2/sourmash_AZ51/${smp}.sig /home/callaban/Projects/additional_genomes/refseq-k31.sbt.zip /home/callaban/Projects/additional_genomes/genbank-k31.lca.json.gz -o /home/callaban/scratch2/sourmash_AZ51/${nme}_search_match.csv --dna
done < /home/callaban/Projects/Adaptation/AZ51_assembly_list.txt 
#takes a long time - submitted separately as job


sourmash lca classify --db /home/callaban/Projects/additional_genomes/genbank-k31.lca.json.gz --query /home/callaban/scratch2/*.sig -o /home/callaban/scratch2/AZ51_lca_classify.csv
#group, not individual