source("src/functions.R")

# Data loading
# count <- read.table("data/count.txt.gz", row.names=1, header=TRUE, sep="\t")
# expdesign <- read.table("data/expdesign.txt.gz", row.names=1, header=TRUE,
# 	sep="\t", skip=6, stringsAsFactors = FALSE)
count <- read_delim("data/count.txt.gz", delim="\t")
expdesign <- read_delim("data/expdesign.txt.gz", delim="\t", skip=6)

#################################################
# Wide -> Long
#################################################
# Merge
# Filtering non single-cells / zero count cells
# count %>%
# 	rownames_to_column("gene") %>%
# 		pivot_longer(-gene, names_to="cell", values_to="exp") %>%
# 			mutate(cell = str_replace(cell, "^X", "")) %>%
# 				inner_join(expdesign,
# 					by=c("cell"="Column_name_in_processed_data_file")) %>%
# 					rename_all(tolower) %>%
# 						group_by(cell) %>%
# 							mutate(sum=sum(exp)) %>%
# 									filter(sum != 0 &&
# 										number_of_cells == 1 &&
# 										group_name %in%
# 											c("B cell", "CD8+pDC",
# 												"monocyte_or_neutrophil", "NK_cell")) %>%
# 											ungroup %>%
# 												arrange(cell) -> marsdata

count %>%
	pivot_longer(-gene_name, names_to="cell", values_to="exp") %>%
		inner_join(expdesign,
			by=c("cell"="Column_name_in_processed_data_file")) %>%
			rename_all(tolower) %>%
				group_by(cell) %>%
					mutate(sum=sum(exp)) %>%
							filter(sum != 0 &&
								number_of_cells == 1 &&
								group_name %in%
									c("B cell", "CD8+pDC",
										"monocyte_or_neutrophil", "NK_cell")) %>%
									ungroup %>%
										arrange(cell) -> marsdata

#################################################
# Long -> Wide
#################################################
# Extract gene expression part
marsdata %>%
	select(gene_name, cell, exp) %>%
		pivot_wider(names_from="cell", values_from="exp") -> wide_marsdata

# Gene name
wide_marsdata %>%
	select(gene_name) %>%
		data.frame %>%
			.[,1] -> genename

# Expression matrix -> SingleCellExperiment
wide_marsdata %>%
	select(!gene_name) %>%
		as.matrix %>%
			SingleCellExperiment(assays=list(counts=.[])) -> sce_marsdata

# rownames
genename -> rownames(sce_marsdata)

# coldata
marsdata %>%
	select(!c(gene_name, exp)) %>%
		distinct %>%
			arrange(cell) %>%
				DataFrame -> colData(sce_marsdata)

#################################################
# scater
#################################################
# Analysis workflow of scater
sce_marsdata %>%
	logNormCounts %>%
		runPCA(ntop=2000, ncomponents=10) %>%
			runTSNE(dimred = "PCA") %>%
				runUMAP(dimred = "PCA") -> sce_marsdata
# save
save(sce_marsdata, file="results/mars.RData")

#################################################
# Visualization
#################################################
# Standard plot functions of R
pairs(reducedDim(sce_marsdata, "PCA"),
	col=factor(colData(sce_marsdata)$group_name),
	pch=16, cex=0.5, main="PCA")

plot(reducedDim(sce_marsdata, "TSNE"),
	col=factor(colData(sce_marsdata)$group_name),
	xlab="tSNE1", ylab="tSNE2",
	pch=16, cex=2, main="tSNE")

# Pair/scatter plot (scater)
sce_marsdata %>%
	plotReducedDim(dimred="PCA", colour_by="group_name", ncomponents=10)
sce_marsdata %>%
	plotReducedDim(dimred="TSNE", colour_by="group_name")
sce_marsdata %>%
	plotReducedDim(dimred="UMAP", colour_by="group_name")

# Scatter plot (schex)
sce_marsdata %>%
	make_hexbin(nbins=40, dimension_reduction="TSNE") %>%
		plot_hexbin_feature(feature="Cd8a", type="logcounts",
			action="mean", xlab="tSNE1", ylab="tSNE2",
			title=paste0("Mean of Cd8a"))

# ggplot2
reducedDim(sce_marsdata, "TSNE") %>%
	cbind(colData(sce_marsdata)$group_name) %>%
		data.frame %>%
			mutate_at(vars(-X3), as.numeric) %>%
			ggplot(aes(x=X1, y=X2, color=X3)) +
				geom_point() +
					xlab("PC1") +
						ylab("PC2") +
							theme(legend.title = element_blank())

# ggpairs
reducedDim(sce_marsdata, "PCA") %>%
	cbind(colData(sce_marsdata)$group_name) %>%
		data.frame %>%
			mutate_at(vars(-V11), as.numeric) %>%
			ggpairs(columns=1:10, aes(color=V11))

# pairsD3
reducedDim(sce_marsdata, "PCA") %>%
	.[,1:5] %>%
		pairsD3(group=colData(sce_marsdata)$group_name,
			tooltip=colData(sce_marsdata)$cell)

# Plotly
reducedDim(sce_marsdata) %>%
	as_tibble %>%
		select(PC1, PC2, PC3) %>%
			data.frame %>%
				plot_ly(x=~PC1, y=~PC2, z=~PC3,
			    type = "scatter3d", mode = "markers",
			    text = colData(sce_marsdata)$cell,
			    color =~colData(sce_marsdata)$group_name
			    )

# iSEE
app <- iSEE(sce_marsdata)
runApp(app)
