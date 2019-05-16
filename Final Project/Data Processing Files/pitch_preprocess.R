# Processing Pitching data
salary_raw <- read.csv("C:/Users/suber/iCloudDrive/Documents/UT Austin/2019 Spring/DataScience/FinalProject/salary_raw.csv")
pitching <- read.csv("C:/Users/suber/iCloudDrive/Documents/UT Austin/2019 Spring/DataScience/FinalProject/pitching.csv")

salary_raw <- read.csv("~/Documents/UT Austin/2019 Spring/DataScience/FinalProject/salary_raw.csv")
pitching <- read_excel("Documents/UT Austin/2019 Spring/DataScience/FinalProject/pitching.xlsx")
pitching <- read.csv("~/Documents/UT Austin/2019 Spring/DataScience/FinalProject/pitching.csv")

#Rename columns of salary_raw to match pitch dataset

pitching$Name <- gsub("[[:punct:]]", "", pitching$Name)
pitching$Name <- gsub("[[:space:]]", "", pitching$Name)

salary_raw$Name <- gsub("[[:punct:]]", "", salary_raw$Name)
salary_raw$Name <- gsub("[[:space:]]", "", salary_raw$Name)
salary_raw$Salary <- gsub("[[:punct:]]", "", salary_raw$Salary)


# Remove non-team values
pitch <- pitching[which(pitching$Tm!='TOT' & pitching$Tm!='FLA' & pitching$Tm!='' & pitching$Tm!='Tm'),]

# Create a dictionary
v <- data.frame(sort(unique(pitch$Tm)))
w <- data.frame(sort(unique(salary_raw$Team)))
d <- cbind(v, w)
colnames(d) <- c("Tm","Team")
# Ammend line
d$Team <- replace(d$Team, c(which(d$Tm == "SFG"), which(d$Tm == "SEA")), c("san-francisco-giants", "seattle-mariners"))

# Add team codes to salary data set
salary_raw$Tm <- d$Tm[match(salary_raw$Team, d$Team)]

pitchers <- merge(x = salary_raw, y = pitch)

# Rename for clarity
colnames(pitchers) <- c("Year", "Name", "TeamAbbr", "Team", "Position", "VetStatus", "Salary", 
                        "SalaryPerc", "Rank", "PlayerCode", "Age", "League", "Wins", "Losses", "Win_Loss", 
                        "ERA", "Games", "GamesStart", "GamesFinished", "CompleteGame", "ShutOut", "Saves",
                        "InningsPitched", "Hits_Allowed", "Runs_Allowed", "EarnedRuns_Allowed", "HomeRuns_Allowed",
                        "BasesWalk", "IntentWalk", "StrikeOuts", "HitByPitch", "Balks", "WildPitches", "BattersFaced",
                        "ERAp", "FieldIndPitch", "Walks/HitsPerInn", "H9", "HR9", "BB9", "SO9", "SO_W")

# Convert Cols to Binary
for(i in 13:ncol(pitchers)){
  pitchers[,i] <- as.numeric(as.character(pitchers[,i]))
}

# Make binary
pitchers$VetInd <- as.numeric(pitchers$VetStatus == "Vet")
pitchers$Age <- as.numeric(pitchers$Age)

# Three stars
pitchers$VetSO <- pitchers$VetInd * pitchers$StrikeOuts      
pitchers$VetWalk <- pitchers$VetInd * pitchers$BasesWalk       
# Two stars
pitchers$VetInnP <- pitchers$VetInd * pitchers$InningsPitched
pitchers$EraWalk <- pitchers$ERA * pitchers$BasesWalk                  
pitchers$VetWalk <- pitchers$VetInd * pitchers$BasesWalk       
pitchers$VetAge <- pitchers$VetInd * pitchers$Age          
pitchers$WalkAge <- pitchers$BasesWalk * pitchers$Age                   
pitchers$EraAge <- pitchers$ERA * pitchers$Age                        

write.csv(pitchers, "C:/Users/suber/iCloudDrive/Documents/UT Austin/2019 Spring/DataScience/FinalProject/pitchers.csv", quote=FALSE)
write.csv(pitchers, "~/Documents/UT Austin/2019 Spring/DataScience/FinalProject/pitchers.csv", quote=FALSE)

