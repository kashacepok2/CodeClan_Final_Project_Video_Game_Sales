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

video_game_sales_original <- read_csv("data/sales-2019.csv") %>% 
  clean_names()

video_game_sales_after_2017 <- video_game_sales_original %>%
  select(-rank, -basename, -vg_chartz_score, -critic_score, -user_score, -pal_sales,
         -last_update, -status, -vgchartzscore, -url, -img_url, -total_shipped) %>% 
  rename("year_of_release" = "year") %>% 
  rename("rating" = "esrb_rating") %>% 
  filter(year_of_release > 2016) %>% 
  filter(is.na(global_sales) == FALSE
         & is.na(na_sales) == FALSE
         & is.na(jp_sales) == FALSE
         & is.na(other_sales) == FALSE)
  
video_game_ratings <- video_game_sales %>%
  filter(name != "Wii Sports") %>% 
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
  filter(is.na(genre) == FALSE | year_of_release < 2017) %>% 
  mutate(rating = case_when(
    rating == "E" ~ "All ages",
    rating == "EC" ~ "3+",
    rating == "E10+" ~ "10+",
    rating == "T" ~ "13+",
    rating == "M" ~ "17+",
    rating == "AO" ~ "18+",
    rating == "RP" ~ "RP",
    rating == "K-A" ~ "6+"
  ))

video_game_sales_clean <- video_game_sales %>% 
  select(-user_count, -user_score, -critic_score, -critic_count) %>%
  filter(name != "Wii Sports") %>% 
  mutate(year_of_release = as.numeric(year_of_release)) %>%
  bind_rows(video_game_sales_after_2017) %>% 
  mutate(platform = case_when(
    platform %in% nintendo ~ "Nintendo",
    platform %in% xbox ~ "Microsoft Xbox",
    platform %in% playstation ~ "Sony Playstation",
    platform %in% sega ~ "Sega",
    platform %in% other ~ "Other",
    platform == "PC" ~ "PC"
  )) %>% 
  filter(is.na(genre) == FALSE) %>%
  filter(year_of_release != 2020) %>% 
  mutate(rating = case_when(
    rating == "E" ~ "All ages",
    rating == "EC" ~ "3+",
    rating == "E10+" ~ "10+",
    rating == "T" ~ "13+",
    rating == "M" ~ "17+",
    rating == "AO" ~ "18+",
    rating == "RP" ~ "RP",
    rating == "K-A" ~ "6+"
  )) %>% 
  mutate(genre = case_when(
    genre %in% c("Action", "Adventure", "Action-Adventure", "Sandbox") ~ "Action-Adventure",
    genre %in% c("Sports", "Racing") ~ "Sports",
    genre %in% c("Misc", "Visual Novel", "Music", "Board Game", "MMO") ~ "Misc",
    TRUE ~ genre
  ))

write.csv(video_game_sales_clean, "vg_sales.csv")
write.csv(video_game_ratings, "vg_ratings.csv")

