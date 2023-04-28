library(tidyverse)
library(janitor)
library(lubridate)

nintendo <- c("Wii", "NES", "GB", "DS", "SNES", "GBA", "3DS", "N64", "WiiU", "GC")

xbox <- c("X360", "XB", "Xone")

playstation <- c("PS", "PS2", "PS3", "PS4", "PSP", "PSV")

sega <- c("DC", "GEN", "SAT", "SCD")

other <- c("TG16", "PCFX", "2600", "3D0", "WS", "NG")

video_game_sales <- read_csv("data/extra_videogame_sales.csv") %>% 
  clean_names()
  
video_game_ratings <- video_game_sales %>% 
  filter(user_count > 25) %>% 
  filter(critic_count > 5) %>% 
  mutate(user_score = as.numeric(user_score) * 10) %>% 
  mutate(year_of_release = as.numeric(year_of_release)) %>% 
  mutate(platform = case_when(
    platform %in% nintendo ~ "Nintendo",
    platform %in% xbox ~ "Microsoft Xbox",
    platform %in% playstation ~ "Sony Playstation",
    platform %in% sega ~ "Sega",
    platform %in% other ~ "Other",
    platform == "PC" ~ "PC"
  )) %>% 
  pivot_longer(cols = c("critic_score", "user_score"),
               names_to = "critic_or_user", values_to = "score") %>% 
  filter(is.na(genre) == FALSE | year_of_release < 2017)

video_game_sales_clean <- video_game_sales %>% 
  select(-user_count, -user_score, -critic_score, -critic_count) %>% 
  mutate(year_of_release = as.numeric(year_of_release)) %>% 
  mutate(platform = case_when(
    platform %in% nintendo ~ "Nintendo",
    platform %in% xbox ~ "Microsoft Xbox",
    platform %in% playstation ~ "Sony Playstation",
    platform %in% sega ~ "Sega",
    platform %in% other ~ "Other",
    platform == "PC" ~ "PC"
  )) %>% 
  filter(is.na(genre) == FALSE | year_of_release < 2017) 

write.csv(video_game_sales_clean, "vg_sales.csv")
write.csv(video_game_ratings, "vg_ratings.csv")

