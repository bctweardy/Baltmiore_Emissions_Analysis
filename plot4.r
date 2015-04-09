## Across the United States, how have emissions from coal combustion-related sources 
## changed from 1999-2008?

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

SCC_coal <- grep("coal", SCC$Short.Name, ignore.case = TRUE)

SCC_coal <- SCC[SCC_coal, ]
SCC_identifiers <- as.character(SCC_coal$SCC)

NEI$SCC <- as.character(NEI$SCC)
NEI_coal <- NEI[NEI$SCC %in% SCC_identifiers, ]

aggregate_coal <- with(NEI_coal, aggregate(Emissions, by = list(year), sum ))
colnames(aggregate_coal) <- c("Year", "Emissions")

plot(x = Year, y = Emissions, xlab = "Year", ylab = "Emissions", main = "Change in 
        Emiissions from Coal Combustion-Related Sources (1999-2008)")