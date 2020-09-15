## Downloading file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile = "FullData.zip", method = "curl")

## Unzip files
if (!file.exists("./NEI_Info"))
{ unzip("FullData.zip") }

## Reading Table, subsetting Baltimore (fips=24510), type related vehicles ("ON-ROAD")
## and aggregate emissions in thousand tons by year.
## I am using for motor vehicle type= ON-ROAD as it includes 4 types for EI.Sector and 2 for
## SCC.level.two, the only not included is border crossing.  Other vehicles in level two are
## minig, recreational and other kind of vehicles.
NEIdata                       <- readRDS("summarySCC_PM25.rds")
NEIBaltimore                  <- NEIdata[NEIdata$fips=="24510" & (NEIdata$type=="ON-ROAD"),]
EmissionsTotalYear            <- aggregate(Emissions ~ year, NEIBaltimore, sum)
EmissionsTotalYear$Emissions  <- EmissionsTotalYear$Emissions / 1000

##Drawing Plot5 = Barplot "Total Baltimore motor vehicle Emissions (thousands Tons) by year"
library(ggplot2)
png("plot5.png")
g <- ggplot(EmissionsTotalYear,aes(factor(year), Emissions)) +
  geom_bar(stat="identity") +   
  ggtitle("Total Baltimore motor vehicle Emissions (thousands Tons) by year") +      
  labs(x="year", y="PM2.5 thousand tons")
print(g)
dev.off()
