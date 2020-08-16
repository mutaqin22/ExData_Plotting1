library("data.table")

setwd("D:\\Coursera\\Exploratory Data Analysis")

#Reads in data from file then subsets data for specified dates
raw_data <- data.table::fread(input = "household_power_consumption.txt", 
                              na.strings = "?")

# Prevents histogram from printing in scientific notation
raw_data[, Global_active_power := lapply(.SD, as.numeric), 
         .SDcols = c("Global_active_power")]

# Change Date Column to Date Type
raw_data[, Date := lapply(.SD, as.Date, "%d/%m/%Y"), .SDcols = c("Date")]

# Filter Dates for 2007-02-01 and 2007-02-02
tidy_data <- raw_data[(Date >= "2007-02-01") & (Date <= "2007-02-02")]

png("plot1.png", width = 480, height = 480)

## Plot 1
hist(tidy_data[, Global_active_power], main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", ylab = "Frequency", col = "Red")

dev.off()