
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
       rm(testDF)
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

# Code for plot2
      png(filename="plot2.png",width=480,height=480)
      par(mfrow=c(1,1))

      with(dataset,
           plot(datetime,Global_active_power, type="l", 
           ylab="Global Active Power (kilowatts)",xlab=""))

dev.off()
