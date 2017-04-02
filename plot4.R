#download and unzip required file
url1 <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("power_consumption.zip")) {download.file(url1, destfile = "power_consumption.zip")}
unzip("power_consumption.zip")

#reading required data
fileurl <- file("household_power_consumption.txt")
data1 <- read.table(text = grep("^[1,2]/2/2007", readLines(FileURL), value = T), 
                    col.names = c("Date", "Time", "Global_active_power", 
                                  "Global_reactive_power", "Voltage", 
                                  "Global_intensity", "Sub_metering_1", 
                                  "Sub_metering_2", "Sub_metering_3"), 
                    sep = ";", header = T)

#modify variables for plotting
require(lubridate)
data1$Date <- dmy(data1$Date)
data1$Global_active_power <- as.numeric(data1$Global_active_power)
data1$Global_reactive_power <- as.numeric(data1$Global_reactive_power)
data1$Voltage <- as.numeric(data1$Voltage)
data1$Sub_metering_1 <- as.numeric(data1$Sub_metering_1)
data1$Sub_metering_2 <- as.numeric(data1$Sub_metering_2)
data1$Sub_metering_3 <- as.numeric(data1$Sub_metering_3)
data1 <- transform(data1, time = as.POSIXct(paste(Date, Time)), 
                   "%d/%m/%Y %H:%M:%S")

#create png plot
png(filename = "plot4.png")
par(mfrow = c(2, 2), mar = c(4, 4, 2, 1))

#1 global active power plot
with(data1, plot(time, Global_active_power, 
                 type = "l", ylab = "Global Active Power"))

#2 voltage plot
with(data1, plot(time, Voltage, type = "l",
                 ylab = "Voltage", xlab = "datetime"))


#3 energy sub metering plot
plot3 <- function() {
  with(data1, plot(time, Sub_metering_1, col = "black", type = "l", 
                   ylab = "Energy sub metering"))
  with(data1, lines(time, Sub_metering_2, col = "red", type = "l"))
  with(data1, lines(time, Sub_metering_3, col = "blue", type = "l"))
  legend("topright", lty = c(1, 1), lwd = c(1, 1), bty = "n", cex = 0.75,
         col = c("black", "red", "blue"), 
         c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
}
plot3()

#4 global reactive power plot
with(data1, plot(time, Global_reactive_power, type = "l",
                 ylab = "Global_reactive_power",
                 xlab = "datetime"))

#end the plot
dev.off()





