## plot2.R
## create a line plot for Global Active Power over time

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

## Plot 2 is a line graph of the Global Active power over time
plot(subDataTable$Global_active_power~subDataTable$DateTime, type="l",
     ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png, file="plot2.png", height=480, width=480)
dev.off()