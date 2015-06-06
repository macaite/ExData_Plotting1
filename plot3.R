library(lubridate);library(sqldf)
rm(list = ls())
#first read the required data in using the the sqldf package to only read the requied data
sample <- read.csv.sql("../data/household_power_consumption.txt",sep = ";",header = TRUE, stringsAsFactors = TRUE, sql = "select * from file where Date in ('1/2/2007','2/2/2007')")
#create a new datatime field from the Date and Time fields
sample$date_time <- dmy_hms(paste(sample$Date, sample$Time))
#transform sub meeting data to numerics
sample$Sub_metering_1 <- as.numeric(sample$Sub_metering_1)
sample$Sub_metering_2 <- as.numeric(sample$Sub_metering_2)
sample$Sub_metering_3 <- as.numeric(sample$Sub_metering_3)
#remove the NAs
na.omit(sample)
#create the 480 x 480 pixel png file
png(file="plot3.png",width = 480,height = 480, units = "px")
with(sample,plot(date_time,Sub_metering_1,type="n",ylab="Energy sub metering", xlab = ""))
with(sample,lines(date_time,Sub_metering_1,col = "black"))
with(sample,lines(date_time,Sub_metering_2,col = "red"))
with(sample,lines(date_time,Sub_metering_3,col = "blue"))
legend("topright",lty=1,col = c("black","red","blue"),legend = colnames(sample)[7:9])
dev.off()
