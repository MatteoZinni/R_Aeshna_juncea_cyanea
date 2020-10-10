#-----------------------------------------#
#   Studying phenology and environmental  #
# differences among two Aeshnidae species #
#     Aeshna cyanea and Aeshna juncea     #
#-----------------------------------------#

#-----------------------------------------#
# 05.1      MODEL BUILDING: LDA           #
#-----------------------------------------#

library(MASS)

# split data into two df: train and test
nrow(aeshnid_df)

nrow(subset(aeshnid_df,aeshnid_df$name == "Aeshna cyanea"))

nrow(subset(aeshnid_df,aeshnid_df$name == "Aeshna juncea"))

# to avoid any bias lets randomly sample 308 observation of aeshna cyanea to have equal size dfs
cyanea_sample = subset(aeshnid_df,aeshnid_df$name == "Aeshna cyanea")[sample(nrow(subset(aeshnid_df,aeshnid_df$name == "Aeshna cyanea")), 308), ]
juncea_sample = subset(aeshnid_df,aeshnid_df$name == "Aeshna juncea")

aeshnid_sample = rbind(cyanea_sample,juncea_sample)

# we will keep 185 observation (60%) for each species to train the model
cyanea_train = cyanea_sample[sample(nrow(subset(cyanea_sample,cyanea_sample$name == "Aeshna cyanea")), 185), ]
juncea_train = juncea_sample[sample(nrow(subset(juncea_sample,juncea_sample$name == "Aeshna juncea")), 185), ]

# build train dataset
aeshnid_train = rbind(cyanea_train,juncea_train)

# subset test data
cyanea_test = cyanea_sample[ !(cyanea_train %in% cyanea_sample), ]
juncea_test = juncea_sample[ !(juncea_train %in% juncea_sample), ]

# build test dataset
aeshnid_test = rbind(cyanea_test,juncea_test)

# run the model
lda_model_1 <- lda(name ~ longitude + latitude + elevation   + amt + maxtwam + tar + ara + pse  + ai, data = aeshnid_train )
summary(lda_model_1)

# Validate result using the test data set and the whole dataset 
prediction_train <- predict(lda_model_1, aeshnid_train)$class
prediction_test <- predict(lda_model_1,aeshnid_test)$class
prediction_whole <- predict(lda_model_1,aeshnid_df)$class

#accuracy on training data
mean(prediction_train == aeshnid_train$name)

#accuracy on test data
mean(prediction_test == aeshnid_test$name)

# accuracy on whole data set     
mean(prediction_whole == aeshnid_df$name)

# build lda to plot output
lda_data = data.frame(aeshnid_train$name, predict(lda_model_1)$x)

# plot LDA 
ggplot(lda_data, aes(x=LD1, fill=aeshnid_train.name)) + 
  geom_histogram(alpha=0.7, color="black") +
  scale_fill_manual(values=c("#bcee68", "#00B2EE")) +
  guides(fill=guide_legend(title="Species"))+
  labs(title = "Linear discriminat analysis",x="LD 1",y="") +
  geom_segment(aes(x = -1.022467, y = 0, xend = -1.022467, yend = 45), size = 1, linetype="twodash") +
  geom_segment(aes(x = 1.022467, y = 0, xend = 1.022467, yend = 45), size = 1, linetype="twodash") +
  theme(plot.title = element_text(hjust = 0.5))+
  annotate(label ="Acc. on training data = 0.86 \nAcc. on test data = 0.85 \nAcc. on whole data = 0.85 ",
   geom = "text", x = -5, y = 40, size = 4,hjust = 0) +
  annotate(geom = "rect", xmin = -5.10, xmax = -3, ymin = 37, ymax = 43, linetype = 1, color = "Grey20", fill = "NA") 



     
     



