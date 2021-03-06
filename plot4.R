## Reading the file

temp <- tempfile()

download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)

energy <- read.table(file = unz(temp, "household_power_consumption.txt"), 
                     header = FALSE, na.strings = "?", sep = ";", skip = 66638, 
                     nrows = 2897)

headers <- c("Date", "Time", "Global_active_power", "Global_reactive_power",
             "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2",
             "Sub_metering_3")

colnames(energy) <- headers

## Creating a date-time column

energy$datetime <- strptime(paste(energy$Date, energy$Time), format = 
                              "%d/%m/%Y %H:%M:%S")

## Creating plots

png("plot4.png")

par(mfrow = c(2,2))

## Plot 1,1
plot(energy$datetime, energy$Global_active_power, type = "l", xlab = " ", 
     ylab = "Global Active Power (kilowatts)", mfg = c(1,1))

## Plot 1,2
plot(energy$datetime, energy$Voltage, type = "l", xlab = "datetime", 
     ylab = "Voltage", mfg = c(1,2))

## Plot 2,1
plot(energy$datetime, energy$Sub_metering_1, type = "l", xlab = " ", 
     ylab = "Energy sub metering", mfg = c(2,1))

lines(energy$datetime, energy$Sub_metering_2, type = "l", col = "red")

lines(energy$datetime, energy$Sub_metering_3, type = "l", col = "blue")

legend("topright", lty = 1, col = c("black", "red", "blue"), legend = 
         c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

## Plot 2,2
plot(energy$datetime, energy$Global_reactive_power, type = "l", xlab = "datetime", 
     ylab = "Global_reactive_power", mfg = c(2,2))

dev.off()