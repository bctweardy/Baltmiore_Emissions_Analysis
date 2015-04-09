library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")



grouped_NEI <- NEI %>%
        group_by(year) %>%
        summarise(Emissions_ttl = sum(Emissions)) %>%
        arrange(desc(Emissions_ttl))
bad_air <- head(grouped_NEI)
bad_air

png("plot1.png", bg="white")

plot(bad_air, type = "b", main = "Change in Total Annual PM.25 Emissions 1999-2008",
     col = "red", xlab = "Year", ylab = "Annual PM.25 Emissions in tons")

dev.off()