library(ggplot2)

plot4 <- function() {
	
	# Get required data files
	nei_data <- "../summarySCC_PM25.rds" 
	scc_data <- "../Source_Classification_Code.rds"
	
	#Check if all required files  exists
	if(file.exists(nei_data) & file.exists(scc_data)) {
		NEI <- readRDS(nei_data)
		SCC <- readRDS(scc_data)
		
		combustion <- grepl("comb", SCC$Short.Name, ignore.case=TRUE)
		coal_ <- grepl("coal", SCC$Short.Name, ignore.case=TRUE)
		coal_combustion <- combustion & coal_
		new_SCC <- SCC[coal_combustion,]$SCC
		new_NEI <- NEI[NEI$SCC %in% new_SCC,]
		
		agg_data <- aggregate(new_NEI$Emissions, by=list(new_NEI$type, new_NEI$year), FUN=sum)
		colnames(agg_data) <- c("type", "year", "Emissions")
		
		pp <- qplot(year, Emissions, data=agg_data, geom=c("point", "line"), xlab="Year", ylab="Emissions (PM 2.5)", colour=type, main="Pollutant Emissions (Coal & Combustion)")

		print("Saving plot...")
		ggsave("plot4.png", plot = pp, )
	}
	else {
		cat('Cannot find all required files...')
	}
}