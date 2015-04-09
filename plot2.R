library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

new_NEI <- NEI[NEI$fips == "24510", ]

grouped_NEI <- new_NEI %>%
        group_by(year) %>%
        summarise(Emissions_ttl = sum(Emissions)) %>%
        arrange(desc(year))
balt_air <- head(grouped_NEI)
balt_air

png("plot2.png", bg = "white")

plot(balt_air, type = "b", main = "Change in Baltimore City Annual PM.25 Emissions 
     1999-2008", col = "dark blue", xlab = "Year", ylab = "Annual PM.25 Emissions 
     in tons")

dev.off()
