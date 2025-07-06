setwd("~/Downloads/QMSS Statistics II")
require(data.table)
require(tidycensus)
require(ggplot2)

##see dataset https://www.kaggle.com/datasets/abdelrahman16/co2-emissions-usa/data
mydata<-fread("emissions.csv", 
              stringsAsFactors = F,
              data.table = F)

View(mydata)
names(mydata)
summary(mydata)

mydata_filtered <- subset(mydata, `state-name` == "New York" & year == 2021)
View(mydata_filtered)
head(mydata_filtered)

hist(mydata_filtered$value)

prop.table(table(mydata_filtered$`sector-name`))
prop.table(table(mydata_filtered$`fuel-name`))

##Is the residential sector emitting more than the
##commercial analysis?
unique(mydata_filtered$`fuel-name`)
mydata_two_fuels <- subset(mydata_filtered, `fuel-name` %in% c("Natural Gas", 
                                                                "Petroleum"))
t.test(value ~ `fuel-name`, data = mydata_two_fuels)

mydata_two_fuels2 <- subset(mydata_filtered, `fuel-name` %in% c("Coal", 
                                                               "All Fuels"))
t.test(value ~ `fuel-name`, data = mydata_two_fuels2)

require (ggplot2)

ggplot(mydata_filtered, aes(x = `sector-name`, y = value)) +
  geom_bar(stat = "identity", fill = "steelblue") +
  labs(
    y = "CO₂ Emissions (units)",
    title = "CO₂ Emissions from Natural Gas by Sector (NY, 2021)"
  ) +
  theme_minimal()









