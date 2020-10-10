#-----------------------------------------#
#   Studying phenology and environmental  #
# differences among two Aeshnidae species #
#     Aeshna cyanea and Aeshna juncea     #
#-----------------------------------------#

#-----------------------------------------#
# 05.1 MODEL BUILDING: LOGISTI REGRESSION #
#-----------------------------------------#

# prepare data for logistic regression
aeshnid_train_log  = aeshnid_train
aeshnid_test_log   = aeshnid_test
aeshnid_whole_log  = aeshnid_df

# train data: replace Aeshna cyanea and Aeshna juncea with 0 and 1
aeshnid_train_log$name[aeshnid_train_log$name == 'Aeshna cyanea'] <- 0
aeshnid_train_log$name[aeshnid_train_log$name == 'Aeshna juncea'] <- 1

# as numeric
aeshnid_train_log$name = as.numeric(aeshnid_train_log$name)

# test data: replace Aeshna cyanea and Aeshna juncea with 0 and 1
aeshnid_test_log$name[aeshnid_test_log$name == 'Aeshna cyanea'] <- 0
aeshnid_test_log$name[aeshnid_test_log$name == 'Aeshna juncea'] <- 1

# as numeric
aeshnid_test_log$name = as.numeric(aeshnid_test_log$name)

# whole data: replace Aeshna cyanea and Aeshna juncea with 0 and 1
aeshnid_whole_log$name[aeshnid_whole_log$name == 'Aeshna cyanea'] <- 0
aeshnid_whole_log$name[aeshnid_whole_log$name == 'Aeshna juncea'] <- 1

# as numeric
aeshnid_whole_log$name = as.numeric(aeshnid_whole_log$name)

# run the model
logistic_model_01 =  glm(name ~ longitude + latitude + elevation   + amt + maxtwam + tar + ara + pse  + ai, data = aeshnid_train_log , family = binomial(link = "logit"))

summary(logistic_model_01)

# predict using logistic regression model on test data
predictions_test_data <- predict(logistic_model_01, aeshnid_test_log, type="response")

# probability output
head(predictions_test_data, 10)

# assign labels with decision rule: if the prediction is greater than 0.5, assign it 1 else 0
predictions_test_data_rd <- ifelse(predictions_test_data > 0.5, 1, 0)
head(predictions_test_data_rd, 10)

# confusion matrix
table(predictions_test_data_rd, aeshnid_test_log[,1])

# model accuracy on test dataset
accuracy <- table(predictions_test_data_rd, aeshnid_test_log[,1])
sum(diag(accuracy))/sum(accuracy)

# predict using logistic regression model on the whole data
predictions_whole_data <- predict(logistic_model_01, aeshnid_whole_log, type="response")

# probability output
head(predictions_whole_data, 10)

# assign labels with decision rule: if the prediction is greater than 0.5, assign it 1 else 0
predictions_whole_data_rd <- ifelse(predictions_whole_data > 0.5, 1, 0)
head(predictions_whole_data_rd, 10)

# confusion matrix
table(predictions_whole_data_rd, aeshnid_whole_log[,1])

# model accuracy on test dataset
accuracy <- table(predictions_whole_data_rd, aeshnid_whole_log[,1])
sum(diag(accuracy))/sum(accuracy)