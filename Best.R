
best <- function(state, outcome){
    ## Read outcome data
    data <- read.csv("outcome-of-care-measures.csv", colClasses = "character")[,c(2,7,11,17,23)]
    ## Check that state and outcome are valid
    if(! ( state %in% levels(factor(data$State)) ) ) {
        stop("invalid state")}
    if(! (outcome == "heart attack" || outcome == "heart failure" || outcome == "pneumonia") ) {
        stop("invalid outcome")}
    # Keep only the state asked and remove column with state names
    data = data[data$State==state,]
    data = data[,c(1,3,4,5)]
    # Remove columns by outcome
    if(outcome == "heart attack") {
        data = data[,c(1,2)]
    } else if(outcome == "heart failure") {
        data = data[,c(1,3)]
    } else if(outcome == "pneumonia") {
        data = data[,c(1,4)]
    }
    ## Rename column as Deaths and convert to numeric
    names(data)[2] = "Deaths"
    data[, 2] = suppressWarnings( as.numeric(data[, 2]) )
    # Remove rows with NA
    data = data[!is.na(data$Deaths),]
    # Order by Deaths and then Hospital Name
    data = data[order(data$Deaths, data$Hospital.Name),]
    ## Return hospital name in that state with lowest 30-day death rate
    return (data$Hospital.Name[1])
}
