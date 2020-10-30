# Original data
left <- LETTERS[1:5]
right <- letters[1:5]
data <- cbind(left, right)
data <- data.frame(data, stringsAsFactors=FALSE)

write.table(left, "left.txt", col.names=FALSE, row.names=FALSE, quote=FALSE)
write.table(right, "right.txt", col.names=FALSE, row.names=FALSE, quote=FALSE)

# Loaded data
left2 <- read.table("left.txt", stringsAsFactors=FALSE)[,1]
right2 <- read.table("right.txt", stringsAsFactors=FALSE)[,1]
data2 <- data.frame(left=left2, right=right2)

# Should be TRUE
identical(data, data2)