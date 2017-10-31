corr <- function(directory, threshold = 0){
    
    setwd(directory)
    files = list.files(pattern = "*.csv") #list of csv files to be sourced
    
    masterlist <- list(NULL)
    index = 1
    
    for (file in files){
        df <- data.frame(read.csv(file = file))
        masterlist[[index]] <- df
        index = index + 1
    }

    
    rm(file, index, df) #remove intermediate variables
    
    corr_vect <- NULL
    
    for (i in 1:length(masterlist)){
        nobs <- nrow(masterlist[[i]][complete.cases(masterlist[[i]]), ])
        if(nobs > threshold){
            corr_vect <- c(corr_vect, cor(masterlist[[i]][complete.cases(masterlist[[i]]), "sulfate"], masterlist[[i]][complete.cases(masterlist[[i]]), "nitrate"]))
        }
    }
    
    corr_vect
}

