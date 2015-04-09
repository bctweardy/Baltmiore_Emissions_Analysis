library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCC_mv <- grep("motor", SCC$Short.Name, ignore.case = TRUE)

SCC_mv <- SCC[SCC_mv, ]
SCC_identifiers <- as.character(SCC_mv$SCC)

NEI$SCC <- as.character(NEI$SCC)
NEI_mv <- NEI[NEI$SCC %in% SCC_identifiers, ]

NEI_mv_balt <- NEI_mv[which(NEI_mv$fips == "24510"), ]
NEI_mv_LA <- NEI_mv[which(NEI_mv$fips == "06037"), ]

aggregate_mv_balt <- with(NEI_mv_balt, aggregate(Emissions, by = list(year), sum))
aggregate_mv_balt$group <- rep("Baltimore County", length(aggregate_mv_balt[, 1]))

aggregate_mv_LA <- with(NEI_mv_LA, aggregate(Emissions, by = list(year), sum))
aggregate_mv_LA$group <- rep("Los Angeles County", length(aggregate_mv_LA[, 1]))

aggregate_mv_cities <- rbind(aggregate_mv_LA, aggregate_mv_balt)
aggregate_mv_cities$group <- as.factor(aggregate_mv_cities$group)

colnames(colnames(aggregate_mv_cities) <- c("Year", "Emissions", "Group"))

png("plot6.png")

qplot(Year, Emissions, data = aggregate_mv_cities, group = Group, color = Group, 
      geom = c("point", "line"), ylab = "Emissions", 
      xlab = "Year", main = "Comparison of Total Emissions
      Baltimore City VS. Los Angeles County
      (1999-2008)")

dev.off()