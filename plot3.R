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

# Create the plot graph
with(t3,plot(DT,Sub_metering_1,type="n",xlab="",ylab = "Energy sub metering"))
lines(t3$DT,t3$Sub_metering_1)
lines(t3$DT,t3$Sub_metering_2,col="red")
lines(t3$DT,t3$Sub_metering_3,col="blue")
legend("topright",
       lty=c(1,1,1),
       col = c("black","red","blue"),
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Copy the graph to a png file
dev.copy(png,file="plot3.png")
dev.off()

