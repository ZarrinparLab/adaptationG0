#!/bin/bash
#SBATCH -J plasmidspades_AZ51A
#SBATCH -n 16
#SBATCH -t 0-12:00:00
#SBATCH --mem=20g 
#SBATCH --array=1-414%20
#SBATCH --mail-user=callaband@ucsd.edu
#SBATCH --mail-type=all
#SBATCH --export=all
#SBATCH -o Output_Files/slurm-%x-%A-%a.out 
#SBATCH -e Error_Files/slurm-%x-%A-%a.err

source ~/.profile

sed -n "${SLURM_ARRAY_TASK_ID}p" /panfs/callaban/plasmidspades_AZ51/AZ51_missing_scaffolds.txt | while read smp r1 r2 x; do 

	if [ -z "${smp:-}" ]; then
		continue
	fi
	nme=$(basename $smp | sed 's/_L00.*//')
	out_dir=/home/callaban/scratch2/plasmidspades_AZ51/${nme}
	if [ ! -s $out_dir/scaffolds.fasta ]; then
		plasmidspades.py -t 16 -1 ${r1} -2 ${r2} --tmp-dir /panfs/callaban/tmp/ --cov-cutoff 50 -o ${out_dir}
		bioawk -c fastx 'length($seq) > 3000 {print ">"$name"\n"$seq"\n"}' ${out_dir}/scaffolds.fasta > ${out_dir}/large_plasmids.fasta
	fi
done