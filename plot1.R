library(data.table)
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
png("plot1.png", width = 480, height = 480)
hist(data$Global_active_power, 
     main = "Histogram of Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     col = "red")
dev.off()



