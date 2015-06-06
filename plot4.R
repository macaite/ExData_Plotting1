library(lubridate);library(sqldf)
rm(list = ls())
#first read the required data in using the the sqldf package to only read the requied data
sample <- read.csv.sql("../data/household_power_consumption.txt",sep = ";",header = TRUE, stringsAsFactors = TRUE, sql = "select * from file where Date in ('1/2/2007','2/2/2007')")

#create a new datatime field from the Date and Time fields
sample$date_time <- dmy_hms(paste(sample$Date, sample$Time))
#transform to numerics
sample$Sub_metering_1 <- as.numeric(sample$Sub_metering_1)
sample$Sub_metering_2 <- as.numeric(sample$Sub_metering_2)
sample$Sub_metering_3 <- as.numeric(sample$Sub_metering_3)
sample$Voltage <- as.numeric(sample$Voltage)
sample$Global_reactive_power <- as.numeric(sample$Global_reactive_power)
# remove the NAs
na.omit(sample)
#create the 480 x 480 pixel png file
png(file="plot4.png",width = 480,height = 480, units = "px")
#create 2 x 2 view
par(mfrow = c(2,2))
#plot 1
plot(sample$date_time,sample$Global_active_power, type = "o",ylab = "Global Active Power", xlab = "",pch = "")
#plot 2
plot(sample$date_time,sample$Voltage, type = "o",ylab = "Voltage", xlab = "datetime",pch = "")
#plot 3
with(sample,plot(date_time,Sub_metering_1,type="n",ylab="Energy sub metering", xlab = ""))
with(sample,lines(date_time,Sub_metering_1,col = "black"))
with(sample,lines(date_time,Sub_metering_2,col = "red"))
with(sample,lines(date_time,Sub_metering_3,col = "blue"))
legend("topright",lty=1,col = c("black","red","blue"),legend = colnames(sample)[7:9],cex = 1,bty = "n")
#plot 4
plot(sample$date_time,sample$Global_reactive_power, type = "o",ylab = "Global_active_power", xlab = "datetime",pch = "")
dev.off()