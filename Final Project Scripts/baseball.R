library(LICORS)
library(randomForest)
library(gamlr)
library(foreach)

# Initial df read in 
baseball <- read.csv("C:/Users/suber/iCloudDrive/Documents/UT Austin/2019 Spring/DataScience/FinalProject/baseball.csv")
baseball <- read.csv("~/Documents/UT Austin/2019 Spring/DataScience/FinalProject/baseball.csv")
# Rename cols for clarity
colnames(baseball) <- c("N", "Year", "Name", "TeamAbbr", "Team", "Position", "VetStatus", "Salary", 
                        "SalaryPerc", "Rank", "PlayerCode", "Age", "League", "Games", 
                        "PlateApp", "AtBats", "Runs","Hits", "Doubles", "Triples", "HomeRuns",
                        "RBI", "StolenBases", "Caught", "BasesWalked", "StrikeOuts", "BattingAvg",
                        "OnBasePerc", "SluggPerc", "OnBaseSluggPerc", "OnBaseSluggPercNorm",
                        "TotalBases", "GroundDouble", "HitByPitch", "SacHit", "SacFlies", "IntBasesOnBalls" )
# Start focus on batter statistics in National League
# Drop AL, Pitchers, Plate Appearances < 200
baseball <- subset(baseball, League == "NL")
baseball <- subset(baseball, 
                   Position != "P" &
                   Position != "SP" &
                   Position != "RP" &
                   Position != "RP/CL" &
                   Position != "CL")
baseball <- subset(baseball, 
                   PlateApp >= 200)

# Base df with complete cases (needed for PCA & Clustering)
baseballcc <- baseball[complete.cases(baseball),]

#-------------------
#-Linear Models
# Beginning with an easily interpreitable linear model
# Key objective is to find which statistics best explain player salary (should probably look at wins......)
# If we assume teams are efficient and are naturally allocating salary according to who will contribute more to wins....


# Basic model
lm1 <- lm(Salary ~ Age + AtBats + Runs + Hits + HomeRuns + StrikeOuts + Doubles + Triples + BattingAvg + StolenBases + BasesWalked, data = baseball)
summary(lm1)

# (Almost) Every fucking thing
lm2 <- lm(Salary ~ Age + Position + AtBats + Runs + Hits + HomeRuns + RBI + StrikeOuts + BattingAvg + Doubles + Triples + StolenBases + Caught + BasesWalked +
            OnBasePerc + SluggPerc + OnBaseSluggPerc + OnBaseSluggPercNorm + TotalBases + GroundDouble + HitByPitch + SacHit + SacFlies + IntBasesOnBalls, data = baseball)

# Pretty much the same but with omissions... 
lm3 <- lm(Salary ~ . -N -Year -Name -Position -TeamAbbr -Team -PlayerCode -League -Rank -SalaryPerc, data = baseball)

#-Step function
# We seek to find a local AIC max based on our original model and our scope terms
lm_step <- step(lm1, scope=~((. + Caught + BasesWalked +
                               OnBasePerc + SluggPerc + OnBaseSluggPerc + OnBaseSluggPercNorm +
                             TotalBases + GroundDouble + HitByPitch + SacHit + SacFlies + IntBasesOnBalls)^2))
summary(lm_step)

# The Lasso
# Lets see what you do
scx <- sparse.model.matrix(Salary ~ Age + AtBats + Runs + Hits + HomeRuns + RBI + StrikeOuts + BattingAvg,
                           data = baseballcc)[,-1]
scy <- baseballcc$Salary
sclasso <- gamlr(scx, scy)

#---------
#-Want to choose variables that are critical in determining our y
# df with just stat attributes
b <- data.frame(subset(baseballcc, select=c(Age, AtBats, Runs, Hits, HomeRuns, StrikeOuts,
                                            Doubles, Triples, BattingAvg, StolenBases, BasesWalked)))
# Scale for funsies
b_scale <- data.frame(scale(b, center = TRUE, scale = TRUE))

#------------
# Clustering 
# Looking for similar players via clustering
# Then find the el cheapo (espanol, si no lo reconoce) en el clustero
# Solamente el ano 2018
# Chupa mi ano

# Same as prior data frames but focusing on 2018 
baseball_2018 <- subset(baseballcc, Year=="2018")
factors <- 
b_2018 <- data.frame(subset(baseball_2018, 
                            select = c(Age, AtBats, Runs, Hits, HomeRuns, 
                                       StrikeOuts,Doubles, Triples, BattingAvg, StolenBases, BasesWalked)))
b_2018_scale <- data.frame(scale(b_2018, center = TRUE, scale = TRUE))

