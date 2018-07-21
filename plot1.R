# Read the file by filtering by Date
library(sqldf)
t1 <- read.csv.sql("household_power_consumption.txt",
                      sql="select * from file where Date = '1/2/2007' or Date = '2/2/2007' ",
                      sep=";")
closeAllConnections()

# Create the histogram
hist(t1$Global_active_power,
     col="red",
     main="Clobal Active Power",
     xlab="Global Active Power (kilowatts)")

# Copy the graph to a png file
dev.copy(png,file="plot1.png")
dev.off()
