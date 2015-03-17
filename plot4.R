################################################################################
#                                                                                                        
# Exploratory Data Analysis (Coursera) 16-03-2015
# Assignment 2. Plot 4
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
fuel <- SCC[SCC$EI.Sector=='Fuel Comb - Comm/Institutional - Coal',]
coal.scc <- paste(fuel$SCC)

# get only coal related emissions from NEI
coal <- subset(NEI, SCC %in% coal.scc)
coal$year <- as.factor(coal$year)
coal$Emissions[coal$Emissions==0] <- NA

# overall change
g1 <- qplot(year, Emissions, data=coal, geom='bar',stat = 'identity')+
        ylab('Emissions, tons')


#just look at the points
#g1<- ggplot(coal, aes(factor(year), Emissions),asp=1)+
#        geom_point(aes(size=10),alpha=0.2,color='blue')+
#        scale_y_log10(breaks=c(0.01,.01,.1,1,10,100))+
#        theme(legend.position="none")+
#        xlab('year')+
#        ylab('log10(Emissions)')

# density lines
g2 <- qplot(Emissions,data=coal,col=year,geom='density',log='x') + 
        xlab('log10(Emissions)')+
        ylab('Frequency')
        
# boxplots
g3 <- ggplot(coal, aes(year, Emissions),asp=1)+
        geom_boxplot(notch = T,outlier.size = 2,outlier.colour = 'grey50',notchwidth = 0.5) +
        scale_y_log10()+
        ylab('log10(Emissions)')


png('plot4.png', width = 800, height = 800)
f <- grid.arrange(arrangeGrob(g1,g3, ncol=2),g2,ncol=1,
                  main = textGrob(expression('Change in '*PM[2.5]*' emissions from coal combustion'), 
                                  gp=gpar(fontsize=20,font=2)),
                  sub = paste('Source: United States, the Environmental Protection Agency,', 
                              '\nNational Emissions Inventory, USA'))
dev.off()
