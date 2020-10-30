f <- function(x){
	out <- seq.Date(Sys.Date(), length.out=x, by="1 day")
	g(out)
}

g <- function(y){
 out <- factor(y, levels=unique(y))
 h(out)
}

h <- function(z){
	if(NA %in% z){
		stop("At least one NA value is in z!!!")
	}else{
		z
	}
}
