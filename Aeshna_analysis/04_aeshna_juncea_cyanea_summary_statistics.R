#-----------------------------------------#
#   Studying phenology and environmental  #
# differences among two Aeshnidae species #
#     Aeshna cyanea and Aeshna juncea     #
#-----------------------------------------#

#-----------------------------------------#
#         04 DESCRIPTIVE STATISTICS       #
#-----------------------------------------#

# install required packages
install.packages("ggplot2")
install.packages("corrplot")

# load libraries
library(ggplot2)
library(corrplot)

# using custiom functions to calculate summary statistics
functions_folder = "F:/Users/matte/Documents/data_science/data_science_r_projects/r_projects_Aeshna_juncea_cyanea/R_Aeshna_juncea_cyanea/Aeshna_functions"

# set output path
path_output_data = "F:/Users/matte/Documents/data_science/data_science_r_projects/r_projects_Aeshna_juncea_cyanea/R_Aeshna_juncea_cyanea/Aeshna_output/Aeshna_output_data/"

# sourcing functions
source(paste(functions_folder, "aeshna_juncea_cyanea_functions.R", sep = '/'))

# data size
dim(aeshnid_df)

# data structure
str(aeshnid_df)

# check variable class
sapply(aeshnid_df,class)

# 04. 1 summary statistics of continuous variables with custom functions
cyanea_summary = round(t(apply(subset(aeshnid_df[,c(3,4,5,8,9,15:33,35,37)],aeshnid_df$species == "Aeshna cyanea"), 2, enhanced_summary)),2)
juncea_summary = round(t(apply(subset(aeshnid_df[,c(3,4,5,8,9,15:33,35,37)],aeshnid_df$species == "Aeshna juncea"), 2, enhanced_summary)),2)

names(aeshnid_df)

# export summary statistics 
write.csv (cyanea_summary, file=paste0(path_output_data, "aeshna_cyanea_summary_statistics_", format(Sys.time(), "%Y%m%d"), ".csv"), row.names=T)
write.csv (juncea_summary, file=paste0(path_output_data, "aeshna_cyanea_summary_statistics_", format(Sys.time(), "%Y%m%d"), ".csv"), row.names=T)

# correlations among variables
aeshnid_df_cor = round(cor(aeshnid_df[,c(3,4,5,8,9,12,15:34,36)], method = "spearman"),2)

# export summary statistics 
write.csv (aeshnid_cont_cor, file=paste0(path_output_data, "aeshnid_spearman_correlations_", format(Sys.time(), "%Y%m%d"), ".csv"), row.names=T)