#!/bin/bash
#SBATCH -J Unicycler_AZ20_First
#SBATCH -n 24
#SBATCH -t 2-00:00:00
#SBATCH --mem=100g 
#SBATCH --mail-user=callaband@ucsd.edu
#SBATCH --mail-type=all
#SBATCH --export=all
#SBATCH -o Output_Files/slurm-AZ20-%A-%a.out 
#SBATCH -e Error_Files/slurm-AZ20-%A-%a.err

sed -n "${SLURM_ARRAY_TASK_ID}p" /home/callaban/Projects/Adaptation/AZ20_breseq00_le.txt | while read smp r1 r2 x; do 

	if [ -z "${smp:-}" ]; then
		continue
	fi
	out_dir=/home/callaban/scratch2/unicycler_AZ20/${smp}
	if [ ! -s $out_dir/assembly.fasta ]; then
		unicycler -t 24 -1 ${r1} -2 ${r2} -l /home/callaban/Projects/AZ20_annotated_genome.fna -o ${out_dir}
	fi
done