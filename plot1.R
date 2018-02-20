## This is the first script to create a histogram plot for Global Active Power

powerFile <- read.csv("./household_power_consumption.txt", header=T, 
                      sep=';', na.strings="?", nrows=2075259, check.names=F, 
                      stringsAsFactors=F, comment.char="", quote='\"')
powerFile$Date <- as.Date(powerFile$Date, format="%d/%m/%Y")

## Subset only for specified dates. I.e. from 2007-02-01 to 2007-02-02
data <- subset(powerFile, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
rm(powerFile)

## Convert dates to POSIXct format
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## plot1 - histogram for Global Active Power
hist(data$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## Saving to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()