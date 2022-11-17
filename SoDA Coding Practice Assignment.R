# Load required packages
library(readxl)
library(dplyr)

# Load data
polity <- read.csv("C:\\Users\\slask\\Downloads\\PolityV.csv")
genocides <- read_xlsx("C:\\Users\\slask\\Downloads\\Number of active Genocides Data Global.xlsx")

# Look at years contained in each dataset
table(polity$year)
table(genocides$Year)

# Remove entries from years not between 1956-2015 in Polity Data
polity <- polity[polity$year >= 1956 & 2015 >= polity$year,]

# Remove values below -10 in Polity data
polity <- polity[polity$polity >= -10,]

# Remove unnecessary variables in datasets
polity <- subset(polity, select = c(5,6,11))
genocides <- subset(genocides, select = -c(2))

# Create master dataframe
df = merge(polity, genocides, by.x = c("country","year"), by.y = c("Entity","Year"))

# Assign genocide variable more appropriate name
rename(df, gen_occurred = ...4)

# Run simple linear regression 
model <- lm(gen_occurred ~ polity, data = df)
model

# Plot simple linear regression
library(ggplot2)
ggplot(df, aes(polity, gen_occurred)) +
  geom_point() +
  stat_smooth(method = lm)




