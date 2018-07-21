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
with(t3,plot(DT,Global_active_power,type="n",xlab = ""))
lines(t3$DT,t3$Global_active_power)

# Copy the graph to a png file
dev.copy(png,file="plot2.png")
dev.off()

