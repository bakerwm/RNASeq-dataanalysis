# Draw the coverage maps of RNASeq data using ggplot2 packages
# Parameters: 1. reads, the input file (line-15); 2. Name of pdf (line-22); 
# 3. Number of scales on X-axis (line-40).


library("ggplot2")
source("../bin/getCovData.R")
tm <- theme(axis.line  = element_line(colour="black"),
            axis.title = element_text(size=16, colour="black"),
            axis.text  = element_text(size=12, colour="black"),
            plot.title = element_text(size=20, colour="black"),
            strip.text = element_text(size=12, face="bold"),
            strip.background = element_rect(fill="gray70", colour="black", size=0.5) )

reads <- read.table("testSeq.txt", comment.char="")
#reads <- read.table("CYRNAseqView.txt", comment.char="")
# Split input seqs by Strain name
names(reads) <- c("ID", "Strain", "Length", "Begin", "End", "Strand")
reads.bystrain <- split(reads, reads$Strain)
Strains <- as.character(unique(reads$Strain))

pdf("testViewer.pdf", width=14, height=6)
#
system.time(
for(i in 1:length(Strains)){
    Strain <- Strains[i]
    CovDir <- "Coverage"
    CovData <- getCovData(Strain, CovDir)  ## Function 1
    readsList <- reads.bystrain[[Strain]]
    
    for(m in 1:length(readsList$ID)) {
        Line.Info <- readsList[m, ]
        Begin <- Line.Info$Begin
        End   <- Line.Info$End
        Length<- Line.Info$Length        
        Linedata <- getReadCovData(CovData, Line.Info)  ## Function 2
        LinePosition <- paste(Line.Info$Begin, Line.Info$End, Line.Info$Strand, Line.Info$Length, sep=":")        
        figtitle <- paste(Strain, Line.Info$ID, LinePosition, sep=" ")        
        p1 <- ggplot(Linedata, aes(x=Position, y=Coverage)) + ggtitle(figtitle) + tm +
            geom_area(fill="black") + scale_x_continuous(breaks=seq(Begin, End, Length/7))
        print(p1 + facet_grid(LibName ~ ID) )
        #print(p1 + facet_grid(LibName ~ ID, scales="free_y") )
    }          
}
)
dev.off()