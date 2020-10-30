f <- function(x){
	if(g(x) == sum(x^2)){
		stop("g(x) is not equal to sum(x^2)!!!")
	}
}

g <- function(y){
	sum(h(y))
}

h <- function(z){
	out <- c()
	for(i in z){
		out <- c(out, z[i]^2)
	}
	out
}

# Should be 35
f(c(1, 3, 5))