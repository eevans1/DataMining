Exercise 1
================
11 February 2019

Wyatt Allen, Elijah Evans, David Ford, Patrick Scovel

Data visualization 1: green buildings
-------------------------------------

![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-2-1.png)![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-2-2.png)![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-2-3.png)![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-2-4.png)

    ## nframes and fps adjusted to match transition

![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-2-1.gif)![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-2-6.png)![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-2-7.png)![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-2-8.png)

Data visualization 2: flights at ABIA
-------------------------------------

![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-4-1.gif)![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-4-2.png)![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-4-3.png)![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-4-4.png)![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-4-5.png)![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-4-6.png)

    ## Warning: Removed 188 rows containing non-finite values (stat_boxplot).

![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-4-7.png)

Using the attached code, we have derived the average delay for the five airliners that fly to Denver, CO from ABIA, as well as the median delays. The first graph is in increasing order of average delay times, but for the second one we made the decision to maintain the original ordering to promote easier comparisons. The most notable thing discovered by comparing these graphs is that no airliner has a negative mean delay, but four of the five airliners have negative median delays. We attribute this difference to outliers skewing the average. There are a few flights for each airliner that have hugely negative delays, even over 10 hours in a few cases. However, the negative delays, indicating an earlier arrival than anticipated, are never more than around 30 minutes. This made intuitive sense to us, as it is possible to leave an airport an indefinite amount of time after a scheduled departure, but an airplane can't really leave hours before it's scheduled to land, as it would clearly be unjust to expect all of the passengers and crew to be boarded and ready an hour or ten early, meaning that there is somewhat of a ceiling on how early a flight can be, but little to no limit on how late it can be.

Regression vs KNN
-----------------

![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-6-1.png)![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-6-2.png)![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-6-3.png)![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-6-4.png)![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-6-5.png)![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-6-6.png)![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-6-7.png)![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-6-8.png)![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-6-9.png)![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-6-10.png)![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-6-11.png)![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-6-12.png)![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-6-13.png)![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-6-14.png)![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-6-15.png)![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-6-16.png)![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-6-17.png)![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-6-18.png)![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-6-19.png)![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-6-20.png)![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-6-21.png)![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-6-22.png)

![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-7-1.png)

![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-8-1.png)![](Exercise_1_Alpha_files/figure-markdown_github/unnamed-chunk-8-2.png)
