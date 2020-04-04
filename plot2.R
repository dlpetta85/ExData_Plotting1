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


#plot2
plot(consumo$Global_active_power~consumo$dttempo, type="l", ylab="Global Active Power (kilowatts)", xlab="")
dev.copy(png,"plot2.png", width=480, height=480)
dev.off()