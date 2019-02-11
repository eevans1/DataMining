sclass <- read.csv("C:/Data Mining/ECO395M-master/data/sclass.csv")
View(sclass)
library(tidyverse)
library(FNN)
library(mosaic)
sclass350 = subset(sclass, trim == '350')
sclass65AMG = subset(sclass, trim == '65 AMG')
summary(sclass65AMG)

N350 = nrow(sclass350)
N350_train = floor(0.8*N350)
N350_test = N350 - N350_train

# randomly sample a set of data points to include in the training set

train350_ind = sample.int(N350, N350_train, replace=FALSE)

# Define the training and testing set

D350_train = sclass350[train350_ind,]
D350_test = sclass350[-train350_ind,]

D350_test = arrange(D350_test, mileage)
head(D350_test)

# Now separate the training and testing sets into features (X) and outcome (y)
X350_train = select(D350_train, mileage)
y350_train = select(D350_train, price)
X350_test = select(D350_test, mileage)
y350_test = select(D350_test, price)

# linear and quadratic models and rmse

lm1 = lm(price ~ mileage, data=D350_train)
lm2 = lm(price ~ poly(mileage, 2), data=D350_train)

rmse = function(y, ypred) {
  sqrt(mean(data.matrix((y-ypred)^2)))
}

ypred_lm1 = predict(lm1, X350_test)
ypred_lm2 = predict(lm2, X350_test)

rmse(y350_test, ypred_lm1)
rmse(y350_test, ypred_lm2)

# creating k= models and fitting them

knn3 = knn.reg(train = X350_train, test = X350_test, y = y350_train, k=3)
names(knn3)

ypred_knn3 = knn3$pred
rmse(y350_test, ypred_knn3)

knn4 = knn.reg(train = X350_train, test = X350_test, y = y350_train, k=4)
names(knn4)

ypred_knn4 = knn4$pred
rmse(y350_test, ypred_knn4)

knn5 = knn.reg(train = X350_train, test = X350_test, y = y350_train, k=5)
names(knn5)

ypred_knn5 = knn5$pred
rmse(y350_test, ypred_knn5)

knn10 = knn.reg(train = X350_train, test = X350_test, y = y350_train, k=10)
names(knn10)

ypred_knn10 = knn10$pred
rmse(y350_test, ypred_knn10)

knn25 = knn.reg(train = X350_train, test = X350_test, y = y350_train, k=25)
names(knn25)

ypred_knn25 = knn25$pred
rmse(y350_test, ypred_knn25)

knn50 = knn.reg(train = X350_train, test = X350_test, y = y350_train, k=50)
names(knn50)

ypred_knn50 = knn50$pred
rmse(y350_test, ypred_knn50)

knn75 = knn.reg(train = X350_train, test = X350_test, y = y350_train, k=75)
names(knn75)

ypred_knn75 = knn75$pred
rmse(y350_test, ypred_knn75)

knn100 = knn.reg(train = X350_train, test = X350_test, y = y350_train, k=100)
names(knn100)

ypred_knn100 = knn100$pred
rmse(y350_test, ypred_knn100)

knn150 = knn.reg(train = X350_train, test = X350_test, y = y350_train, k=150)
names(knn150)

ypred_knn150 = knn150$pred
rmse(y350_test, ypred_knn150)

knn200 = knn.reg(train = X350_train, test = X350_test, y = y350_train, k=200)
names(knn200)

ypred_knn200 = knn200$pred
rmse(y350_test, ypred_knn200)

knn250 = knn.reg(train = X350_train, test = X350_test, y = y350_train, k=250)
names(knn250)

ypred_knn250 = knn250$pred
rmse(y350_test, ypred_knn250)

# graphing

p_test = ggplot(data = D350_test) + 
  geom_point(mapping = aes(x = mileage, y = price), color='lightgrey') + 
  theme_bw(base_size=18) + 
  ylim(0, 250000)

p_test + geom_path(aes(x = mileage, y = ypred_knn3), color='red')
p_test + geom_path(aes(x = mileage, y = ypred_knn3), color='red') + 
  geom_path(aes(x = mileage, y = ypred_lm2), color='blue')


p_test + geom_path(aes(x = mileage, y = ypred_knn4), color='red')
p_test + geom_path(aes(x = mileage, y = ypred_knn4), color='red') + 
  geom_path(aes(x = mileage, y = ypred_lm2), color='blue')

p_test + geom_path(aes(x = mileage, y = ypred_knn5), color='red')
p_test + geom_path(aes(x = mileage, y = ypred_knn5), color='red') + 
  geom_path(aes(x = mileage, y = ypred_lm2), color='blue')

p_test + geom_path(aes(x = mileage, y = ypred_knn10), color='red')
p_test + geom_path(aes(x = mileage, y = ypred_knn10), color='red') + 
  geom_path(aes(x = mileage, y = ypred_lm2), color='blue')

p_test + geom_path(aes(x = mileage, y = ypred_knn25), color='red')
p_test + geom_path(aes(x = mileage, y = ypred_knn25), color='red') + 
  geom_path(aes(x = mileage, y = ypred_lm2), color='blue')

p_test + geom_path(aes(x = mileage, y = ypred_knn50), color='red')
p_test + geom_path(aes(x = mileage, y = ypred_knn50), color='red') + 
  geom_path(aes(x = mileage, y = ypred_lm2), color='blue')

p_test + geom_path(aes(x = mileage, y = ypred_knn75), color='red')
p_test + geom_path(aes(x = mileage, y = ypred_knn75), color='red') + 
  geom_path(aes(x = mileage, y = ypred_lm2), color='blue')

p_test + geom_path(aes(x = mileage, y = ypred_knn100), color='red')
p_test + geom_path(aes(x = mileage, y = ypred_knn100), color='red') + 
  geom_path(aes(x = mileage, y = ypred_lm2), color='blue')

p_test + geom_path(aes(x = mileage, y = ypred_knn150), color='red')
p_test + geom_path(aes(x = mileage, y = ypred_knn150), color='red') + 
  geom_path(aes(x = mileage, y = ypred_lm2), color='blue')

p_test + geom_path(aes(x = mileage, y = ypred_knn200), color='red')
p_test + geom_path(aes(x = mileage, y = ypred_knn200), color='red') + 
  geom_path(aes(x = mileage, y = ypred_lm2), color='blue')

p_test + geom_path(aes(x = mileage, y = ypred_knn250), color='red')
p_test + geom_path(aes(x = mileage, y = ypred_knn250), color='red') + 
  geom_path(aes(x = mileage, y = ypred_lm2), color='blue')

# Creating a Graph of RMSE as a function of K

df <- data.frame(3:320)
for(i in 3:300){
  df$rmse[i-2] <- rmse(y350_test, knn.reg(train = X350_train, test = X350_test, y = y350_train, k = i)$pred)}
view(df)
names(df) <- c("k", "rmse")

ggplot(data = df) + 
  geom_point(mapping = aes(x = k, y = rmse), color='darkgrey') + 
  ylim(0, 20000)


# RMSE is minimized at k=40, verifying RMSE from the df computations, and creating a fitted model, but 
# it should be noted that this changes every time the program is run due to randomness
# the same holds for the 65AMG data
knn40 = knn.reg(train = X350_train, test = X350_test, y = y350_train, k=40)
names(knn40)

ypred_knn40 = knn40$pred
rmse(y350_test, ypred_knn40)

p_test + geom_path(aes(x = mileage, y = ypred_knn40), color='red')
p_test + geom_path(aes(x = mileage, y = ypred_knn40), color='red') + 
  geom_path(aes(x = mileage, y = ypred_lm2), color='blue')

