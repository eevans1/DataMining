Exercise 1
================
06 April 2019

``` r
greenbuildings <- read.csv("https://raw.githubusercontent.com/jgscott/ECO395M/master/data/greenbuildings.csv")
library(tidyverse)
```

    ## -- Attaching packages ------------------------------------------------------------------------------------------------------------- tidyverse 1.2.1 --

    ## v ggplot2 3.1.0.9000     v purrr   0.3.0     
    ## v tibble  2.0.1          v dplyr   0.7.8     
    ## v tidyr   0.8.2          v stringr 1.3.1     
    ## v readr   1.3.1          v forcats 0.3.0

    ## -- Conflicts ---------------------------------------------------------------------------------------------------------------- tidyverse_conflicts() --
    ## x dplyr::filter() masks stats::filter()
    ## x dplyr::lag()    masks stats::lag()

``` r
library(mosaic)
```

    ## Loading required package: lattice

    ## Loading required package: ggformula

    ## Loading required package: ggstance

    ## 
    ## Attaching package: 'ggstance'

    ## The following objects are masked from 'package:ggplot2':
    ## 
    ##     geom_errorbarh, GeomErrorbarh

    ## 
    ## New to ggformula?  Try the tutorials: 
    ##  learnr::run_tutorial("introduction", package = "ggformula")
    ##  learnr::run_tutorial("refining", package = "ggformula")

    ## Loading required package: mosaicData

    ## Loading required package: Matrix

    ## 
    ## Attaching package: 'Matrix'

    ## The following object is masked from 'package:tidyr':
    ## 
    ##     expand

    ## 
    ## The 'mosaic' package masks several functions from core packages in order to add 
    ## additional features.  The original behavior of these functions should not be affected by this.
    ## 
    ## Note: If you use the Matrix package, be sure to load it BEFORE loading mosaic.

    ## 
    ## Attaching package: 'mosaic'

    ## The following object is masked from 'package:Matrix':
    ## 
    ##     mean

    ## The following objects are masked from 'package:dplyr':
    ## 
    ##     count, do, tally

    ## The following object is masked from 'package:purrr':
    ## 
    ##     cross

    ## The following object is masked from 'package:ggplot2':
    ## 
    ##     stat

    ## The following objects are masked from 'package:stats':
    ## 
    ##     binom.test, cor, cor.test, cov, fivenum, IQR, median,
    ##     prop.test, quantile, sd, t.test, var

    ## The following objects are masked from 'package:base':
    ## 
    ##     max, mean, min, prod, range, sample, sum

``` r
library(foreach)
```

    ## Warning: package 'foreach' was built under R version 3.5.3

    ## 
    ## Attaching package: 'foreach'

    ## The following objects are masked from 'package:purrr':
    ## 
    ##     accumulate, when

``` r
# Lets first try the step function

g <- greenbuildings[complete.cases(greenbuildings),]

lm = lm(Rent ~ 
          size + age + class_a + class_b + 
          amenities + cluster_rent + cluster,
        data = g)
summary(lm)
```

    ## 
    ## Call:
    ## lm(formula = Rent ~ size + age + class_a + class_b + amenities + 
    ##     cluster_rent + cluster, data = g)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -52.207  -3.700  -0.472   2.363 176.263 
    ## 
    ## Coefficients:
    ##                Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)  -4.545e+00  5.073e-01  -8.959  < 2e-16 ***
    ## size          6.080e-06  4.208e-07  14.451  < 2e-16 ***
    ## age          -7.079e-03  3.991e-03  -1.774 0.076162 .  
    ## class_a       2.842e+00  4.219e-01   6.735 1.76e-11 ***
    ## class_b       1.290e+00  3.378e-01   3.819 0.000135 ***
    ## amenities     4.522e-01  2.456e-01   1.841 0.065616 .  
    ## cluster_rent  1.066e+00  1.046e-02 101.919  < 2e-16 ***
    ## cluster       9.804e-04  2.772e-04   3.537 0.000407 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 9.473 on 7812 degrees of freedom
    ## Multiple R-squared:  0.6069, Adjusted R-squared:  0.6066 
    ## F-statistic:  1723 on 7 and 7812 DF,  p-value: < 2.2e-16

