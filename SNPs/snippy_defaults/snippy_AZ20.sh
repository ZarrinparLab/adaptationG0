#!/bin/bash
#SBATCH -J Snippy_AZ20_First
#SBATCH -n 8
#SBATCH -t 0-03:00:00
#SBATCH --mem=16g 
#SBATCH --array=1-780%10
#SBATCH --mail-user=callaband@ucsd.edu
#SBATCH --mail-type=all
#SBATCH --export=all
#SBATCH -o Output_Files/%x-%A-%a.out 
#SBATCH -e Error_Files/%x-%A-%a.err

source ~/.profile
conda activate snippy

sed -n "${SLURM_ARRAY_TASK_ID}p" /home/callaban/Projects/Adaptation/AZ20_list_leA.txt | while read smp r1 r2 rest; do
	
	if [ -z "${smp:-}" ]; then
		continue
	fi
	out_dir=/home/callaban/scratch2/snippy_indv_AZ20/${smp}
	
	snippy --outdir "${out_dir}" --reference "/home/callaban/Projects/AZ20_Nissle_ref_compliant.gbk" --R1 "${r1}" --R2 "${r2}" --prefix "${smp}" --unmapped -cpus 8 --mincov 10 --minfrac 0.75 --minqual 90 --report
done