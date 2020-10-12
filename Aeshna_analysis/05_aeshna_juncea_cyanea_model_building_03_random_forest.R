#-----------------------------------------#
#   Studying phenology and environmental  #
# differences among two Aeshnidae species #
#     Aeshna cyanea and Aeshna juncea     #
#-----------------------------------------#

#-----------------------------------------#
# 05.1  MODEL BUILDING: RANDOM FOREST     #
#-----------------------------------------#

# install required packages
install.packages("randomForest")
install.packages("ggplot2")

# load libraries
library(randomForest)
library(ggplot2)

# set output path
path_output_data = "F:/mypath/r_projects_Aeshna_juncea_cyanea/R_Aeshna_juncea_cyanea/Aeshna_output/Aeshna_output_data/"

# prepare data 
aeshnid_train_rf  = aeshnid_train
aeshnid_test_rf   = aeshnid_test
aeshnid_whole_rf  = aeshnid_df

# train data: replace Aeshna cyanea and Aeshna juncea with 0 and 1
aeshnid_train_rf$species = as.factor(aeshnid_train_rf$species)
aeshnid_test_rf$species = as.factor(aeshnid_test_rf$species)
aeshnid_whole_rf$species = as.factor(aeshnid_whole_rf$species)

# run the first model
rf_model_01 <- randomForest(species ~ longitude + latitude + mdr   + maxtwam + mintdrq + rawem + radrm + pse  + radrq + ai, data = aeshnid_train_rf, importance = TRUE)
rf_model_01

# Predicting on train set
pred_rf_train_data <- predict(rf_model_01, aeshnid_train_rf, type = "class")

# Checking classification accuracy
table(pred_rf_train_data, aeshnid_train_rf$species)  

# Predicting on Validation set
pred_rf_test_data <- predict(rf_model_01, aeshnid_test_rf, type = "class")

# Checking classification accuracy
mean(pred_rf_test_data == aeshnid_test_rf$species)                    
table(pred_rf_test_data,aeshnid_test_rf$species)

#check important variables
importance(rf_model_01)        
varImpPlot(rf_model_01) 

# try to tune the model to achieve better accuracy 
rf_model_02 <- randomForest(species ~ longitude + latitude + mdr   + maxtwam + mintdrq + rawem + radrm + pse  + radrq + ai, data = aeshnid_train_rf, ntree = 500, mtry = 5, importance = TRUE)

# Predicting on train set
pred_rf_train_data <- predict(rf_model_02, aeshnid_train_rf, type = "class")

# Checking classification accuracy
table(pred_rf_train_data, aeshnid_train_rf$species)  

# Predicting on Validation set
pred_rf_test_data <- predict(rf_model_02, aeshnid_test_rf, type = "class")

# Checking classification accuracy
mean(pred_rf_test_data == aeshnid_test_rf$species)                    
table(pred_rf_test_data,aeshnid_test_rf$species)

#check important variables

importance(rf_model_02)

png(file = paste0(path_output_figs,"aeshnid_rf_important_var", ".png", sep=""), res=500, height=5, width=5, units="in")
varImpPlot(rf_model_02, main = "Random forest algorithm \n mtry = 5") 
dev.off()

# plot random forest 
plot(rf_model_03)

png(file = paste0(path_output_figs,"aeshnid_rf_nodes", ".png", sep=""), res=500, height=5, width=5, units="in")
hist(treesize(rf_model_02),col = "gray", main = "Number of nodes", xlab = "Nodes")
dev.off()

# tuning the model using a loop to identify the best mtry number
a=c()
i=9
for (i in 3:9) {
  rf_model_03 <- randomForest(species ~ longitude + latitude + mdr   + maxtwam + mintdrq + rawem + radrm + pse  + radrq + ai, data = aeshnid_train_rf, ntree = 500, mtry = i, importance = TRUE)
  pred_rf_test_data_03 <- predict(rf_model_03, aeshnid_test_rf, type = "class")
  a[i-2] = mean(pred_rf_test_data_03 == aeshnid_test_rf$species)
}
a

plot(3:9,a)
