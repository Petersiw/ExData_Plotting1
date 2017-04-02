#download and unzip required file
url1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("power_consumption.zip")) {download.file(url1, destfile = "power_consumption.zip")}
unzip("power_consumption.zip")

#reading required data
fileurl <- file("household_power_consumption.txt")
data1 <- read.table(text = grep("^[1,2]/2/2007", readLines(FileURL), value = T), 
                   col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
                   sep = ";", header = T)

#produce png plot
png(file="plot1.png", width=480, height=480)
hist(data1$Global_active_power, col = "red", main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)")
dev.off()
