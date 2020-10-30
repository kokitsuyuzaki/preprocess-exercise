# Data
set.seed(1234)
input <- matrix(runif(20), nrow=5, ncol=4)
rownames(input) <- paste0("Gene", 1:5)
colnames(input) <- paste0("Cell", 1:4)

# Mean
m <- rep(0, length=nrow(input))
for(i in 1:nrow(input)){
	m[i] <- mean(input[i,])
}

# Scaling
scaled.mat <- input
for(i in 1:nrow(input)){
	scaled.mat[i,] <- input[i,] - m[i]
}

# Covariance matrix
cov.mat <- matrix(0, nrow=nrow(input), ncol=nrow(input))
for(i in 1:nrow(cov.mat)){
	for(j in 1:ncol(cov.mat)){
		cov.mat[i,j] <- cov(scaled.mat[i,], scaled.mat[j,])
	}
}

# SVD (PCA)
output <- eigen(cov.mat)
