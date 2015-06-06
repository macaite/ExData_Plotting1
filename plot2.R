library(lubridate);library(sqldf)
rm(list = ls())
#first read the required data in using the the sqldf package to only read the requied data
sample <- read.csv.sql("../data/household_power_consumption.txt",sep = ";",header = TRUE, stringsAsFactors = TRUE, sql = "select * from file where Date in ('1/2/2007','2/2/2007')")
#create a new datatime field from the Date and Time fields
sample$date_time <- dmy_hms(paste(sample$Date, sample$Time))
#transform Global_active_power data to numerics
sample$Global_active_power <- as.numeric(sample$Global_active_power)
#remove NAs
na.omit(sample)
#create the 480 x 480 pixel png file
png(file="plot2.png",width = 480,height = 480, units = "px")
plot(sample$date_time,sample$Global_active_power, type = "o",ylab = "Global Active Power (kilowatts)", xlab = "",pch = "")
dev.off()
