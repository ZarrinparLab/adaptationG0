#!/bin/bash
#SBATCH -J Prokka_AZ20A
#SBATCH -n 16
#SBATCH -t 1-00:00:00
#SBATCH --mem=8g 
#SBATCH --array=1-780%20
#SBATCH --mail-user=callaband@ucsd.edu
#SBATCH --mail-type=all
#SBATCH --export=all
#SBATCH -o Output_Files/%x-%A-%a.out 
#SBATCH -e Error_Files/%x-%A-%a.err

source ~/.profile
conda activate prokka_env

sed -n "${SLURM_ARRAY_TASK_ID}p" /home/callaban/Projects/Adaptation/AZ20_list_leA.txt | while read smp r1 r2 x; do 

	if [ -z "${smp:-}" ]; then
		continue
	fi
	out_dir=/home/callaban/scratch2/prokka_AZ20/${smp}
	nme=$(basename $smp | sed 's/_L00.*//')
	
	prokka /home/callaban/scratch2/AZ20_assemblies/${smp}.fasta --proteins /home/callaban/Projects/AZ20.gbk --compliant --cpus 16 --genus Escherichia --species coli --strain AZ20 --outdir $out_dir --prefix ${nme}_AZ20_mut --locustag ${nme} --force

done