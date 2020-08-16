library("data.table")

setwd("D:\\Coursera\\Exploratory Data Analysis")

#Reads in data from file then subsets data for specified dates
raw_data <- data.table::fread(input = "household_power_consumption.txt", 
                              na.strings = "?")

# Prevents Scientific Notation
raw_data[, Global_active_power := lapply(.SD, as.numeric), 
         .SDcols = c("Global_active_power")]

# Making a POSIXct date capable of being filtered and graphed by time of day
raw_data[, dateTime := as.POSIXct(paste(Date, Time), 
                                  format = "%d/%m/%Y %H:%M:%S")]

# Filter Dates for 2007-02-01 and 2007-02-02
tidy_data <- raw_data[(dateTime >= "2007-02-01") & (dateTime < "2007-02-03")]

png("plot2.png", width = 480, height = 480)

## Plot 2
plot(x = tidy_data[, dateTime]
     , y = tidy_data[, Global_active_power]
     , type = "l", xlab = "", ylab = "Global Active Power (kilowatts)")

dev.off()