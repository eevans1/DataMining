library(ggplot2)
library(tidyverse)

#Creating a Subset
ABIA$TotalDelay <- ABIA$DepDelay + ABIA$ArrDelay # defining an important variable
DenFlights <- subset(ABIA, ABIA$Dest=="DEN") # subsetting the data, only care about DEN

#Plotting by Mean
AvgCarrierDelay <- aggregate(DenFlights$TotalDelay ~ DenFlights$UniqueCarrier, data=DenFlights, mean) # finding mean by carrier
AvgCarrierDelay # seeing what it looks like
colnames(AvgCarrierDelay) <- c("Carrier", "Avg Delay") # renaming the columns
AvgCarrierDelay <- AvgCarrierDelay[order(AvgCarrierDelay$`Avg Delay`), ]  # sort
AvgCarrierDelay$Carrier <- factor(AvgCarrierDelay$Carrier, levels = AvgCarrierDelay$Carrier)  # to retain the order in plot
head(AvgCarrierDelay, 5) # taking a goose gander
library(ggplot2) #loading ggplot2
ggplot(data=AvgCarrierDelay, aes(x=AvgCarrierDelay$Carrier, y=AvgCarrierDelay$`Avg Delay`))+
  geom_bar(stat="identity", width=.5, fill="tomato3") + 
  labs(title="Average Delays to Denver", 
       x="Carrier",
       y="AvgDelay (minutes)",
       subtitle="Airline Carrier vs Average Minutes Delayed", 
       caption="source: ABIA") + 
  theme(axis.text.x = element_text(angle=0, vjust=0.6))             

#Plotting by Median
AvgCarrierDelayMedian <- aggregate(DenFlights$TotalDelay ~ DenFlights$UniqueCarrier, data=DenFlights, median) # finding median by carrier
AvgCarrierDelayMedian$Volume <- FlightVolume$n
AvgCarrierDelayMedian # seeing what it looks like
colnames(AvgCarrierDelayMedian) <- c("Carrier", "Avg Delay") # renaming the columns
AvgCarrierDelayMedian <- AvgCarrierDelayMedian[order(c("F9", "WN", "UA", "YV", "OO")), ]  # sort
AvgCarrierDelayMedian$Carrier <- factor(AvgCarrierDelayMedian$Carrier, levels = c("F9", "WN", "UA", "YV", "OO"))  # to retain the order in plot
head(AvgCarrierDelayMedian, 5) # taking a goose gander
ggplot(data=AvgCarrierDelayMedian, aes(x=AvgCarrierDelayMedian$Carrier, y=AvgCarrierDelayMedian$`Avg Delay`))+
  geom_bar(stat="identity", width=.5, fill="tomato3") + 
  labs(title="Median Delay to Denver", 
       x="Carrier",
       y="Median Delay (minutes)",
       subtitle="Airline Carrier vs Median Delay", 
       caption="source: ABIA") + 
  theme(axis.text.x = element_text(angle=0, vjust=0.6))
