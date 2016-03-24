plot2 <- function() {
	
	# Get required data files
	nei_data <- "../summarySCC_PM25.rds" 
	scc_data <- "../Source_Classification_Code.rds"
	
	#Check if all required files  exists
	if(file.exists(nei_data) & file.exists(scc_data)) {
		NEI <- readRDS(nei_data)
		SCC <- readRDS(scc_data)
		
		baltimore_data <- NEI[NEI$fips == "24510", ]
		agg_data <- aggregate(Emissions ~ year, baltimore_data, sum)
		plot(agg_data$year, agg_data$Emissions/1000, type="l", xlab="Year", ylab="Emissions (PM 2.5)", main="Pollutant Emissions for Baltimore City (in 1000)", col="blue")
		
		print("Saving plot...")
		dev.copy(png, file="plot2.png", width=480, height=480)
        dev.off()
	}
	else {
		cat('Cannot find all required files...')
	}
}