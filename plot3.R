#read raw data

rawdata<-read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings="?")

#only pick data between 2007-02-01 and 2007-02-02

housedata<-rawdata[which(rawdata$Date %in% c("1/2/2007","2/2/2007")),]
housedata<-housedata[complete.cases(housedata),]

#type conversion
housedata$Sub_metering_1<-as.numeric(housedata$Sub_metering_1)
housedata$Sub_metering_2<-as.numeric(housedata$Sub_metering_2)


housedata$CDate<-strptime(paste(housedata$Date,housedata$Time),format="%d/%m/%Y %H:%M:%S")

#English locale setting for Weekday Expression
Sys.setlocale("LC_TIME", "English") 


#Date/Time column setting, Date,Time removal
housedata$CDate <- as.POSIXct(housedata$CDate)
housedata$Date <- NULL
housedata$Time <- NULL

#plotting
plot( housedata$Sub_metering_1~housedata$CDate,type="l", col="black",
      xlab="" ,ylab="Energy sub metering")

lines(housedata$Sub_metering_2~housedata$CDate,  col="red")
lines(housedata$Sub_metering_3~housedata$CDate,  col="blue")

legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3") )


dev.copy(png,"plot3.png",width=480,height=480)
dev.off() 
