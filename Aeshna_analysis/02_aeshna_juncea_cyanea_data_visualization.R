#-----------------------------------------#
#   Studying phenology and environmental  #
# differences among two Aeshnidae species #
#     Aeshna cyanea and Aeshna juncea     #
#-----------------------------------------#

#-----------------------------------------#
#  02 DATA VISUALIZATION CLEANING         #
#-----------------------------------------#

# install required packages
install.packages("CoordinateCleaner")
install.packages("leaflet")

# load libraries
library(leaflet)

# set input path 
input_data_path_shape = "F:/Users/matte/Documents/data_science/data_science_r_projects/r_projects_Aeshna_juncea_cyanea/R_Aeshna_juncea_cyanea/Aeshna_data/Aeshna_data_base/shapes"

# Create a palette that maps factor levels to colors
species_color <- colorFactor(c("darkolivegreen2", "deepskyblue2"), domain = c("A. cyanea", "A. juncea"))


aeshnid_map <- leaflet() %>% 
            addTiles() %>%
addMarkers(data = aeshnid_df, lng = ~longitude, lat = ~latitude, popup =  ~as.character(species), 
           label = ~as.character(species) ,clusterOptions = markerClusterOptions())

aeshnid_map

