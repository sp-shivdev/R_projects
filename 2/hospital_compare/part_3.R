rankall<- function(outcome, num = "best"){
    
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")
    
    if((outcome %in% c("heart attack", "heart failure", "pneumonia")) == FALSE){
        stop(print("invalid outcome"))
    }
    
    if (outcome == "heart attack"){
        colnum <- 11
    }
    else if (outcome == "heart failure"){
        colnum <- 17
    }
    else{
        colnum <- 23
    }
    
    data[, colnum] <- as.numeric(data[, colnum])
    
    data = data[!is.na(data[, colnum]), ]
    
    split_data = split(data, data$State)
    
    result = lapply(split_data, function(x, num){ 
        
        x = x[order(x[, colnum], x$Hospital.Name), ]
        
        if(num == "best"){
            return (x$Hospital.Name[1])
        }
        else if(num == "worst"){
            return (x$Hospital.Name[nrow(x)])
        }
        else{
            return (x$Hospital.Name[num])
        }
    }, num)
    
    return(data.frame(Hospital=unlist(result), State=names(result)))
}