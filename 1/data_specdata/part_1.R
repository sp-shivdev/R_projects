pollutantmean <- function(directory, pollutant, id){
    
    setwd(directory)
    files = list.files(pattern = "*.csv") #list of csv files to be sourced
    
    masterlist <- list(NULL)
    index = 1
    
    for (file in files){
        df <- data.frame(read.csv(file = file))
        masterlist[[index]] <- df
        index = index + 1
    }
    
    #rm(file, index, df) #remove intermediate variables
    
    meanlist = data.frame()
    
    for (i in id){
        isna <- is.na(masterlist[[i]][ , pollutant])
        meanlist <- rbind(meanlist, masterlist[[i]][!isna, ])
    }
    
    mean(meanlist[ , pollutant])
    
}