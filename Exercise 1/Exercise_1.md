Exercise 1
================
Wyatt Allen, Elijah Evans, David Ford, Patrick Scovel
`r format(Sys.time(), '%d %B %Y')`

`{r setup, include=FALSE} knitr::opts_chunk$set(echo = TRUE)`

Data visualization 1: green buildings
-------------------------------------

Placeholder 1

Data visualization 2: flights at ABIA
-------------------------------------

\`\`\`{r, echo=FALSE} ABIA &lt;- read.csv("C:/Users/small/OneDrive/Spring 2019/Data Mining Local/Data Sets/ABIA.csv") library(ggplot2) library(tidyverse)

Creating a Subset
=================

ABIA*T**o**t**a**l**D**e**l**a**y* &lt; −*A**B**I**A*DepDelay + ABIA$ArrDelay \# defining an important variable DenFlights &lt;- subset(ABIA, ABIA$Dest=="DEN") \# subsetting the data, only care about DEN

Plotting by Mean
================

AvgCarrierDelay &lt;- aggregate(DenFlights*T**o**t**a**l**D**e**l**a**y* *D**e**n**F**l**i**g**h**t**s*UniqueCarrier, data=DenFlights, mean) \# finding mean by carrier colnames(AvgCarrierDelay) &lt;- c("Carrier", "Avg Delay") \# renaming the columns AvgCarrierDelay &lt;- AvgCarrierDelay\[order(AvgCarrierDelay$`Avg Delay`), \] \# sort AvgCarrierDelay*C**a**r**r**i**e**r* &lt; −*f**a**c**t**o**r*(*A**v**g**C**a**r**r**i**e**r**D**e**l**a**y*Carrier, levels = AvgCarrierDelay$Carrier) \# to retain the order in plot head(AvgCarrierDelay, 5) \# taking a goose gander library(ggplot2) \#loading ggplot2 ggplot(data=AvgCarrierDelay, aes(x=AvgCarrierDelay$Carrier, y=AvgCarrierDelay$`Avg Delay`))+ geom\_bar(stat="identity", width=.5, fill="tomato3") + labs(title="Average Delays to Denver", x="Carrier", y="AvgDelay (minutes)", subtitle="Airline Carrier vs Average Minutes Delayed", caption="source: ABIA") + theme(axis.text.x = element\_text(angle=0, vjust=0.6))

Plotting by Median
==================

AvgCarrierDelayMedian &lt;- aggregate(DenFlights*T**o**t**a**l**D**e**l**a**y* *D**e**n**F**l**i**g**h**t**s*UniqueCarrier, data=DenFlights, median) \# finding median by carrier AvgCarrierDelayMedian \# seeing what it looks like colnames(AvgCarrierDelayMedian) &lt;- c("Carrier", "Avg Delay") \# renaming the columns AvgCarrierDelayMedian &lt;- AvgCarrierDelayMedian\[order(c("F9", "WN", "UA", "YV", "OO")), \] \# sort AvgCarrierDelayMedian*C**a**r**r**i**e**r* &lt; −*f**a**c**t**o**r*(*A**v**g**C**a**r**r**i**e**r**D**e**l**a**y**M**e**d**i**a**n*Carrier, levels = c("F9", "WN", "UA", "YV", "OO")) \# to retain the order in plot head(AvgCarrierDelayMedian, 5) \# taking a goose gander ggplot(data=AvgCarrierDelayMedian, aes(x=AvgCarrierDelayMedian*C**a**r**r**i**e**r*, *y* = *A**v**g**C**a**r**r**i**e**r**D**e**l**a**y**M**e**d**i**a**n*`Avg Delay`))+ geom\_bar(stat="identity", width=.5, fill="tomato3") + labs(title="Median Delay to Denver", x="Carrier", y="Median Delay (minutes)", subtitle="Airline Carrier vs Median Delay", caption="source: ABIA") + theme(axis.text.x = element\_text(angle=0, vjust=0.6)) \`\`\`

Using the attached code, we have derived the average delay for the five airliners that fly to Denver, CO from ABIA, as well as the median delays. The first graph is in increasing order of average delay times, but for the second one we made the decision to maintain the original ordering to promote easier comparisons. The most notable thing discovered by comparing these graphs is that no airliner has a negative mean delay, but four of the five airliners have negative median delays. We attribute this difference to outliers skewing the average. There are a few flights for each airliner that have hugely negative delays, even over 10 hours in a few cases. However, the negative delays, indicating an earlier arrival than anticipated, are never more than around 30 minutes. This made intuitive sense to us, as it is possible to leave an airport an indefinite amount of time after a scheduled departure, but an airplane can't really leave hours before it's scheduled to land, as it would clearly be unjust to expect all of the passengers and crew to be boarded and ready an hour or ten early, meaning that there is somewhat of a ceiling on how early a flight can be, but little to no limit on how late it can be.

Regression vs KNN
-----------------

Placeholder 2
