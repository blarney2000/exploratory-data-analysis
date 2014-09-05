plot3 <- function() {
    
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

    png("plot3.png", width = 480, height = 480)
    ylimits = range(c(data$Sub_metering_1, data$Sub_metering_2, data$Sub_metering_3))
    plot(data$Time, data$Sub_metering_1, xlab = "", ylab = "Energy sub metering", type = "l", ylim = ylimits, col = "black")
    par(new = TRUE)
    plot(data$Time, data$Sub_metering_2, xlab = "", axes = FALSE, ylab = "", type = "l", ylim = ylimits, col = "red")
    par(new = TRUE)
    plot(data$Time, data$Sub_metering_3, xlab = "", axes = FALSE, ylab = "", type = "l", ylim = ylimits, col = "blue")
    legend("topright",
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
           #bg = "transparent",
           #bty = "n",
           lty = c(1,1,1),
           col = c("black", "red", "blue")
    )
    dev.off()
    
}