#-----------------------------------------#
#   Studying phenology and environmental  #
# differences among two Aeshnidae species #
#     Aeshna cyanea and Aeshna juncea     #
#-----------------------------------------#

#-----------------------------------------#
#         04 DATA VISUALIZATION           #
#-----------------------------------------#

# install required packages
install.packages("ggplot2")
install.packages("corrplot")

# load libraries
library(ggplot2)
library(corrplot)

# using custiom functions to calculate summary statistics
functions_folder = "F:/Users/matte/Documents/data_science/data_science_r_projects/r_projects_Aeshna_juncea_cyanea/R_Aeshna_juncea_cyanea/Aeshna_functions"

#  set OUTPUT path Tfigure folder
path_output_figs  = "F:/Users/matte/Documents/data_science/data_science_r_projects/r_projects_Aeshna_juncea_cyanea/R_Aeshna_juncea_cyanea/Aeshna_output/Aeshna_output_figs/"  


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
write.csv (cyanea_summary, file=paste0(path_processed_data, "aeshna_cyanea_summary_statistics_", format(Sys.time(), "%Y%m%d"), ".csv"), row.names=T)
write.csv (juncea_summary, file=paste0(path_processed_data, "aeshna_cyanea_summary_statistics_", format(Sys.time(), "%Y%m%d"), ".csv"), row.names=T)

# subset continuous variables
aeshnid_cont = aeshnid_df[,c(1,3,4,5,8,9,12,15:33,35,37)]

# 04.2 Qualitative variables

# month

