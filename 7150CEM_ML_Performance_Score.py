# -*- coding: utf-8 -*-
"""
Created on Tue Jul  5 08:55:04 2022

@author: SarahWindrum
"""
# Using data to predict win / not win

import pandas as pd
import matplotlib.pyplot as plt
import numpy as np
import sklearn

# Import & Prepare Dataset -> Select & Shape

dataset = pd.read_csv('21-22_Gallagher_Premiership_Data_NoSymbol.csv')
print(dataset.head)
dataset_features_score = dataset.filter(['Amber_Zone_Possession_Try', 'Defenders_Beaten_in_Green_Zone', 'Linebreaks', 'Rucks0_Try',
                                   'Defence_Scrum_Offence', 'Green_Zone_Entries', 'Green_Zone_Points_Scored',
                                   'Green_Zone_Positive', 'Kick_Difference', 'Linebreaks_in_Green_Zone', 'Metres_Per_Carry', 
                                   'Penalties_Kicked', 'Penalty_Difference', 'Scrum_Pens_Con', 'Rucks1_Try', 'Rucks3_Try', 'Rucks_Three', 
                                   'Total_Possession_Turnovers', 'Tries_From_Green_Zone_Within_Three', 'Tries_From_Counter',  
                                   'Tries_From_Lineout_from_Amber', 'Tries_from_Set_Piece', 'Tries_From_Amber_Zone_Within_Three',
                                   'Tries_From_Grey_Zone_Within_Three', 'Rucks_Over_Three_Seconds_Grey_Zone', 'Tries_From_Brokenplay',
                                   'Tries_From_Lineout_from_Green', 'Turnovers_Conceded'])
X = np.array(dataset_features_score)
print(X)
y = np.array(dataset['Score'])
print(X.shape)
print(y.shape)

# Split -> Leave One Out Cross Validation 
from sklearn.model_selection import LeaveOneOut
# https://towardsdatascience.com/train-test-split-and-cross-validation-in-python-80b61beca4b6
locv = LeaveOneOut()
locv.get_n_splits(X)

for train_index, test_index in locv.split(X):
    X_train, X_test = X[train_index], X[test_index]
    y_train, y_test = y[train_index], y[test_index]

# Feature Scaling -> we may need to scale here before LOOCV
# Robust versus Standard -> outliers
from sklearn import preprocessing
# Scale X_train
scaler = preprocessing.RobustScaler().fit(X_train)
X_train_scaled = scaler.transform(X_train)
# Scale X_test
scaler = preprocessing.RobustScaler().fit(X_test)
X_test_scaled = scaler.transform(X_test)
# y is class label so doesn't need scaling

# Logistic Regression -> Done in R

# Random Forest -> no hyperparameter tuning
from sklearn.ensemble import RandomForestRegressor
regr = RandomForestRegressor() # Parameters: n_estimators (100)
regr_model = regr.fit(X_train_scaled, y_train) 

# Validate & Score
# https://medium.com/analytics-vidhya/evaluation-metrics-for-regression-algorithms-along-with-their-implementation-in-python-9ec502729dad
from sklearn.model_selection import cross_val_predict
from sklearn.metrics import r2_score
from sklearn.metrics import mean_absolute_error

regr_predictions = cross_val_predict(regr_model, dataset_features_score, y, cv=LeaveOneOut())
accuracy_score_RF = r2_score(y, regr_predictions)
print(mean_absolute_error(y, regr_predictions))
print(accuracy_score_RF)

# Support Vector Regression 
from sklearn.svm import SVR
svr_ = SVR(C=1.0, epsilon = 0.2)
svr_model = svr_.fit(X_train_scaled, y_train)

# Validate & Score
svr_predictions = cross_val_predict(svr_model, dataset_features_score, y, cv=LeaveOneOut())
accuracy_score_SVR = r2_score(y, svr_predictions)
print(mean_absolute_error(y, svr_predictions))
print(accuracy_score_SVR)

## Naive Bayes -> need to convert problem to classification problem 








