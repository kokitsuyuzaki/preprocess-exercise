# Data
set.seed(1234)
input <- matrix(runif(20), nrow=5, ncol=4)
rownames(input) <- paste0("Gene", 1:5)
colnames(input) <- paste0("Cell", 1:4)

# Mean
m <- apply(input, 1, mean)

# Scaling
scaled.mat <- apply(input, 2, function(x, m){
	x - m
}, m=m)

# Covariance matrix
cov.mat <- cov(t(scaled.mat))

# SVD (PCA)
output <- eigen(cov.mat)
