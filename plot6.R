################################################################################
#                                                                                                        
# Exploratory Data Analysis (Coursera) 17-03-2015
# Assignment 2. Plot 6
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

# get all coal conected SCC's
motor.names <- levels(SCC$EI.Sector)[43:52]
motor.data <- subset(SCC, EI.Sector %in% motor.names)
motor.scc <- paste(motor.data$SCC)

# subset Baltomore City
bltLA <- subset(NEI, fips %in% c('24510','06037'))

# get only coal related emissions for Baltimore ci
motor <- subset(bltLA, SCC %in% motor.scc)
motor$year <- as.factor(motor$year)
motor$fips <- as.factor(motor$fips)
levels(motor$fips) <- c('Los Angeles', 'Baltimore')

# overall change
g1 <- qplot(year, Emissions, data=motor, fill=fips, facets = .~fips, geom='bar',stat = 'identity')+
        theme(legend.position="none")+
        ylab('Emissions, tons')

# density lines
g2 <- qplot(Emissions,data=motor,col=fips,geom='density', log='x',facets = .~year) + 
        xlab('log10(Emissions)')+
        ylab('Frequency')
        
# boxplots
g3 <- ggplot(motor, aes(year, Emissions),asp=1)+
        facet_grid(facets = .~fips)+
        geom_boxplot(notch = T,outlier.size = 2,outlier.colour = 'grey50',notchwidth = 0.5) +
        scale_y_log10()+
        ylab('log10(Emissions)')

# arrange all 3 plots in a fancy way
png('plot6.png', width = 800, height = 800)
f <- grid.arrange(arrangeGrob(g1,g3, ncol=2),g2,ncol=1,
                  main = textGrob(expression('Change in '*PM[2.5]*' emissions from motor vehicles'), 
                                  gp=gpar(fontsize=20,font=2)),
                  sub = paste('Source: Baltimore & Los Angeles, the Environmental Protection Agency,', 
                              '\nNational Emissions Inventory, USA'))
dev.off()
