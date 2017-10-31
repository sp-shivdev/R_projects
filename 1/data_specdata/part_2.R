complete <- function(directory, ids){
    
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
    
    complete_list <- data.frame()
    
    for (i in ids){
        nobs <- nrow(masterlist[[i]][complete.cases(masterlist[[i]]), ])
        complete_list <- rbind(complete_list, c(i, nobs))
    }
    
    colnames(complete_list) <- c("id", "nobs")
    complete_list
}