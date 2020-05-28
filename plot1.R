#read raw data

rawdata<-read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings = "?")

#subsetting data between 2007-02-01 and 2007-02-02

housedata<-rawdata[which(rawdata$Date %in% c("1/2/2007","2/2/2007")),]

#type conversion
housedata$Global_active_power<-as.numeric(housedata$Global_active_power)

#hist plotting
hist(housedata$Global_active_power,col="red",xlab="Global Active Power (kilowatts)", ylab="Frequency"
     ,main="Global Active Power",cex.axis=0.8)


dev.copy(png,"plot1.png",width=480,height=480)
dev.off()
