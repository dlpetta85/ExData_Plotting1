##This assignment uses data from the UC Irvine Machine Learning Repository, a popular repository for machine learning datasets. In particular, we will be using the “Individual household electric power consumption Data Set” which I have made available on the course web site.
##reading the file
consumo <- read.table("household_power_consumption.txt", header=TRUE, sep=";", na.strings = "?", colClasses = c('character','character','numeric','numeric','numeric','numeric','numeric','numeric','numeric'))

#Organizing the data
consumo$Date <- as.Date(consumo$Date, "%d/%m/%Y")
consumo <- subset(consumo,Date >= as.Date("2007-2-1") & Date <= as.Date("2007-2-2"))
consumo <- consumo[complete.cases(consumo),]
dttempo <- paste(consumo$Date, consumo$Time)

##Naming it
dttempo <- setNames(dttempo, "Time")
consumo <- consumo[ ,!(names(consumo) %in% c("Date","Time"))]
consumo <- cbind(dttempo, consumo)

consumo$dttempo <- as.POSIXct(dttempo)

##plot1
hist(consumo$Global_active_power, main="Global Active Power", xlab = "Global Active Power (kilowatts)", col="red")
dev.copy(png,"plot1.png", width=480, height=480)
dev.off()

#plot2
plot(consumo$Global_active_power~consumo$dttempo, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()

#plot3
with(consumo, {
  plot(Sub_metering_1~dttempo, type="l", ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dttempo,col='Red')
  lines(Sub_metering_3~dttempo,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()

##plot4
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(consumo, {
  plot(Global_active_power~dttempo, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  plot(Voltage~dttempo, type="l", 
       ylab="Voltage (volt)", xlab="")
  plot(Sub_metering_1~dttempo, type="l", 
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~dttempo,col='Red')
  lines(Sub_metering_3~dttempo,col='Blue')
  legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
         legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Global_reactive_power~dttempo, type="l", 
       ylab="Global Rective Power (kilowatts)",xlab="")
})
dev.copy(png, file="plot4.png", height=480, width=480)
dev.off()

