library(data.table)
unlink(list.files(tempdir(), full.names = TRUE))
#select and get data
data <- fread(
  cmd = 'grep -E "^(1/2/2007|2/2/2007)[;]" household_power_consumption.txt',
  sep = ";",
  header = FALSE,
  na.strings = "?"
)
colnames(data) <- names(read.table(
  "household_power_consumption.txt",
  nrows = 1, sep = ";", header = TRUE
))

data$Datetime<-as.POSIXct(strptime(paste(data$Date,data$Time), format="%d/%m/%Y %H:%M:%S"))

png(filename="plot3.png",width=480,height=480)
with(data, {
  plot(Sub_metering_1~Datetime, type="l",
       ylab="Global Active Power (kilowatts)", xlab="")
  lines(Sub_metering_2~Datetime,col='Red')
  lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lwd=c(1,1,1), 
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off()