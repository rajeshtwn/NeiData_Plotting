plot1 <- function() {
	
	# Get required data files
	nei_data <- "../summarySCC_PM25.rds" 
	scc_data <- "../Source_Classification_Code.rds"
	
	#Check if all required files  exists
	if(file.exists(nei_data) & file.exists(scc_data)) {
		NEI <- readRDS(nei_data)
		SCC <- readRDS(scc_data)
		
		# unique(NEI$year)
		agg_data <- aggregate(Emissions ~ year, NEI, sum)
		plot(agg_data$year, agg_data$Emissions/1e6, type="l", xlab="Year", ylab="Emissions (PM 2.5)", main="Pollutant Emissions (in millions)", col="blue")
		
		print("Saving plot...")
		dev.copy(png, file="plot1.png", width=480, height=480)
        dev.off()
	}
	else {
		cat('Cannot find all required files...')
	}
}