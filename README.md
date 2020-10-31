# preprocess-exercise
Preprocessing tutorial for bioinformatics intermediate

## Requirements in my environment
- Bash: GNU bash, version 3.2.57(1)-release (x86_64-apple-darwin19)
- Anaconda: 4.9.0

## Precedure to crate the conda environment

```bash
conda create -y -n r-4.0 r=4.0
conda activate r-4.0
conda install -y -c conda-forge snakemake
conda install -y -c conda-forge jupyter
conda install -y -c conda-forge jupyterlab
conda install -c r r-irkernel
conda install -y -c conda-forge papermill
conda install -y -c conda-forge r-tidyverse
conda install -y -c conda-forge r-ggbeeswarm
conda install -y -c conda-forge r-shiny
conda install -y -c conda-forge r-plotly
conda install -y -c conda-forge r-pairsd3
conda install -y -c conda-forge r-ggpairs
conda install -y -c conda-forge r-rtsne
conda install -y -c conda-forge r-uwot
conda install -y -c conda-forge r-lintr
conda install -y -c conda-forge r-formatr
conda install -y -c conda-forge r-styler
conda install -y -c conda-forge r-markdown
conda install -y -c conda-forge r-knitr
conda install -y -c bioconda bioconductor-singlecellexperiment
conda install -y -c bioconda bioconductor-scater
conda install -y -c bioconda bioconductor-schex
conda install -y -c bioconda bioconductor-isee
conda install -y -c bioconda bioconductor-s4vectors
R -e "IRkernel::installspec()"
mkdir -p envs
conda env export > envs/myenv.yaml
```

## How to perform the snakemake

```bash
snakemake --cores 1
```

## How to start R

```bash
R
```

## How to start Jupyter notebook

```bash
jupyter notebook
```

## How to start JupyterLab

```bash
jupyter lab
```