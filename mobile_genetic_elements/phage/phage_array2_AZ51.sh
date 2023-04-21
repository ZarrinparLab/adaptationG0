#!/bin/bash
#SBATCH -J VirSorter2_AZ51A
#SBATCH -n 32
#SBATCH -t 5-00:00:00
#SBATCH --mem=50g 
#SBATCH --array=1-798%10
#SBATCH --array=799-1596%10
#SBATCH --mail-user=callaband@ucsd.edu
#SBATCH --mail-type=all
#SBATCH --export=all
#SBATCH -o Output_Files/slurm-%x-%A-%a.out 
#SBATCH -e Error_Files/slurm-%x-%A-%a.err

source ~/.profile
conda activate DRAMv

cd /home/callaban/scratch2/

sed -n "${SLURM_ARRAY_TASK_ID}p" /home/callaban/scratch2/AZ51_assemblies/AZ51_assembly_list.txt | while read smp x; do 
	
	nme=$(basename -s .fasta $smp)

	DRAM-v.py annotate -i Phage/AZ51/vs2-pass2/${nme}/for-dramv/final-viral-combined-for-dramv.fa -v Phage/AZ51/vs2-pass2/${nme}/for-dramv/viral-affi-contigs-for-dramv.tab -o Phage/AZ51/DRAMv/${nme}/dramv-annotate --skip_trnascan --threads 32 --min_contig_size 1000

	DRAM-v.py distill -i Phage/AZ51/DRAMv/${nme}/dramv-annotate/annotations.tsv -o Phage/AZ51/DRAMv/${nme}/dramv-distill
done