# absolute frequencies
ggplot(as.data.frame(table(aeshnid_df$species, aeshnid_df$month)), aes(x= Var2 , y = Freq, fill=Var1 )) + 
  geom_bar(stat="identity") +
  scale_fill_manual(values=c("darkolivegreen2", "deepskyblue2")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurences by month",x="Month",y="Absolute frequencies")
theme(plot.title = element_text(hjust = 0.5))

# side by side
ggplot(as.data.frame(table(aeshnid_df$species, aeshnid_df$month)), aes(x= Var2 , y = Freq, fill=Var1 )) + 
  geom_bar(stat="identity",position = "dodge") +
  scale_fill_manual(values=c("darkolivegreen2", "deepskyblue2")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurences by month",x="Month",y="Absolute frequencies")+
  theme(plot.title = element_text(hjust = 0.5))

# relative frequencies
ggplot(as.data.frame(table(aeshnid_df$species, aeshnid_df$month)/length(aeshnid_df$species)), aes(x= Var2 , y = Freq, fill=Var1 )) + 
  geom_bar(stat="identity",position = "dodge") +
  scale_fill_manual(values=c("darkolivegreen2", "deepskyblue2")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurences by month",x="Month",y="Relative frequencies")+
  theme(plot.title = element_text(hjust = 0.5))

# relative percentage frequencies
ggplot(as.data.frame(table(aeshnid_df$species, aeshnid_df$month)/length(aeshnid_df$species)*100), aes(x= Var2 , y = Freq, fill=Var1 )) + 
  geom_bar(stat="identity",position = "dodge") +
  scale_fill_manual(values=c("darkolivegreen2", "deepskyblue2")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurences by month",x="Month",y="Relative frequencies")+
  theme(plot.title = element_text(hjust = 0.5))

# season

# absolute frequencies
ggplot(as.data.frame(table(aeshnid_df$species, aeshnid_df$season)), aes(x= Var2 , y = Freq, fill=Var1 )) + 
  geom_bar(stat="identity") +
  scale_fill_manual(values=c("darkolivegreen2", "deepskyblue2")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurences by season",x="Season",y="Absolute frequencies")
theme(plot.title = element_text(hjust = 0.5))

# side by side
ggplot(as.data.frame(table(aeshnid_df$species, aeshnid_df$season)), aes(x= Var2 , y = Freq, fill=Var1 )) + 
  geom_bar(stat="identity",position = "dodge") +
  scale_fill_manual(values=c("darkolivegreen2", "deepskyblue2")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurences by season",x="Season",y="Absolute frequencies")+
  theme(plot.title = element_text(hjust = 0.5))

# relative frequencies
ggplot(as.data.frame(table(aeshnid_df$species, aeshnid_df$season)/length(aeshnid_df$species)), aes(x= Var2 , y = Freq, fill=Var1 )) + 
  geom_bar(stat="identity",position = "dodge") +
  scale_fill_manual(values=c("darkolivegreen2", "deepskyblue2")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurences by season",x="Season",y="Relative frequencies")+
  theme(plot.title = element_text(hjust = 0.5))

# relative percentage frequencies
ggplot(as.data.frame(table(aeshnid_df$species, aeshnid_df$season)/length(aeshnid_df$species)*100), aes(x= Var2 , y = Freq, fill=Var1 )) + 
  geom_bar(stat="identity",position = "dodge") +
  scale_fill_manual(values=c("darkolivegreen2", "deepskyblue2")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurences by season",x="Season",y="Relative frequencies (%)")+
  theme(plot.title = element_text(hjust = 0.5))

# shifted length?

# corine land cover habitat

# absolute frequencies
ggplot(as.data.frame(table(aeshnid_df$species, aeshnid_df$clc_hab)), aes(x= Var2 , y = Freq, fill=Var1 )) + 
  geom_bar(stat="identity") +
  scale_fill_manual(values=c("darkolivegreen2", "deepskyblue2")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurences by clc_hab",x="Corine Land Cover Habitat",y="Absolute frequencies")
theme(plot.title = element_text(hjust = 0.5))

# side by side
ggplot(as.data.frame(table(aeshnid_df$species, aeshnid_df$clc_hab)), aes(x= Var2 , y = Freq, fill=Var1 )) + 
  geom_bar(stat="identity",position = "dodge") +
  scale_fill_manual(values=c("darkolivegreen2", "deepskyblue2")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurences by clc_hab",x="Corine Land Cover Habitat",y="Absolute frequencies")+
  theme(plot.title = element_text(hjust = 0.5))

# relative frequencies
ggplot(as.data.frame(table(aeshnid_df$species, aeshnid_df$clc_hab)/length(aeshnid_df$species)), aes(x= Var2 , y = Freq, fill=Var1 )) + 
  geom_bar(stat="identity",position = "dodge") +
  scale_fill_manual(values=c("darkolivegreen2", "deepskyblue2")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurences by clc_hab",x="Corine Land Cover Habitat",y="Relative frequencies")+
  theme(plot.title = element_text(hjust = 0.5))

# relative percentage frequencies
ggplot(as.data.frame(table(aeshnid_df$species, aeshnid_df$clc_hab)/length(aeshnid_df$species)*100), aes(x= Var2 , y = Freq, fill=Var1 )) + 
  geom_bar(stat="identity",position = "dodge") +
  scale_fill_manual(values=c("darkolivegreen2", "deepskyblue2")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurences by clc_hab",x="Corine Land Cover Habitat",y="Relative frequencies (%)")+
  theme(plot.title = element_text(hjust = 0.5))

# aridity index climate

# absolute frequencies
ggplot(as.data.frame(table(aeshnid_df$species, aeshnid_df$ai_climate)), aes(x= Var2 , y = Freq, fill=Var1 )) + 
  geom_bar(stat="identity") +
  scale_fill_manual(values=c("darkolivegreen2", "deepskyblue2")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurences by ai_climate",x="Corine Land Cover Habitat",y="Absolute frequencies")
theme(plot.title = element_text(hjust = 0.5))

# side by side
ggplot(as.data.frame(table(aeshnid_df$species, aeshnid_df$ai_climate)), aes(x= Var2 , y = Freq, fill=Var1 )) + 
  geom_bar(stat="identity",position = "dodge") +
  scale_fill_manual(values=c("darkolivegreen2", "deepskyblue2")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurences by ai_climate",x="Corine Land Cover Habitat",y="Absolute frequencies")+
  theme(plot.title = element_text(hjust = 0.5))

# relative frequencies
ggplot(as.data.frame(table(aeshnid_df$species, aeshnid_df$ai_climate)/length(aeshnid_df$species)), aes(x= Var2 , y = Freq, fill=Var1 )) + 
  geom_bar(stat="identity",position = "dodge") +
  scale_fill_manual(values=c("darkolivegreen2", "deepskyblue2")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurences by ai_climate",x="Corine Land Cover Habitat",y="Relative frequencies")+
  theme(plot.title = element_text(hjust = 0.5))

# relative percentage frequencies
ggplot(as.data.frame(table(aeshnid_df$species, aeshnid_df$ai_climate)/length(aeshnid_df$species)*100), aes(x= Var2 , y = Freq, fill=Var1 )) + 
  geom_bar(stat="identity",position = "dodge") +
  scale_fill_manual(values=c("darkolivegreen2", "deepskyblue2")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurences by ai_climate",x="Corine Land Cover Habitat",y="Relative frequencies (%)")+
  theme(plot.title = element_text(hjust = 0.5))



# 04.3 Quantitative variables

# boxplot of continuous variables

# make a vector to loop over
cont_var_list = names(aeshnid_cont[-1])

# start plot
for (i in cont_var_list) 
{
  tiff(file = paste0(path_output_figs,"aeshnid_bp_", i, ".tiff", sep=""), res=500, compression = "lzw", height=5, width=5, units="in")
  boxplot(aeshnid_cont[, i] ~ aeshnid_cont$species, drop = T,
          xaxt = "n",
          ylab = paste(i), las = 1,
          xlab = "Species",
          cex = 1.10,
          main = paste("A. cyanea and A. juncea \n", i))
  axis(1, at=1:2, labels= c("A. cyanea", "A. juncea"))
  dev.off()
}

# violin plot

# longitude
ggplot(aeshnid_cont, aes(x=species, y=longitude , fill = species)) + 
  geom_violin(trim=T, scale = "area")+
  scale_fill_manual(values=c("#bcee68", "#00B2EE"))+
  geom_boxplot(width=0.1, fill="white") +
  labs(fill = "Species")+
  labs(title = "A. cyanea and A. juncea occurences",x="Species",y="Longitude") +
  theme(plot.title = element_text(hjust = 0.5))

# latitude
ggplot(aeshnid_cont, aes(x=species, y=latitude , fill = species)) + 
  geom_violin(trim=T, scale = "area")+
  scale_fill_manual(values=c("#bcee68", "#00B2EE"))+
  geom_boxplot(width=0.1, fill="white") +
  labs(fill = "Species")+
  labs(title = "A. cyanea and A. juncea occurences",x="Species",y="Latitude") +
  theme(plot.title = element_text(hjust = 0.5))

# elevation
ggplot(aeshnid_cont, aes(x=species, y=elevation, fill = species)) + 
  geom_violin(trim=T, scale = "area")+
  scale_fill_manual(values=c("#bcee68", "#00B2EE"))+
  geom_boxplot(width=0.1, fill="white") +
  labs(fill = "Species")+
  labs(title = "A. cyanea and A. juncea occurences",x="Species",y="Elevation (m)") +
  theme(plot.title = element_text(hjust = 0.5))

# day
ggplot(aeshnid_cont, aes(x=species, y= day, fill = species)) + 
  geom_violin(trim=T, scale = "area")+
  scale_fill_manual(values=c("#bcee68", "#00B2EE"))+
  geom_boxplot(width=0.1, fill="white") +
  labs(fill = "Species")+
  labs(title = "A. cyanea and A. juncea occurences",x="Species",y="Day") +
  theme(plot.title = element_text(hjust = 0.5))

# month
ggplot(aeshnid_cont, aes(x=species, y= month, fill = species)) + 
  geom_violin(trim=T, scale = "area")+
  scale_fill_manual(values=c("#bcee68", "#00B2EE"))+
  geom_boxplot(width=0.1, fill="white") +
  labs(fill = "Species")+
  labs(title = "A. cyanea and A. juncea occurences",x="Species",y="Month") +
  theme(plot.title = element_text(hjust = 0.5))

# endDayOfYear  
ggplot(aeshnid_cont, aes(x=species, y=endDayOfYear, fill = species)) + 
  geom_violin(trim=T, scale = "area")+
  scale_fill_manual(values=c("#bcee68", "#00B2EE"))+
  geom_boxplot(width=0.1, fill="white") +
  labs(fill = "Species")+
  labs(title = "A. cyanea and A. juncea occurences",x="Species",y="Day of the Year") +
  theme(plot.title = element_text(hjust = 0.5))

# amt
ggplot(aeshnid_cont, aes(x=species, y=amt, fill = species)) + 
  geom_violin(trim=T, scale = "area")+
  scale_fill_manual(values=c("#bcee68", "#00B2EE"))+
  geom_boxplot(width=0.1, fill="white") +
  labs(fill = "Species")+
  labs(title = "A. cyanea and A. juncea occurences",x="Species",y="Annual mean temperature") +
  theme(plot.title = element_text(hjust = 0.5))

# mean diurnal range
ggplot(aeshnid_cont, aes(x=species, y=mdr, fill = species)) + 
  geom_violin(trim=T, scale = "area")+
  scale_fill_manual(values=c("#bcee68", "#00B2EE"))+
  geom_boxplot(width=0.1, fill="white") +
  labs(fill = "Species")+
  labs(title = "A. cyanea and A. juncea occurences",x="Species",y="Mean diurnal range") +
  theme(plot.title = element_text(hjust = 0.5))

# isothermality
ggplot(aeshnid_cont, aes(x=species, y=ist, fill = species)) + 
  geom_violin(trim=T, scale = "area")+
  scale_fill_manual(values=c("#bcee68", "#00B2EE"))+
  geom_boxplot(width=0.1, fill="white") +
  labs(fill = "Species")+
  labs(title = "A. cyanea and A. juncea occurences",x="Species",y="Isothermality") +
  theme(plot.title = element_text(hjust = 0.5))

# temperature seasonality
ggplot(aeshnid_cont, aes(x=species, y=tse, fill = species)) + 
  geom_violin(trim=T, scale = "area")+
  scale_fill_manual(values=c("#bcee68", "#00B2EE"))+
  geom_boxplot(width=0.1, fill="white") +
  labs(fill = "Species")+
  labs(title = "A. cyanea and A. juncea occurences",x="Species",y="Temperature seasonality") +
  theme(plot.title = element_text(hjust = 0.5))

# Max temperature of the warmest month
ggplot(aeshnid_cont, aes(x=species, y=maxtwam, fill = species)) + 
  geom_violin(trim=T, scale = "area")+
  scale_fill_manual(values=c("#bcee68", "#00B2EE"))+
  geom_boxplot(width=0.1, fill="white") +
  labs(fill = "Species")+
  labs(title = "A. cyanea and A. juncea occurences",x="Species",y="Max temperature of the warmest month") +
  theme(plot.title = element_text(hjust = 0.5))

# Min temperature of the coldest month
ggplot(aeshnid_cont, aes(x=species, y=mintcom , fill = species)) + 
  geom_violin(trim=T, scale = "area")+
  scale_fill_manual(values=c("#bcee68", "#00B2EE"))+
  geom_boxplot(width=0.1, fill="white") +
  labs(fill = "Species")+
  labs(title = "A. cyanea and A. juncea occurences",x="Species",y="Min temperature of the coldest month") +
  theme(plot.title = element_text(hjust = 0.5))

# Temperature annual range
ggplot(aeshnid_cont, aes(x=species, y=tar , fill = species)) + 
  geom_violin(trim=T, scale = "area")+
  scale_fill_manual(values=c("#bcee68", "#00B2EE"))+
  geom_boxplot(width=0.1, fill="white") +
  labs(fill = "Species")+
  labs(title = "A. cyanea and A. juncea occurences",x="Species",y="Temperature annual range") +
  theme(plot.title = element_text(hjust = 0.5))

# Min temperature of wettest quarter
ggplot(aeshnid_cont, aes(x=species, y=mintwq  , fill = species)) + 
  geom_violin(trim=T, scale = "area")+
  scale_fill_manual(values=c("#bcee68", "#00B2EE"))+
  geom_boxplot(width=0.1, fill="white") +
  labs(fill = "Species")+
  labs(title = "A. cyanea and A. juncea occurences",x="Species",y="Min temperature of wettest quarter") +
  theme(plot.title = element_text(hjust = 0.5))

# Min temperature of the driest quarter
ggplot(aeshnid_cont, aes(x=species, y=mintdrq  , fill = species)) + 
  geom_violin(trim=T, scale = "area")+
  scale_fill_manual(values=c("#bcee68", "#00B2EE"))+
  geom_boxplot(width=0.1, fill="white") +
  labs(fill = "Species")+
  labs(title = "A. cyanea and A. juncea occurences",x="Species",y="Min temperature of the driest quarter") +
  theme(plot.title = element_text(hjust = 0.5))

# Min temperature of the warmest quarter
ggplot(aeshnid_cont, aes(x=species, y=mintdrq   , fill = species)) + 
  geom_violin(trim=T, scale = "area")+
  scale_fill_manual(values=c("#bcee68", "#00B2EE"))+
  geom_boxplot(width=0.1, fill="white") +
  labs(fill = "Species")+
  labs(title = "A. cyanea and A. juncea occurences",x="Species",y="Min temperature of the warmest quarter") +
  theme(plot.title = element_text(hjust = 0.5))

# Min temperature of the coldest quarter
ggplot(aeshnid_cont, aes(x=species, y=mtcoq     , fill = species)) + 
  geom_violin(trim=T, scale = "area")+
  scale_fill_manual(values=c("#bcee68", "#00B2EE"))+
  geom_boxplot(width=0.1, fill="white") +
  labs(fill = "Species")+
  labs(title = "A. cyanea and A. juncea occurences",x="Species",y="Min temperature of the coldest quarter") +
  theme(plot.title = element_text(hjust = 0.5))

# Annual rainfall
ggplot(aeshnid_cont, aes(x=species, y=ara, fill = species)) + 
  geom_violin(trim=T, scale = "area")+
  scale_fill_manual(values=c("#bcee68", "#00B2EE"))+
  geom_boxplot(width=0.1, fill="white") +
  labs(fill = "Species")+
  labs(title = "A. cyanea and A. juncea occurences",x="Species",y="Annual Rainfall (mm)") +
  theme(plot.title = element_text(hjust = 0.5))

# Precipitation of the wettest month
ggplot(aeshnid_cont, aes(x=species, y=rawem, fill = species)) + 
  geom_violin(trim=T, scale = "area")+
  scale_fill_manual(values=c("#bcee68", "#00B2EE"))+
  geom_boxplot(width=0.1, fill="white") +
  labs(fill = "Species")+
  labs(title = "A. cyanea and A. juncea occurences",x="Species",y="Precipitation of the wettest month") +
  theme(plot.title = element_text(hjust = 0.5))

# Precipitation of the driest month
ggplot(aeshnid_cont, aes(x=species, y=radrm, fill = species)) + 
  geom_violin(trim=T, scale = "area")+
  scale_fill_manual(values=c("#bcee68", "#00B2EE"))+
  geom_boxplot(width=0.1, fill="white") +
  labs(fill = "Species")+
  labs(title = "A. cyanea and A. juncea occurences",x="Species",y="Precipitation of the driest month") +
  theme(plot.title = element_text(hjust = 0.5))

# Precipitation seasonality
ggplot(aeshnid_cont, aes(x=species, y=pse, fill = species)) + 
  geom_violin(trim=T, scale = "area")+
  scale_fill_manual(values=c("#bcee68", "#00B2EE"))+
  geom_boxplot(width=0.1, fill="white") +
  labs(fill = "Species")+
  labs(title = "A. cyanea and A. juncea occurences",x="Species",y="Precipitation seasonality (CV)") +
  theme(plot.title = element_text(hjust = 0.5))

# Precipitation of the wettest quarter
ggplot(aeshnid_cont, aes(x=species, y=raweq, fill = species)) + 
  geom_violin(trim=T, scale = "area")+
  scale_fill_manual(values=c("#bcee68", "#00B2EE"))+
  geom_boxplot(width=0.1, fill="white") +
  labs(fill = "Species")+
  labs(title = "A. cyanea and A. juncea occurences",x="Species",y="Precipitation of the wettest quarter") +
  theme(plot.title = element_text(hjust = 0.5))

# Precipitation of the driest quarter
ggplot(aeshnid_cont, aes(x=species, y=radrq, fill = species)) + 
  geom_violin(trim=T, scale = "area")+
  scale_fill_manual(values=c("#bcee68", "#00B2EE"))+
  geom_boxplot(width=0.1, fill="white") +
  labs(fill = "Species")+
  labs(title = "A. cyanea and A. juncea occurences",x="Species",y="Precipitation of the driest quarter") +
  theme(plot.title = element_text(hjust = 0.5))

# Precipitation of the warmest quarter
ggplot(aeshnid_cont, aes(x=species, y=rawaq , fill = species)) + 
  geom_violin(trim=T, scale = "area")+
  scale_fill_manual(values=c("#bcee68", "#00B2EE"))+
  geom_boxplot(width=0.1, fill="white") +
  labs(fill = "Species")+
  labs(title = "A. cyanea and A. juncea occurences",x="Species",y="Precipitation of the warmest quarter") +
  theme(plot.title = element_text(hjust = 0.5))

# Precipitation of the coldest quarter
ggplot(aeshnid_cont, aes(x=species, y=rawaq , fill = species)) + 
  geom_violin(trim=T, scale = "area")+
  scale_fill_manual(values=c("#bcee68", "#00B2EE"))+
  geom_boxplot(width=0.1, fill="white") +
  labs(fill = "Species")+
  labs(title = "A. cyanea and A. juncea occurences",x="Species",y="Precipitation of the coldest quarter") +
  theme(plot.title = element_text(hjust = 0.5))

# Aridity index
ggplot(aeshnid_cont, aes(x=species, y= ai , fill = species)) + 
  geom_violin(trim=T, scale = "area")+
  scale_fill_manual(values=c("#bcee68", "#00B2EE"))+
  geom_boxplot(width=0.1, fill="white") +
  labs(fill = "Species")+
  labs(title = "A. cyanea and A. juncea occurences",x="Species",y="Aridity index") +
  theme(plot.title = element_text(hjust = 0.5))

# clc values
ggplot(aeshnid_cont, aes(x=species, y= clc_values , fill = species)) + 
  geom_violin(trim=T, scale = "area")+
  scale_fill_manual(values=c("#bcee68", "#00B2EE"))+
  geom_boxplot(width=0.1, fill="white") +
  labs(fill = "Species")+
  labs(title = "A. cyanea and A. juncea occurences",x="Species",y="Corine Land Cover values") +
  theme(plot.title = element_text(hjust = 0.5))

# kernel density plot

# Longitude
ggplot(aeshnid_df, aes(x=longitude, fill=species)) + geom_density(alpha=0.7) +
  scale_fill_manual(values=c("#bcee68", "#00B2EE")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurence",x="Longitude",y="Density")

# Latitude
ggplot(aeshnid_df, aes(x=latitude, fill=species)) + geom_density(alpha=0.7) +
  scale_fill_manual(values=c("#bcee68", "#00B2EE")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurence",x="Latitude",y="Density")

# Elevation
ggplot(aeshnid_df, aes(x=elevation , fill=species)) + geom_density(alpha=0.7) +
  scale_fill_manual(values=c("#bcee68", "#00B2EE")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurence",x="Elevation",y="Density")

# Day
ggplot(aeshnid_df, aes(x=day , fill=species)) + geom_density(alpha=0.7) +
  scale_fill_manual(values=c("#bcee68", "#00B2EE")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurence",x="Day",y="Density")

# Month
ggplot(aeshnid_df, aes(x=month , fill=species)) + geom_density(alpha=0.7) +
  scale_fill_manual(values=c("#bcee68", "#00B2EE")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurence",x="Month",y="Density")

# Day of the Year
ggplot(aeshnid_df, aes(x=endDayOfYear  , fill=species)) + geom_density(alpha=0.7) +
  scale_fill_manual(values=c("#bcee68", "#00B2EE")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurence",x="Day of the Year",y="Density") 

# Annual Mean Temperature
ggplot(aeshnid_df, aes(x=amt   , fill=species)) + geom_density(alpha=0.7) +
  scale_fill_manual(values=c("#bcee68", "#00B2EE")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurence",x="Annual Mean Temperature",y="Density") 

# Mean diurnal range
ggplot(aeshnid_df, aes(x=mdr    , fill=species)) + geom_density(alpha=0.7) +
  scale_fill_manual(values=c("#bcee68", "#00B2EE")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurence",x="Mean diurnal range",y="Density") 

# Isothermality
ggplot(aeshnid_df, aes(x=ist     , fill=species)) + geom_density(alpha=0.7) +
  scale_fill_manual(values=c("#bcee68", "#00B2EE")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurence",x="Isothermality",y="Density") 

# Temperature seasonality
ggplot(aeshnid_df, aes(x=tse     , fill=species)) + geom_density(alpha=0.7) +
  scale_fill_manual(values=c("#bcee68", "#00B2EE")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurence",x="Temperature seasonality",y="Density") 

# Max temperature of the warmest month
ggplot(aeshnid_df, aes(x=maxtwam     , fill=species)) + geom_density(alpha=0.7) +
  scale_fill_manual(values=c("#bcee68", "#00B2EE")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurence",x=" Max temperature of the warmest month",y="Density")

# Max temperature Warmest month
ggplot(aeshnid_df, aes(x=maxtwam, fill=species)) + geom_density(alpha=0.7) +
  scale_fill_manual(values=c("#bcee68", "#00B2EE")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurence",x="Max temperature Warmest month",y="Density") 

# Min temperature coldest month
ggplot(aeshnid_df, aes(x=mintcom, fill=species)) + geom_density(alpha=0.7) +
  scale_fill_manual(values=c("#bcee68", "#00B2EE")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurence",x="Min temperature coldest month",y="Density") 

# Annual Temperature Range
ggplot(aeshnid_df, aes(x=tar, fill=species)) + geom_density(alpha=0.7) +
  scale_fill_manual(values=c("#bcee68", "#00B2EE")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurence",x="Annual Temperature Range",y="Density") 

# Min temperature wettest quarter
ggplot(aeshnid_df, aes(x=mintwq, fill=species)) + geom_density(alpha=0.7) +
  scale_fill_manual(values=c("#bcee68", "#00B2EE")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurence",x="Min temperature wettest quarter",y="Density")

# Min temperature driest quarter
ggplot(aeshnid_df, aes(x=mintdrq, fill=species)) + geom_density(alpha=0.7) +
  scale_fill_manual(values=c("#bcee68", "#00B2EE")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurence",x="Min temperature driest quarter",y="Density")

# Mean temperature warmest quarter
ggplot(aeshnid_df, aes(x=mtwaq , fill=species)) + geom_density(alpha=0.7) +
  scale_fill_manual(values=c("#bcee68", "#00B2EE")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurence",x="Mean temperature warmest quarter",y="Density")

# Mean temperature coldest quarter
ggplot(aeshnid_df, aes(x=mtcoq , fill=species)) + geom_density(alpha=0.7) +
  scale_fill_manual(values=c("#bcee68", "#00B2EE")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurence",x="Mean temperature coldest quarter",y="Density")

# Annual rainfall
ggplot(aeshnid_df, aes(x=ara, fill=species)) + geom_density(alpha=0.7) +
  scale_fill_manual(values=c("#bcee68", "#00B2EE")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurence",x="Annual rainfall",y="Density") 

# Precipitation  of the wettest month
ggplot(aeshnid_df, aes(x=rawem, fill=species)) + geom_density(alpha=0.7) +
  scale_fill_manual(values=c("#bcee68", "#00B2EE")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurence",x="Precipitation  of the wettest month",y="Density") 

# Precipitation  of the driest month
ggplot(aeshnid_df, aes(x=radrm, fill=species)) + geom_density(alpha=0.7) +
  scale_fill_manual(values=c("#bcee68", "#00B2EE")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurence",x="Precipitation  of the wettest month",y="Density") 

# Precipitation Seasonality (CV)
ggplot(aeshnid_df, aes(x=pse, fill=species)) + geom_density(alpha=0.7) +
  scale_fill_manual(values=c("#bcee68", "#00B2EE")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurence",x="Precipitation Seasonality (CV)",y="Density") 

# Precipitation of the wettest quarter
ggplot(aeshnid_df, aes(x=raweq, fill=species)) + geom_density(alpha=0.7) +
  scale_fill_manual(values=c("#bcee68", "#00B2EE")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurence",x="Precipitation of the wettest quarter",y="Density")

# Precipitation of the driest quarter
ggplot(aeshnid_df, aes(x=radrq , fill=species)) + geom_density(alpha=0.7) +
  scale_fill_manual(values=c("#bcee68", "#00B2EE")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurence",x="Precipitation of the driest quarter",y="Density")

# Precipitation of the warmest quarter
ggplot(aeshnid_df, aes(x=radrq , fill=species)) + geom_density(alpha=0.7) +
  scale_fill_manual(values=c("#bcee68", "#00B2EE")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurence",x="Precipitation of the warmest quarter",y="Density")

# Precipitation of the coldest quarter
ggplot(aeshnid_df, aes(x=racoq  , fill=species)) + geom_density(alpha=0.7) +
  scale_fill_manual(values=c("#bcee68", "#00B2EE")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurence",x="Precipitation of the coldest quarter",y="Density")

# Aridity index
ggplot(aeshnid_df, aes(x=ai   , fill=species)) + geom_density(alpha=0.7) +
  scale_fill_manual(values=c("#bcee68", "#00B2EE")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurence",x="Aridity index",y="Density")

# Corine land cover values
ggplot(aeshnid_df, aes(x=clc_values   , fill=species)) + geom_density(alpha=0.7) +
  scale_fill_manual(values=c("#bcee68", "#00B2EE")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "A. cyanea and A. juncea occurence",x="Corine land cover values",y="Density")

# correlogramm
# calculate correlation matrix with customized funtion
p_mat_aeshnid_cont <- corr_m_test(aeshnid_cont[,-1])

# customize corrplot color palette
col <- colorRampPalette(c("#BB4444", "#EE9988", "#FFFFFF", "#77AADD", "#4477AA"))

# export correlogram
tiff(file = paste0(path_output_figs,"aeshnid_continuos_", ".tiff", sep=""), res=500, compression = "lzw", height=15, width=15, units="in")
aeshnid_cont_corrplot = corrplot(aeshnid_cont_cor, method="color", col=col(200),  
                                 type="upper", order="hclust", 
                                 addCoef.col = "black", # Add coefficient of correlation
                                 tl.col="black", tl.srt=45, #Text label color and rotation
                                 # Combine with significance
                                 p.mat = p_mat_aeshnid_cont, sig.level = 0.01, insig = "blank", 
                                 # hide correlation coefficient on the principal diagonal
                                 diag=FALSE)
mtext("A. cyanea and A. juncea \n Environmental continuous variables", at=5.5, line=- -1, cex=1.5)
box(which = "outer", lty = "solid", lwd=3)
dev.off()