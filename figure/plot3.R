library(data.table)

#sets coursera as the working directory
setwd("./coursera")   
#builds the data table using fread and changes na data from "?" to "NA"
table<-data.table(suppressWarnings(fread("household_power_consumption.txt", na.strings="NA")))      


#subsets for the required dates
subset<-table[table$Date=="1/2/2007" | table$Date=="2/2/2007",]

#converts Date to time format and Sub metering measures to numeric
date<-paste(subset$Date, subset$Time)
fdate<-strptime(date,format="%d/%m/%Y %H:%M:%S")
subset$Sub_metering_1 <- suppressWarnings(as.numeric(subset$Sub_metering_1))
subset$Sub_metering_2 <- suppressWarnings(as.numeric(subset$Sub_metering_2))      
subset$Sub_metering_3 <- suppressWarnings(as.numeric(subset$Sub_metering_3))

#activates graphic device png and creates file plot3
png(filename="plot3.png", height=480, width=480)

#plots to file chart and legend
plot(fdate, subset$Sub_metering_1, col="black",main="", ylab="Energy sub metering", xlab="", type="l")
lines(fdate, subset$Sub_metering_2, col="red", type="l")
lines(fdate, subset$Sub_metering_3, col="blue", type="l")

legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col=c("black","red","blue"), lty=c(1,1,1))

#turns off png
dev.off()
