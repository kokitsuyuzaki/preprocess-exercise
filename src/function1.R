# Data
set.seed(1234)
input <- matrix(runif(20), nrow=5, ncol=4)
rownames(input) <- paste0("Gene", 1:5)
colnames(input) <- paste0("Cell", 1:4)

# Scaling
scaled.mat <- scale(t(input), center=TRUE, scale=FALSE)

# Covariance matrix
cov.mat <- cov(scaled.mat)

# SVD (PCA)
output <- eigen(cov.mat)
