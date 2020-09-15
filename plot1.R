## Downloading file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile = "FullData.zip", method = "curl")

## Unzip files
if (!file.exists("./NEI_Info"))
{ unzip("FullData.zip") }

## Reading Table and aggregate emissions in million thousand by year
NEIdata             <- readRDS("summarySCC_PM25.rds")
EmissionsTotalYear  <- aggregate(Emissions ~ year,NEIdata, sum)
EmissionsTotalYear$Emissions <- EmissionsTotalYear$Emissions / 1000

##Drawing Plot1 = Barplot "Total Emissions (thousand Tons) by year"
png("plot1.png")
with(EmissionsTotalYear, barplot(Emissions, names.arg=year, 
        col="green", main = "Total Emissions PM2.5 (thousand Tons) by year",
        xlab = "Year", ylab = "PM2.5 thousand tons")) 
dev.off()


