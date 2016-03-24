library(ggplot2)

plot6 <- function() {
	
	# Get required data files
	nei_data <- "../summarySCC_PM25.rds" 
	scc_data <- "../Source_Classification_Code.rds"
	
	#Check if all required files  exists
	if(file.exists(nei_data) & file.exists(scc_data)) {
		NEI <- readRDS(nei_data)
		SCC <- readRDS(scc_data)
		
		balti_la_data <- NEI[NEI$fips %in% c("24510","06037"), ]
		
		vehicle <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case=TRUE)
		new_SCC <- SCC[vehicle,]$SCC
		balti_la_vehicle_data <- balti_la_data[balti_la_data$SCC %in% new_SCC,]

		
		agg_data <- aggregate(balti_la_vehicle_data$Emissions, by=list(balti_la_vehicle_data$fips, balti_la_vehicle_data$year), FUN=sum)
		colnames(agg_data) <- c("fips", "year", "Emissions")
		
		pp <- qplot(year, Emissions, data=agg_data, geom=c("point", "line"), xlab="Year", ylab="Emissions (PM 2.5)", colour=fips, main="Baltimore Vs Los Angeles: Pollutant Emissions (Vehicle)")

		print("Saving plot...")
		ggsave("plot6.png", plot = pp)
	}
	else {
		cat('Cannot find all required files...')
	}
}