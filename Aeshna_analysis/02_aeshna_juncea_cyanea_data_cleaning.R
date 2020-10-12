#-----------------------------------------#
#   Studying phenology and environmental  #
# differences among two Aeshnidae species #
#     Aeshna cyanea and Aeshna juncea     #
#-----------------------------------------#

#-----------------------------------------#
#           02 DATA CLEANING              #
#-----------------------------------------#

# install required packages
install.packages("CoordinateCleaner")

# load libraries
library(CoordinateCleaner)

# set output path
path_processed_data = "F:/Users/matte/Documents/data_science/data_science_r_projects/r_projects_Aeshna_juncea_cyanea/R_Aeshna_juncea_cyanea/Aeshna_data/Aeshna_data_processed/"
path_output_data = "F:/Users/matte/Documents/data_science/data_science_r_projects/r_projects_Aeshna_juncea_cyanea/R_Aeshna_juncea_cyanea/Aeshna_output/Aeshna_output_data/"

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

names(cyanea_clean)

# cleaning data that show to large coordinate uncertainty
cyanea_clean_01 = subset(cyanea_clean, cyanea_clean$coordinateUncertaintyInMeters < 1000)
juncea_clean_01 = subset(juncea_clean, juncea_clean$coordinateUncertaintyInMeters < 1000)

# check also if for coordinate uncertainty NAs are present 
sum(is.na(cyanea_clean_01$coordinateUncertaintyInMeters))
sum(is.na(juncea_clean_01$coordinateUncertaintyInMeters))

# export clean data
write.csv (cyanea_clean_01, file=paste0(path_processed_data, "aeshna_cyanea_occurences_clean_data_", format(Sys.time(), "%Y%m%d"), ".csv"), row.names=T)
write.csv (cyanea_clean_01, file=paste0(path_processed_data, "aeshna_juncea_occurences_clean_data_", format(Sys.time(), "%Y%m%d"), ".csv"), row.names=T)

# subset data to alpine region occurrences

# select countries
alpine_region <-c("Austria","Belgium", "France", "Germany", "Italy", "Luxembourg", "Netherlands", "Slovenia", "Switzerland ") 

# subset
aeshna_cyanea = cyanea_clean_01[cyanea_clean_01$country %in% alpine_region,]
aeshna_juncea = juncea_clean_01[juncea_clean_01$country %in% alpine_region,]

# latitudinal subsetting
aeshna_cyanea = subset(aeshna_cyanea, aeshna_cyanea$latitude > 43 & aeshna_cyanea$latitude < 48)
aeshna_juncea = subset(aeshna_juncea, aeshna_juncea$latitude > 43 & aeshna_juncea$latitude < 48)
         
# export data
write.csv (aeshna_cyanea, file=paste0(path_processed_data, "aeshna_cyanea_occurences_clean_data_", format(Sys.time(), "%Y%m%d"), ".csv"), row.names=T)
write.csv (aeshna_juncea, file=paste0(path_processed_data, "aeshna_juncea_occurences_clean_data_", format(Sys.time(), "%Y%m%d"), ".csv"), row.names=T)

# retain only variable useful for the project

# set of variables
variables_to_subset = c("name","scientificName", "longitude", "latitude", "elevation", "countryCode", "stateProvince", "day","month", "year", "eventDate", "endDayOfYear")

# subset
aeshna_cyanea <- aeshna_cyanea[variables_to_subset]
aeshna_juncea <- aeshna_juncea[variables_to_subset]

# finally merge the two df 
aeshnid_df = rbind(aeshna_cyanea,aeshna_juncea)

# rename first column
colnames(aeshnid_df)[1] = "species"

# export data
write.csv (aeshnid_df, file=paste0(path_processed_data, "aeshnid_df_clean_data_", format(Sys.time(), "%Y%m%d"), ".csv"), row.names=T)
write.csv (aeshnid_df, file=paste0(path_output_data, "aeshnid_df_clean_data_", format(Sys.time(), "%Y%m%d"), ".csv"), row.names=T)