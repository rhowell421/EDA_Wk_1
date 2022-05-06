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
png(filename = "plot1.png",
    width = 480,
    height = 480)
hist(df_filtered$Global_active_power,
     col = "red",
     main = "Global Active Power",
     xlab = "Global Active Power (kilowatts)")
dev.off()