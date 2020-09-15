## Downloading file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile = "FullData.zip", method = "curl")

## Unzip files
if (!file.exists("./NEI_Info"))
{ unzip("FullData.zip") }

## Reading Table, subsetting Baltimore (fips=24510), type and aggregate emissions in thousand tons by year
NEIdata                       <- readRDS("summarySCC_PM25.rds")
NEIBaltimore                  <- NEIdata[NEIdata$fips=="24510",]
EmissionsTotalYear            <- aggregate(Emissions ~ year + type ,NEIBaltimore, sum)
EmissionsTotalYear$Emissions  <- EmissionsTotalYear$Emissions / 1000

##Drawing Plot3 = Barplot "Baltimore Total Emissions (thousands Tons) by type, by year"
library(ggplot2)
png("plot3.png")
g <- ggplot(EmissionsTotalYear,aes(factor(year), Emissions, fill=type)) +
      geom_bar(stat="identity") +   facet_grid(.~type) + 
      ggtitle("Baltimore Total Emissions (thousands Tons) by type, by year") +      
      labs(x="year", y="PM2.5 thousand tons")
print(g)
dev.off()
