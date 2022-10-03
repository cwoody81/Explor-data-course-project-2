##set the environment
library(readr)
library(dplyr)
library(lubridate)
library(lattice)
library(ggplot2)

##download data from project1 data site
if(!file.exists("./data")){dir.create("./data")}
url1<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(url1,"./data/NEI_data.zip",method="curl")
## decompress the file
unzip("./data/NEI_data.zip", exdir = "./data")

##read the file to a table and store in variable data

NEI <- readRDS("./data/summarySCC_PM25.rds")
SCC <- readRDS("./data/Source_Classification_Code.rds")

## subset out the correct data according to directions
data_BMC2<-NEI%>%filter(fips=="24510")%>%group_by(type,year)%>%
        summarise(total=sum(Emissions))

##open a png device and set to prescribed dimensions
png(file="plot3.png", width = 480, height = 480, units = "px",)

##plot graph
myplot3<-qplot(year,total,data = data_BMC2,geom=c("line","point"),color = type)+
        geom_smooth(lty=2,method="lm",se=FALSE)+labs(x="Year",y="PM 2.5 Emissions in Tons", 
             title = "Decrease in Baltimore City Emissions by type")
print(myplot3)
## turn off png in order to create the file

dev.off()