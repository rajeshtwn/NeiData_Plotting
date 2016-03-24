library(ggplot2)

plot3 <- function() {
	
	# Get required data files
	nei_data <- "../summarySCC_PM25.rds" 
	scc_data <- "../Source_Classification_Code.rds"
	
	#Check if all required files  exists
	if(file.exists(nei_data) & file.exists(scc_data)) {
		NEI <- readRDS(nei_data)
		SCC <- readRDS(scc_data)
		
		baltimore_data <- NEI[NEI$fips == "24510", ]
		agg_data <- aggregate(baltimore_data$Emissions, by=list(baltimore_data$type, baltimore_data$year), FUN=sum)
		colnames(agg_data) <- c("type", "year", "Emissions")
		
		pp <- qplot(year, Emissions, data=agg_data, geom=c("point", "line"), xlab="Year", ylab="Emissions (PM 2.5)", colour=type, main="Pollutant Emissions for Baltimore City")

		print("Saving plot...")
		ggsave("plot3.png", plot = pp, )
	}
	else {
		cat('Cannot find all required files...')
	}
}