``` r
lm_step = step(lm, 
               scope=~(. + empl_gr + stories + green_rating + leasing_rate + renovated)^2)
```

    ## Start:  AIC=35174.32
    ## Rent ~ size + age + class_a + class_b + amenities + cluster_rent + 
    ##     cluster
    ## 
    ##                          Df Sum of Sq     RSS   AIC
    ## + size:cluster_rent       1     41134  659954 34703
    ## + size:cluster            1     10113  690975 35063
    ## + class_a:cluster_rent    1      9843  691245 35066
    ## + class_b:cluster_rent    1      6532  694555 35103
    ## + amenities:cluster_rent  1      4639  696449 35124
    ## + age:cluster_rent        1      2252  698836 35151
    ## + class_a:cluster         1      2071  699016 35153
    ## + age:class_b             1      1298  699790 35162
    ## + age:cluster             1      1161  699927 35163
    ## + amenities:cluster       1      1072  700016 35164
    ## + class_b:cluster         1       924  700164 35166
    ## + cluster_rent:cluster    1       865  700222 35167
    ## + size:class_b            1       620  700468 35169
    ## + size:class_a            1       402  700686 35172
    ## + class_a:amenities       1       340  700748 35173
    ## + green_rating            1       299  700789 35173
    ## + stories                 1       295  700792 35173
    ## + class_b:amenities       1       245  700842 35174
    ## + renovated               1       229  700859 35174
    ## + leasing_rate            1       212  700876 35174
    ## <none>                                 701088 35174
    ## + size:amenities          1       141  700946 35175
    ## + age:amenities           1       121  700967 35175
    ## + size:age                1       117  700970 35175
    ## + age:class_a             1        82  701006 35175
    ## - age                     1       282  701370 35175
    ## - amenities               1       304  701392 35176
    ## + empl_gr                 1         4  701083 35176
    ## - cluster                 1      1123  702210 35185
    ## - class_b                 1      1309  702397 35187
    ## - class_a                 1      4071  705158 35218
    ## - size                    1     18741  719828 35379
    ## - cluster_rent            1    932220 1633308 41786
    ## 
    ## Step:  AIC=34703.5
    ## Rent ~ size + age + class_a + class_b + amenities + cluster_rent + 
    ##     cluster + size:cluster_rent
    ## 
    ##                          Df Sum of Sq    RSS   AIC
    ## + size:cluster            1      2772 657182 34673
    ## + cluster_rent:cluster    1      2332 657622 34678
    ## + class_a:cluster         1       774 659180 34696
    ## + leasing_rate            1       637 659317 34698
    ## + class_b:cluster         1       529 659424 34699
    ## + age:cluster_rent        1       462 659492 34700
    ## + green_rating            1       387 659566 34701
    ## + age:class_b             1       369 659585 34701
    ## + age:cluster             1       347 659606 34701
    ## + size:class_a            1       318 659636 34702
    ## + age:class_a             1       286 659668 34702
    ## + class_b:cluster_rent    1       260 659694 34702
    ## + class_b:amenities       1       250 659704 34703
    ## + amenities:cluster       1       235 659719 34703
    ## + class_a:amenities       1       198 659756 34703
    ## <none>                                659954 34703
    ## + size:class_b            1       162 659792 34704
    ## + size:age                1        75 659879 34705
    ## + amenities:cluster_rent  1        74 659880 34705
    ## + stories                 1        31 659923 34705
    ## + class_a:cluster_rent    1        27 659926 34705
    ## + size:amenities          1        23 659931 34705
    ## + age:amenities           1        21 659933 34705
    ## + renovated               1        19 659935 34705
    ## + empl_gr                 1         0 659954 34705
    ## - amenities               1       486 660440 34707
    ## - age                     1       822 660776 34711
    ## - cluster                 1      1242 661196 34716
    ## - class_b                 1      1492 661445 34719
    ## - class_a                 1      3990 663944 34749
    ## - size:cluster_rent       1     41134 701088 35174
    ## 
    ## Step:  AIC=34672.58
    ## Rent ~ size + age + class_a + class_b + amenities + cluster_rent + 
    ##     cluster + size:cluster_rent + size:cluster
    ## 
    ##                          Df Sum of Sq    RSS   AIC
    ## + cluster_rent:cluster    1      2546 654636 34644
    ## + leasing_rate            1       643 656539 34667
    ## + age:class_b             1       416 656766 34670
    ## + age:cluster_rent        1       387 656795 34670
    ## + green_rating            1       354 656828 34670
    ## + class_b:cluster_rent    1       288 656893 34671
    ## + class_b:amenities       1       262 656920 34671
    ## + age:class_a             1       238 656944 34672
    ## + class_a:amenities       1       180 657001 34672
    ## + size:class_a            1       168 657014 34673
    ## <none>                                657182 34673
    ## + size:age                1       110 657071 34673
    ## + class_b:cluster         1        85 657097 34674
    ## + stories                 1        79 657103 34674
    ## + amenities:cluster_rent  1        76 657106 34674
    ## + size:class_b            1        70 657112 34674
    ## + age:cluster             1        51 657131 34674
    ## + amenities:cluster       1        31 657151 34674
    ## + class_a:cluster_rent    1        24 657158 34674
    ## + class_a:cluster         1        16 657166 34674
    ## + renovated               1        16 657166 34674
    ## + age:amenities           1        16 657166 34674
    ## + empl_gr                 1         1 657181 34675
    ## + size:amenities          1         0 657182 34675
    ## - amenities               1       431 657613 34676
    ## - age                     1       966 658148 34682
    ## - class_b                 1      1413 658595 34687
    ## - size:cluster            1      2772 659954 34703
    ## - class_a                 1      3555 660737 34713
    ## - size:cluster_rent       1     33793 690975 35063
    ## 
    ## Step:  AIC=34644.23
    ## Rent ~ size + age + class_a + class_b + amenities + cluster_rent + 
    ##     cluster + size:cluster_rent + size:cluster + cluster_rent:cluster
    ## 
    ##                          Df Sum of Sq    RSS   AIC
    ## + leasing_rate            1       632 654004 34639
    ## + age:class_b             1       438 654198 34641
    ## + age:cluster_rent        1       360 654276 34642
    ## + green_rating            1       351 654285 34642
    ## + class_b:amenities       1       226 654410 34644
    ## + age:class_a             1       219 654417 34644
    ## + class_b:cluster_rent    1       217 654419 34644
    ## <none>                                654636 34644
    ## + size:class_a            1       162 654474 34644
    ## + class_a:amenities       1       143 654493 34645
    ## + stories                 1       124 654512 34645
    ## + size:age                1       113 654523 34645
    ## + size:class_b            1        65 654571 34645
    ## + amenities:cluster_rent  1        50 654586 34646
    ## + age:cluster             1        36 654600 34646
    ## + class_b:cluster         1        33 654603 34646
    ## + amenities:cluster       1        32 654604 34646
    ## + age:amenities           1        25 654611 34646
    ## + class_a:cluster_rent    1         9 654627 34646
    ## + renovated               1         7 654629 34646
    ## + class_a:cluster         1         3 654634 34646
    ## + size:amenities          1         1 654635 34646
    ## + empl_gr                 1         0 654636 34646
    ## - amenities               1       466 655102 34648
    ## - age                     1      1251 655887 34657
    ## - class_b                 1      1448 656084 34660
    ## - cluster_rent:cluster    1      2546 657182 34673
    ## - size:cluster            1      2986 657622 34678
    ## - class_a                 1      3586 658222 34685
    ## - size:cluster_rent       1     35068 689704 35050
    ## 
    ## Step:  AIC=34638.68
    ## Rent ~ size + age + class_a + class_b + amenities + cluster_rent + 
    ##     cluster + leasing_rate + size:cluster_rent + size:cluster + 
    ##     cluster_rent:cluster
    ## 
    ##                             Df Sum of Sq    RSS   AIC
    ## + size:leasing_rate          1       928 653076 34630
    ## + age:class_b                1       459 653545 34635
    ## + age:cluster_rent           1       395 653609 34636
    ## + cluster:leasing_rate       1       323 653681 34637
    ## + green_rating               1       306 653698 34637
    ## + age:leasing_rate           1       257 653747 34638
    ## + class_b:cluster_rent       1       240 653765 34638
    ## + class_b:amenities          1       226 653778 34638
    ## + age:class_a                1       225 653779 34638
    ## <none>                                   654004 34639
    ## + cluster_rent:leasing_rate  1       167 653837 34639
    ## + stories                    1       157 653848 34639
    ## + size:class_a               1       146 653858 34639
    ## + amenities:leasing_rate     1       122 653882 34639
    ## + class_a:amenities          1       122 653883 34639
    ## + size:age                   1       110 653894 34639
    ## + class_a:leasing_rate       1        71 653933 34640
    ## + size:class_b               1        65 653940 34640
    ## + amenities:cluster_rent     1        45 653959 34640
    ## + age:cluster                1        43 653961 34640
    ## + class_b:cluster            1        35 653969 34640
    ## + age:amenities              1        31 653973 34640
    ## + amenities:cluster          1        29 653975 34640
    ## + class_a:cluster_rent       1        17 653987 34640
    ## + renovated                  1        12 653992 34641
    ## + size:amenities             1         9 653995 34641
    ## + class_b:leasing_rate       1         5 653999 34641
    ## + empl_gr                    1         2 654002 34641
    ## + class_a:cluster            1         1 654003 34641
    ## - amenities                  1       364 654369 34641
    ## - leasing_rate               1       632 654636 34644
    ## - class_b                    1      1185 655189 34651
    ## - age                        1      1262 655266 34652
    ## - cluster_rent:cluster       1      2535 656539 34667
    ## - size:cluster               1      2991 656996 34672
    ## - class_a                    1      3116 657120 34674
    ## - size:cluster_rent          1     35451 689455 35049
    ## 
    ## Step:  AIC=34629.57
    ## Rent ~ size + age + class_a + class_b + amenities + cluster_rent + 
    ##     cluster + leasing_rate + size:cluster_rent + size:cluster + 
    ##     cluster_rent:cluster + size:leasing_rate
    ## 
    ##                             Df Sum of Sq    RSS   AIC
    ## + age:class_b                1       438 652638 34626
    ## + age:cluster_rent           1       410 652666 34627
    ## + green_rating               1       311 652765 34628
    ## + class_b:cluster_rent       1       268 652808 34628
    ## + class_b:amenities          1       261 652815 34628
    ## + size:class_a               1       242 652834 34629
    ## + cluster:leasing_rate       1       239 652837 34629
    ## + cluster_rent:leasing_rate  1       229 652847 34629
    ## + age:class_a                1       226 652850 34629
    ## + class_a:amenities          1       167 652909 34630
    ## <none>                                   653076 34630
    ## + size:class_b               1       120 652956 34630
    ## + stories                    1       118 652958 34630
    ## + age:leasing_rate           1       109 652967 34630
    ## + amenities:cluster_rent     1        58 653018 34631
    ## + size:age                   1        56 653020 34631
    ## + age:cluster                1        49 653027 34631
    ## + class_a:leasing_rate       1        45 653031 34631
    ## + class_b:cluster            1        44 653032 34631
    ## + amenities:cluster          1        37 653039 34631
    ## + class_a:cluster_rent       1        22 653054 34631
    ## + age:amenities              1        16 653060 34631
    ## + renovated                  1         9 653067 34631
    ## + amenities:leasing_rate     1         8 653068 34631
    ## + empl_gr                    1         3 653073 34632
    ## + class_b:leasing_rate       1         2 653074 34632
    ## + class_a:cluster            1         0 653076 34632
    ## + size:amenities             1         0 653076 34632
    ## - amenities                  1       488 653564 34633
    ## - size:leasing_rate          1       928 654004 34639
    ## - age                        1      1162 654238 34641
    ## - class_b                    1      1443 654519 34645
    ## - cluster_rent:cluster       1      2457 655533 34657
    ## - size:cluster               1      3099 656175 34665
    ## - class_a                    1      3471 656547 34669
    ## - size:cluster_rent          1     32092 685168 35003
    ## 
    ## Step:  AIC=34626.33
    ## Rent ~ size + age + class_a + class_b + amenities + cluster_rent + 
    ##     cluster + leasing_rate + size:cluster_rent + size:cluster + 
    ##     cluster_rent:cluster + size:leasing_rate + age:class_b
    ## 
    ##                             Df Sum of Sq    RSS   AIC
    ## + age:class_a                1    1303.4 651335 34613
    ## + age:cluster_rent           1     446.2 652192 34623
    ## + green_rating               1     344.8 652294 34624
    ## + class_b:amenities          1     273.2 652365 34625
    ## + size:class_a               1     265.1 652373 34625
    ## + class_b:cluster_rent       1     257.7 652381 34625
    ## + cluster_rent:leasing_rate  1     229.3 652409 34626
    ## + cluster:leasing_rate       1     221.3 652417 34626
    ## <none>                                   652638 34626
    ## + class_a:amenities          1     146.9 652491 34627
    ## + size:class_b               1     142.5 652496 34627
    ## + stories                    1     123.1 652515 34627
    ## + size:age                   1     103.5 652535 34627
    ## + age:leasing_rate           1      93.5 652545 34627
    ## + class_b:cluster            1      63.6 652575 34628
    ## + amenities:cluster_rent     1      56.4 652582 34628
    ## + class_a:leasing_rate       1      54.2 652584 34628
    ## + age:amenities              1      38.7 652600 34628
    ## + age:cluster                1      38.5 652600 34628
    ## + amenities:cluster          1      37.6 652601 34628
    ## + renovated                  1      23.7 652615 34628
    ## + class_a:cluster_rent       1      15.4 652623 34628
    ## + amenities:leasing_rate     1       8.0 652630 34628
    ## + empl_gr                    1       4.0 652634 34628
    ## + class_b:leasing_rate       1       2.1 652636 34628
    ## + class_a:cluster            1       0.1 652638 34628
    ## + size:amenities             1       0.0 652638 34628
    ## - amenities                  1     404.2 653042 34629
    ## - age:class_b                1     437.6 653076 34630
    ## - size:leasing_rate          1     906.7 653545 34635
    ## - cluster_rent:cluster       1    2479.8 655118 34654
    ## - size:cluster               1    3149.5 655788 34662
    ## - class_a                    1    3686.5 656325 34668
    ## - size:cluster_rent          1   31301.0 683939 34991
    ## 
    ## Step:  AIC=34612.69
    ## Rent ~ size + age + class_a + class_b + amenities + cluster_rent + 
    ##     cluster + leasing_rate + size:cluster_rent + size:cluster + 
    ##     cluster_rent:cluster + size:leasing_rate + age:class_b + 
    ##     age:class_a
    ## 
    ##                             Df Sum of Sq    RSS   AIC
    ## + class_b:cluster_rent       1       322 651013 34611
    ## + class_b:amenities          1       311 651024 34611
    ## + cluster_rent:leasing_rate  1       291 651043 34611
    ## + size:class_a               1       249 651086 34612
    ## + age:cluster_rent           1       247 651087 34612
    ## + green_rating               1       237 651098 34612
    ## + cluster:leasing_rate       1       203 651132 34612
    ## <none>                                   651335 34613
    ## + size:class_b               1       145 651190 34613
    ## + class_a:amenities          1       107 651228 34613
    ## + stories                    1       106 651228 34613
    ## + class_b:cluster            1        88 651247 34614
    ## + amenities:cluster_rent     1        57 651277 34614
    ## + amenities:cluster          1        45 651289 34614
    ## + age:cluster                1        42 651293 34614
    ## + class_a:leasing_rate       1        40 651295 34614
    ## + class_a:cluster_rent       1        28 651307 34614
    ## + age:leasing_rate           1        11 651323 34615
    ## + amenities:leasing_rate     1         6 651329 34615
    ## + empl_gr                    1         1 651334 34615
    ## + size:age                   1         1 651334 34615
    ## + size:amenities             1         1 651334 34615
    ## + class_a:cluster            1         1 651334 34615
    ## + renovated                  1         0 651334 34615
    ## + age:amenities              1         0 651334 34615
    ## + class_b:leasing_rate       1         0 651335 34615
    ## - amenities                  1       360 651695 34615
    ## - size:leasing_rate          1       880 652214 34621
    ## - age:class_a                1      1303 652638 34626
    ## - age:class_b                1      1515 652850 34629
    ## - cluster_rent:cluster       1      2455 653789 34640
    ## - size:cluster               1      3071 654406 34647
    ## - size:cluster_rent          1     32267 683602 34989
    ## 
    ## Step:  AIC=34610.83
    ## Rent ~ size + age + class_a + class_b + amenities + cluster_rent + 
    ##     cluster + leasing_rate + size:cluster_rent + size:cluster + 
    ##     cluster_rent:cluster + size:leasing_rate + age:class_b + 
    ##     age:class_a + class_b:cluster_rent
    ## 
    ##                             Df Sum of Sq    RSS   AIC
    ## + cluster_rent:leasing_rate  1     281.5 650732 34609
    ## + class_b:amenities          1     250.6 650763 34610
    ## + green_rating               1     236.3 650777 34610
    ## + cluster:leasing_rate       1     193.6 650820 34611
    ## + class_a:cluster_rent       1     188.0 650825 34611
    ## + size:class_a               1     171.5 650842 34611
    ## <none>                                   651013 34611
    ## + age:cluster_rent           1     127.6 650886 34611
    ## + amenities:cluster_rent     1     104.0 650909 34612
    ## + class_a:amenities          1      89.1 650924 34612
    ## + stories                    1      85.5 650928 34612
    ## + size:class_b               1      82.1 650931 34612
    ## + class_a:leasing_rate       1      68.6 650945 34612
    ## + amenities:cluster          1      47.2 650966 34612
    ## + class_b:cluster            1      28.9 650984 34612
    ## + age:cluster                1      27.5 650986 34613
    ## + class_a:cluster            1      11.7 651002 34613
    ## - class_b:cluster_rent       1     321.6 651335 34613
    ## + class_b:leasing_rate       1       8.4 651005 34613
    ## + age:leasing_rate           1       7.3 651006 34613
    ## + amenities:leasing_rate     1       5.3 651008 34613
    ## + size:amenities             1       2.7 651011 34613
    ## + empl_gr                    1       1.3 651012 34613
    ## + size:age                   1       0.1 651013 34613
    ## + renovated                  1       0.0 651013 34613
    ## + age:amenities              1       0.0 651013 34613
    ## - amenities                  1     346.9 651360 34613
    ## - size:leasing_rate          1     909.5 651923 34620
    ## - age:class_a                1    1367.3 652381 34625
    ## - age:class_b                1    1543.5 652557 34627
    ## - cluster_rent:cluster       1    2368.0 653381 34637
    ## - size:cluster               1    3099.2 654112 34646
    ## - size:cluster_rent          1   27268.0 678281 34930
    ## 
    ## Step:  AIC=34609.45
    ## Rent ~ size + age + class_a + class_b + amenities + cluster_rent + 
    ##     cluster + leasing_rate + size:cluster_rent + size:cluster + 
    ##     cluster_rent:cluster + size:leasing_rate + age:class_b + 
    ##     age:class_a + class_b:cluster_rent + cluster_rent:leasing_rate
    ## 
    ##                             Df Sum of Sq    RSS   AIC
    ## + cluster:leasing_rate       1     319.9 650412 34608
    ## + class_a:cluster_rent       1     311.0 650421 34608
    ## + class_b:amenities          1     242.6 650489 34609
    ## + green_rating               1     240.2 650492 34609
    ## <none>                                   650732 34609
    ## + size:class_a               1     164.4 650567 34609
    ## + amenities:cluster_rent     1     161.6 650570 34610
    ## + class_a:leasing_rate       1     124.4 650607 34610
    ## + age:cluster_rent           1     103.2 650629 34610
    ## + stories                    1      89.0 650643 34610
    ## + class_a:amenities          1      88.5 650643 34610
    ## + size:class_b               1      77.1 650655 34611
    ## + amenities:cluster          1      52.6 650679 34611
    ## - cluster_rent:leasing_rate  1     281.5 651013 34611
    ## + class_b:cluster            1      32.6 650699 34611
    ## + age:cluster                1      27.5 650704 34611
    ## - class_b:cluster_rent       1     311.7 651043 34611
    ## + class_a:cluster            1      15.9 650716 34611
    ## + class_b:leasing_rate       1      12.2 650720 34611
    ## + size:amenities             1       4.0 650728 34611
    ## + amenities:leasing_rate     1       3.8 650728 34611
    ## + age:leasing_rate           1       1.6 650730 34611
    ## + empl_gr                    1       1.3 650730 34611
    ## + age:amenities              1       0.3 650732 34611
    ## + size:age                   1       0.1 650732 34611
    ## + renovated                  1       0.1 650732 34611
    ## - amenities                  1     340.1 651072 34612
    ## - size:leasing_rate          1     977.4 651709 34619
    ## - age:class_a                1    1428.6 652160 34625
    ## - age:class_b                1    1585.3 652317 34626
    ## - cluster_rent:cluster       1    2257.9 652990 34635
    ## - size:cluster               1    3051.4 653783 34644
    ## - size:cluster_rent          1   24933.4 675665 34901
    ## 
    ## Step:  AIC=34607.6
    ## Rent ~ size + age + class_a + class_b + amenities + cluster_rent + 
    ##     cluster + leasing_rate + size:cluster_rent + size:cluster + 
    ##     cluster_rent:cluster + size:leasing_rate + age:class_b + 
    ##     age:class_a + class_b:cluster_rent + cluster_rent:leasing_rate + 
    ##     cluster:leasing_rate
    ## 
    ##                             Df Sum of Sq    RSS   AIC
    ## + class_a:cluster_rent       1     294.5 650117 34606
    ## + green_rating               1     241.9 650170 34607
    ## + class_b:amenities          1     233.3 650179 34607
    ## <none>                                   650412 34608
    ## + amenities:cluster_rent     1     163.8 650248 34608
    ## + size:class_a               1     157.8 650254 34608
    ## + class_a:leasing_rate       1     114.3 650298 34608
    ## + age:cluster_rent           1     102.8 650309 34608
    ## + stories                    1      92.5 650319 34608
    ## + class_a:amenities          1      80.2 650332 34609
    ## + size:class_b               1      74.0 650338 34609
    ## + age:cluster                1      44.2 650368 34609
    ## - class_b:cluster_rent       1     297.4 650709 34609
    ## + class_b:cluster            1      27.6 650384 34609
    ## + amenities:cluster          1      23.3 650389 34609
    ## + class_b:leasing_rate       1      15.7 650396 34609
    ## - cluster:leasing_rate       1     319.9 650732 34609
    ## + age:leasing_rate           1       7.6 650404 34610
    ## + size:amenities             1       5.6 650406 34610
    ## + class_a:cluster            1       4.0 650408 34610
    ## + amenities:leasing_rate     1       4.0 650408 34610
    ## + empl_gr                    1       0.7 650411 34610
    ## + size:age                   1       0.1 650412 34610
    ## + renovated                  1       0.0 650412 34610
    ## + age:amenities              1       0.0 650412 34610
    ## - amenities                  1     344.9 650757 34610
    ## - cluster_rent:leasing_rate  1     407.8 650820 34611
    ## - size:leasing_rate          1     894.7 651307 34616
    ## - age:class_a                1    1418.3 651830 34623
    ## - age:class_b                1    1546.1 651958 34624
    ## - cluster_rent:cluster       1    2492.9 652905 34636
    ## - size:cluster               1    3326.9 653739 34646
    ## - size:cluster_rent          1   24836.5 675248 34899
    ## 
    ## Step:  AIC=34606.06
    ## Rent ~ size + age + class_a + class_b + amenities + cluster_rent + 
    ##     cluster + leasing_rate + size:cluster_rent + size:cluster + 
    ##     cluster_rent:cluster + size:leasing_rate + age:class_b + 
    ##     age:class_a + class_b:cluster_rent + cluster_rent:leasing_rate + 
    ##     cluster:leasing_rate + class_a:cluster_rent
    ## 
    ##                             Df Sum of Sq    RSS   AIC
    ## + age:cluster_rent           1     348.1 649769 34604
    ## + green_rating               1     237.3 649880 34605
    ## + size:class_a               1     219.6 649898 34605
    ## + class_b:amenities          1     207.5 649910 34606
    ## <none>                                   650117 34606
    ## + class_a:amenities          1     106.3 650011 34607
    ## + size:class_b               1     102.3 650015 34607
    ## + stories                    1      98.8 650019 34607
    ## + class_a:leasing_rate       1      96.6 650021 34607
    ## + age:cluster                1      77.4 650040 34607
    ## + amenities:cluster_rent     1      72.7 650045 34607
    ## - class_a:cluster_rent       1     294.5 650412 34608
    ## - cluster:leasing_rate       1     303.5 650421 34608
    ## + class_b:leasing_rate       1      24.1 650093 34608
    ## + class_b:cluster            1      17.9 650100 34608
    ## + amenities:cluster          1      16.1 650101 34608
    ## + age:leasing_rate           1       8.1 650109 34608
    ## + age:amenities              1       2.8 650115 34608
    ## + size:amenities             1       1.5 650116 34608
    ## + renovated                  1       1.4 650116 34608
    ## + size:age                   1       1.3 650116 34608
    ## + amenities:leasing_rate     1       1.2 650116 34608
    ## + empl_gr                    1       0.7 650117 34608
    ## + class_a:cluster            1       0.1 650117 34608
    ## - amenities                  1     391.2 650509 34609
    ## - cluster_rent:leasing_rate  1     539.3 650657 34611
    ## - class_b:cluster_rent       1     583.9 650701 34611
    ## - size:leasing_rate          1     919.7 651037 34615
    ## - age:class_a                1    1436.7 651554 34621
    ## - age:class_b                1    1600.6 651718 34623
    ## - cluster_rent:cluster       1    2471.9 652589 34634
    ## - size:cluster               1    3368.8 653486 34644
    ## - size:cluster_rent          1   24167.7 674285 34889
    ## 
    ## Step:  AIC=34603.87
    ## Rent ~ size + age + class_a + class_b + amenities + cluster_rent + 
    ##     cluster + leasing_rate + size:cluster_rent + size:cluster + 
    ##     cluster_rent:cluster + size:leasing_rate + age:class_b + 
    ##     age:class_a + class_b:cluster_rent + cluster_rent:leasing_rate + 
    ##     cluster:leasing_rate + class_a:cluster_rent + age:cluster_rent
    ## 
    ##                             Df Sum of Sq    RSS   AIC
    ## + green_rating               1     256.2 649513 34603
    ## + size:class_a               1     228.5 649541 34603
    ## + class_b:amenities          1     203.2 649566 34603
    ## <none>                                   649769 34604
    ## + amenities:cluster_rent     1     122.8 649646 34604
    ## + size:class_b               1     110.0 649659 34605
    ## + class_a:amenities          1     104.5 649665 34605
    ## + class_a:leasing_rate       1      92.8 649676 34605
    ## + stories                    1      59.8 649709 34605
    ## - cluster:leasing_rate       1     295.1 650064 34605
    ## + class_b:leasing_rate       1      27.7 649742 34606
    ## + age:cluster                1      23.5 649746 34606
    ## + amenities:cluster          1      19.4 649750 34606
    ## + class_b:cluster            1      12.4 649757 34606
    ## + amenities:leasing_rate     1       2.7 649767 34606
    ## + size:age                   1       1.7 649768 34606
    ## + renovated                  1       1.2 649768 34606
    ## + size:amenities             1       0.7 649769 34606
    ## + empl_gr                    1       0.4 649769 34606
    ## + age:leasing_rate           1       0.3 649769 34606
    ## + class_a:cluster            1       0.2 649769 34606
    ## + age:amenities              1       0.2 649769 34606
    ## - amenities                  1     334.0 650103 34606
    ## - age:cluster_rent           1     348.1 650117 34606
    ## - class_a:cluster_rent       1     539.8 650309 34608
    ## - cluster_rent:leasing_rate  1     552.8 650322 34609
    ## - class_b:cluster_rent       1     714.8 650484 34610
    ## - size:leasing_rate          1     933.3 650703 34613
    ## - age:class_a                1    1137.5 650907 34616
    ## - age:class_b                1    1499.1 651268 34620
    ## - cluster_rent:cluster       1    2469.3 652239 34632
    ## - size:cluster               1    3305.8 653075 34642
    ## - size:cluster_rent          1   24506.4 674276 34891
    ## 
    ## Step:  AIC=34602.79
    ## Rent ~ size + age + class_a + class_b + amenities + cluster_rent + 
    ##     cluster + leasing_rate + green_rating + size:cluster_rent + 
    ##     size:cluster + cluster_rent:cluster + size:leasing_rate + 
    ##     age:class_b + age:class_a + class_b:cluster_rent + cluster_rent:leasing_rate + 
    ##     cluster:leasing_rate + class_a:cluster_rent + age:cluster_rent
    ## 
    ##                             Df Sum of Sq    RSS   AIC
    ## + amenities:green_rating     1     705.8 648807 34596
    ## + size:class_a               1     224.2 649289 34602
    ## + class_b:amenities          1     214.0 649299 34602
    ## + class_a:green_rating       1     192.8 649320 34602
    ## + age:green_rating           1     167.6 649345 34603
    ## <none>                                   649513 34603
    ## + amenities:cluster_rent     1     127.5 649386 34603
    ## + class_b:green_rating       1     119.6 649394 34603
    ## + class_a:amenities          1     114.1 649399 34603
    ## + class_a:leasing_rate       1     113.7 649399 34603
    ## + size:class_b               1     107.8 649405 34603
    ## + size:green_rating          1      98.2 649415 34604
    ## - green_rating               1     256.2 649769 34604
    ## + cluster_rent:green_rating  1      58.0 649455 34604
    ## + stories                    1      37.8 649475 34604
    ## - cluster:leasing_rate       1     296.6 649810 34604
    ## + class_b:leasing_rate       1      31.2 649482 34604
    ## + amenities:cluster          1      24.6 649489 34604
    ## + age:cluster                1      18.8 649494 34605
    ## + cluster:green_rating       1      14.6 649498 34605
    ## + class_b:cluster            1      10.7 649502 34605
    ## - amenities                  1     322.8 649836 34605
    ## + amenities:leasing_rate     1       4.3 649509 34605
    ## + size:age                   1       2.0 649511 34605
    ## + green_rating:leasing_rate  1       1.7 649511 34605
    ## + renovated                  1       1.6 649511 34605
    ## + class_a:cluster            1       0.9 649512 34605
    ## + size:amenities             1       0.8 649512 34605
    ## + age:amenities              1       0.6 649513 34605
    ## + empl_gr                    1       0.5 649513 34605
    ## + age:leasing_rate           1       0.0 649513 34605
    ## - age:cluster_rent           1     367.0 649880 34605
    ## - class_a:cluster_rent       1     543.4 650057 34607
    ## - cluster_rent:leasing_rate  1     557.7 650071 34608
    ## - class_b:cluster_rent       1     712.1 650225 34609
    ## - size:leasing_rate          1     938.4 650452 34612
    ## - age:class_a                1    1029.6 650543 34613
    ## - age:class_b                1    1468.3 650981 34618
    ## - cluster_rent:cluster       1    2469.1 651982 34630
    ## - size:cluster               1    3278.6 652792 34640
    ## - size:cluster_rent          1   24501.6 674015 34890
    ## 
    ## Step:  AIC=34596.29
    ## Rent ~ size + age + class_a + class_b + amenities + cluster_rent + 
    ##     cluster + leasing_rate + green_rating + size:cluster_rent + 
    ##     size:cluster + cluster_rent:cluster + size:leasing_rate + 
    ##     age:class_b + age:class_a + class_b:cluster_rent + cluster_rent:leasing_rate + 
    ##     cluster:leasing_rate + class_a:cluster_rent + age:cluster_rent + 
    ##     amenities:green_rating
    ## 
    ##                             Df Sum of Sq    RSS   AIC
    ## + size:class_a               1     180.6 648627 34596
    ## <none>                                   648807 34596
    ## + age:green_rating           1     162.8 648645 34596
    ## + amenities:cluster_rent     1     132.2 648675 34597
    ## + class_b:amenities          1     117.5 648690 34597
    ## + class_a:leasing_rate       1     114.8 648692 34597
    ## + size:class_b               1      84.0 648723 34597
    ## + cluster_rent:green_rating  1      78.9 648728 34597
    ## - cluster:leasing_rate       1     286.1 649093 34598
    ## + stories                    1      32.5 648775 34598
    ## + class_b:leasing_rate       1      30.2 648777 34598
    ## + cluster:green_rating       1      29.9 648777 34598
    ## + class_a:amenities          1      27.8 648780 34598
    ## + class_a:green_rating       1      26.5 648781 34598
    ## + age:amenities              1      21.4 648786 34598
    ## + amenities:cluster          1      20.3 648787 34598
    ## + age:cluster                1      19.6 648788 34598
    ## + class_b:cluster            1      13.8 648794 34598
    ## + size:amenities             1       9.4 648798 34598
    ## + class_b:green_rating       1       6.7 648801 34598
    ## + size:green_rating          1       4.4 648803 34598
    ## + renovated                  1       1.8 648806 34598
    ## + green_rating:leasing_rate  1       0.4 648807 34598
    ## + class_a:cluster            1       0.2 648807 34598
    ## + empl_gr                    1       0.1 648807 34598
    ## + amenities:leasing_rate     1       0.0 648807 34598
    ## + size:age                   1       0.0 648807 34598
    ## + age:leasing_rate           1       0.0 648807 34598
    ## - age:cluster_rent           1     373.2 649180 34599
    ## - class_a:cluster_rent       1     568.0 649375 34601
    ## - cluster_rent:leasing_rate  1     579.5 649387 34601
    ## - amenities:green_rating     1     705.8 649513 34603
    ## - class_b:cluster_rent       1     720.8 649528 34603
    ## - size:leasing_rate          1     971.2 649778 34606
    ## - age:class_a                1     998.0 649805 34606
    ## - age:class_b                1    1388.7 650196 34611
    ## - cluster_rent:cluster       1    2422.0 651229 34623
    ## - size:cluster               1    3273.9 652081 34634
    ## - size:cluster_rent          1   24318.5 673126 34882
    ## 
    ## Step:  AIC=34596.11
    ## Rent ~ size + age + class_a + class_b + amenities + cluster_rent + 
    ##     cluster + leasing_rate + green_rating + size:cluster_rent + 
    ##     size:cluster + cluster_rent:cluster + size:leasing_rate + 
    ##     age:class_b + age:class_a + class_b:cluster_rent + cluster_rent:leasing_rate + 
    ##     cluster:leasing_rate + class_a:cluster_rent + age:cluster_rent + 
    ##     amenities:green_rating + size:class_a
    ## 
    ##                             Df Sum of Sq    RSS   AIC
    ## + size:class_b               1     172.4 648454 34596
    ## <none>                                   648627 34596
    ## + age:green_rating           1     164.4 648462 34596
    ## - size:class_a               1     180.6 648807 34596
    ## + size:age                   1     146.3 648480 34596
    ## + amenities:cluster_rent     1     126.8 648500 34597
    ## + class_a:leasing_rate       1      95.1 648532 34597
    ## + cluster_rent:green_rating  1      78.9 648548 34597
    ## + class_b:amenities          1      65.9 648561 34597
    ## - cluster:leasing_rate       1     278.0 648905 34597
    ## + age:amenities              1      37.5 648589 34598
    ## + size:amenities             1      33.1 648594 34598
    ## + class_a:green_rating       1      29.7 648597 34598
    ## + cluster:green_rating       1      28.2 648599 34598
    ## + class_b:leasing_rate       1      21.7 648605 34598
    ## + age:cluster                1      19.8 648607 34598
    ## + amenities:cluster          1      17.0 648610 34598
    ## + stories                    1      10.1 648617 34598
    ## + class_b:green_rating       1       8.6 648618 34598
    ## + class_b:cluster            1       7.6 648619 34598
    ## + class_a:amenities          1       4.3 648622 34598
    ## + class_a:cluster            1       2.2 648624 34598
    ## + renovated                  1       1.3 648625 34598
    ## + size:green_rating          1       0.1 648627 34598
    ## + age:leasing_rate           1       0.1 648627 34598
    ## + green_rating:leasing_rate  1       0.1 648627 34598
    ## + empl_gr                    1       0.0 648627 34598
    ## + amenities:leasing_rate     1       0.0 648627 34598
    ## - age:cluster_rent           1     381.0 649008 34599
    ## - cluster_rent:leasing_rate  1     582.9 649210 34601
    ## - class_a:cluster_rent       1     638.5 649265 34602
    ## - amenities:green_rating     1     662.2 649289 34602
    ## - class_b:cluster_rent       1     720.8 649348 34603
    ## - age:class_a                1     979.0 649606 34606
    ## - size:leasing_rate          1    1053.4 649680 34607
    ## - age:class_b                1    1409.4 650036 34611
    ## - cluster_rent:cluster       1    2419.5 651046 34623
    ## - size:cluster               1    3106.8 651734 34631
    ## - size:cluster_rent          1   23892.6 672519 34877
    ## 
    ## Step:  AIC=34596.03
    ## Rent ~ size + age + class_a + class_b + amenities + cluster_rent + 
    ##     cluster + leasing_rate + green_rating + size:cluster_rent + 
    ##     size:cluster + cluster_rent:cluster + size:leasing_rate + 
    ##     age:class_b + age:class_a + class_b:cluster_rent + cluster_rent:leasing_rate + 
    ##     cluster:leasing_rate + class_a:cluster_rent + age:cluster_rent + 
    ##     amenities:green_rating + size:class_a + size:class_b
    ## 
    ##                             Df Sum of Sq    RSS   AIC
    ## + size:age                   1     177.5 648277 34596
    ## <none>                                   648454 34596
    ## + age:green_rating           1     164.9 648289 34596
    ## - size:class_b               1     172.4 648627 34596
    ## + class_b:amenities          1     126.1 648328 34597
    ## + amenities:cluster_rent     1     109.8 648345 34597
    ## + class_a:leasing_rate       1      87.9 648366 34597
    ## + cluster_rent:green_rating  1      80.5 648374 34597
    ## - size:class_a               1     269.0 648723 34597
    ## - cluster:leasing_rate       1     270.6 648725 34597
    ## + age:amenities              1      60.3 648394 34597
    ## + size:amenities             1      59.3 648395 34597
    ## + class_b:leasing_rate       1      45.0 648409 34597
    ## + class_a:green_rating       1      28.2 648426 34598
    ## + cluster:green_rating       1      25.6 648429 34598
    ## + stories                    1      18.5 648436 34598
    ## + class_b:cluster            1      14.8 648440 34598
    ## + amenities:cluster          1      14.6 648440 34598
    ## + age:cluster                1      14.1 648440 34598
    ## + class_b:green_rating       1      10.1 648444 34598
    ## + class_a:cluster            1       3.2 648451 34598
    ## + class_a:amenities          1       1.8 648453 34598
    ## + age:leasing_rate           1       1.5 648453 34598
    ## + renovated                  1       0.2 648454 34598
    ## + empl_gr                    1       0.1 648454 34598
    ## + green_rating:leasing_rate  1       0.0 648454 34598
    ## + amenities:leasing_rate     1       0.0 648454 34598
    ## + size:green_rating          1       0.0 648454 34598
    ## - age:cluster_rent           1     372.0 648826 34599
    ## - cluster_rent:leasing_rate  1     597.3 649052 34601
    ## - amenities:green_rating     1     637.6 649092 34602
    ## - class_a:cluster_rent       1     701.3 649156 34602
    ## - class_b:cluster_rent       1     804.7 649259 34604
    ## - age:class_a                1     940.5 649395 34605
    ## - size:leasing_rate          1    1096.2 649551 34607
    ## - age:class_b                1    1341.5 649796 34610
    ## - cluster_rent:cluster       1    2417.7 650872 34623
    ## - size:cluster               1    3075.4 651530 34631
    ## - size:cluster_rent          1   23846.7 672301 34876
    ## 
    ## Step:  AIC=34595.89
    ## Rent ~ size + age + class_a + class_b + amenities + cluster_rent + 
    ##     cluster + leasing_rate + green_rating + size:cluster_rent + 
    ##     size:cluster + cluster_rent:cluster + size:leasing_rate + 
    ##     age:class_b + age:class_a + class_b:cluster_rent + cluster_rent:leasing_rate + 
    ##     cluster:leasing_rate + class_a:cluster_rent + age:cluster_rent + 
    ##     amenities:green_rating + size:class_a + size:class_b + size:age
    ## 
    ##                             Df Sum of Sq    RSS   AIC
    ## + age:green_rating           1     167.2 648110 34596
    ## <none>                                   648277 34596
    ## - size:age                   1     177.5 648454 34596
    ## - size:class_b               1     203.6 648480 34596
    ## + amenities:cluster_rent     1     107.5 648169 34597
    ## + class_b:amenities          1     105.5 648171 34597
    ## + class_a:leasing_rate       1      85.4 648192 34597
    ## + size:amenities             1      79.9 648197 34597
    ## + cluster_rent:green_rating  1      78.1 648199 34597
    ## - cluster:leasing_rate       1     267.1 648544 34597
    ## + stories                    1      47.8 648229 34597
    ## + class_b:leasing_rate       1      41.2 648236 34597
    ## + age:cluster                1      28.2 648249 34598
    ## + cluster:green_rating       1      28.0 648249 34598
    ## + class_a:green_rating       1      26.3 648251 34598
    ## + age:amenities              1      25.9 648251 34598
    ## + amenities:cluster          1      15.4 648262 34598
    ## + class_b:cluster            1      11.3 648266 34598
    ## + class_b:green_rating       1       9.8 648267 34598
    ## + class_a:cluster            1       4.2 648273 34598
    ## + size:green_rating          1       3.1 648274 34598
    ## + empl_gr                    1       0.8 648276 34598
    ## + class_a:amenities          1       0.4 648276 34598
    ## + renovated                  1       0.2 648277 34598
    ## + green_rating:leasing_rate  1       0.1 648277 34598
    ## + amenities:leasing_rate     1       0.0 648277 34598
    ## + age:leasing_rate           1       0.0 648277 34598
    ## - age:cluster_rent           1     371.5 648648 34598
    ## - size:class_a               1     394.0 648671 34599
    ## - age:class_a                1     503.5 648780 34600
    ## - cluster_rent:leasing_rate  1     584.8 648862 34601
    ## - amenities:green_rating     1     644.3 648921 34602
    ## - class_a:cluster_rent       1     705.8 648983 34602
    ## - class_b:cluster_rent       1     793.0 649070 34603
    ## - size:leasing_rate          1    1062.1 649339 34607
    ## - age:class_b                1    1200.4 649477 34608
    ## - cluster_rent:cluster       1    2427.6 650704 34623
    ## - size:cluster               1    3032.5 651309 34630
    ## - size:cluster_rent          1   23561.0 671838 34873
    ## 
    ## Step:  AIC=34595.88
    ## Rent ~ size + age + class_a + class_b + amenities + cluster_rent + 
    ##     cluster + leasing_rate + green_rating + size:cluster_rent + 
    ##     size:cluster + cluster_rent:cluster + size:leasing_rate + 
    ##     age:class_b + age:class_a + class_b:cluster_rent + cluster_rent:leasing_rate + 
    ##     cluster:leasing_rate + class_a:cluster_rent + age:cluster_rent + 
    ##     amenities:green_rating + size:class_a + size:class_b + size:age + 
    ##     age:green_rating
    ## 
    ##                             Df Sum of Sq    RSS   AIC
    ## <none>                                   648110 34596
    ## - age:green_rating           1     167.2 648277 34596
    ## - size:age                   1     179.8 648289 34596
    ## - size:class_b               1     204.3 648314 34596
    ## + class_b:amenities          1     110.0 648000 34597
    ## + amenities:cluster_rent     1     108.0 648002 34597
    ## + size:amenities             1      76.8 648033 34597
    ## + class_a:leasing_rate       1      76.7 648033 34597
    ## + cluster_rent:green_rating  1      72.8 648037 34597
    ## - cluster:leasing_rate       1     266.3 648376 34597
    ## + stories                    1      53.5 648056 34597
    ## + class_b:leasing_rate       1      37.3 648072 34597
    ## + cluster:green_rating       1      34.5 648075 34597
    ## + age:cluster                1      24.0 648086 34598
    ## + age:amenities              1      22.9 648087 34598
    ## + amenities:cluster          1      16.2 648093 34598
    ## + class_b:cluster            1      10.3 648099 34598
    ## + class_a:cluster            1       4.9 648105 34598
    ## + empl_gr                    1       1.1 648109 34598
    ## + size:green_rating          1       1.1 648109 34598
    ## + class_a:amenities          1       1.0 648109 34598
    ## + class_a:green_rating       1       0.7 648109 34598
    ## + renovated                  1       0.5 648109 34598
    ## + class_b:green_rating       1       0.4 648109 34598
    ## + age:leasing_rate           1       0.3 648109 34598
    ## + green_rating:leasing_rate  1       0.1 648110 34598
    ## + amenities:leasing_rate     1       0.0 648110 34598
    ## - age:cluster_rent           1     354.2 648464 34598
    ## - size:class_a               1     396.4 648506 34599
    ## - age:class_a                1     575.9 648686 34601
    ## - cluster_rent:leasing_rate  1     586.0 648696 34601
    ## - amenities:green_rating     1     639.5 648749 34602
    ## - class_a:cluster_rent       1     705.5 648815 34602
    ## - class_b:cluster_rent       1     781.7 648891 34603
    ## - size:leasing_rate          1    1045.6 649155 34606
    ## - age:class_b                1    1228.3 649338 34609
    ## - cluster_rent:cluster       1    2415.5 650525 34623
    ## - size:cluster               1    3014.5 651124 34630
    ## - size:cluster_rent          1   23669.6 671779 34874

``` r
library(gamlr) 
```

    ## Warning: package 'gamlr' was built under R version 3.5.3

``` r
scx = sparse.model.matrix(Rent ~ ., data=g)[,-1]
scy = g$Rent
sclasso = gamlr(scx, scy)
plot(sclasso)
```

![](E3_Alpha_Gamma_files/figure-markdown_github/unnamed-chunk-1-1.png)

``` r
lmstepbeta = coef(lm_step)
## Green rating: 1.477

scbeta = coef(sclasso) 
## Green rating coef: -0.3294
```
