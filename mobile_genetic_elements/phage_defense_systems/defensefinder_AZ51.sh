#!/bin/bash
#SBATCH -J defensefinder_AZ51A
#SBATCH -n 16
#SBATCH -t 1-00:00:00
#SBATCH --mem=10g 
#SBATCH --array=1-986%10
#SBATCH --mail-user=callaband@ucsd.edu
#SBATCH --mail-type=all
#SBATCH --export=all
#SBATCH -o Output_Files/%x-%A-%a.out 
#SBATCH -e Error_Files/%x-%A-%a.err

source ~/.profile
conda activate defensefinder

sed -n "${SLURM_ARRAY_TASK_ID}p" /home/callaban/Projects/Adaptation/AZ51_list_leA.txt | while read smp r1 r2 x; do 

	if [ -z "${smp:-}" ]; then
		continue
	fi
	nme=$(basename $smp | sed 's/_L00.*//')
	
	defense-finder run /home/callaban/scratch2/prokka_AZ51/${nme}/${nme}_AZ51_mut.faa -w 16 -o /home/callaban/scratch2/defensefinder_AZ51/${nme}

done