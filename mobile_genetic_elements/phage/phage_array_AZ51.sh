#!/bin/bash
#SBATCH -J VirSorter2_AZ51A
#SBATCH -n 32
#SBATCH -t 0-12:00:00
#SBATCH --mem=5g 
#SBATCH --array=1-798%10
#SBATCH --array=799-1596%10
#SBATCH --mail-user=callaband@ucsd.edu
#SBATCH --mail-type=all
#SBATCH --export=all
#SBATCH -o Output_Files/slurm-%x-%A-%a.out 
#SBATCH -e Error_Files/slurm-%x-%A-%a.err

source ~/.profile
conda activate phage_pipeline

cd /home/callaban/scratch2/

sed -n "${SLURM_ARRAY_TASK_ID}p" /home/callaban/scratch2/AZ51_assemblies/AZ51_assembly_list.txt | while read smp x; do 
	
	nme=$(basename -s .fasta $smp)
	
	virsorter run --keep-original-seq -i AZ51_assemblies/${smp} -w Phage/AZ51/vs2-pass1/${nme} --include-groups dsDNAphage,ssDNA --min-length 5000 --min-score 0.5 -j 32 all
	
	checkv end_to_end Phage/AZ51/vs2-pass1/${nme}/final-viral-combined.fa Phage/AZ51/vs2-pass1/${nme}/checkv/ -t 32 -d /home/callaban/checkv-db-v1.1/
	
	cat Phage/AZ51/vs2-pass1/${nme}/checkv/proviruses.fna Phage/AZ51/vs2-pass1/${nme}/checkv/viruses.fna > Phage/AZ51/vs2-pass1/${nme}/checkv/combined.fna

	virsorter run --seqname-suffix-off --viral-gene-enrich-off --provirus-off --prep-for-dramv -i Phage/AZ51/vs2-pass1/${nme}/checkv/combined.fna -w Phage/AZ51/vs2-pass2/${nme} --include-groups dsDNAphage,ssDNA --min-length 5000 --min-score 0.5 -j 32 all

done