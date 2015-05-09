## plot1.R
## create a histogram for the Global Active Power

## install packages and libraries
## install.packages("data.table")
## library(data.table)
## load the csv file into a dataframe.  
DataTable <- read.csv("data/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                      nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
DataTable$Date <- as.Date(DataTable$Date, format="%d/%m/%Y")

## Subset the table, only get the two dates we need
subDataTable <- subset(DataTable, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))

## Plot the histogram
hist(subDataTable$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## Saving to file
dev.copy(png, file="plot1.png", height=480, width=480)
dev.off()