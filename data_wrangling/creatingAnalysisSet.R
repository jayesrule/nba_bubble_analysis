suppressPackageStartupMessages(library(tidyverse))
library(lubridate)
library(here)

#Loading data created in data/Creating_dataset.Rmd----------------------------------------
load(here("data/shot_data.RData"))


#Removing players who take less than 15 shots in either pre-bubble, bubble periods-------------
temp_tab <- table(shotsData$namePlayer, shotsData$bubble) > 15

analysis_players <- row.names(temp_tab[temp_tab[, 1]*temp_tab[, 2] == 1,])

analysis_set <- filter(shotsData, namePlayer %in% analysis_players)

player_ids_table <- tibble(namePlayer = unique(analysis_set$namePlayer), 
                           player_id = 1:length(unique(analysis_set$namePlayer)))


#Creating final modeling dataset ---------------------------------------
modeling_data <- analysis_set %>% 
  left_join(y = player_ids_table, by = "namePlayer") %>%
  mutate(is3pt = 1*(typeShot == "3PT Field Goal")) %>%
  select(made_shot, bubble, distanceShot, defRate, is3pt, player_id) 

#Saving ---------------------------------------------------------
save(modeling_data, file = here("data_wrangling/modeling_data.RData"))
