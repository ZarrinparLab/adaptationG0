#!/bin/bash
#SBATCH -J Prokka_AZ51_redo
#SBATCH -n 16
#SBATCH -t 1-00:00:00
#SBATCH --mem=10g 
#SBATCH --array=1-721%20
#SBATCH --mail-user=callaband@ucsd.edu
#SBATCH --mail-type=all
#SBATCH --export=all
#SBATCH -o Output_Files/%x-%A-%a.out 
#SBATCH -e Error_Files/%x-%A-%a.err

source ~/.profile
conda activate prokka_env

sed -n "${SLURM_ARRAY_TASK_ID}p" /home/callaban/Projects/Adaptation/AZ51_redo_fulllist.txt | while read smp r1 r2 x; do 

	if [ -z "${smp:-}" ]; then
		continue
	fi
	out_dir=/home/callaban/scratch2/prokka_AZ51/${smp}
	fi
	if [ ! -s $out_dir/${smp}_AZ51_mut.gbk ]; then
	prokka /home/callaban/scratch2/AZ51_assemblies/${smp}.fasta --proteins /home/callaban/Projects/AZ51_mouse_native_strain.gbk --compliant --cpus 16 --genus Escherichia --species coli --strain AZ51 --outdir $out_dir --prefix ${smp}_AZ51_mut --locustag ${smp}
	fi
done