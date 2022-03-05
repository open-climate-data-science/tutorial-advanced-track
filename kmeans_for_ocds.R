# ---- script header ----
# script name: kmeans_For_ocds.R
# purpose of script: example script for L & N
# author: sheila saia
# date created: 2022-02-21
# email: ssaia@ncsu.edu


# ---- notes ----
# notes:

# helpful links
# tutorial (kmeans w/ 2 variables): https://www.tidymodels.org/learn/statistics/k-means/
# tutorial (kmeans w/ 3+ variables): https://juliasilge.com/blog/kmeans-employment/
# tutorial: silhouette score: https://krisrs1128.github.io/stat479/posts/2021-03-17-week9-4/


# ---- to do ----
# to do list:


# ---- load libraries ----
library(tidyverse)
library(here)
library(tidymodels)
library(cluster)
library(lubridate)


# ---- load data ----
# station id list
coop_station_complete_list <- read_csv("coop_station_complete_list.csv",
                                       col_names = TRUE, show_col_types = FALSE)

# coop data
coop_data <- read_csv("coop_data.csv",
                      col_names = TRUE, show_col_types = FALSE)


# ---- create function for cluster analysis ----
# function to calculate cluster info for a given k value
calculate_cluster <- function(data, k) {
  x <- data %>%
    na.omit() %>%
    scale()
  
  df <- kmeans(x, center = k) %>%
    augment(data) %>% # creates column ".cluster" with cluster label
    mutate(silhouette = cluster::silhouette(as.integer(.cluster), dist(x))[, "sil_width"]) # calculate silhouette score
  
  return(df)
}


# ---- set seed ----
set.seed(123)


# ---- k means clustering analysis (max temperature only) ----
# create empty dataset
coop_tempmax_optimal_cluster_data <- NULL

# for loop for all stations
for (i in 1:length(coop_station_complete_list$station)) {
  # select station
  temp_station <- coop_station_complete_list$station[i]
  
  # data subset
  temp_coop_data <- coop_data %>%
    select(station, date, tempmax_c) %>%
    mutate(doy = yday(date)) %>%
    filter(station == temp_station) %>% # select one station for now
    select(doy, tempmax_c) %>%
    na.omit()
  
  # test function
  # calculate_cluster(data = coop_data_small, k = 2)
  
  # map cluster calculations function to range of k values
  temp_cluster_data <- tibble(k = 2:12) %>%
    mutate(kclust = map(k, ~calculate_cluster(temp_coop_data, .x))) %>%
    unnest(cols = c(kclust))
  
  # print status
  print(paste0("finished cluster analysis for station ", temp_station))
  
  # calculate silhoutte score (highest for optimal number of k clusters)
  temp_sil_score_data <- temp_cluster_data %>%
    group_by(k) %>%
    summarize(avg_sil_score = mean(silhouette, na.rm = TRUE))
  
  # find maximum
  temp_optimal_sil_score_data <- temp_sil_score_data %>%
    filter(max(avg_sil_score, na.rm = TRUE) == avg_sil_score)
  
  # save optimal k
  temp_optimal_k_value <- temp_optimal_sil_score_data$k
  
  # print status
  print(paste0("optimal number of clusters was k = ", temp_optimal_k_value))
  
  # save optimal k cluster data
  temp_cluster_data_sel <- temp_cluster_data %>%
    filter(k == temp_optimal_k_value) %>%
    mutate(station = temp_station)
  
  # append data
  coop_tempmax_optimal_cluster_data <- bind_rows(temp_cluster_data_sel, coop_tempmax_optimal_cluster_data)
  
}

# quick look
length(unique(coop_tempmax_optimal_cluster_data$station))
unique(coop_tempmax_optimal_cluster_data$k)
# optimal k is always 3

# plot outputs tempmax vs doy
ggplot(data = coop_tempmax_optimal_cluster_data) +
  geom_point(aes(x = doy, y = tempmax_c, color = .cluster), alpha = 0.5) + 
  facet_wrap(~ station) +
  labs(x = "Day of Year", y = "Max. Air Temperature (C)", color = "Cluster ID")

# plot outputs density of doy colored by cluster
ggplot(data = coop_tempmax_optimal_cluster_data) +
  geom_density(aes(x = doy, fill = .cluster), alpha = 0.5) + 
  facet_wrap(~ station, scale = "free") +
  labs(x = "Day of Year", y = "Density", fill = "Cluster ID") +
  theme_classic()

