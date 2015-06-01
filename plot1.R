plot1 <- function() {
    
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

    
    #==========================================================================
    # Create the plot
    #==========================================================================
    
    # Setup for adjusted text size
    par(pty="s", cex.axis=0.75, cex.lab=0.75)
    
    # Generate a histogram of global active power 
    hist(gActPwr, ylim=c(0,1200),
         col="RED", 
         main="Global Active Power", 
         xlab="Global Active Power (kilowatts)")   
    
    # Copy the screen figure to a PNG file    
    dev.copy( png, file="plot1.png" )  # use default 480x480 pixel size
    dev.off()    
}