#-PCA - No necesario - 
pc_baseball = prcomp(b_scale, rank.=5)
plot(pc_baseball, type="lines")
summary(pc_baseball)

#-Kmeans++
# Buscar la solucion optima
# Aproximamente diecisiete clusteros 
k_grid_bat = seq(2, 25, by = 1)
N = nrow(b_2018_scale)
SSE_grid_bat = foreach(k = k_grid_bat, .combine = 'c') %do% {
  cluster_kp_bat = kmeanspp(b_2018_scale, k, nstart=25)
  cluster_kp_bat$tot.withinss
}
plot(SSE_grid_bat)
# Maybe baby like 17??
clustkp_bat = kmeanspp(b_2018_scale, k = 17, nstart = 50, iter.max = 1000)
# Now we observe an uninterpretable plot :')
# I cri evri tim
plot(b_2018_scale, col = clustkp_bat$cluster, pch=16, cex=0.3)

# Lets focus on a single player
baseball_2018$KCluster <- clustkp_bat$cluster
key_player = "AJPollock"
key_cluster = baseball_2018[which(baseball_2018$Name == key_player),]$KCluster
players_Kcluster1 <- subset(baseball_2018, KCluster == key_cluster)
el_cheapo_k <- players_Kcluster1[which(players_Kcluster1$Salary == min(players_Kcluster1$Salary)),]

# Lets repeat this for a whole teams roster
# We are not accounting for what position they play
# Maybe we should maybe we shouldnt, Baseball suxx eitherway

# Focus on a single team in NL
key_team = "ATL"
key_roster = subset(baseball_2018, TeamAbbr == key_team)$Name
replace_roster <- data.frame(matrix(ncol=3,nrow=length(key_roster)))
colnames(replace_roster) <- c("Old","New","NewSamePos")
for(n in 1:length(key_roster)) {
  # Get the player on the roster
  key_p = key_roster[n]
  replace_roster[n,1] <- as.character(key_p)
  # Get which cluster they are in
  key_cl = baseball_2018[which(baseball_2018$Name == key_p),]$KCluster
  # Get df of players in that cluster
  players_K <- subset(baseball_2018, KCluster == key_cl)
  # Which player in that cluster is cheapest
  # Order by salary
  players_K <- players_K[order(players_K$Salary),]  
  for(m in 1:length(players_K)){
    value_pl <- players_K[m,]$Name
    # If current cheapest player is not already in data set
    if(!(value_pl %in% replace_roster[,2])){
      replace_roster[n,2] <- as.character(value_pl)
      break
    } else(replace_roster[n,2] <- as.character(players_K[1]))
  }
  #---
  # Players in the cluster who play the same pos as current player
  # Note we are assuming that position doesnt affect clustering.....
  # Possible we should cluster after separating into position
  same_pos <- subset(players_K, Position == players_K[which(players_K$Name==key_p),]$Position)
  same_pos <- same_pos[order(same_pos$Salary),]
  
  for(m in 1:length(same_pos)){
    value_pl <- same_pos[m,]$Name
    # If current cheapest player is not already in data set
    if(!(value_pl %in% replace_roster[,3])){
      replace_roster[n,3] <- as.character(value_pl)
      break
    } else(replace_roster[n,3] <- as.character(same_pos[1]))
  }
}

#---------------------------
# Cluster for each postion?


#----------------------------
#-Heirarchical Clustering
# Problem: Super A-symmetrical
dist_b_2018 <- dist(b_2018_scale, method = "euclidean")
cluster_hier <- hclust(dist_b_2018, method = "average")
plot(cluster_hier)
# we want ~6 people nearest to our player
k_b <- floor(nrow(b_2018_scale)/4)
cut_b <- cutree(cluster_hier, k = k_b)

#Get a df of just the 2018 baseball players
baseball_2018$HCluster <- cut_b

key_player = "AJPollock"
key_cluster = baseball_2018[which(baseball_2018$Name == key_player),]$HCluster
players_Hcluster1 <- subset(baseball_2018, HCluster == key_cluster)



#-----------
#-- Non-linear models
#-Trees
# Prolly just good for prediction
N <- nrow(baseballcc)
train_perc <- 0.8
N_train <- floor(train_perc*N)
N_test <- N - N_train
train_ind <- sort(sample.int(N, N_train, replace=FALSE))
b_train <- baseballcc[train_ind,]
b_test <- baseballcc[-train_ind,]

#- Bagging
forest <- randomForest(Salary ~ . -N -Year -Name -Position -TeamAbbr -Team -PlayerCode -League -Rank, 
                       mtry=10, nTree=100, data = b_train)

yhat_forest_test <- predict(forest, b_test)
rmse_forest <- sqrt(mean((b_test$Salary - yhat_forest_test)^2))
rmse_forest
