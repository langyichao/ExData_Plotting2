################################################################################
#                                                                                                        
# Exploratory Data Analysis (Coursera) 12-03-2015
# Assignment 2. Plot 3
# Ilya Kashnitsky, ilya.kashnitsky@gmail.com
#                                                                                                    
################################################################################

# Erase all objects in memory
rm(list = ls(all = TRUE))

# Load libraries
library(ggplot2)
library(grid)
library(gridExtra)

# set working directory
setwd('d:/ACADEMIC/COURSES/2015.03 Exploratory data analysis/Assignment 2/')

# Load data
NEI <- readRDS("data/summarySCC_PM25.rds")
SCC <- readRDS("data/Source_Classification_Code.rds")

# subset Baltomore City
blt <- subset(NEI, NEI$fips=="24510")

# Plot the facet histograms (total emissions by type)
# NOTE: this plot gives a simple answer for the question as it reflects the overall 
#       change in emissions
q <- qplot(data = blt, x=year, y=Emissions, fill=type, facets=.~type, 
           geom='bar',stat="identity")
q <- q + scale_x_continuous(breaks=c(1999,2002,2005,2008))+
        labs(title='Total emissions', ylab='Emissions, tons')+
        theme(legend.position="none")

# plot the distibution change using boxplot
# NOTE: the boxplot gives answer for another possible interpretation of the question #4
#       here we are ib=nterested if the distribution of emission has changed
p <- ggplot(blt, aes(factor(year), Emissions),asp=1)
p <- p + geom_boxplot(notch = T,outlier.size = 0,notchwidth = 0.7)+
        facet_grid(facets = .~type)+
        scale_y_log10()+
        labs(title='Distribution change')+
        xlab('year')+
        ylab('log10(Emissions)')
        
png('plot3.png', width = 800, height = 800)
grid.arrange(q, p, nrow=2,
             main = textGrob(expression('Change in '*PM[2.5]*' emissions by type'), 
                             gp=gpar(fontsize=20,font=2)),
             sub = 'Source: Baltimore city, the Environmental Protection Agency, \nNational Emissions Inventory, USA')
dev.off()
