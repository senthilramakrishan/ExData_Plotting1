## This is the fourth script to create sub metering plot
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

## Plot 4 - All 4 charts with 2 in each line
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
        plot(Global_active_power~Datetime, type="l", 
             ylab="Global Active Power (kilowatts)", xlab="")
        plot(Voltage~Datetime, type="l", 
             ylab="Voltage (volt)", xlab="")
        plot(Sub_metering_1~Datetime, type="l", 
             ylab="Energy sub metering", xlab="")
        lines(Sub_metering_2~Datetime,col='Red')
        lines(Sub_metering_3~Datetime,col='Blue')
        legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
               legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(Global_reactive_power~Datetime, type="l", 
             ylab="Global_reactive_power",xlab="datetime")
})

## Saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()