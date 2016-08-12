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

## Creating plot

png("plot1.png")

hist(energy$Global_active_power, main = "Global Active Power", xlab = 
       "Global Active Power (kilowatts)", col = "red")

dev.off()