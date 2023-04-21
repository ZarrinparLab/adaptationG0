#!/bin/bash
#SBATCH -J AZ51ref_Phage
#SBATCH -n 32
#SBATCH -t 1-00:00:00
#SBATCH --mem=20g 
#SBATCH --mail-user=callaband@ucsd.edu
#SBATCH --mail-type=all
#SBATCH --export=all
#SBATCH -o Output_Files/slurm-%x-%N-%j.out 
#SBATCH -e Error_Files/slurm-%x-%N-%j.err

source ~/.profile

conda activate phage_pipeline

cd /home/callaban/scratch2/

virsorter run --keep-original-seq -i /home/callaban/Projects/AZ51ref_assembly.fasta -w Phage/AZ51/vs2-pass1/AZ51ref --include-groups dsDNAphage,ssDNA --min-length 5000 --min-score 0.5 -j 32 all

checkv end_to_end Phage/AZ51/vs2-pass1/AZ51ref/final-viral-combined.fa Phage/AZ51/vs2-pass1/AZ51ref/checkv/ -t 32 -d /home/callaban/checkv-db-v1.1/

cat Phage/AZ51/vs2-pass1/AZ51ref/checkv/proviruses.fna Phage/AZ51/vs2-pass1/AZ51ref/checkv/viruses.fna > Phage/AZ51/vs2-pass1/AZ51ref/checkv/combined.fna

virsorter run --seqname-suffix-off --viral-gene-enrich-off --provirus-off --prep-for-dramv -i Phage/AZ51/vs2-pass1/AZ51ref/checkv/combined.fna -w Phage/AZ51/vs2-pass2/AZ51ref --include-groups dsDNAphage,ssDNA --min-length 5000 --min-score 0.5 -j 32 all

conda deactivate

conda activate DRAMv

DRAM-v.py annotate -i Phage/AZ51/vs2-pass2/AZ51ref/for-dramv/final-viral-combined-for-dramv.fa -v Phage/AZ51/vs2-pass2/AZ51ref/for-dramv/viral-affi-contigs-for-dramv.tab -o Phage/AZ51/DRAMv/AZ51ref --skip_trnascan --threads 16 --min_contig_size 1000

DRAM-v.py distill -i Phage/AZ51/DRAMv/AZ51ref/annotations.tsv -o Phage/AZ51/DRAMv/AZ51ref/dramv-distill