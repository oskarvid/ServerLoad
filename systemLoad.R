#!/usr/bin/env Rscript
args = commandArgs(trailingOnly=TRUE)

# test if there is at least one argument: if not, return an error
if (length(args)==0) {
  stop("Input file must be given as argument", call.=FALSE)
}

## -- Dataset with system load data --
table <- 
  read.delim(args[1], header = FALSE, sep = "")

#head(table)

setwd('/data')

## -- Create variables for plot dimensions
len=dim(table[1]) # Creates variable that will define the number of x axis data points for the graph
max=head(sort(table[1:len[1],1], decreasing=TRUE)) # Creates variable for y axis maximum height

png('SystemLoad.png', width = 1920, height = 1080)

## -- Plot CPU usage graph --
plot(table[1:len[1],1], xaxt = "n", ylim=c(0, (max[1]+2)), type = "l" , col="blue", 
     xlab="Time", ylab="Server Load", 
     main = "CPU usage")

## Print 5 minute load average
lines(table[1:len[1],2], xaxt = "n", type="l", col="green")

## Print 15 minute load average
lines(table[1:len[1],3], xaxt = "n", type="l", col="red")

## Draw X axis
axis(1, at=1:len[1], labels = table[1:len[1],6])

## Create legend
legend("topright", c("1 minute load average", "5 minute load average", "15 minute load average"), col=c("blue", "green", "red"), lty=c(1),
       inset=c(0,0), xpd=TRUE, bty="n", cex = 2
)

invisible(dev.off())
print("SystemLoad.png has been created")

## Remove "G" from the disk usage column
table[,11] <- gsub("G", "", table[,11])
table[,12] <- gsub("G", "", table[,12])

#tail(table)


png('DiskUsage.png', width = 1920, height = 1080)

## -- Plot disk usage graph
plot(table[,11], xaxt = "n", ylim=c(0, 1000), type = "l" , col="blue", 
     xlab="Time", ylab="Disk Usage", 
     main = "Disk usage")

## Draw X axis
axis(1, at=1:len[1], labels = table[1:len[1],6])

## Create legend
legend("topright", c("/dev/sdb1"), col=c("blue"), lty=c(1),
       inset=c(0,0), xpd=TRUE, bty="n", cex = 2
)

invisible(dev.off())
print("DiskUsage.png has been created")

## -- Create variables for plot dimensions
len=dim(table[1]) # Creates variable that will define the number of x axis data points for the graph
max=max(as.numeric(table[1:len[1],13])) # Creates variable for y axis maximum height

png('RAM-Usage.png', width = 1920, height = 1080)

## -- Plot RAM usage graph
plot(table[,14], xaxt = "n", ylim=c(0, max), type = "l" , col="blue", 
     xlab="Time", ylab="RAM Usage (MB)", 
     main = "RAM usage")

## Print free RAM line
lines(table[1:len[1],15], xaxt = "n", type="l", col="green")

## Print available RAM line
lines(table[1:len[1],16], xaxt = "n", type="l", col="purple")

## Draw X axis
axis(1, at=1:len[1], labels = table[1:len[1],6])

## Create legend
legend("topright", c("Used RAM", "Free RAM", "Available RAM"), col=c("blue", "green", "purple"), lty=c(1,1,1),
       inset=c(0,0), xpd=TRUE, bty="n", cex = 2
)

invisible(dev.off())
print("RAM-Usage.png has been created")
