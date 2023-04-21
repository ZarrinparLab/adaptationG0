#!/bin/bash
#SBATCH -J plasmidProkka_AZ51
#SBATCH -n 16
#SBATCH -t 1-00:00:00
#SBATCH --mem=10g 
#SBATCH --array=1-382%20
#SBATCH --mail-user=callaband@ucsd.edu
#SBATCH --mail-type=all
#SBATCH --export=all
#SBATCH -o Output_Files/%x-%A-%a.out 
#SBATCH -e Error_Files/%x-%A-%a.err

source ~/.profile
conda activate prokka_env

sed -n "${SLURM_ARRAY_TASK_ID}p" /home/callaban/scratch2/plasmidspades_AZ51/AZ51_missing.txt | while read smp x; do 

	if [ -z "${smp:-}" ]; then
		continue
	fi
	nme=$(basename $smp | sed 's/_L00.*//')
	out_dir=/home/callaban/scratch2/plasmidspades_AZ51/${nme}/prokka

	prokka /home/callaban/scratch2/plasmidspades_AZ51/${nme}*/large_plasmids.fasta --proteins /home/callaban/Projects/AZ51.gbk --compliant --cpus 16 --genus Escherichia --species coli --strain AZ51 --outdir $out_dir --prefix ${nme}_AZ51_plasmids --locustag ${nme} --force

done
