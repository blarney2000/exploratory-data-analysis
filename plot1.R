plot1 <- function() {
    
    setwd("C:/Users/user/Dropbox/School/Data Science 2014/Course 4 - Exploratory Data Analysis/Project 1/ExData_Plotting1-master")
        
    # for using SQL, which makes it easier to get subset of rows
    require(sqldf) 
    
    # read csv and use SQL query to filter rows
    rawdata <- read.csv.sql( file="household_power_consumption.txt", sep=";", sql="select * from file where Date = '1/2/2007' or Date = '2/2/2007'", header=TRUE)
    
    #create working frame
    data <- rawdata
    
    #convert date column to date object type
    data$Date <- as.Date(rawdata$Date , "%d/%m/%Y")
    
    #create new factor for Time that includes the date
    data$Time <- paste(rawdata$Date, rawdata$Time, sep=" ")
    
    #convert fractal time to time type
    data$Time <- strptime(data$Time, "%d/%m/%Y %H:%M:%S")
    
    #convert the remaining columns to numeric (but to character first to preserve values [start at column 3])
    data[,3:ncol(data)] <- as.numeric(as.character(unlist(data[,3:ncol(data)])))
    
    # create the plot
    png("plot1.png", width = 480, height = 480)
    hist(data$Global_active_power, main = "Global Active power", col = "red", xlab = "Global Active Power (kilowatts)", )
    dev.off()
        
}