DIMS = list(range(2,7))

rule all:
	input:
		"results/mars.ipynb",
		"results/mars.RData",
		"results/mars.html",
		expand("results/papermill_{dim}.ipynb", dim=DIMS),
		"results/mars_rmd.html"

# Data download
rule mars_dl:
	output:
		"data/count.txt.gz",
		"data/expdesign.txt.gz"
	conda:
		'envs/myenv.yaml'
	log:
		"logs/mars_dl.log"
	benchmark:
		"benchmarks/mars_dl.txt"
	shell:
		"src/mars_dl.sh"

# Notebook to Notebook
rule mars_nb:
	input:
		"data/count.txt.gz",
		"data/expdesign.txt.gz"
	output:
		notebook="results/mars.ipynb",
		rdata="results/mars.RData"
	conda:
		'envs/myenv.yaml'
	log:
		"logs/mars_nb.log"
	benchmark:
		"benchmarks/mars_nb.txt"
	shell:
		"jupyter nbconvert --to=notebook --execute notebooks/mars.ipynb --ExecutePreprocessor.timeout=600 --output-dir='.' --output {output.notebook}"

# Notebook to HTML
rule mars_html:
	input:
		"data/count.txt.gz",
		"data/expdesign.txt.gz"
	output:
		html="results/mars.html"
	conda:
		'envs/myenv.yaml'
	log:
		"logs/mars_html.log"
	benchmark:
		"benchmarks/mars_html.txt"
	shell:
		"jupyter nbconvert --to=html --execute notebooks/mars.ipynb --ExecutePreprocessor.timeout=600 --output-dir='.' --output {output.html}"

# Papermill
rule mars_papermill:
	input:
		"results/mars.RData"
	output:
		"results/papermill_{dim}.ipynb"
	conda:
		'envs/myenv.yaml'
	params:
		"{dim}"
	log:
		"logs/papermill_{dim}.log"
	benchmark:
		"benchmarks/papermill_{dim}.txt"
	shell:
		"papermill notebooks/papermill.ipynb {output} -p ncomponents {params}"

# R markdown
rule mars_rmd:
	input:
		"data/count.txt.gz",
		"data/expdesign.txt.gz"
	output:
		"results/mars_rmd.html"
	conda:
		'envs/myenv.yaml'
	log:
		"logs/mars_rmd.log"
	benchmark:
		"benchmarks/mars_rmd.txt"
	shell:
		"src/mars_rmd.sh"
