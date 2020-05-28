#read raw data

rawdata<-read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings="?")

#only pick data between 2007-02-01 and 2007-02-02

housedata<-rawdata[which(rawdata$Date %in% c("1/2/2007","2/2/2007")),]
housedata<-housedata[complete.cases(housedata),]

#type conversion 

housedata$Global_active_power<-as.numeric(housedata$Global_active_power)
housedata$Sub_metering_1<-as.numeric(housedata$Sub_metering_1)
housedata$Sub_metering_2<-as.numeric(housedata$Sub_metering_2)
housedata$Voltage<-as.numeric(housedata$Voltage) 

housedata$dateTime<-strptime(paste(housedata$Date,housedata$Time),format="%d/%m/%Y %H:%M:%S")

#English locale setting for Weekday Expression
Sys.setlocale("LC_TIME", "English") 

#dateTime column setting, Date,Time removal
housedata$dateTime <- as.POSIXct(housedata$dateTime)
housedata$Date <- NULL
housedata$Time <- NULL

#plot numbers and margin setting
par(mfrow=c(2,2))
par(mar=c(4,4,2,2))

#lefttop
plot(housedata$Global_active_power~housedata$dateTime,ylab="Global Active Power",xlab="",type="l")

#righttop
plot(housedata$Voltage~housedata$dateTime,xlab="datetime", ylab="Voltage", type="l", yaxt="n")
axis(2, at=seq(234, 246, by=2) , labels= seq(234, 246, by=2))

#leftbottom
plot( housedata$Sub_metering_1~housedata$dateTime,type="l", col="black",
      xlab="" ,ylab="Energy sub metering")

lines(housedata$Sub_metering_2~housedata$dateTime,  col="red")
lines(housedata$Sub_metering_3~housedata$dateTime,  col="blue")

legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))


#rightbottom
plot(housedata$Global_reactive_power~housedata$dateTime,type="l", 
     xlab="datetime",ylab="Global_reactive_Power")

dev.copy(png,"plot4.png",width=480,height=480)
dev.off()

