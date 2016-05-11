library(XML)
library(dplyr)
library(plotly)

get_cum_rundiff <- function(df) {
     ## calculate running run diff
     cum_rundiff <- rep(0,nrow(df))
     cum_rundiff[1] <- df$R[1] - df$RA[1]
     for (n in 2 : nrow(df)) {
          rundiff <- df$R[n] - df$RA[n]
          cum_rundiff[n] <- rundiff  + cum_rundiff[n-1]    
     }
     df$cum_rundiff <- cum_rundiff
     
     return(df)
     
}

get_cum_wins <- function(df) {
     ## calculate running win total
     cum_wins <- rep(0,nrow(df))
     wins <- 0
     for (n in 1 : nrow(df)) {
          if (df$WL[n] == ("W") | df$WL[n] == ("W-wo")) 
          { wins <- wins + 1 } 
          cum_wins[n] <- wins         
     }
     df$cum_wins <- cum_wins
     
     return(df)
}

get_tidy_data <- function(url, team) {
     data <- readHTMLTable(url)
     results <- data$team_schedule
     colnames(results)[2] <- "Gm"
     colnames(results)[8] <- "WL"
     
     tidyresults <- results %>% select(Gm, WL, R, RA) %>% filter(Gm != "Gm#") %>% filter(WL != "T") %>% filter(R != "Game Preview, Matchups, and Tickets")
     
     tidyresults$R <- factor(tidyresults$R)
     tidyresults$RA <- factor(tidyresults$RA)
     tidyresults$R <- as.numeric(as.character(tidyresults$R))
     tidyresults$RA <- as.numeric(as.character(tidyresults$RA))
     tidyresults$team <- team
     
     return(tidyresults)
     
}

## Get cubs data
Cubs2016results <- get_tidy_data("http://www.baseball-reference.com/teams/CHC/2016-schedule-scores.shtml", "Cubs2016")
Cubs2016results <- get_cum_wins(Cubs2016results)
Cubs2016results <- get_cum_rundiff(Cubs2016results)

##
## Get M's data
##
Mariners2001results <- get_tidy_data("http://www.baseball-reference.com/teams/SEA/2001-schedule-scores.shtml", "Mariners2001")
Mariners2001results <- get_cum_wins(Mariners2001results)
Mariners2001results <- get_cum_rundiff(Mariners2001results)


## Get Yankees Data
Yankees1939results <- get_tidy_data("http://www.baseball-reference.com/teams/NYY/1939-schedule-scores.shtml", "Yankees1939")
Yankees1939results<- get_cum_wins(Yankees1939results)
Yankees1939results<- get_cum_rundiff(Yankees1939results)

wins_table <- rbind(Cubs2016results,Mariners2001results)
rundiff_table <- rbind(Cubs2016results,Yankees1939results)

games <- nrow(Cubs2016results)
wins <- Cubs2016results$cum_wins[games]
rundiff <- Cubs2016results$cum_rundiff[games]

wins_to_go <- 116 - wins 
win_rate <- (116 - wins) / (162 - games)
rundiff_rate <- (411-rundiff) / (162 - games)

