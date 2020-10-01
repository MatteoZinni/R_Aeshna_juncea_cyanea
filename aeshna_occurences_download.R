# install required packages
install.packages("spocc")
install.packages("maps")
install.packages("CoordinateCleaner")

# load libraries
library(spocc)
library(maps)
library(CoordinateCleaner)

# set output path
path_processed_data = "F:/Users/matte/Documents/data_science/data_science_r_projects/r_projects_Aeshna_juncea_cyanea/R_Aeshna_juncea_cyanea/Aeshna_data/Aeshna_data_processed/"

# set the two target species
aeshna_cyanea <- "Aeshna cyanea"
aeshna_juncea   <- "Aeshna juncea"

# query to gbif database
cyanea_gbif =  occ(query = aeshna_cyanea, from = 'gbif', has_coords = TRUE, limit = 5000)
juncea_gbif =  occ(query = aeshna_juncea, from = 'gbif', has_coords = TRUE, limit = 5000)

# keep only data and discarding metadata
cyanea_raw = cyanea_gbif$gbif$data$Aeshna_cyanea
juncea_raw = juncea_gbif$gbif$data$Aeshna_juncea

# number of records for aeshna cyanea
nrow(cyanea_raw)

# number of records for aeshna cyanea
nrow(juncea_raw)


# check colnames
colnames(cyanea_raw)
colnames(juncea_raw)

# replace rownames 
cyanea_raw[1] = rep(aeshna_cyanea, nrow(cyanea_raw))
juncea_raw[1] = rep(aeshna_juncea, nrow(juncea_raw))

# export row data
write.csv (cyanea_raw, file=paste0(path_processed_data, "aeshna_cyanea_occurences_raw_data_", format(Sys.time(), "%Y%m%d"), ".csv"), row.names=T)
write.csv (juncea_raw, file=paste0(path_processed_data, "aeshna_juncea_occurences_raw_data_", format(Sys.time(), "%Y%m%d"), ".csv"), row.names=T)

# check scientific name for synonyms
sort(unique(cyanea_raw$scientificName))
sort(unique(juncea_raw$scientificName))

# look at the accepted name
table(cyanea_raw$taxonomicStatus)
table(juncea_raw$taxonomicStatus)

# coordinate cleaning

# transform tibble into dataframe
cyanea_coord = as.data.frame(cyanea_raw[!is.na(cyanea_raw$latitude) & !is.na(cyanea_raw$longitude),])
juncea_coord = as.data.frame(juncea_raw[!is.na(juncea_raw$latitude) & !is.na(juncea_raw$longitude),])

# cleaning coordinates using clean_coordinates()
cyanea_clean = clean_coordinates(x=cyanea_coord, lon = "longitude" , lat = "latitude", species = "name", value = "clean")
juncea_clean = clean_coordinates(x=juncea_coord, lon = "longitude" , lat = "latitude", species = "name", value = "clean")

# number of clean occurrences
nrow(cyanea_clean)
nrow(juncea_clean)

# check df
sapply(cyanea_clean, class)
sapply(juncea_clean, class)

# unlist a list variable that can prevent .csv export
juncea_clean$networkKeys = unlist(juncea_clean$networkKeys)

# export clean data
write.csv (cyanea_clean, file=paste0(path_processed_data, "aeshna_cyanea_occurences_clean_data_", format(Sys.time(), "%Y%m%d"), ".csv"), row.names=T)
write.csv (juncea_clean, file=paste0(path_processed_data, "aeshna_juncea_occurences_clean_data_", format(Sys.time(), "%Y%m%d"), ".csv"), row.names=T)