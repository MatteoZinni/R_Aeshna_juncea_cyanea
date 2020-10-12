#-----------------------------------------#
#   Studying phenology and environmental  #
# differences among two Aeshnidae species #
#     Aeshna cyanea and Aeshna juncea     #
#-----------------------------------------#

#-----------------------------------------#
# 05.1      MODEL BUILDING: LDA           #
#-----------------------------------------#

# install required packages
install.packages("MASS")
install.packages("ggplot2")

# load libraries
library(MASS)
library(ggplot2)

# using custiom functions to calculate summary statistics
functions_folder = "F:/Users/matte/Documents/data_science/data_science_r_projects/r_projects_Aeshna_juncea_cyanea/R_Aeshna_juncea_cyanea/Aeshna_functions"

# set output path
path_output_data = "F:/Users/matte/Documents/data_science/data_science_r_projects/r_projects_Aeshna_juncea_cyanea/R_Aeshna_juncea_cyanea/Aeshna_output/Aeshna_output_data/"

# set output path to figure folder
path_output_figs  = "F:/Users/matte/Documents/data_science/data_science_r_projects/r_projects_Aeshna_juncea_cyanea/R_Aeshna_juncea_cyanea/Aeshna_output/Aeshna_output_figs/"  


# split data into two df: train and test
nrow(aeshnid_df)

nrow(subset(aeshnid_df,aeshnid_df$species == "Aeshna cyanea"))

nrow(subset(aeshnid_df,aeshnid_df$species == "Aeshna juncea"))

#  lets randomly sample equal number of  observation of Aeshna juncea and Aeshna cyanea  to have equal size dfs
cyanea_sample = subset(aeshnid_df,aeshnid_df$species == "Aeshna cyanea")
juncea_sample = subset(aeshnid_df,aeshnid_df$species == "Aeshna juncea")[sample(nrow(subset(aeshnid_df,aeshnid_df$species == "Aeshna juncea")), 184), ]


# deletion of highly correlated variables
sample_data_correlation = round(cor(aeshnid_df[, c(5,8,9,12,15:34,36)], method = "spearman"),2)
sample_data_correlation[upper.tri(sample_data_correlation)] <- 0
diag(sample_data_correlation) <- 0

# subsetting high correlated variables from dfs
cyanea_sample_01 = cbind(cyanea_sample[,1:4], cyanea_sample[,5:37][,!apply(sample_data_correlation,2,function(x) any(abs(x) > 0.70))])
juncea_sample_01 = cbind(juncea_sample[,1:4], juncea_sample[,5:37][,!apply(sample_data_correlation,2,function(x) any(abs(x) > 0.70))])

# build df made by the two species
aeshnid_sample = rbind(cyanea_sample_01,juncea_sample_01)
aeshnid_sample = aeshnid_sample[,-c(2)]

# we will keep 110 observation (60%) for each species to train the model
cyanea_train = subset(aeshnid_sample, aeshnid_sample$species == "Aeshna cyanea")
juncea_train = subset(aeshnid_sample, aeshnid_sample$species == "Aeshna juncea")

# randomly extract train data
cyanea_train_01 = cyanea_train[sample(nrow(cyanea_train), 110), ]
juncea_train_01 = juncea_train[sample(nrow(juncea_train), 110), ]

# build train dataset
aeshnid_train = rbind(cyanea_train_01,juncea_train_01)

# subset test data
cyanea_test = subset(aeshnid_sample, aeshnid_sample$species == "Aeshna cyanea")[ !(cyanea_train %in% subset(aeshnid_sample, aeshnid_sample$species == "Aeshna cyanea")), ]
juncea_test = subset(aeshnid_sample, aeshnid_sample$species == "Aeshna juncea")[ !(cyanea_train %in% subset(aeshnid_sample, aeshnid_sample$species == "Aeshna juncea")), ]

# build test dataset
aeshnid_test = rbind(cyanea_test,juncea_test)

# run the model
lda_model_1 <- lda(species  ~ longitude + latitude + mdr  + maxtwam + mintdrq  + rawem  + radrm + pse + radrq + ai, data = aeshnid_train )
summary(lda_model_1)

# Validate result using the test data set and the whole dataset 
prediction_train <- predict(lda_model_1, aeshnid_train)$class
prediction_test <- predict(lda_model_1,aeshnid_test)$class
prediction_whole <- predict(lda_model_1,aeshnid_df)$class

#accuracy on training data
mean(prediction_train == aeshnid_train$species)

#accuracy on test data
mean(prediction_test == aeshnid_test$species)

# accuracy on whole data set     
mean(prediction_whole == aeshnid_df$species)

# build lda to plot output
lda_data = data.frame(aeshnid_train$species, predict(lda_model_1)$x)

# plot LDA 
aeshnid_lda_plot = ggplot(lda_data, aes(x=LD1, fill=aeshnid_train.species)) + 
  geom_histogram(alpha=0.7, color="black") +
  scale_fill_manual(values=c("#bcee68", "#00B2EE")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "Linear discriminat analysis",x="LD 1",y="") +
  #geom_segment(aes(x = -1.022467, y = 0, xend = -1.022467, yend = 45), size = 1, linetype="twodash") +
  #geom_segment(aes(x = 1.022467, y = 0, xend = 1.022467, yend = 45), size = 1, linetype="twodash") +
  theme(plot.title = element_text(hjust = 0.5))+
  annotate(label ="Acc. on training data = 0.85 \nAcc. on test data = 0.82 \nAcc. on whole data = 0.82 ",
   geom = "text", x = -5, y = 40, size = 4,hjust = 0) +
  annotate(geom = "rect", xmin = -5.10, xmax = -3, ymin = 37, ymax = 43, linetype = 1, color = "Grey20", fill = "NA") +
  geom_segment(aes(x = -0.07122065, y = 0, xend = -0.07122065, yend = 45), size = 1, linetype="twodash") 

ggsave(paste0(path_output_figs,"aeshnid_lda_barplot", ".png", sep=""), plot = aeshnid_lda_plot, device = NULL, path = NULL,
       scale = 1, width = 12, height = 12, dpi = 1000, limitsize = TRUE, units = "in")
