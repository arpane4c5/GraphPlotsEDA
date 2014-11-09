# Create plot3.png 
# column names extracted from the file by reading a single row
# This reduces the overhead of reading the entire dataset
labels<-read.table("household_power_consumption.txt",sep=";", nrows=1, 
                   header=TRUE, colClasses="character")
labels<-names(labels)

# Rows from 66638 to 69517 are required. Skipped 66637 rows 
# and 2880 rows read corresponding to the two day data 
houseData<-read.table("household_power_consumption.txt", sep=";", 
                      col.names=labels,header=F, skip=66637, 
                      nrows=2880, na.strings="?")

# Extracting the date and time values and converting to DateTime format
# It is then added as a new column in the dataset
dateTimeCol<-paste(houseData$Date, houseData$Time, sep=" ")
dateTimeCol<-strptime(dateTimeCol,format="%d/%m/%Y %H:%M:%S")
houseData$Datetime<-as.POSIXct(dateTimeCol)

#Plot 3:
with(houseData, {
     plot(Sub_metering_1~Datetime, type="l",
          ylab="Energy sub metering", 
          xlab="")
     lines(Sub_metering_2~Datetime, col="Red")
     lines(Sub_metering_3~Datetime, col="Blue")
})
legend("topright", col=c("Black","Red","Blue"), lty=1, lwd=2,
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       cex=0.5, pt.cex=1, xjust=0)

# Exporting to the png file
dev.copy(png, file="plot3.png", height=480, width=480)
dev.off()
