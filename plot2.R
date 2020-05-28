#read raw data

rawdata<-read.table("household_power_consumption.txt",header=TRUE,sep=";",na.strings = "?")

#only pick data between 2007-02-01 and 2007-02-02

housedata<-rawdata[which(rawdata$Date %in% c("1/2/2007","2/2/2007")),]
housedata<-housedata[which(!is.na(housedata$Global_active_power)),]


#type conversion
housedata$Global_active_power<-as.numeric(housedata$Global_active_power)



#Date/Time column setting, Date,Time removal
housedata$CDate<-strptime(paste(housedata$Date,housedata$Time),format="%d/%m/%Y %H:%M:%S")
housedata$Date <- NULL;
housedata$Time <- NULL;
housedata$CDate <- as.POSIXct(housedata$CDate)


#English locale setting for Weekday Expression
Sys.setlocale("LC_TIME", "English") 

#plotting
plot(housedata$Global_active_power~housedata$CDate, type="l", ylab="Global Active Power (kilowatts)", xlab="")
 

dev.copy(png,"plot2.png",width=480,height=480)
dev.off()
