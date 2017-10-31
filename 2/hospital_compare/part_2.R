best<- function(state, outcome, num){
    
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    if(!any(state == data$State)){
        stop(print("Invalid state")
    }
    else if((outcome %in% c("heart attack", "heart failure", "pneumonia")) == FALSE){
        stop(print("Invalid outcome"))
    }
    
    sub_data <- subset(data, State == state)
    if (outcome == "heart attack"){
        colnum <- 11
    }
    else if (outcome == "heart failure"){
        colnum <- 17
    }
    else{
        colnum <- 23
    }
    
    sub_data[, colnum] <- as.numeric(sub_data[, colnum])
    sub_data <- sub_data[order(sub_data[, colnum], sub_data[, 2]), ]
    sub_data <- sub_data[(!is.na(sub_data[, colnum])), ]
    
    if(num == "best"){
        num <- 1
    }            
    else if (num == "worst"){
        num <- nrow(sub_data)
    }      
    
    return(sub_data[num, 2])
    
}