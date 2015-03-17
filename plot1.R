################################################################################
#                                                                                                        
# Exploratory Data Analysis (Coursera) 12-03-2015
# Assignment 2. Plot 1
# Ilya Kashnitsky, ilya.kashnitsky@gmail.com
#                                                                                                    
################################################################################

# Erase all objects in memory
rm(list = ls(all = TRUE))

# Load libraries
library(RColorBrewer)

# set working directory
setwd('d:/ACADEMIC/COURSES/2015.03 Exploratory data analysis/Assignment 2/')

# Load data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# aggregate the emissons by year
total <- aggregate(NEI$Emissions,by = list(NEI$year), sum)
total$mln <- round(total$x/10^06,2)

# show the decrease with barplot
png(filename = 'plot1.png')
par(mar = c(5,5,5,2))
barplot(height = total$mln, names.arg = total$Group.1, col = rev(brewer.pal(4,'Reds')), 
        ylab = 'Emissions, mln tons')
title(main = expression('Total '*PM[2.5]*' emissions by year',cex=2), 
      sub='Source: United States, the Environmental Protection Agency \nNational Emissions Inventory, USA')
dev.off()

