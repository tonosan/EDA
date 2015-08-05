######Getting data######
dataSetFile <- "analysis_dataset.zip"
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, dataSetFile)
unzip(dataSetFile)
#######load data in R#######
#First get the column names
col.names<-read.table("household_power_consumption.txt",sep = ";",nrows = 1)
col.names<-as.character(unname(unlist(col.names[1,])))
#Now the data from the dates 2007-02-01 and 2007-02-02 
data<-read.table("household_power_consumption.txt",
           header = F,dec = ".",sep = ";",col.names = col.names,
           na.strings = "?",nrows=2880,skip = 66637)
#######just checking#######
head(data)
tail(data)
summary(data)
#######Converting date and time######
library(lubridate)
data$datetime<-paste(data$Date,data$Time,sep = " ")
data$datetime<-dmy_hms(data$datetime)
#######Creating the plot#######
png(filename = "plot2.png",width = 480, height = 480)
tickmarks<-ymd_hms(c("2007/02/01 00:00:00","2007/02/02 00:00:00","2007/02/02 23:59:00"))
plot(data$datetime,data$Global_active_power,type="l",xaxt="n",
     xlab="",ylab="Global Active Power (kilowatts)")
axis(1,at=tickmarks,labels=c("Thu","Fri","Sat"))
dev.off()

