#!/bin/bash
#SBATCH -J Unicycler_AZ51
#SBATCH -n 24
#SBATCH -t 2-00:00:00
#SBATCH --mem=100g 
#SBATCH --mail-user=callaband@ucsd.edu
#SBATCH --mail-type=all
#SBATCH --export=all
#SBATCH -o Output_Files/slurm-AZ51-%A%a.out 
#SBATCH -e Error_Files/slurm-AZ51-%A%a.err

sed -n "${SLURM_ARRAY_TASK_ID}p" /home/callaban/Projects/Adaptation/AZ51_breseq.txt | while read smp r1 r2; do 

	if [ -z ${smp:-} ]; then
		continue
	fi
	out_dir=/home/callaban/scratch2/unicycler_AZ51/${smp}
	if [ ! -f $out_dir/assembly.fasta ]; then
		unicycler -t 24 -1 ${r1} -2 ${r2} -l /home/callaban/Projects/AZ51_minION.fasta -o ${out_dir}
	fi
done