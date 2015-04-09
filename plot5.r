## How have emissions from motor vehicle sources changed from 1999-2008 in 
## Baltimore City?

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCC_mv <- grep("motor", SCC$Short.Name, ignore.case = TRUE)

SCC_mv <- SCC[SCC_mv, ]
SCC_identifiers <- as.character(SCC_mv$SCC)

NEI$SCC <- as.character(NEI$SCC)
NEI_mv <- NEI[NEI$SCC %in% SCC_identifiers, ]

NEI_mv_balt <- NEI_mv[which(NEI_mv$fips == "24510"), ]

aggregate_mv_balt <- with(NEI_mv_balt, aggregate(Emissions, by = list(year), sum))

png("plot5.png")

plot(aggregate_mv_balt, xlab = "Year", ylab = "Emissions", main = "Change in 
        Emiissions from Motor Vehicle
     Sources (1999-2008)", type = "b",
     col = "orange")

dev.off()