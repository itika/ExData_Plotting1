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

#plotting the histrogram
hist(as.numeric(d$Global_active_power),xlab = "Global Active Power (in kilowatt)",col="red",main="Global Active Power")

#copy to png
dev.copy(png, file = "plot1.png")

#change the device back
dev.off()

