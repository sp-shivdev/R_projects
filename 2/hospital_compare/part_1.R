best<- function(state, outcome){
    
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    if(!any(state == data$State)){
        stop(print("Invalid state"))
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
    else {
        colnum <- 23
    }
    
    min <- which(as.numeric(sub_data[ ,colnum]) == min(as.numeric(sub_data[ ,colnum]), na.rm = TRUE))
    hospitals <- sub_data[min, 2]
    hospitals <- sort(hospitals)
    
    return(hospitals[1])
    
}