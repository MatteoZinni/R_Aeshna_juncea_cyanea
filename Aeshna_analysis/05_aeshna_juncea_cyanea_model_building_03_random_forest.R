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

# load libraries
library(randomForest)
library(ggplot2)

# prepare data 
aeshnid_train_rf  = aeshnid_train
aeshnid_test_rf   = aeshnid_test
aeshnid_whole_rf  = aeshnid_df

# train data: replace Aeshna cyanea and Aeshna juncea with 0 and 1
aeshnid_train_rf$name = as.factor(aeshnid_train_rf$name)
aeshnid_test_rf$name = as.factor(aeshnid_test_rf$name)
aeshnid_whole_rf$name = as.factor(aeshnid_whole_rf$name)

# run the first model
rf_model_01 <- randomForest(name ~ longitude + latitude + elevation   + amt + maxtwam + tar + ara + pse  + ai, data = aeshnid_train_rf, importance = TRUE)
rf_model_01

# Predicting on train set
pred_rf_train_data <- predict(rf_model_01, aeshnid_train_rf, type = "class")

# Checking classification accuracy
table(pred_rf_train_data, aeshnid_train_rf$name)  

# Predicting on Validation set
pred_rf_test_data <- predict(rf_model_01, aeshnid_test_rf, type = "class")

# Checking classification accuracy
mean(pred_rf_test_data == aeshnid_test_rf$name)                    
table(pred_rf_test_data,aeshnid_test_rf$name)

#check important variables
importance(rf_model_01)        
varImpPlot(rf_model_01) 

# try to tune the model to achieve better accuracy 
rf_model_02 <- randomForest(name ~ longitude + latitude + elevation   + amt + maxtwam + tar + ara + pse  + ai, data = aeshnid_train_rf, ntree = 500, mtry = 5, importance = TRUE)

# Predicting on train set
pred_rf_train_data <- predict(rf_model_02, aeshnid_train_rf, type = "class")

# Checking classification accuracy
table(pred_rf_train_data, aeshnid_train_rf$name)  

# Predicting on Validation set
pred_rf_test_data <- predict(rf_model_02, aeshnid_test_rf, type = "class")

# Checking classification accuracy
mean(pred_rf_test_data == aeshnid_test_rf$name)                    
table(pred_rf_test_data,aeshnid_test_rf$name)

#check important variables
importance(rf_model_02)        
varImpPlot(rf_model_02) 

# plot random forest 
plot(rf_model_03)

hist(treesize(rf_model_02),col = "gray", main = "Number of nodes", xlab = "Nodes")

# tuning the model using a loop to identify the best mtry number
a=c()
i=9
for (i in 3:9) {
  rf_model_03 <- randomForest(name ~ longitude + latitude + elevation   + amt + maxtwam + tar + ara + pse  + ai, data = aeshnid_train_rf, ntree = 500, mtry = i, importance = TRUE)
  pred_rf_test_data_03 <- predict(rf_model_03, aeshnid_test_rf, type = "class")
  a[i-2] = mean(pred_rf_test_data_03 == aeshnid_test_rf$name)
}
a

plot(3:9,a)







