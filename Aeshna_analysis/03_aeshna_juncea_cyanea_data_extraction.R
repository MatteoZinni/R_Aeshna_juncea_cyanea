#-----------------------------------------#
#   Studying phenology and environmental  #
# differences among two Aeshnidae species #
#     Aeshna cyanea and Aeshna juncea     #
#-----------------------------------------#

#-----------------------------------------#
#           03 DATA EXTRACTION            #
#-----------------------------------------#

# install required packages
install.packages("rgdal")
install.packages("raster")
install.packages("sp")

# load libraries
library(rgdal)
library(raster)
library(sp)

# set input path 
input_data_path_shape = "F:/Users/matte/Documents/data_science/data_science_r_projects/r_projects_Aeshna_juncea_cyanea/R_Aeshna_juncea_cyanea/Aeshna_data/Aeshna_data_base/shapes"
input_data_path_raster = "F:/Users/matte/Documents/data_science/data_science_r_projects/r_projects_Aeshna_juncea_cyanea/R_Aeshna_juncea_cyanea/Aeshna_data/Aeshna_data_base/rasters"

# set output path
path_output_data = "F:/https://github.com/MatteoZinni/R_Aeshna_juncea_cyanea/blob/master/Aeshna_analysis/01_aeshna_juncea_cyanea_occurences_download.R/r_projects_Aeshna_juncea_cyanea/R_Aeshna_juncea_cyanea/Aeshna_output/Aeshna_output_data/"

# load european countries boundaries shapefiles
europe_shapefile = "CNTR_BN_01M_2020_4326.shp"

# set name for rastes data
elevation = "alt_16.tif"
bio_01 = "bio1_16.tif"
bio_02 = "bio2_16.tif"
bio_03 = "bio3_16.tif"
bio_04 = "bio4_16.tif"
bio_05 = "bio5_16.tif"
bio_06 = "bio6_16.tif"
bio_07 = "bio7_16.tif"
bio_08 = "bio8_16.tif"
bio_09 = "bio9_16.tif"
bio_10 = "bio10_16.tif"
bio_11 = "bio11_16.tif"
bio_12 = "bio12_16.tif"
bio_13 = "bio13_16.tif"
bio_14 = "bio14_16.tif"
bio_15 = "bio15_16.tif"
bio_16 = "bio16_16.tif"
bio_17 = "bio17_16.tif"
bio_18 = "bio18_16.tif"
bio_19 = "bio19_16.tif"

# corine land cover
clc_2018 = "clc2018_clc2018_V2018.20b2.tif"

# calculate endDayofYear
aeshnid_df$endDayOfYear = strftime(aeshnid_df$eventDate, format = "%j")

# replace month variable with factor
aeshnid_df$Month = factor(aeshnid_df$month, levels=c(1,2,3,4,5,6,7,8,9,10,11,12), labels=c("Jan", "Feb", "Mar", "Apr", "May", "JUn", 
                                                                                           "Jul", "Ago", "Sep", "Oct", "Nov", "Dec"))     
# season: Early - Early, Early - Late, Mid - Early, Mid - Late, Late - Early, Late - Late
aeshnid_df$season = cut(aeshnid_df$day, breaks= 6, right = FALSE, labels = c("EE","EL", "ME", "ML", "LE", "LL"))

# load wordclim rasters: servers not available               
elevation_r =  raster(paste(input_data_path_raster,elevation, sep = "/"))

# load the full set of bioclim rasters: servers not available
AMT = raster(paste(input_data_path_raster,bio_01, sep = "/"))
MDR = raster(paste(input_data_path_raster,bio_02, sep = "/"))
ITh = raster(paste(input_data_path_raster,bio_03, sep = "/"))
TSe = raster(paste(input_data_path_raster,bio_04, sep = "/"))
maxTWaM = raster(paste(input_data_path_raster,bio_05, sep = "/"))
minTCoM = raster(paste(input_data_path_raster,bio_06, sep = "/"))
TAR  = raster(paste(input_data_path_raster,bio_07, sep = "/"))  
minTWQ = raster(paste(input_data_path_raster,bio_08, sep = "/"))
minTDrQ = raster(paste(input_data_path_raster,bio_09, sep = "/"))
MTWaQ = raster(paste(input_data_path_raster,bio_10, sep = "/"))
MTCoQ = raster(paste(input_data_path_raster,bio_11, sep = "/"))
Ara  = raster(paste(input_data_path_raster,bio_12, sep = "/"))
RaWeM  = raster(paste(input_data_path_raster,bio_13, sep = "/"))
RaDrM  = raster(paste(input_data_path_raster,bio_14, sep = "/"))
PSe  = raster(paste(input_data_path_raster,bio_15, sep = "/")) 
RaWeQ  = raster(paste(input_data_path_raster,bio_16, sep = "/")) 
RaDrQ  = raster(paste(input_data_path_raster,bio_17, sep = "/")) 
RaWaQ  = raster(paste(input_data_path_raster,bio_18, sep = "/")) 
RaCoQ  = raster(paste(input_data_path_raster,bio_19, sep = "/")) 

# load corine land cover IV level
clc  = raster(paste(input_data_path_raster,clc_2018, sep = "/")) 

