#!/usr/bin/env Rscript
library("ggplot2")

# Load getCovData.R in the same dir of this script
args <- commandArgs(trailingOnly=FALSE)
ScriptName <- sub("--file=", "", args[grep("--file=", args)])
getCovData <- paste(dirname(ScriptName), "getCovData.R", sep="/")
source(getCovData)  # Function getCovData

# Pass 2 parameters to the script:
# 1. CovDir: The dir contain Coverage file. Rv.01.coverage.p
# 2. InList: The position info of seq. at least 6-column.
print("Usage: Rscript getSeqCovFig.R InDir InFile")
args   <- commandArgs(TRUE)
#InDir <- "Rv.coverage"
InDir  <- args[1] 
InFile <- args[2]
FlankGap <- 200
print(c("Input parameters:", args))
# Read in seq info
InLists <- read.table(InFile, comment.char="")
names(InLists) <- c("ID", "Strain", "Length", "Begin", "End", "Strand")
InLists$Note   <- apply(InLists[, c(1,3:6)], 1, paste, collapse=":")

tm <- theme(axis.line  = element_line(colour="black"),
            axis.title = element_text(size=16, colour="black"),
            axis.text  = element_text(size=12, colour="black"),
            plot.title = element_text(size=20, colour="black"),
            strip.text = element_text(size=12, face="bold"),
            strip.background = element_rect(fill="gray70", colour="black", size=0.5) )

pdf("ReadsCov.pdf", width=8, height=6)
system.time(
	for(i in 1:nrow(InLists)) {
        LinePos   <- InLists[i, ]
        FigBegin  <- LinePos$Begin; FigEnd <- LinePos$End
        LinePos$Begin  <- LinePos$Begin - FlankGap; if(LinePos$Begin < 0) LinePos$Begin <- 1
        LinePos$End    <- LinePos$End + FlankGap
        LinePos$Length <- LinePos$End - LinePos$Begin + 1
		LineData  <- getCovData(CovDir=InDir, InPos=LinePos)
		LineTitle <- paste(LinePos$Strain, LinePos$Note, sep=" ")
        # Select subset of data
        LineData  <- subset(LineData, 
                           Position >= LinePos$Begin & Position <= LinePos$End)
        # For labels on x-axis
        xStart <- 10 * floor(LinePos$Begin/10)
        xEnd   <- 10 * floor(LinePos$End/10)
        xStep  <- 10 * floor(floor(LinePos$Length/7)/10)
        xBreak <- seq(xStart, xEnd, by=xStep)        
        
		p1 <- ggplot(LineData, aes(x=Position, y=Coverage)) +
            geom_area(fill="black") + 
		    geom_vline(xintercept=c(FigBegin, FigEnd), colour="blue",
		               linetype="longdash", size=.3) +
            scale_x_continuous(breaks=xBreak) +
            ggtitle(LineTitle) + tm
        
		print(p1 + facet_grid(LibName ~ ID) )
		print(p1 + facet_grid(LibName ~ ID, scales="free_y") )
	}
)
dev.off()

# Draw the coverage maps of RNASeq data using ggplot2 packages
# Parameters: 1. reads, the input file (line-15); 2. Name of pdf (line-22); 
# 3. Number of scales on X-axis (line-40).