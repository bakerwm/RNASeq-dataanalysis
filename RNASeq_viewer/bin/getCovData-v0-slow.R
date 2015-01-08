# This function is designed to pick out coverage data from 4 libraries.
# 
# Coverage file named in this format:
# CovDir
#    |- Rv.01.coverage.n
#    |- Rv.01.coverage.p
#
# InPos: contain at least 6 columns
# <ID> <Strain> <Length> <Begin> <End> <Strand>

getCovData <- function(CovDir="Rv.coverage", InPos) {
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
    # Read each coverage file    
    for(n in 1:nrow(CovIndex)) {
		LibFile <- CovIndex$Path[n]
		LibData <- read.table(LibFile, skip=StartRow, nrows=ReadRows, comment.char="",
								colClasses=c("character", "numeric", "numeric"))
		names(LibData)  <- c("Chr", "Position", "Coverage")
        LibData$LibName <- LibIndex$LibName[LibIndex$LibType == CovIndex$LibType[n]]
        LibData$ID      <- InPos$ID
        AllLibData      <- rbind(AllLibData, LibData)
	}
	AllLibData <- na.omit(AllLibData)
}