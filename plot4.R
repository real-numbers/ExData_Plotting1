
setwd("~/ExData_Plotting1")
# Unzipped the big data file into the /ExData_Plotting directory
# I really only did the data steps once for all four plots.  Oh well!
# First I ran this to get a quick look at the data..
testDF <- read.table("household_power_consumption.txt, na.strings="?", nrows = 10)
                     head(testDF)
                     
# Then I added sep=, header=, and colClasses=c() based on what I saw...
                     testDF <- read.table("household_power_consumption.txt", nrows= 100, sep=";"
                     ,header=TRUE,colClasses=c('character','character',rep('numeric',7)))
                     head(testDF)
                     str(testDF)
                     
# Played with the first 100 rows of the data a bit to figure out how to use the
# dates & times, then loaded the whole shebang
                     
                     fullData <- read.table("household_power_consumption.txt"
                     , header=TRUE, sep=";",na.strings="?"
                     ,colClasses=c('character','character',rep('numeric',7)
                     )
                     )
                     
# Took just the rows I needed
                     dataset<-fullData[fullData$Date=='1/2/2007' |fullData$Date=='2/2/2007' ,]
                     
# Got rid of the big data frame
                     rm(fullData)
                     
# Made the datetime column
                     x<- paste(dataset$Date,dataset$Time)
                     y<- strptime(x, "%d/%m/%Y %H:%M:%S")
                     dataset$datetime <- y
                     head(dataset)
                     
# Saved the data frame to file for later
                     write.csv(dataset, file = "Assignment1.csv")
                     

# Code for plot4 (seems silly to have datetime labels on two of them, oh well!)
       png(filename="plot4.png",width=480,height=480)
# I decided to leave the text size and margin size as default after playing with
# the setting quite a bit.
       par(mfrow=c(2,2))

       with(dataset, {plot(datetime,Global_active_power, type="l", xlab=""
                           ,ylab="Global Active Power"
                           )

                      plot(datetime,Voltage, type="l", ylab="Voltage")

                      plot(datetime,Sub_metering_1, xlab="",ylab="Energy sub metering",type="n")
                      points(datetime,Sub_metering_1, type="l", col="black")
                      points(datetime,Sub_metering_2, type="l", col="red")
                      points(datetime,Sub_metering_3, type="l", col="blue")
                      legend("topright", col=c("black","red","blue"),lty=c(1,1,1), cex=0.8
                        ,box.lwd = 0, legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
                      box()  # fixes a little problem caused by erasing the legend box
                      plot(datetime,Global_reactive_power, type="l")
                      }
           )
       dev.off()
       par(mfrow=c(1,1),mar=c(5.1,4.1,4.1,3.1),cex.lab=1.0, cex.axis=1.0)
