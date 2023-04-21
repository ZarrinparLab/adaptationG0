#!/bin/bash
#SBATCH -J Breseq_AZ20_First
#SBATCH -n 12
#SBATCH -t 1-00:00:00
#SBATCH --mem=12g 
#SBATCH --array=1-780%10
#SBATCH --mail-user=callaband@ucsd.edu
#SBATCH --mail-type=all
#SBATCH --export=all
#SBATCH -o Output_Files/%x-%A-%a.out 
#SBATCH -e Error_Files/%x-%A-%a.err

source ~/.profile
conda activate breseq

sed -n "${SLURM_ARRAY_TASK_ID}p" /home/callaban/Projects/Adaptation/AZ20_list_leA.txt | while read smp r1 r2 rest; do

	if [ -z "${smp:-}" ]; then
		continue
	fi
	out_dir=/home/callaban/scratch2/breseq_indv_AZ20/${smp}
	if [ -d ${out_dir} ]; then
		out_dir=${out_dir}
	fi
	breseq -n -p -j 12 -r /home/callaban/Projects/AZ20_Nissle_ref_compliant_breseq.gff $r1 $r2 -o $out_dir

done

