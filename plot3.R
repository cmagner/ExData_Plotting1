plot3 <- function() {
    
    library(data.table)
    
    #==========================================================================
    # Extract the desired data from the CSV file
    #==========================================================================
    
    # Read in the entire data file
    allData <- fread("household_power_consumption.txt")

    # Keep data only for the desired data range
    data <- allData[allData$Date=="1/2/2007" | allData$Date=="2/2/2007",]
    rm("allData")    
    
    # Extract sub-metering info from the data
    subMeter1 <- as.numeric(data$Sub_metering_1)
    subMeter2 <- as.numeric(data$Sub_metering_2)
    subMeter3 <- as.numeric(data$Sub_metering_3)
    
    # Extract time from the data
    dateTime = strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")   
      
    
    #==========================================================================
    # Create the plot
    #==========================================================================
    
    # Setup for adjusted text size
    par(pty="s", cex.axis=0.75, cex.lab=0.75)
    
    # Plot sub-meter #1 vs time
    plot(dateTime, subMeter1, type="l",
         xlab="", ylab="Energy sub metering")
    
    # Add sub-meter #2 to the plot
    par(new=TRUE)
    plot(dateTime, subMeter2, type="l", col="RED",
         axes=FALSE, ylim=c(0,40), ylab="", xlab="")
    
    # Add sub-meter #3 to the plot
    par(new=TRUE)
    plot(dateTime, subMeter3, type="l", col="BLUE",
         axes=FALSE, ylim=c(0,40), ylab="", xlab="")
    
    # Add a legend to the plot.  (Also, adjust so text is readable when copied
    # to a 480x480 png.)
    legend("topright", lty=1, cex=0.75, inset=c(0.2.5,0), y.intersp=1.5,
           col=c("BLACK", "RED", "BLUE"), 
           legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    
    # Copy the screen figure to a PNG file
    dev.copy( png, file="plot3.png" )  # use default 480x480 pixel size
    dev.off()    
}
