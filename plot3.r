##Of the four types of sources indicated by the type (point, nonpoint, onroad, 
##nonroad) variable, which of these four sources have seen decreases in emissions 
##from 1999-2008 for Baltimore City? Which have seen increases in emissions from 
##1999-2008? Use the ggplot2 plotting system to make a plot answer this question.

library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

point_NEI <- NEI[NEI$fips == "24510", ]

grouped_NEI <- point_NEI %>%
        group_by(year, type) %>%
        summarise(Emissions_ttl = sum(Emissions)) %>%
        arrange(desc(year))
grouped_NEI


qplot(year, Emissions_ttl, data = grouped_NEI, facets = type~., bandwidth = 2, 
      color = type, geom = c("line", "point"), xlab = "Year", ylab = "Annual 
        PM.25 Emissions in tons", main = "Change in Baltimore City Annual PM.25 
      Emissions by Type (1999-2008)")