library(lubridate)

# Downloading the file
fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url = fileURL, destfile = "data.zip")
unzip(zipfile = "data.zip", exdir = "data")

#Reading the file
df <- read.csv2(file = "data/household_power_consumption.txt",
                na.strings = "?",
                dec = ".",
                stringsAsFactors = FALSE)

# Transforming the df
df$date_time <- dmy_hms(paste(df$Date, df$Time))     # Cohersing class to dates and times

df_filtered <-  subset(df, date_time > ymd("2007-02-01") & 
                         date_time < ymd("2007-02-03"))   # Filtering the dates

# Plot it
png(filename = "plot4.png",
    width = 480,
    height = 480)
par(mfrow = c(2, 2))     # For the grid layout
# Chart 1
plot(x = df_filtered$date_time,
     y = df_filtered$Global_active_power,
     type = "l",
     xlab = "",
     ylab = "Global Active Power (kilowatts)")
# Chart 2
plot(x = df_filtered$date_time,
     y = df_filtered$Voltage,
     type = "l",
     xlab = "datetime",
     ylab = "Voltage")
# Chart 3
plot(x = df_filtered$date_time,
     y = df_filtered$Sub_metering_1,
     xlab = "",
     ylab = "Energy sub metering",
     type = "l")
points(x = df_filtered$date_time,
       y = df_filtered$Sub_metering_2,
       col = "red",
       type = "l")
points(x = df_filtered$date_time,
       y = df_filtered$Sub_metering_3,
       col = "blue",
       type = "l")
legend("topright",
       lty = 1,
       col = c("black", "red", "blue"),
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
# Chart 4
plot(x = df_filtered$date_time,
     y = df_filtered$Global_reactive_power,
     type = "l",
     lwd = 1,
     xlab = "datetime",
     ylab = "Global_reactive_power")
dev.off()