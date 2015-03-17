################################################################################
#                                                                                                        
# Exploratory Data Analysis (Coursera) 12-03-2015
# Assignment 2. Plot 2
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

# subset Baltomore City
blt <- subset(NEI, NEI$fips=="24510")

# aggregate the emissons for Baltimore city by year
total <- aggregate(blt$Emissions,by = list(blt$year), sum)
total$thd <- round(total$x/10^03,2)

# show the decrease with barplot
png(filename = 'plot2.png')
par(mar = c(7,5,5,2))
barplot(height = total$thd, names.arg = total$Group.1, col = rev(brewer.pal(4,'Reds')), 
        ylab = 'Emissions, thd tons')
title(main = expression('Total '*PM[2.5]*' emissions by year'), 
      sub='Source: Baltimore city, the Environmental Protection Agency, \nNational Emissions Inventory, USA')
dev.off()

