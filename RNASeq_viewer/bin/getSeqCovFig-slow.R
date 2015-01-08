## ~40s for each seq
## solution for big data:
## Skip the first N rows, (skip=N), read N rows, (nrow=N)

getCovData <- function(CovDir="Rv.coverage", InPos) {
	#CovDir <- "Rv.coverage"
	## Check the strand
	if (InPos$Strand == "+"){
	    CovType <- ".p$"		
	} else if (InPos$Strand == "-"){
        CovType <- ".n$"
	} else {
        stop("Input Strand should be +/- .")
	}
    
    # Prepare the data index
	CovFiles <- dir(CovDir, CovType)
    CovNames <- strsplit(CovFiles, "\\.")
	CovIndex <- data.frame(matrix(unlist(CovNames), length(CovFiles), byrow=TRUE))
    names(CovIndex) <- c("Strain", "LibType", "Cov", "Strand")
    CovIndex$Path <- paste(CovDir, CovFiles, sep="/")
    CovIndex$Filename <- CovFiles
    LibIndex <- data.frame(LibType=c('01', '02', '03', '04'),
                           LibName=c("1. 18-40 nt", "2. 40-80 nt", "3. 80-140 nt", "4. >140 nt"))
	
    # Reading coverage file: skip N row (for big data)
	StartRow <- InPos$Begin - 200; if(StartRow < 0) StartRow <- 0 
	ReadRows <- InPos$Length + 400
	
	AllLibData <- data.frame(Chr      = NULL,
                             Position = NULL, 
                             Count    = NULL, 
                             LibName  = NULL, 
                             ID       = NULL)
        
    for(n in 1:nrow(CovIndex)) {
		LibFile <- CovIndex$Path[n]
		LibData <- read.table(LibFile, skip=StartRow, nrows=ReadRows, comment.char="",
								colClasses=c("character", "numeric", "numeric"))
		names(LibData) <- c("Chr", "Position", "Coverage")
        LibData$LibName <- LibIndex$LibName[LibIndex$LibType == CovIndex$LibType[n]]
        LibData$ID      <- InPos$ID
        AllLibData      <- rbind(AllLibData, LibData)
	}
	AllLibData <- na.omit(AllLibData)
}

#################################
#################################
library("ggplot2")

args <- commandArgs(TRUE)
InFile <- args[1]
InLists <- read.table(InFile, comment.char="")
#InLists <- read.table("InputData/All_NB_exp.txt", comment.char="")
names(InLists) <- c("ID", "Strain", "Length", "Begin", "End", "Strand")
InLists$Note   <- apply(InLists[, c(1,3:6)], 1, paste, collapse=":")

InDir <- "Rv.coverage"
FlankGap <- 200

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
