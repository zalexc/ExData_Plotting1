#uses data.table for time efficiency
library(data.table)

#checks if the coursera directory exixts and if not creates it
if (!file.exists("coursera")) {
        dir.create("coursera")
        
}      

#sets coursera as the working directory
setwd("./coursera")     

#downloads and unzips the database, please note in Ubuntu I had to use http instead of https, otherwise the url would not be supported
download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="file", method="auto")
unzip("file")  

#stores date of data downloading
dateDownloaded<-date()

#builds the data table using fread and changes na data from "?" to "NA"
table<-data.table(suppressWarnings(fread("household_power_consumption.txt", na.strings="NA")))      


#subsets for the required dates 
subset<-table[table$Date=="1/2/2007" | table$Date=="2/2/2007",]

#converts Date to date format and Global active power to numeric
subset$Date<-as.Date(subset$Date,format="%d/%m/%Y")       
subset$Global_active_power<- suppressWarnings(as.numeric(subset$Global_active_power))

#activates graphic device png and creates file plot1
png(filename="plot1.png", height=480, width=480)

#plots histogram to file
hist(subset$Global_active_power, col="red",main="Global active power", xlab="Global active power (kilowatts)")

#turns off png
dev.off()
