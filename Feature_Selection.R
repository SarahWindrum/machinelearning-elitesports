# Large amount of variables -> methods of feature selection

library(tidyverse)
performance_data_features = read_csv('21-22_Gallagher_Premiership_Data_NoSymbol.csv')
performance_data_num3 = dplyr::select(performance_data_features, -Team, -Opposition, -Round, -Score, -Score_Difference, -Result_Points, -Total_Match_Points,
                                      -Points_Conceded, -Within_Seven_Point, -Tries_Scored, -Tries_Conceded, -Four_Try_Bonus_Point)
# http://r-statistics.co/Variable-Selection-and-Importance-With-R.html
# install.packages("party")

# Explain why removed -> Head of Performance will know tries scored win games!

# Result 
# Random Forest to determine variable importance 
library(party)
cf1 = cforest(RESULT ~ . , data = performance_data_num3, control=cforest_unbiased(mtry=2,ntree=50)) 

feature_select = varimp(cf1)
feature_df = as.data.frame(feature_select)
# Variable importance based on mean decrease in accuracy
write.csv(feature_df, "C:\\Users\\SarahWindrum\\OneDrive - Sarah Windrum Ltd\\DataScience\\7150CEM\\Variable_RF.csv")

# Boruta Method
# install.packages('Boruta')
library(Boruta)
boruta_output = Boruta(RESULT ~ ., data=na.omit(performance_data_num3), doTrace=2) 
# Collect Confirmed and Tentative variables
boruta_signif = names(boruta_output$finalDecision[boruta_output$finalDecision %in% c("Confirmed")])
print(boruta_signif)
# 23 confirmed significant variables - 44 confirmed + tentative

# Plot variable importance
plot(boruta_output, cex.axis=.7, las=2, main="Variable Importance for Predicting Result")  

# MARS method
# Estimates variable importance based on GCV, number of subset models, and residual sum of squares (RSS)
# install.packages("earth")
library(earth)
est_model = earth(RESULT ~ ., data=performance_data_num3)  
est_importance = evimp (est_model)
print(est_importance) 
plot(est_importance, main="Variable Importance for Predicting Result")

# RFE 
# https://towardsdatascience.com/effective-feature-selection-recursive-feature-elimination-using-r
# install.packages("caret")
library(caret) # For RFE functions
# install.packages("randomForest")
library(randomForest)
library(caTools) # to split dataset
control = rfeControl(functions = rfFuncs,
                     method = "repeatedcv",
                     repeats = 5,
                     number = 10) # Doesn't recognise function so do we include later?
x = dplyr::select(performance_data_num2, -RESULT) 
y = performance_data_num2$RESULT

set.seed(2021)
inTrain = createDataPartition(y, p=.80, list = FALSE)[,1]
x_Train = x[inTrain,]
x_Test = x[-inTrain,]

# Score
performance_data_num4 = dplyr::select(performance_data_features, -Team, -Opposition, -Round, -RESULT, -Score_Difference, -Result_Points, -Total_Match_Points,
                                      -Points_Conceded, -Within_Seven_Point, -Tries_Scored, -Tries_Conceded, -Four_Try_Bonus_Point)


cf3 = cforest(Score ~ . , data = performance_data_num4, control=cforest_unbiased(mtry=2,ntree=50)) 

feature_select2 = varimp(cf3)
feature_df2 = as.data.frame(feature_select2)
# Variable importance based on mean decrease in accuracy
write.csv(feature_df2, "C:\\Users\\SarahWindrum\\OneDrive - Sarah Windrum Ltd\\DataScience\\7150CEM\\Variable_RF_Score.csv")

# Boruta Method
library(Boruta)
boruta_output_score = Boruta(Score ~ ., data=na.omit(performance_data_num4), doTrace=2) 
# Collect Confirmed and Tentative variables
boruta_signif_Score = names(boruta_output_score$finalDecision[boruta_output_score$finalDecision %in% c("Confirmed")])
print(boruta_signif_Score)
# 26 confirmed significant variables - 38 confirmed + tentative

# Plot variable importance
plot(boruta_output_score, cex.axis=.7, las=2, main="Variable Importance for Predicting Score")  

# MARS method
# Estimates variable importance based on GCV, number of subset models, and residual sum of squares (RSS)
library(earth)
est_model_score = earth(Score ~ ., data=performance_data_num4)  
est_importance_score = evimp (est_model_score, trim = FALSE, sqrt. = TRUE)
print(est_importance_score) 
plot(est_importance_score, main="Variable Importance for Predicting Score")