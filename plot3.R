## This is the third script to create sub metering plot
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

## Plot 3 - Submetering plot
with(data, {
        plot(Sub_metering_1~Datetime, type="l",
             ylab="Energy sub metering", xlab="")
        lines(Sub_metering_2~Datetime,col='Red')
        lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Saving to file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()