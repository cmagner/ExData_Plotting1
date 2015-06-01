plot2 <- function() {
    
    library(data.table)
    
    
    #==========================================================================
    # Extract the desired data from the CSV file
    #==========================================================================
    
    # Read in the entire data file
    allData <- fread("household_power_consumption.txt")
    
    # Keep data only for the desired data range
    data <- allData[allData$Date=="1/2/2007" | allData$Date=="2/2/2007",]
    rm("allData")    
    
    # Extract global active power from the data
    gActPwr <- as.numeric(data$Global_active_power)
    
    # Extract time from the data
    dateTime = strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")

    dateTime = strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")   
    
    
    #==========================================================================
    # Create the plot
    #==========================================================================
    
    # Setup for adjusted text size
    par(pty="s", cex.axis=0.75, cex.lab=0.75)
    
    # Plot global active power vs time
    plot(dateTime, gActPwr, type="l", 
         xlab="", ylab="Global Active Power (kilowatts)")
    
    # Copy the screen figure to a PNG file
    dev.copy( png, file="plot2.png" )  # use default 480x480 pixel size
    dev.off()    
}