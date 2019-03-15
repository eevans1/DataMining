---
title: "Homework 2"
date: "`r format(Sys.time(), '%d %B %Y')`"
output: html_document
---
Wyatt Allen, Elijah Evans, David Ford, Patrick Scovel

```{r, include=TRUE}
## Question 1 Updated
library(mosaic)
library(FNN)
library(foreach)

# Create an array of lm models
data(SaratogaHouses)

# Make variables numeric
SaratogaHouses$heatingElectric <- ifelse(SaratogaHouses$heating == "electric", 1, 0)
SaratogaHouses$heatingWater <- ifelse(SaratogaHouses$heating == "hot water/steam", 1, 0)
SaratogaHouses$heatingAir <- ifelse(SaratogaHouses$heating == "hot air", 1, 0)

SaratogaHouses$fuelGas <- ifelse(SaratogaHouses$fuel == "gas", 1, 0)
SaratogaHouses$fuelElectric <- ifelse(SaratogaHouses$fuel == "electric", 1, 0)
SaratogaHouses$fuelOil <- ifelse(SaratogaHouses$fuel == "oil", 1, 0)

SaratogaHouses$sewerSeptic <- ifelse(SaratogaHouses$sewer == "septic", 1, 0)
SaratogaHouses$sewerPublic <- ifelse(SaratogaHouses$sewer == "public/commercial", 1, 0)
SaratogaHouses$sewerNone <- ifelse(SaratogaHouses$sewer == "none", 1, 0)

SaratogaHouses$waterfront <- ifelse(SaratogaHouses$waterfront == "Yes", 1, 0)
SaratogaHouses$newConstruction <- ifelse(SaratogaHouses$newConstruction == "Yes", 1, 0)
SaratogaHouses$centralAir <- ifelse(SaratogaHouses$centralAir == "Yes", 1, 0)

# Model formula
formula <- as.formula(price ~ 
                        newConstruction +
                        lotSize + 
                        landValue + 
                        livingArea + 
                        bedrooms +
                        bathrooms +
                        rooms +
                        heating +
                        waterfront +
                        centralAir)

# OLS
lm = lm(formula, data=SaratogaHouses)
summary(lm)

## Objective function
rmse = function(y, yhat) {
  sqrt(mean((y - yhat)^2 ))
}

# Dataframe of RMSE values
rmse_df <- data.frame()

for(i in 1:100){
  # Split into training and testing sets
  n = nrow(SaratogaHouses)
  n_train = round(0.8*n)  # round to nearest integer
  n_test = n - n_train
  train_cases = sample.int(n, n_train, replace=FALSE)
  test_cases = setdiff(1:n, train_cases)
  saratoga_train = SaratogaHouses[train_cases,]
  saratoga_test = SaratogaHouses[test_cases,]
  
  ## Linear model
  lm_train = lm(formula, data=saratoga_train)
  summary(lm_train) 
  
  yhat_test = predict(lm_train, saratoga_test)
  
  # Root mean-squared prediction error
  rmse_df <- rbind(rmse_df, c(i, rmse(saratoga_test$price, yhat_test)))
} 
colnames(rmse_df) <- c("i", "rmse")
rmse_lm <- mean(rmse_df$rmse)
rmse_lm

########### KNN ############

# Question 1 Modified
library(FNN)
# Create an array of lm models
data(SaratogaHouses)
## Objective function
rmse = function(y, yhat) {
  sqrt(mean((y - yhat)^2 ))
}


# Dataframe of RMSE values
rmse_df <- data.frame()
knn_df <- data.frame(matrix(ncol = 2, nrow = 0))

# select a training set
n = nrow(SaratogaHouses)
n_train = round(0.8*n)
n_test = n - n_train

for(i in 2:25){
  for(j in 1:100) {
    train_cases = sample.int(n, n_train, replace=FALSE)
    test_cases = setdiff(1:n, train_cases)
    saratoga_train = SaratogaHouses[train_cases,]
    saratoga_test = SaratogaHouses[test_cases,]
    
    # construct the training and test-set feature matrices
    # note the "-1": this says "don't add a column of ones for the intercept"
    Xtrain = model.matrix(~ newConstruction +
                            lotSize + 
                            landValue + 
                            livingArea + 
                            bedrooms +
                            bathrooms +
                            rooms +
                            heating +
                            waterfront +
                            centralAir - 1, data=saratoga_train)
    Xtest = model.matrix(~ newConstruction +
                           lotSize + 
                           landValue + 
                           livingArea + 
                           bedrooms +
                           bathrooms +
                           rooms +
                           heating +
                           waterfront +
                           centralAir - 1, data=saratoga_test)
    
    # training and testing set responses
    ytrain = saratoga_train$price
    ytest = saratoga_test$price
    
    # now rescale:
    scale_train = apply(Xtrain, 2, sd)  # calculate std dev for each column
    Xtilde_train = scale(Xtrain, scale = scale_train) 
    Xtilde_test = scale(Xtest, scale = scale_train)  # use the training set scales!
    
    ## KNN regression model
    knn_model = knn.reg(Xtilde_train, Xtilde_test, ytrain, k=i)
    rmse_knn <- rmse(ytest, knn_model$pred)
    
    ## Store all stastics in df
    knn_df <- rbind(knn_df, list(i, rmse_knn))
  }
}
colnames(knn_df) <- c("knn","rmse")
rmse_df <- aggregate(rmse ~ knn, knn_df, mean)
boxplot(rmse ~ knn, data = rmse_df)

rmse_df[which.min(rmse_df$rmse),]
rmse_lm

##Question 2
# Libraries, idk which ones we really need??
library(tidyverse)
library(foreach)
library(FNN)

# Reading in the raw data from online
brca <- read.csv("https://raw.githubusercontent.com/jgscott/ECO395M/master/data/brca.csv", header=TRUE)

# Overall cancer rate + defining variables
n=nrow(brca)
cancer_rate <- sum(brca$cancer==1)/n #the total rate of breast cancer
y=brca$cancer
threshold = 0.1 #threshold for prediction models, NEED TO FIND GOOD ONE
rmse = function(y,yhat) {
  sqrt(mean((y - yhat)^2))
}

# creating the train test split

coef_df <- data.frame()

for (i in 1:2000){
  n_train <- round(0.8*n)
  n_test <- n - n_train
  train_pats <-sample.int(n,n_train,replace=FALSE)
  test_pats <- setdiff(1:n, train_pats)
  brca_train <- brca[train_pats,]
  brca_test <- brca[test_pats,]
  
  
  #running logit regression for recall on all other variables for train set
  
  logit_drcon = glm(recall ~ ., data=brca_train, family='binomial')
  coef_df <- rbind(coef_df, c(i,coef(logit_drcon)))
  
}

colnames(coef_df) <- c("i", "intercept", "radiologist34", "radiologist66", "radiologist89", "radiologist95",
                       "cancer", "age5059", "age6069", "age70plus", "history", "symptoms", "menopausepostmenoNoHT", "menopausepostmenounknown", "menopausepremeno",
                       "densitydensity2","densitydensity3","densitydensity4")
means_df <- colMeans(coef_df)
means_df

mean(coef_df$radiologist34)
mean(coef_df$radiologist66)
mean(coef_df$radiologist89)
mean(coef_df$radiologist95)

# Out-of-sample accuracy
logit_drcon_test_pred = predict(logit_drcon, brca_test)
logit_drcon_test_yhat = ifelse(logit_drcon_test_pred > threshold, 1, 0) #NEED TO ISOLATE GOOD THRESHOLD!
logit_drcon_confusion_out = table(y=brca_test$cancer, yhat=logit_drcon_test_yhat)
logit_drcon_test_accuracy = sum(diag(logit_drcon_confusion_out))/sum(logit_drcon_confusion_out) #checking accuracy


# Question 2: Are doctors appropriately weighing risk factors?

# Consider a logit regression of cancer on just recall
#first reset our threshold
threshold = -2.5 #threshold for prediction models, NEED TO FIND GOOD ONE
# a new dataframe
coef_recall <- data.frame()
#another train/test split
#looping

for (i in 1:1000){
  n_train <- round(0.8*n)
  n_test <- n - n_train
  train_pats <-sample.int(n,n_train,replace=FALSE)
  test_pats <- setdiff(1:n, train_pats)
  brca_train <- brca[train_pats,]
  brca_test <- brca[test_pats,]
  
  logit_recall = glm(cancer ~ recall, data=brca_train, family="binomial")
  logit_recall
  
  
  
  #out of sample accuracy
  
  logit_recall_test_pred = predict(logit_recall, brca_test)
  logit_recall_test_yhat = ifelse(logit_recall_test_pred > threshold, 1, 0) #NEED TO ISOLATE GOOD THRESHOLD!
  logit_recall_confusion_out = table(y=brca_test$cancer, yhat=logit_recall_test_yhat)
  logit_recall_confusion_out
  logit_recall_test_accuracy = sum(diag(logit_recall_confusion_out))/sum(logit_recall_confusion_out) #checking accuracy
  logit_recall_test_accuracy
  
  coef_recall <- rbind(coef_recall, c(i, coef(logit_recall), logit_recall_test_accuracy))
  
  
  
}

colnames(coef_recall) <- c("i", "intercept", "recall", "accuracy")
means_recall <- colMeans(coef_recall)
means_recall

logit_plus_meno = glm(cancer ~ recall + menopause, data=brca_train, family="binomial")
logit_plus_meno

#now consider a logit regression of cancer on recall and all risk factors

logit_all = glm(cancer ~ . , data=brca_train, family="binomial")
logit_all

#from this it seems that density seems pretty important, lets see if doctors think so as well
#another train/test split

n_train <- round(0.8*n)
n_test <- n - n_train
train_pats <-sample.int(n,n_train,replace=FALSE)
test_pats <- setdiff(1:n, train_pats)
brca_train <- brca[train_pats,]
brca_test <- brca[test_pats,]

logit_plus_density = glm(cancer ~ recall + density, data=brca_train, family="binomial")
logit_plus_density

#out of sample accuracy

logit_plus_density_test_pred = predict(logit_plus_density, brca_test)
logit_plus_density_test_yhat = ifelse(logit_plus_density_test_pred > threshold, 1, 0) #NEED TO ISOLATE GOOD THRESHOLD!
logit_plus_density_confusion_out = table(y=brca_test$cancer, yhat=logit_plus_density_test_yhat)
logit_plus_density_confusion_out
logit_plus_density_test_accuracy = sum(diag(logit_plus_density_confusion_out))/sum(logit_plus_density_confusion_out) #checking accuracy
logit_plus_density_test_accuracy
#it seems like dr.s are pretty good at accounting for density

#let's try menopause

#from this it seems that density seems pretty important, lets see if doctors think so as well
#another train/test split

coef_meno <- data.frame()

for (i in 1:1000){
  n_train <- round(0.8*n)
  n_test <- n - n_train
  train_pats <-sample.int(n,n_train,replace=FALSE)
  test_pats <- setdiff(1:n, train_pats)
  brca_train <- brca[train_pats,]
  brca_test <- brca[test_pats,]
  
  
  logit_plus_meno = glm(cancer ~ recall + menopause, data=brca_train, family='binomial')
  
  #out of sample accuracy
  
  logit_plus_meno_test_pred = predict(logit_plus_meno, brca_test)
  logit_plus_meno_test_yhat = ifelse(logit_plus_meno_test_pred > threshold, 1, 0) #NEED TO ISOLATE GOOD THRESHOLD!
  logit_plus_meno_confusion_out = table(y=brca_test$cancer, yhat=logit_plus_meno_test_yhat)
  logit_plus_meno_confusion_out
  logit_plus_meno_test_accuracy = sum(diag(logit_plus_meno_confusion_out))/sum(logit_plus_meno_confusion_out) #checking accuracy
  logit_plus_meno_test_accuracy
  
  
  coef_meno <- rbind(coef_meno, c(i, coef(logit_plus_meno), logit_plus_meno_test_accuracy))
  
  
  
}

colnames(coef_meno) <- c("i", "intercept", "recall", "menopausepostmenoNoHT", "menopausepostmenounknown", "menopausepremeno", "accuracy")
means_meno <- colMeans(coef_meno)
means_meno
logit_plus_meno = glm(cancer ~ recall + menopause, data=brca_train, family="binomial")
logit_plus_meno

#out of sample accuracy

logit_plus_meno_test_pred = predict(logit_plus_meno, brca_test)
logit_plus_meno_test_yhat = ifelse(logit_plus_meno_test_pred > threshold, 1, 0) #NEED TO ISOLATE GOOD THRESHOLD!
logit_plus_meno_confusion_out = table(y=brca_test$cancer, yhat=logit_plus_meno_test_yhat)
logit_plus_meno_confusion_out
logit_plus_meno_test_accuracy = sum(diag(logit_plus_meno_confusion_out))/sum(logit_plus_meno_confusion_out) #checking accuracy
logit_plus_meno_test_accuracy


coef_meno <- rbind(coef_meno, c(i,coef(logit_plus_meno)))

#menopause seems to be accounted for pretty well, lets try age

coef_age <- data.frame()
#another train/test split
#looping

for (i in 1:1000){
  n_train <- round(0.8*n)
  n_test <- n - n_train
  train_pats <-sample.int(n,n_train,replace=FALSE)
  test_pats <- setdiff(1:n, train_pats)
  brca_train <- brca[train_pats,]
  brca_test <- brca[test_pats,]
  
  logit_plus_age = glm(cancer ~ recall + age, data=brca_train, family="binomial")
  logit_plus_age
  
  
  
  #out of sample accuracy
  
  logit_plus_age_test_pred = predict(logit_plus_age, brca_test)
  logit_plus_age_test_yhat = ifelse(logit_plus_age_test_pred > threshold, 1, 0) #NEED TO ISOLATE GOOD THRESHOLD!
  logit_plus_age_confusion_out = table(y=brca_test$cancer, yhat=logit_plus_age_test_yhat)
  logit_plus_age_confusion_out
  logit_plus_age_test_accuracy = sum(diag(logit_plus_age_confusion_out))/sum(logit_plus_age_confusion_out) #checking accuracy
  logit_plus_age_test_accuracy
  
  coef_age <- rbind(coef_age, c(i, coef(logit_plus_age), logit_plus_age_test_accuracy))
  
  
  
}

colnames(coef_age) <- c("i", "intercept", "recall", "40s", "50s", "60s", "accuracy")
means_age <- colMeans(coef_age)
means_age
means_recall
```
