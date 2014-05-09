## Exploratory Data Analysis: Course Project 1

## Open plot4.png and call the 4 subplot functions to build a png with 4 panels
plot4 <- function( ) {
    
    data <- parsefile();
    png( filename = "plot4.png", width = 480, height = 480, units = "px", 
         bg = "transparent")
    par(mfcol = c(2,2))
    subplot1( data )
    subplot2( data )
    subplot3( data )
    subplot4( data )
    dev.off()
}

## subplot1: generate a line chart of Global Active Power
subplot1 <- function( data ) {
    
    with(data, plot(Time, Global_active_power, type="l", xlab="", 
                    ylab="Global Active Power (kilwatts)"))
}

## subplot2: generate a line chart of Sub_metering 1-3
subplot2 <- function( data ) {
    
    with(data, plot(Time, Sub_metering_1, type="n", pch=" ", xlab="", 
                    ylab="Energy sub metering"))
    with(data, lines(Time, Sub_metering_1, col="black"))
    with(data, lines(Time, Sub_metering_2, col="red"))
    with(data, lines(Time, Sub_metering_3, col="blue"))
    legend("topright", lty = 1, bty = "n", col=c("black","red","blue"), 
           legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3") )
}

## subplot3: generate a line chart of Voltage
subplot3 <- function( data ) {
    
    with(data, plot(Time, Voltage, type="l", xlab="datetime", 
                    ylab="Voltage"))
}

## subplot4: generate a line chart of Global_reactive_power
subplot4 <- function( data ) {
    
    with(data, plot(Time, Global_reactive_power, type="l", xlab="datetime", 
                    ylab="Global_reactive_power"))
}

## parsefile: download and unzip source file if necessary,
## read the relevant lines into a table, and coerce date & time columns
parsefile <- function( ) {
    
    ## download file to working directory and unzip, if necessary
    if ( !file.exists("household_power_consumption.txt")) {
        download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
                      method="curl", destfile="exadata-data-household_power_consumption.zip")
        system("unzip exadata-data-household_power_consumption.zip")
    }
    
    ## read file into p, focusing only on observations from 2007-02-01 and 2007-02-02
    p <- read.table("household_power_consumption.txt",header=FALSE,sep=";",skip=66637,nrows=2880)
    colnames(p) <- c("Date","Time","Global_active_power","Global_reactive_power",
                     "Voltage","Global_intensity","Sub_metering_1",
                     "Sub_metering_2","Sub_metering_3")
    
    ## convert Date from char to date
    p$Date <- as.Date(strptime(p$Date,"%d/%m/%Y"))
    p$Time <- as.POSIXlt(strptime(paste(p$Date,p$Time,sep=" "),"%Y-%m-%d %H:%M:%S"))
    
    ## return the object
    p
}

