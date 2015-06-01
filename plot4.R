plot4 <- function() {

    library(data.table)
    
    #==========================================================================
    # Extract the desired data from the CSV file
    #==========================================================================
    
    # Read in the entire data file
    allData <- fread("household_power_consumption.txt")
    
    # Keep data only for the desired data range
    data <- allData[allData$Date=="1/2/2007" | allData$Date=="2/2/2007",]
    rm("allData")
    
    # Extract time from the data
    dateTime = strptime(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S")   

    # Extract global active power from the data
    gActPwr <- as.numeric(data$Global_active_power)
    
    # Extract voltage from the data
    voltage <- as.numeric(data$Voltage)
    
    # Extract sub-metering info from the data
    subMeter1 <- as.numeric(data$Sub_metering_1)
    subMeter2 <- as.numeric(data$Sub_metering_2)
    subMeter3 <- as.numeric(data$Sub_metering_3)
    
    # Extract global reactive power from the data
    gReactPwr <- as.numeric(data$Global_reactive_power)
    
    
    #==========================================================================
    # Create the plot
    #==========================================================================
    
    # Setup for 4 plots with adjusted text size
    par(mfcol=c(2,2), cex.axis=0.75, cex.lab=0.75)
    
    # UPPER LEFT PLOT:
    # Plot global active power as a function of time
    plot(dateTime, gActPwr, type="l",
         xlab="", ylab="Global Active Power (kilowatts)")
    
    # LOWER LEFT PLOT:
    # Overlay plots of the 3 sub-metering variables (Also, turn off the legend
    # box lines and adjust so text is readable when copied to a 480x480 png.)
    {
        plot(dateTime, subMeter1, type="l",
             xlab="", ylab="Energy sub metering")
        par(new=TRUE)
        plot(dateTime, subMeter2, type="l", col="RED",
             axes=FALSE, ylim=c(0,40), ylab="", xlab="")
        par(new=TRUE)
        plot(dateTime, subMeter3, type="l", col="BLUE",
             axes=FALSE, ylim=c(0,40), ylab="", xlab="")
        legend("topright", lty=1, bty="n", cex=0.75, inset=c(0.2.5,0), y.intersp=1.5,
               col=c("BLACK", "RED", "BLUE"), 
               legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    }
    
    # UPPER RIGHT PLOT:
    # Plot Voltage as a function of time
    plot(dateTime, voltage, type="l", 
         xlab="datetime", ylab="Voltage")
    
    # LOWER RIGHT PLOT:
    # Plot global reactive power as a function of time
    plot(dateTime, gReactPwr, type="l", 
         xlab="datetime", ylab="Global_reactive_power")    
    
    # Copy the screen figure to a PNG file
    dev.copy( png, file="plot4.png" )  # use default 480x480 pixel size
    dev.off()    
}
