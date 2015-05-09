## plot4.R
## create a plot for the the 4 different graphs in one device

## install packages and libraries
## install.packages("data.table")
## library(data.table)
## load the csv file into a dataframe.  
DataTable <- read.csv("data/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
DataTable$Date <- as.Date(DataTable$Date, format="%d/%m/%Y")

## Subsetting the subDataTable to only contain 2 days
subDataTable <- subset(DataTable, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

## Create a new column to contain POSIX DataTime so that we plot over time
Date_Time <- paste(as.Date(subDataTable$Date), subDataTable$Time)
subDataTable$DateTime <- as.POSIXct(Date_Time)


## Plot the 4 quadrant graphs
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))

plot(subDataTable$Global_active_power~subDataTable$DateTime, type="l", 
     ylab="Global Active Power", xlab="")
plot(subDataTable$Voltage~subDataTable$DateTime, type="l", 
     ylab="Voltage", xlab="datetime")
plot(subDataTable$Sub_metering_1~subDataTable$DateTime, type="l", 
     ylab="Energy sub metering", xlab="")
lines(subDataTable$Sub_metering_2~subDataTable$DateTime,col='Red')
lines(subDataTable$Sub_metering_3~subDataTable$DateTime,col='Blue')
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(subDataTable$Global_reactive_power~subDataTable$DateTime, type="l", 
     ylab="Global_reactive_power",xlab="datetime")

## Saving to file
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()