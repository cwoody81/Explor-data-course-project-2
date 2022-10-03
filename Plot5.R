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
data_BMC_Veh<-NEI%>%filter(fips=="24510",type=="ON-ROAD")%>%
        group_by(year)%>%
        summarise(total=sum(Emissions))


##open a png device and set to prescribed dimensions
png(file="plot5.png", width = 480, height = 480, units = "px",)

##plot  graph 
myplot5<-qplot(year,total,data = data_BMC_Veh,geom=c("line","point"))+
        geom_smooth(method = "lm",se=FALSE)+
        labs(x="Year",y="PM 2.5 Emissions in Tons", 
             title = "Decrease in Emissions by Vehicles in Baltimore City")
print(myplot5)
## turn off png in order to create the file
dev.off()