salary_raw <- read.csv("C:/Users/suber/iCloudDrive/Documents/UT Austin/2019 Spring/DataScience/FinalProject/salary_raw.csv")
stats_clean <- read.csv("C:/Users/suber/iCloudDrive/Documents/UT Austin/2019 Spring/DataScience/FinalProject/stats_clean.csv")

salary_raw <- read.csv("~/Documents/UT Austin/2019 Spring/DataScience/FinalProject/salary_raw.csv")
stats_clean <- read_excel("Documents/UT Austin/2019 Spring/DataScience/FinalProject/stats_clean.xlsx")
stats_clean <- read.csv("~/Documents/UT Austin/2019 Spring/DataScience/FinalProject/stats_clean.csv")

# Rename columns of salary_raw to match stats dataset
stats_clean$Name <- gsub("[[:punct:]]", "", stats_clean$Name)
stats_clean$Name <- gsub("[[:space:]]", "", stats_clean$Name)

salary_raw$Name <- gsub("[[:punct:]]", "", salary_raw$Name)
salary_raw$Name <- gsub("[[:space:]]", "", salary_raw$Name)
salary_raw$Salary <- gsub("[[:punct:]]", "", salary_raw$Salary)


# Remove non-team values
stats <- stats_clean[which(stats_clean$Tm!='TOT' & stats_clean$Tm!='FLA' & stats_clean$Tm!=''),]

# Create a dictionary
v <- data.frame(sort(unique(stats$Tm)))
w <- data.frame(sort(unique(salary_raw$Team)))
d <- cbind(v, w, fill = NA)
colnames(d) <- c("Tm","Team")
# Ammend line
d$Team <- replace(d$Team, c(which(d$Tm == "SFG"), which(d$Tm == "SEA")), c("san-francisco-giants", "seattle-mariners"))

# Add team codes to salary data set
salary_raw$Tm <- d$Tm[match(salary_raw$Team, d$Team)]

baseball <- merge(x = salary_raw, y = stats)

baseball <- baseball[,-ncol(baseball)]

# Rename cols for clarity
colnames(baseball) <- c("Year", "Name", "TeamAbbr", "Team", "Position", "VetStatus", "Salary", 
                        "SalaryPerc", "Rank", "PlayerCode", "Age", "League", "Games", 
                        "PlateApp", "AtBats", "Runs","Hits", "Doubles", "Triples", "HomeRuns",
                        "RBI", "StolenBases", "Caught", "BasesWalked", "StrikeOuts", "BattingAvg",
                        "OnBasePerc", "SluggPerc", "OnBaseSluggPerc", "OnBaseSluggPercNorm",
                        "TotalBases", "GroundDouble", "HitByPitch", "SacHit", "SacFlies", "IntBasesOnBalls" )

# Convert Vet to Binary
baseball$VetInd <- as.numeric(baseball$VetStatus == "Vet")


# Based on our step function these interactions were deemed important
#----
# Create a bunch of variables
# Three star
baseball$BaseGame <- baseball$BasesWalked * baseball$Games
baseball$GDAge <- baseball$GroundDouble * baseball$Age
baseball$SBWalk <- baseball$StolenBases * baseball$BasesWalked
baseball$AgeBoB <- baseball$Age * baseball$IntBasesOnBalls
baseball$VetBoB <- baseball$VetInd * baseball$IntBasesOnBalls
baseball$HitAge <- baseball$Hits * baseball$Age
baseball$AgeRBI <- baseball$Age * baseball$RBI
# Two Star
baseball$VetGames <- baseball$VetInd * baseball$Games
baseball$VetAge <- baseball$VetInd * baseball$Age
baseball$VetTriples <- baseball$VetInd * baseball$Triples
baseball$RunDoub <- baseball$Runs * baseball$Doubles
baseball$SOWalked <- baseball$StrikeOuts * baseball$BasesWalked

write.csv(baseball, "C:/Users/suber/iCloudDrive/Documents/UT Austin/2019 Spring/DataScience/FinalProject/baseball.csv", quote=FALSE)
write.csv(baseball, "~/Documents/UT Austin/2019 Spring/DataScience/FinalProject/baseball.csv", quote=FALSE)

