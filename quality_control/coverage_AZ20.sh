#!/bin/bash
#SBATCH -J BAM_AZ20
#SBATCH -N 1
#SBATCH -n 8
#SBATCH -t 0-12:00:00
#SBATCH --array=1-780%15
#SBATCH --mem=10g 
#SBATCH --mail-user=callaband@ucsd.edu
#SBATCH --mail-type=all
#SBATCH --export=all
#SBATCH -o /home/callaban/Output_Files/%x-%N-%j.out 
#SBATCH -e /home/callaban/Error_Files/%x-%N-%j.err

source ~/.profile

module load bowtie2_bowtie2-2.3.2

sed -n "${SLURM_ARRAY_TASK_ID}p" /home/callaban/Projects/Adaptation/AZ20_list_leA.txt | while read smp r1 r2 x; do 

	if [ -z "${smp:-}" ]; then
		continue
	fi
	out_dir=/panfs/callaban/coverage/AZ20
	if [ ! -s ${out_dir}/${smp}_sorted.bam ]; then
		bowtie2 -x /panfs/callaban/coverage/AZ20/AZ20_ref -p 8 -1 ${r1} -2 ${r2} -S ${out_dir}/${smp}.sam
		samtools sort ${out_dir}/${smp}.sam -o ${out_dir}/${smp}_sorted.bam
	fi
done