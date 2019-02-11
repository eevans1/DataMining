sclass <- read.csv("C:/Data Mining/ECO395M-master/data/sclass.csv")
View(sclass)
library(tidyverse)
library(FNN)
library(mosaic)
sclass350 = subset(sclass, trim == '350')
sclass65 = subset(sclass, trim == '65 AMG')
summary(sclass65)

N65 = nrow(sclass65)
N65_train = floor(0.8*N65)
N65_test = N65 - N65_train

# randomly sample a set of data points to include in the training set

train65_ind = sample.int(N65, N65_train, replace=FALSE)

# Define the training and testing set

D65_train = sclass65[train65_ind,]
D65_test = sclass65[-train65_ind,]

D65_test = arrange(D65_test, mileage)
head(D65_test)

# Now separate the training and testing sets into features (X) and outcome (y)
X65_train = select(D65_train, mileage)
y65_train = select(D65_train, price)
X65_test = select(D65_test, mileage)
y65_test = select(D65_test, price)

# linear and quadratic models and rmse

lm165 = lm(price ~ mileage, data=D65_train)
lm265 = lm(price ~ poly(mileage, 2), data=D65_train)

rmse = function(y, ypred) {
  sqrt(mean(data.matrix((y-ypred)^2)))
}

ypred_lm165 = predict(lm165, X65_test)
ypred_lm265 = predict(lm265, X65_test)

rmse(y65_test, ypred_lm165)
rmse(y65_test, ypred_lm265)

# creating k= models and fitting them, using a to differentiate from the same k values used for 350

knn3a = knn.reg(train = X65_train, test = X65_test, y = y65_train, k=3)
names(knn3a)

ypred_knn3a = knn3a$pred
rmse(y65_test, ypred_knn3a)

knn4a = knn.reg(train = X65_train, test = X65_test, y = y65_train, k=4)
names(knn4a)

ypred_knn4a = knn4a$pred
rmse(y65_test, ypred_knn4a)

knn5a = knn.reg(train = X65_train, test = X65_test, y = y65_train, k=5)
names(knn5a)

ypred_knn5a = knn5a$pred
rmse(y65_test, ypred_knn5a)

knn10a = knn.reg(train = X65_train, test = X65_test, y = y65_train, k=10)
names(knn10a)

ypred_knn10a = knn10a$pred
rmse(y65_test, ypred_knn10a)

knn25a = knn.reg(train = X65_train, test = X65_test, y = y65_train, k=25)
names(knn25a)

ypred_knn25a = knn25a$pred
rmse(y65_test, ypred_knn25a)

knn50a = knn.reg(train = X65_train, test = X65_test, y = y65_train, k=50)
names(knn50a)

ypred_knn50a = knn50a$pred
rmse(y65_test, ypred_knn50a)

knn75a = knn.reg(train = X65_train, test = X65_test, y = y65_train, k=75)
names(knn75a)

ypred_knn75a = knn75a$pred
rmse(y65_test, ypred_knn75a)

knn100a = knn.reg(train = X65_train, test = X65_test, y = y65_train, k=100)
names(knn100a)

ypred_knn100a = knn100a$pred
rmse(y65_test, ypred_knn100a)

knn150a = knn.reg(train = X65_train, test = X65_test, y = y65_train, k=150)
names(knn150a)

ypred_knn150a = knn150a$pred
rmse(y65_test, ypred_knn150a)

knn200a = knn.reg(train = X65_train, test = X65_test, y = y65_train, k=200)
names(knn200a)

ypred_knn200a = knn200a$pred
rmse(y65_test, ypred_knn200a)

# graphing

p_test = ggplot(data = D65_test) + 
  geom_point(mapping = aes(x = mileage, y = price), color='lightgrey') + 
  theme_bw(base_size=18) + 
  ylim(0, 250000)

p_test + geom_path(aes(x = mileage, y = ypred_knn3a), color='red')
p_test + geom_path(aes(x = mileage, y = ypred_knn3a), color='red') + 
  geom_path(aes(x = mileage, y = ypred_lm265), color='blue')


p_test + geom_path(aes(x = mileage, y = ypred_knn4a), color='red')
p_test + geom_path(aes(x = mileage, y = ypred_knn4a), color='red') + 
  geom_path(aes(x = mileage, y = ypred_lm265), color='blue')

p_test + geom_path(aes(x = mileage, y = ypred_knn5a), color='red')
p_test + geom_path(aes(x = mileage, y = ypred_knn5a), color='red') + 
  geom_path(aes(x = mileage, y = ypred_lm265), color='blue')

p_test + geom_path(aes(x = mileage, y = ypred_knn10a), color='red')
p_test + geom_path(aes(x = mileage, y = ypred_knn10a), color='red') + 
  geom_path(aes(x = mileage, y = ypred_lm265), color='blue')

p_test + geom_path(aes(x = mileage, y = ypred_knn25a), color='red')
p_test + geom_path(aes(x = mileage, y = ypred_knn25a), color='red') + 
  geom_path(aes(x = mileage, y = ypred_lm265), color='blue')

p_test + geom_path(aes(x = mileage, y = ypred_knn50a), color='red')
p_test + geom_path(aes(x = mileage, y = ypred_knn50a), color='red') + 
  geom_path(aes(x = mileage, y = ypred_lm265), color='blue')

p_test + geom_path(aes(x = mileage, y = ypred_knn75a), color='red')
p_test + geom_path(aes(x = mileage, y = ypred_knn75a), color='red') + 
  geom_path(aes(x = mileage, y = ypred_lm265), color='blue')

p_test + geom_path(aes(x = mileage, y = ypred_knn100a), color='red')
p_test + geom_path(aes(x = mileage, y = ypred_knn100a), color='red') + 
  geom_path(aes(x = mileage, y = ypred_lm265), color='blue')

p_test + geom_path(aes(x = mileage, y = ypred_knn150a), color='red')
p_test + geom_path(aes(x = mileage, y = ypred_knn150a), color='red') + 
  geom_path(aes(x = mileage, y = ypred_lm265), color='blue')

p_test + geom_path(aes(x = mileage, y = ypred_knn200a), color='red')
p_test + geom_path(aes(x = mileage, y = ypred_knn200a), color='red') + 
  geom_path(aes(x = mileage, y = ypred_lm265), color='blue')

# Creating a Graph of RMSE as a function of K

dfa <- data.frame(3:221)
for(i in 3:200){
  dfa$rmse[i-2] <- rmse(y65_test, knn.reg(train = X65_train, test = X65_test, y = y65_train, k = i)$pred)}
view(dfa)
names(dfa) <- c("k", "rmse")

ggplot(data = dfa) + 
  geom_point(mapping = aes(x = k, y = rmse), color='darkgrey') + 
  ylim(0, 75000)

view(dfa)

# RMSE is minimized at k=40, verifying RMSE from the df computations, and creating a fitted model
knn40a = knn.reg(train = X65_train, test = X65_test, y = y65_train, k=40)
names(knn40a)

ypred_knn40a = knn40a$pred
rmse(y65_test, ypred_knn40a)

p_test + geom_path(aes(x = mileage, y = ypred_knn40a), color='red')
p_test + geom_path(aes(x = mileage, y = ypred_knn40a), color='red') + 
  geom_path(aes(x = mileage, y = ypred_lm265), color='blue')

