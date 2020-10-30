#$ -l nc=4
#$ -p -50
#$ -r yes
#$ -q large.q

#SBATCH -n 4
#SBATCH --nice=50
#SBATCH --requeue
#SBATCH -p node03-06
SLURM_RESTART_COUNT=2

R -e "source('src/functions.R'); render('markdown/mars.Rmd', 'html_document', '../results/mars_rmd.html')"
