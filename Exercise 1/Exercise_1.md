Exercise 1
================
Wyatt Allen, Elijah Evans, David Ford, Patrick Scovel
10 February 2019

Data visualization 1: green buildings
-------------------------------------

Placeholder 1

Data visualization 2: flights at ABIA
-------------------------------------

    ## -- Attaching packages ------------------------------------------------------------------------------------------ tidyverse 1.2.1 --

    ## v tibble  2.0.1     v purrr   0.3.0
    ## v tidyr   0.8.2     v dplyr   0.7.8
    ## v readr   1.3.1     v stringr 1.3.1
    ## v tibble  2.0.1     v forcats 0.3.0

    ## -- Conflicts --------------------------------------------------------------------------------------------- tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

    ##   DenFlights$UniqueCarrier DenFlights$TotalDelay
    ## 1                       F9              3.390977
    ## 2                       OO             29.398601
    ## 3                       UA             16.700000
    ## 4                       WN             16.089905
    ## 5                       YV             23.123016

    ##   Carrier Avg Delay
    ## 1      F9  3.390977
    ## 4      WN 16.089905
    ## 3      UA 16.700000
    ## 5      YV 23.123016
    ## 2      OO 29.398601

![](Exercise_1_files/figure-markdown_github/unnamed-chunk-1-1.png)

    ##   DenFlights$UniqueCarrier DenFlights$TotalDelay
    ## 1                       F9                    -7
    ## 2                       OO                     3
    ## 3                       UA                    -5
    ## 4                       WN                    -1
    ## 5                       YV                    -3

    ##   Carrier Avg Delay
    ## 1      F9        -7
    ## 5      YV        -3
    ## 3      UA        -5
    ## 2      OO         3
    ## 4      WN        -1

![](Exercise_1_files/figure-markdown_github/unnamed-chunk-1-2.png)

Using the attached code, we have derived the average delay for the five airliners that fly to Denver, CO from ABIA, as well as the median delays. The first graph is in increasing order of average delay times, but for the second one we made the decision to maintain the original ordering to promote easier comparisons. The most notable thing discovered by comparing these graphs is that no airliner has a negative mean delay, but four of the five airliners have negative median delays. We attribute this difference to outliers skewing the average. There are a few flights for each airliner that have hugely negative delays, even over 10 hours in a few cases. However, the negative delays, indicating an earlier arrival than anticipated, are never more than around 30 minutes. This made intuitive sense to us, as it is possible to leave an airport an indefinite amount of time after a scheduled departure, but an airplane can't really leave hours before it's scheduled to land, as it would clearly be unjust to expect all of the passengers and crew to be boarded and ready an hour or ten early, meaning that there is somewhat of a ceiling on how early a flight can be, but little to no limit on how late it can be.

Regression vs KNN
-----------------

Placeholder 2
