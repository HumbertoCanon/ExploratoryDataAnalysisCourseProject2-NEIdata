## Downloading file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile = "FullData.zip", method = "curl")

## Unzip files
if (!file.exists("./NEI_Info"))
{ unzip("FullData.zip") }

## Reading Table, merging Tables, pull data with "coal" , subsetting Coal related
## and aggregate emissions in thousand tons by year
NEIdata                       <- readRDS("summarySCC_PM25.rds")
SCCdata                       <- readRDS("Source_Classification_Code.rds")

DataMerge                     <- merge(NEIdata, SCCdata, by="SCC")

IncludeCoal                   <- grepl("coal", DataMerge$Short.Name, ignore.case=TRUE)

SetOnlyCoal                   <- DataMerge [IncludeCoal, ]

EmissionsTotalYear            <- aggregate(Emissions ~ year, SetOnlyCoal, sum)
EmissionsTotalYear$Emissions  <- EmissionsTotalYear$Emissions / 1000

##Drawing Plot4 = Barplot "Total US Coal Combustion Emissions (thousands Tons) by year"
library(ggplot2)
png("plot4.png")
g <- ggplot(EmissionsTotalYear,aes(factor(year), Emissions)) +
  geom_bar(stat="identity") +   
  ggtitle("Total US Coal Combustion Emissions (thousands Tons) by year") +      
  labs(x="year", y="PM2.5 thousand tons")
print(g)
dev.off()
