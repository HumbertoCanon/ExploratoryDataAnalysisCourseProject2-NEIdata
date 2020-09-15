## Downloading file
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
download.file(fileUrl, destfile = "FullData.zip", method = "curl")

## Unzip files
if (!file.exists("./NEI_Info"))
{ unzip("FullData.zip") }

## Reading Table, subsetting Baltimore (fips=24510) and aggregate emissions in thousand tons by year
NEIdata                       <- readRDS("summarySCC_PM25.rds")
NEIBaltimore                  <- NEIdata[NEIdata$fips=="24510",]
EmissionsTotalYear            <- aggregate(Emissions ~ year,NEIBaltimore, sum)
EmissionsTotalYear$Emissions  <- EmissionsTotalYear$Emissions / 1000

##Drawing Plot2 = Barplot "Baltimore Total Emissions (thousands Tons) by year"
png("plot2.png")
with(EmissionsTotalYear, barplot(Emissions, names.arg=year, 
                                 col="blue", main = "Baltimore Total Emissions PM2.5 (thousand Tons) by year",
                                 xlab = "Year", ylab = "PM2.5 thousand tons")) 
dev.off()


