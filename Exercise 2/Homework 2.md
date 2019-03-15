Exercise 2
================
15 March 2019

Wyatt Allen, Elijah Evans, David Ford, Patrick Scovel

Question 1

Below is our graph for RMSE across many values of K. The Red line represents the RMSE of a linear model; the minimum RMSE of the linear model which is typically around 58,000. The Green line represnt the minimum RMSE of the KNN model. The minimum K value is usually between 10 and 20 with a RMSE of around 61,000

![](untitled2_files/figure-markdown_github/unnamed-chunk-2-1.png)

Question 2 To answer the first question, we decided to take a very direct approach. We started by dividing the data set into a train/test split. We then ran a logit regression of recall on dummy variables for four of the individual doctors, as well as the other risk factors using only the training set. Using the estimated coefficients, we then tested our results on the test set, and saw an accuracy rate of &gt;99%. This seems like a very strong indicator that the logit model is a good estimator of reality. Now we can determine individual doctor effect, simply by looking at their coefficient, while remembering that the baseline is the estimate for Dr. 13. -Dr. 89: ~ 0.48 -Dr. 66: ~ 0.41 -Dr. 95: ~0.03 -Dr. 13: 0.0 -Dr. 34: ~-0.54 So we see here that Dr. 34 is much less likely to recall a patient for further screening, holding all other factors constant, than Dr. 13. Dr. 66 and Dr. 89 are both much more likely to recall a patient than Dr. 13. Dr. 95 is almost indistinguishable from Dr. 13 in terms of conservativeness.

    ## [1] 0.8573665

    ## [1] 0.858668

    ## [1] 0.8571462

    ## [1] 0.8575096

    ## [1] 0.8567858

    ## [1] 0.8574203

    ## [1] 0.8616203

For the second question, we first wanted to gain a basic understanding of the way all of the factors have on cancer outcomes, so we ran a standard logit regression of cancer on all of the variables. This allowed us to identify particular variables of interest in later analysis. Next we wanted to run a baseline logit model of cancer on recall. To do this we produced a new train test split of 80/20. We then ran the regression, and tested the coefficients we gained from this regression. Then we stored the accuracy rate and looped back through, with a new train/test split 5000 times. At the end , we computed and accuracy rate of approximately 85.72%. Once we had a baseline model we were happy with, we started running regressions of cancer on recall and one additional variable for regressor on which we had information, looping each of them 5000 times and averaging their accuracy, yielding the following results -Recall + density: ~85.74% -Recall + menopause: ~85.75% -Recall + age: ~85.68% -Recall + history: ~85.74% -Recall + symptoms: ~ 85.54% Since these are all so close to the accuracy rate of the baseline model, we are confident that the Dr.'s, in general, are doing a very good job of incorporating all available information into their decisions to recall patients for further screening. However, we did want to explore a few more options, specifically, we wanted to see if, despite being individually insignificant, of a pair of regressors might be jointly significant. We were able to find a non-negligible improvement in accuracy when we ran a logit regression of cancer on recall, age and density. Recording an accuracy rate of roughly 86.05%. However, This still only translates to roughly 3 additional correct recalls per 1000 patients, so it may not be worth retraining your on staff doctors in new recall decision techniques. If you do decide to implement new protocols, I would suggest a system in which patients are called in if they meet either set of criteria for recall, simply because the benefits of early detection generally outweigh the concerns of unnecessary recalls. This system should stay in place until it has been verified and can outperform current protocols.

Question 3

Below is our graph for RMSE across many values of K. The Red line represents the RMSE of a linear model, the minimum RMSE of the linear model which is typically around 11,000. The Green line represnt the minimum RMSE of the KNN model. The minimum K value is usually between 10 and 20 with a RMSE of around 8,000. ![](untitled2_files/figure-markdown_github/unnamed-chunk-6-1.png)![](untitled2_files/figure-markdown_github/unnamed-chunk-6-2.png)

    ##    yhat
    ## y      0    1
    ##   0   77 3939
    ##   1   23 3890

    ## [1] 11394.17

    ## [1] 0.4969946

    ## [1] 0.5030054

    ## [1] 0.9942008

    ## [1] 0.987675

    ## [1] 0.5047376

    ##    yhat
    ## y      0    1
    ##   0  138 3856
    ##   1   40 3895

    ## [1] 9511.77

    ## [1] 0.5609451

    ## [1] 0.4390549

    ## [1] 0.9924976

    ## [1] 0.9763162

    ## [1] 0.5042933

    ##    yhat
    ## y      0    1
    ##   0 2521 1506
    ##   1 1444 2458

    ## [1] 11770.03

    ## [1] 0.621999

    ## [1] 0.378001

    ## [1] 0.6276197

    ## [1] 0.3834216

    ## [1] 0.3863256

    ##    yhat
    ## y      0    1
    ##   0 3539  452
    ##   1 2953  985

    ## [1] 11869.94

    ## [1] 0.5722159

    ## [1] 0.4277841

    ## [1] 0.2428087

    ## [1] 0.1057807

    ## [1] 0.3081912

Both models are not great at predicting whether an article will go viral or not. There is a bias-variance tradeoff between the two methods.
