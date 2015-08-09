#creating a temporary file to download zip
temp <- tempfile()

#downloading data
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)

#data_reqd<-read.table("./household_power_consumption.txt",sep = ";",header=TRUE,as.is = TRUE,na.strings='?')

#read from data, as csv, separator is ";" and all variables are converted to characters
data_reqd<-read.table(unz(temp, "household_power_consumption.txt"),sep = ";",header=TRUE,as.is = TRUE,na.strings='?')

#no use of the temp file
unlink(temp)

#convert the first column's class type to Date
data_reqd[,1]<-as.Date(data_reqd[,1],"%d/%m/%Y")

#selecting data corresponding to the two days
d<-subset(data_reqd,Date==as.Date("2/2/2007","%d/%m/%Y")|Date==as.Date("1/2/2007","%d/%m/%Y"))

#combining date and time
datetime<-paste(d$Date,d$Time)

#converting it to Posix format
datetime<-strptime(datetime,"%Y-%m-%d %H:%M:%S")

#add this as a coumn to the data set
d<-cbind(d,datetime)

par(mfrow = c(2, 2))

#plotting the graph, with type = l
plot(d$datetime,d$Global_active_power,type = 'l',xlab = "",ylab = "Global Active Power")
par(bg = "transparent")
plot(d$datetime,d$Voltage,type = 'l',xlab = "datetime",ylab = "Voltage")


plot(d$datetime,d$Sub_metering_1,type = 'l',xlab = "",ylab = "Energy Sub Metering",bg="transparent")

lines(d$datetime,d$Sub_metering_2,col="red")

lines(d$datetime,d$Sub_metering_3,col="blue")

legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),col = c("black","red","blue"),lty=1)

plot(d$datetime,d$Global_reactive_power,type = 'l',xlab = "datetime",ylab = "Global_reactive_power")


#copy to png
dev.copy(png, file = "plot4.png")

#change the device back
dev.off()

