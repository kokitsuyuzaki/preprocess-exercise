source("src/functions.R")

# Data
set.seed(1234)
input <- matrix(runif(20), nrow=5, ncol=4)
rownames(input) <- paste0("Gene", 1:5)
colnames(input) <- paste0("Cell", 1:4)

# Scaling, Covariance matrix, SVD (PCA)
input %>% t() %>% scale(center=TRUE, scale=FALSE) %>% cov() %>% eigen() -> output

# OR
output <- input %>% t() %>% scale(center=TRUE, scale=FALSE) %>% cov() %>% eigen()

# OR
input %>% t %>% scale(center=TRUE, scale=FALSE) %>% cov %>% eigen -> output
