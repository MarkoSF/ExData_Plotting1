## Exploratory Data Analysis: Course Project 1

## plot1: generate a 480x480 PNG pilot histogram of Global Active Power
plot1 <- function( ) {
    
    data <- parsefile();
    
    png( filename = "plot1.png", width = 480, height = 480, units = "px", 
         bg = "transparent")
    hist(data$Global_active_power, col="red", main="Global Active Power", 
         xlab="Global Active Power (kilowatts)")
    dev.off()
    
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