# export
write_csv(x = coop_tempmax_optimal_cluster_data, file = here::here("data", "cluster_data", "coop_tempmax_optimal_cluster_data.csv"))


# ---- k means clustering analysis (max temperature + precipitation) ----
# create empty dataset
coop_tempmax_precip_optimal_cluster_data <- NULL

# for loop for all stations
for (i in 1:length(coop_station_complete_list$station)) {
  # select station
  temp_station <- coop_station_complete_list$station[i]
  
  # data subset
  temp_coop_data <- coop_data %>%
    select(station, date, tempmax_c, precip_cm) %>%
    mutate(doy = yday(date)) %>%
    filter(station == temp_station) %>% # select one station for now
    select(doy, tempmax_c, precip_cm) %>%
    na.omit()
  
  # test function
  # calculate_cluster(data = coop_data_small, k = 2)
  
  # map cluster calculations function to range of k values
  temp_cluster_data <- tibble(k = 2:12) %>%
    mutate(kclust = map(k, ~calculate_cluster(temp_coop_data, .x))) %>%
    unnest(cols = c(kclust))
  
  # print status
  print(paste0("finished cluster analysis for station ", temp_station))
  
  # calculate silhoutte score (highest for optimal number of k clusters)
  temp_sil_score_data <- temp_cluster_data %>%
    group_by(k) %>%
    summarize(avg_sil_score = mean(silhouette, na.rm = TRUE))
  
  # find maximum
  temp_optimal_sil_score_data <- temp_sil_score_data %>%
    filter(max(avg_sil_score, na.rm = TRUE) == avg_sil_score)
  
  # save optimal k
  temp_optimal_k_value <- temp_optimal_sil_score_data$k
  
  # print status
  print(paste0("optimal number of clusters was k = ", temp_optimal_k_value))
  
  # save optimal k cluster data
  temp_cluster_data_sel <- temp_cluster_data %>%
    filter(k == temp_optimal_k_value) %>%
    mutate(station = temp_station)
  
  # append data
  coop_tempmax_precip_optimal_cluster_data <- bind_rows(temp_cluster_data_sel, coop_tempmax_precip_optimal_cluster_data)
  
}

# quick look
length(unique(coop_tempmax_precip_optimal_cluster_data$station))
unique(coop_tempmax_precip_optimal_cluster_data$k)
# optimal k is always 3

# plot outputs
ggplot(data = coop_tempmax_precip_optimal_cluster_data) +
  geom_point(aes(x = doy, y = tempmax_c, color = .cluster), alpha = 0.5) + 
  facet_wrap(~ station, scale = "free") +
  labs(x = "Day of Year", y = "Max. Air Temperature (C)", color = "Cluster ID")

# plot outputs prcip vs doy
ggplot(data = coop_tempmax_precip_optimal_cluster_data) +
  geom_point(aes(x = doy, y = precip_cm, color = .cluster), alpha = 0.5) + 
  facet_wrap(~ station, scale = "free") +
  labs(x = "Day of Year", y = "Precipitation (cm)", color = "Cluster ID")

# plot outputs tempmax vs doy
ggplot(data = coop_tempmax_precip_optimal_cluster_data) +
  geom_point(aes(x = tempmax_c, y = precip_cm, color = .cluster), alpha = 0.5) + 
  facet_wrap(~ station, scale = "free") +
  labs(x = "Max. Air Temperature (C)", y = "Precipitation (cm)", color = "Cluster ID") +
  theme_classic()

# plot outputs precip vs tempmax
ggplot(data = coop_tempmax_precip_optimal_cluster_data %>% filter(station == 313106)) +
  geom_point(aes(x = tempmax_c, y = precip_cm, color = doy), alpha = 0.5) + 
  facet_wrap(~ .cluster, scale = "free") +
  labs(x = "Max. Air Temperature (C)", y = "Precipitation (cm)", color = "DOY") +
  theme_classic()

# plot outputs density of doy colored by cluster
ggplot(data = coop_tempmax_precip_optimal_cluster_data) +
  geom_density(aes(x = doy, fill = .cluster), alpha = 0.5) + 
  facet_wrap(~ station, scale = "free") +
  labs(x = "Day of Year", y = "Density", fill = "Cluster ID") +
  theme_classic()

# export
write_csv(x = coop_tempmax_precip_optimal_cluster_data, file = here::here("data", "cluster_data", "coop_tempmax_precip_optimal_cluster_data.csv"))


