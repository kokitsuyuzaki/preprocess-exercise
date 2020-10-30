f <- function(x){
    if(is.character(x)){
        sum(x)
	}else{
    	g(x)
	}
}

g <- function(y){
    y <- as.numeric(y)
    sum(y)
}

# Should be 15
f(c("3", "5", "7"))