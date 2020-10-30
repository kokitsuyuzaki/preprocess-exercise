#$ -l nc=4
#$ -p -50
#$ -r yes
#$ -q large.q

#SBATCH -n 4
#SBATCH --nice=50
#SBATCH --requeue
#SBATCH -p node03-06
SLURM_RESTART_COUNT=2

# Data download
curl https://ftp.ncbi.nlm.nih.gov/geo/series/GSE54nnn/GSE54006/suppl/GSE54006%5Fumitab%2Etxt%2Egz > data/count.txt.gz
curl https://ftp.ncbi.nlm.nih.gov/geo/series/GSE54nnn/GSE54006/suppl/GSE54006%5Fexperimental%5Fdesign%2Etxt%2Egz > data/expdesign.txt.gz