# creating spatial points for data extraction
aeshnid_p <- SpatialPoints(aeshnid_df[,3:4], proj4string = elevation_r@crs)


# extract data from raster using extract from raster package 
# elevation data
aeshnid_elevation = extract(elevation_r,aeshnid_p)
aeshnid_df$elevation = aeshnid_elevation

# BIO1; annual mean temperature
aeshnid_df$amt = extract(AMT,aeshnid_p)
aeshnid_df$amt = aeshnid_df$amt/10

# BIO2; mean diurnal range
aeshnid_df$mdr = extract(MDR,aeshnid_p)
aeshnid_df$mdr = aeshnid_df$mdr/10

# BIO3; isothermality 
aeshnid_df$ist = extract(ITh,aeshnid_p)

# BIO4; Temperature Seasonality
aeshnid_df$tse = extract(TSe,aeshnid_p)
aeshnid_df$tse = aeshnid_df$tse/100

# BIO5: max temperature warmest month
aeshnid_df$maxtwam = extract(maxTWaM,aeshnid_p)
aeshnid_df$maxtwam = aeshnid_df$maxtwam/10

# BIO6 = Min Temperature of Coldest Month
aeshnid_df$mintcom = extract(minTCoM,aeshnid_p)
aeshnid_df$mintcom = aeshnid_df$mintcom/10

# BI07 = Temperature Annual Range (BIO5-BIO6)
aeshnid_df$tar = extract(TAR,aeshnid_p)
aeshnid_df$tar = aeshnid_df$tar/10  

# BIO8 = Mean Temperature of Wettest Quarter
aeshnid_df$mintwq = extract(minTWQ,aeshnid_p)
aeshnid_df$mintwq = aeshnid_df$mintwq/10  

# BIO9 = Mean Temperature of Driest Quarter
aeshnid_df$mintdrq = extract(minTDrQ,aeshnid_p)
aeshnid_df$mintdrq = aeshnid_df$mintdrq/10  

# BIO10 = Mean Temperature of Warmest Quarter
aeshnid_df$mtwaq = extract(MTWaQ,aeshnid_p)
aeshnid_df$mtwaq = aeshnid_df$mintdrq/10 

# BIO11 = Mean Temperature of Coldest Quarter
aeshnid_df$mtcoq = extract(MTCoQ,aeshnid_p)
aeshnid_df$mtcoq = aeshnid_df$mintdrq/10 

# BIO12 = Annual Precipitation
aeshnid_df$ara = extract(Ara,aeshnid_p)

# BIO13 = Precipitation of Wettest Month
aeshnid_df$rawem = extract(RaWeM,aeshnid_p)

# BIO14 = Precipitation of Driest Month
aeshnid_df$radrm = extract(RaDrM,aeshnid_p)

# BIO15 = Precipitation Seasonality (Coefficient of Variation)
aeshnid_df$pse = extract(PSe,aeshnid_p)

# BIO16 = Precipitation of Wettest Quarter
aeshnid_df$raweq = extract(RaWeQ,aeshnid_p)

# BIO17 = Precipitation of Driest Quarter
aeshnid_df$radrq = extract(RaDrQ,aeshnid_p)

# BIO18 = Precipitation of Warmest Quarter
aeshnid_df$rawaq = extract(RaDrQ,aeshnid_p)

# BIO19 = Precipitation of Coldest Quarter
aeshnid_df$racoq = extract(RaCoQ,aeshnid_p)

# corine land cover iv levels values
aeshnid_df$clc_values = extract(clc, aeshnid_p)

# corine land cover iv levels
aeshnid_df$clc_hab = factor(aeshnid_df$clc_values, names(table(clc_values)), label = c("CUF", "DUF", "ICU", "RRN", "GUA", "SLF","NIAL", "Vin", "FTP", "Pas", "CCP", "LSN", 
                                                                            "BLF", "CF", "MF", "NG", "MH", "TWS", "BR", "SVA","IM", "PB", "WC", "WB", "SO"))
# calculate De Martonne aridity index aridity index
aeshnid_df$ai = aeshnid_df$ara/(aeshnid_df$amt + 10)

# aridity index classification
aeshnid_df$ai_climate = cut(aeshnid_df$ai, breaks= c(15,24,30,35,40,50,60,187), right = FALSE, labels = c("SeAr", "MoAr","SlAr", "MoHu", "Hu", "VeHu", "ExHu")) 

# data s tructure
str(aeshnid_df)

# convert endDayOfYear as numeric
aeshnid_df$endDayOfYear = as.numeric(aeshnid_df$endDayOfYear)
                   
# last check on data

# looking for NAs in elevation
sum(is.na(aeshnid_df$elevation))

# remove negative numbers 
aeshnid_df = aeshnid_df[aeshnid_df$elevation > 0,]

# one last check to remove nas
aeshnid_df = aeshnid_df[rowSums(is.na(aeshnid_df)) != ncol(aeshnid_df),]

# export data 
write.csv (aeshnid_df, file=paste0(path_output_data, "aeshnid_df_", format(Sys.time(), "%Y%m%d"), ".csv"), row.names=T)
