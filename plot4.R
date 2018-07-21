# Read the file by filtering by Date
library(sqldf)
t1 <- read.csv.sql("household_power_consumption.txt",
                   sql="select * from file where Date = '1/2/2007' or Date = '2/2/2007' ",
                   sep=";")
closeAllConnections()

# Add a new variable in the table that is date and time class
library(dplyr)
t2 <- tbl_df(t1)
library(lubridate)
t3 <- mutate(t2,DT=dmy_hms(paste(Date,Time)))

# Define two rows and two files 
par(mfrow=c(2,2))

# Create the 1rst plot graph
with(t3,plot(DT,Global_active_power,type="n",xlab = ""))
lines(t3$DT,t3$Global_active_power)

# Create the 2nd plot graph
with(t3,plot(DT,Voltage,type="n",xlab = "datetime"))
lines(t3$DT,t3$Voltage)

# Create the 3rd plot graph
with(t3,plot(DT,Sub_metering_1,type="n",xlab="",ylab = "Energy sub metering"))
lines(t3$DT,t3$Sub_metering_1)
lines(t3$DT,t3$Sub_metering_2,col="red")
lines(t3$DT,t3$Sub_metering_3,col="blue")
legend("topright",
       lty=c(1,1,1),
       col = c("black","red","blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       bty="n",
       cex = 0.8)

# Create the 4th plot graph
with(t3,plot(DT,Global_reactive_power,type="n",xlab = "datetime"))
lines(t3$DT,t3$Global_reactive_power)

# Copy the graph to a png file
dev.copy(png,file="plot4.png")
dev.off()

