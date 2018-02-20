## This is the second script to create plot2
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

## Plot 2
plot(data$Global_active_power~data$Datetime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")

## Saving to file
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()