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
NEISet                        <- NEIdata[(NEIdata$fips=="24510" | NEIdata$fips=="06037")& (NEIdata$type=="ON-ROAD"),]
EmissionsTotalYear            <- aggregate(Emissions ~ year + fips, NEISet, sum)
EmissionsTotalYear$fips[EmissionsTotalYear$fips=="24510"] <- "Baltimore"
EmissionsTotalYear$fips[EmissionsTotalYear$fips=="06037"] <- "Los Angeles"

##Drawing Plot6 = Barplot "Comparison Baltimore-Los Angeles motor vehicle Emissions (Tons) by year"
library(ggplot2)
png("plot6.png")
g <- ggplot(EmissionsTotalYear,aes(factor(year), Emissions, fill= fips)) +
  facet_grid(fips~.) +
  geom_bar(stat="identity") +
  ggtitle("Comparison Baltimore-Los Angeles motor vehicle Emissions (Tons) by year") +      
  labs(x="Year", y="PM2.5 Tons")
print(g)
dev.off()
