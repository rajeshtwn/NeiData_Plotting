library(ggplot2)

plot5 <- function() {
	
	# Get required data files
	nei_data <- "../summarySCC_PM25.rds" 
	scc_data <- "../Source_Classification_Code.rds"
	
	#Check if all required files  exists
	if(file.exists(nei_data) & file.exists(scc_data)) {
		NEI <- readRDS(nei_data)
		SCC <- readRDS(scc_data)
		
		baltimore_data <- NEI[NEI$fips == "24510", ]
		
		vehicle <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
		new_SCC <- SCC[vehicle,]$SCC
		baltimore_vehicle_data <- baltimore_data[baltimore_data$SCC %in% new_SCC,]
		
		agg_data <- aggregate(baltimore_vehicle_data$Emissions, by=list(baltimore_vehicle_data$type, baltimore_vehicle_data$year), FUN=sum)
		colnames(agg_data) <- c("type", "year", "Emissions")
		
		pp <- qplot(year, Emissions, data=agg_data, geom=c("point", "line"), xlab="Year", ylab="Emissions (PM 2.5)", colour=type, main="Pollutant Emissions for Baltimore(Vehicle)")

		print("Saving plot...")
		ggsave("plot5.png", plot = pp)
	}
	else {
		cat('Cannot find all required files...')
	}
}