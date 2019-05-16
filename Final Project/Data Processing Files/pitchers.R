library(LICORS)
library(randomForest)
library(foreach)
library(ggplot2)

pitchers <- read.csv("~/Documents/UT Austin/2019 Spring/DataScience/FinalProject/pitchers.csv")

pitchers <- subset(pitchers, League == "NL")
pitchers <- subset(pitchers, 
                   InningsPitched >= 100)
pitcherscc <- pitchers[complete.cases(pitchers),]

# OOS Prediction
N <- nrow(pitcherscc)
train_perc <- 0.8
N_train <- floor(train_perc*N)
N_test <- N - N_train
train_ind <- sort(sample.int(N, N_train, replace=FALSE))
p_train <- pitcherscc[train_ind,]
p_test <- pitcherscc[-train_ind,]

#--------------------
# Linear Models to look judge characteristic
# Basic model
lm5 <- lm(Salary ~ Position + VetStatus + Win_Loss + ERA + InningsPitched 
          + EarnedRuns_Allowed + BasesWalk + StrikeOuts + HitByPitch  + Walks.HitsPerInn, data = pitchers)
summary(lm5)

#-Step function
# We seek to find a local AIC max based on our original model and our scope terms
lm_step_p <- step(lm5, scope=~((. + Age + IntentWalk + Balks + WildPitches + BattersFaced + FieldIndPitch + H9 + HR9
                              + BB9 + SO9)^2))
summary(lm_step_p)

# Model
lm6 <- lm(Salary ~ VetInd + Win_Loss + ERA + InningsPitched + 
            EarnedRuns_Allowed + BasesWalk + StrikeOuts + HitByPitch + 
            Age + VetSO + VetWalk +  VetInnP + EraWalk + VetWalk + VetAge + WalkAge + EraAge, data = pitchers)
# Out of sample RMSE for the linear model
yhat_linear_test_p <- predict(lm6, p_test)
rmse_linear_p <- sqrt(mean((p_test$Salary - yhat_linear_test_p)^2))
rmse_linear_p

#---------------------
# Select pitcher fators that are meaningful based upon linear model

pitchers_2018 <- subset(pitcherscc, Year=='2018')
p_2018 <- data.frame(subset(pitchers_2018,
                     select = c(Age, VetInd, BasesWalk, ERA, StrikeOuts)))
p_2018 <- data.frame(subset(pitchers_2018,
                    select = c(VetInd, Win_Loss, ERA, InningsPitched, 
                      EarnedRuns_Allowed, BasesWalk, StrikeOuts, HitByPitch, 
                      Age, VetSO, VetWalk,  VetInnP, EraWalk, VetWalk, VetAge, WalkAge, EraAge)))
p_2018_scale <- data.frame(scale(p_2018, center = TRUE, scale = TRUE))

# # Find an optimal solution
# k_grid_pit = seq(2, 25, by = 1)
# N = nrow(p_2018_scale)
# SSE_grid_pit = foreach(k = k_grid_pit, .combine = 'c') %do% {
#   cluster_kp_pit = kmeanspp(p_2018_scale, k, nstart=25)
#   cluster_kp_pit$tot.withinss
# }
# plot(SSE_grid_pit)

clustkp_pit = kmeanspp(p_2018_scale, k=7, nstart = 50, iter.max = 1000)

pitchers_2018$KCluster <- clustkp_pit$cluster

# Lets focus on a single player
key_player = "AaronNola"
key_cluster = pitchers_2018[which(pitchers_2018$Name == key_player),]$KCluster
players_Kcluster1 <- subset(pitchers_2018, KCluster == key_cluster)
el_cheapo_k <- players_Kcluster1[which(players_Kcluster1$Salary == min(players_Kcluster1$Salary)),]
el_cheapo_k$Name
# Now lets look at an entire
key_team = "LAD"
key_roster = subset(pitchers_2018, TeamAbbr == key_team)
key_roster_pitchers <- key_roster$Name
replace_pitch <- data.frame(matrix(ncol=2,nrow=length(key_roster_pitchers)))
colnames(replace_pitch) <- c("Old","New")
for(n in 1:length(key_roster_pitchers)) {
  # Loop over players currently on team
  # Get the player on the roster
  key_p = key_roster_pitchers[n]
  replace_pitch[n,1] <- as.character(key_p)
  # Get which cluster they are in
  key_cl = pitchers_2018[which(pitchers_2018$Name == key_p),]$KCluster
  # Get df of players in that cluster
  players_K <- subset(pitchers_2018, KCluster == key_cl)
  # Which player in that cluster is cheapest
  # Order by salary
  players_K <- players_K[order(players_K$Salary),]  
  for(m in 1:length(players_K)){
    # Loop over players in cluster
    value_pl <- players_K[m,]$Name
    # If current cheapest player is not already in data set
    if(!(value_pl %in% replace_pitch[,2])){
      replace_pitch[n,2] <- as.character(value_pl)
      break
    } else(replace_pitch[n,2] <- as.character(players_K[1]))
  }
}
replace_pitch

# ---------------------------------------------
# Look at error terms based on our linear model
roster_pred <- predict(lm6, key_roster)
key_roster$Error <- key_roster$Salary - roster_pred
p5 <- ggplot(data=key_roster, aes(x=Name, y=Error)) +
  geom_bar(stat="identity", color = key_roster$KCluster) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
p5

#-----------------------------
# Aggregate Team and Look at Team Errors
league_pred <- predict(lm6, pitchers_2018)
pitchers_2018$Error <- pitchers_2018$Salary - league_pred
team_error <- aggregate(Error ~ TeamAbbr, pitchers_2018, sum)
p6 <- ggplot(data=team_error, aes(x=TeamAbbr, y=Error)) +
  geom_bar(stat="identity", color = "red") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
p6

#- Bagging
# Using the linear model from before
forest2 <- randomForest(Salary ~ VetInd + Win_Loss + ERA + InningsPitched + 
                         EarnedRuns_Allowed + BasesWalk + StrikeOuts + HitByPitch + 
                         Age + VetSO + VetWalk +  VetInnP + EraWalk + VetWalk + VetAge + WalkAge + EraAge, mtry=15, nTree=100, data = pitchers)

yhat_forest_test <- predict(forest2, p_test)
rmse_forest_p <- sqrt(mean((p_test$Salary - yhat_forest_test)^2))
rmse_forest_p

matrix( c("Linear", "Tree", rmse_linear_p, rmse_forest_p), nrow = 2, ncol = 2)

#--------------------------
# Look at error terms based on our linear model
roster_pred <- predict(forest2, key_roster)
key_roster$Error <- key_roster$Salary - roster_pred
p7 <- ggplot(data=key_roster, aes(x=Name, y=Error)) +
  geom_bar(stat="identity", color = key_roster$KCluster) +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
p7

#-----------------------------
# Agggregate Team and Look at Team Errors
league_pred <- predict(forest2, pitchers_2018)
pitchers_2018$Error <- pitchers_2018$Salary - league_pred
team_error <- aggregate(Error ~ TeamAbbr, pitchers_2018, sum)
p8 <- ggplot(data=team_error, aes(x=TeamAbbr, y=Error)) +
  geom_bar(stat="identity", color = "green") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))
p8



