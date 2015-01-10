library(data.table)

#sets coursera as the working directory
setwd("./coursera")   
#builds the data table using fread and changes na data from "?" to "NA"
table<-data.table(suppressWarnings(fread("household_power_consumption.txt", na.strings="NA")))      


#subsets for the required dates
subset<-table[table$Date=="1/2/2007" | table$Date=="2/2/2007",]

#converts Date to time format other columns to numeric
date<-paste(subset$Date, subset$Time)
fdate<-strptime(date,format="%d/%m/%Y %H:%M:%S")

subset$Global_active_power<- suppressWarnings(as.numeric(subset$Global_active_power))
subset$Global_reactive_power<- suppressWarnings(as.numeric(subset$Global_reactive_power))
subset$Voltage<- suppressWarnings(as.numeric(subset$Voltage))
subset$Sub_metering_1 <- suppressWarnings(as.numeric(subset$Sub_metering_1))
subset$Sub_metering_2 <- suppressWarnings(as.numeric(subset$Sub_metering_2))      
subset$Sub_metering_3 <- suppressWarnings(as.numeric(subset$Sub_metering_3))


#activates graphic device png and creates file plot4
png(filename="plot4.png", height=480, width=480)

par(mfrow=c(2,2))

#plots to file chart1 in the top left corner
plot(fdate, subset$Global_active_power, col="black",main="", ylab="Global Active Power", xlab="", type="l")

#plots to file chart2 in the top right corner
plot(fdate, subset$Voltage, col="black",main="", ylab="Voltage", xlab="datetime", type="l")

#plots to file chart3 and legend to the bottom left corner
plot(fdate, subset$Sub_metering_1, col="black",main="", ylab="Energy sub metering", xlab="", type="l")
lines(fdate, subset$Sub_metering_2, col="red", type="l")
lines(fdate, subset$Sub_metering_3, col="blue", type="l")

legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=c(1,1,1),cex=0.9, bty="n")

#plots to file chart4 in the bottom right corner
plot(fdate, subset$Global_reactive_power, col="black",main="", xlab="datetime", ylab="Global_reactive_ power", type="l")

#turns off png
dev.off()