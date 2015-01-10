library(data.table)

#sets coursera as the working directory
setwd("./coursera")   
#builds the data table using fread and changes na data from "?" to "NA"
table<-data.table(suppressWarnings(fread("household_power_consumption.txt", na.strings="NA")))      


#subsets for the required dates
subset<-table[table$Date=="1/2/2007" | table$Date=="2/2/2007",]

#converts Date to time format and Global active power to numeric
date<-paste(subset$Date, subset$Time)
fdate<-strptime(date,format="%d/%m/%Y %H:%M:%S")
subset$Global_active_power<- suppressWarnings(as.numeric(subset$Global_active_power))

#activates graphic device png and creates file plot2
png(filename="plot2.png", height=480, width=480)

#plots to file
plot(fdate, subset$Global_active_power, col="black",main="", ylab="Global Active Power (kilowatts)", xlab="", type="l")

#turns off png
dev.off()