##set the environment
library(readr)
library(dplyr)
library(lubridate)
library(lattice)
library(ggplot2)

##download data from project1 data site
##if(!file.exists("./data")){dir.create("./data")}
##url1<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
##download.file(url1,"./data/NEI_data.zip",method="curl")
## decompress the file
##unzip("./data/NEI_data.zip", exdir = "./data")

##read the file to a table and store in variable data
## This first line will likely take a few seconds. Be patient!
##NEI <- readRDS("./data/summarySCC_PM25.rds")
##SCC <- readRDS("./data/Source_Classification_Code.rds")

## subset out the correct date window for the data according to directions
data_BMC_LA<-NEI%>%filter(fips=="24510"|fips=="06037",type=="ON-ROAD")%>%
        group_by(fips,year)%>%
        summarise(total=sum(Emissions))


##open a png device and set to prescribed dimensions
png(file="plot6.png", width = 480, height = 480, units = "px",)

##plot the line graph like the example
myplot6<-qplot(year,total,data = data_BMC_LA,geom=c("line","point"),color=fips)+
        geom_smooth(method = "lm",se=FALSE)+
        labs(x="Year",y="PM 2.5 Emissions in Tons", 
        title = "Compare Emissions from Motor Vehicles in LA and Baltimore City")+
        scale_colour_discrete(name="City",labels=c("Los Angeles","Baltimore"))
print(myplot6)
## turn off png in order to create the file
dev.off()