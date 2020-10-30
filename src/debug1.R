f <- function(x){
	out <- c()
	for(i in x){
		out <- c(out, log10(i))
	}
	sum(out)
}

x <- c(0.13, 0.03, -1.34, 2.13)

f(x)
