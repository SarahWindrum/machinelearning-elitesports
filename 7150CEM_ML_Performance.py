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
dataset_features = dataset.filter(['Rucks0_Try', 'Amber_Zone_Possession_Try', 'Attacking_Not_Releasing', 'Attacking_Breakdown_Penalties',
                                   'Complete_Opp_Half', 'Defence_Scrum_Offence', 'Green_Zone_Entries', 'Green_Zone_Points_Scored',
                                   'Green_Zone_Positive', 'Kick_Difference', 'Kick_P2_', 'Linebreaks_in_Green_Zone', 'Passes_in_Grey_Zone', 
                                   'Penalties_Kicked', 'Penalty_Difference', 'Pens_in_Amber_Zone', 'Phase2_Possessions', 'Rucks_in_Grey_Zone', 
                                   'Scrums_Won', 'Total_Possession_Turnovers', 'Total_Scrum_Pens_Won', 'Tries_From_Green_Zone', 
                                   'Tries_From_Lineout_from_Amber', 'Tries_From_Scrum', 'Tries_from_Set_Piece', 'Tries_From_Amber_Zone_Within_Three',
                                   'Turnover_Won_Opp_Half', 'Rucks_Over_Three_Seconds_Green_Zone', 'Possessions_Ended_With_Kicks_In_Play', 'Kicked_to_Touch',
                                   'Ruck_Speed_'])
X = np.array(dataset_features)
print(X)
y = np.array(dataset['RESULT'])
print(X.shape)
print(y.shape)

# Split -> 50% - 65% - 80%
from sklearn.model_selection import train_test_split

# 50%
X_train_50, X_test_50, y_train_50, y_test_50 = train_test_split(X, y, test_size=0.5,
random_state=0)

# 65%
X_train_65, X_test_65, y_train_65, y_test_65 = train_test_split(X, y, test_size=0.35,
random_state=0)
print(X_train_65.shape)
print(X_test_65.shape)
print(y_train_65.shape)
print(y_test_65.shape)

# 80%
X_train_80, X_test_80, y_train_80, y_test_80 = train_test_split(X, y, test_size=0.2,
random_state=0)

# No need for over-sampling training data in this analysis

# Feature Scaling -> split first then scale
# Robust versus Standard -> outliers
# Do we need to scale? 
# from sklearn import preprocessing
## Scale X_train
# scaler = preprocessing.RobustScaler().fit(X_train)
# print(scaler)
# X_train_scaled = scaler.transform(X_train)
# print(X_train_scaled)
## Scale X_test
# scaler = preprocessing.RobustScaler().fit(X_test)
# print(scaler)
# X_test_scaled = scaler.transform(X_test)
# print(X_test_scaled)
## y is class label so doesn't need scaling

# Logistic Regression -> Done in R

# Random Forest -> no hyperparameter tuning
# https://medium.com/@hjhuney/implementing-a-random-forest-classification-model-in-python
from sklearn.ensemble import RandomForestClassifier
rfc_50 = RandomForestClassifier()
# 50%
rfc_50.fit(X_train_50, y_train_50)
rfc_50_predictions = rfc_50.predict(X_test_50)

# 65%
rfc_65 = RandomForestClassifier()
rfc_65.fit(X_train_65, y_train_65)
rfc_65_predictions = rfc_65.predict(X_test_65)

# 80%
rfc_80 = RandomForestClassifier()
rfc_80.fit(X_train_80, y_train_80)
rfc_80_predictions = rfc_80.predict(X_test_80)

# Parameters: n_estimators (100), max_depth, min_samples_split
# https://scikit-learn.org/stable/modules/generated/sklearn.ensemble.RandomForestClassifier.html

# Support Vector Machines (SVM) -> using previous hyperparameters
from sklearn import svm
clf_50 = svm.LinearSVC(penalty='l2', loss='squared_hinge', dual=True, tol=0.0001,
C=1, multi_class='ovr', fit_intercept=True, intercept_scaling=1, class_weight=None,
verbose=0, random_state=None, max_iter=2000000)
clf_50.fit(X_train_50, y_train_50)
clf_50_predictions = clf_50.predict(X_test_50)

clf_65 = svm.LinearSVC(penalty='l2', loss='squared_hinge', dual=True, tol=0.0001,
C=1, multi_class='ovr', fit_intercept=True, intercept_scaling=1, class_weight=None,
verbose=0, random_state=None, max_iter=2000000)
clf_65.fit(X_train_65, y_train_65)
clf_65_predictions = clf_65.predict(X_test_65)

clf_80 = svm.LinearSVC(penalty='l2', loss='squared_hinge', dual=True, tol=0.0001,
C=1, multi_class='ovr', fit_intercept=True, intercept_scaling=1, class_weight=None,
verbose=0, random_state=None, max_iter=2000000)
clf_80.fit(X_train_80, y_train_80)
clf_80_predictions = clf_80.predict(X_test_80)

# Naive Bayes 
from sklearn.naive_bayes import GaussianNB
model_50 = GaussianNB(priors=None, var_smoothing=1e-09)
y_pred_50 = model_50.fit(X_train_50, y_train_50).predict(X_test_50)

model_65 = GaussianNB(priors=None, var_smoothing=1e-09)
y_pred_65 = model_65.fit(X_train_65, y_train_65).predict(X_test_65)

model_80 = GaussianNB(priors=None, var_smoothing=1e-09)
y_pred_80 = model_80.fit(X_train_80, y_train_80).predict(X_test_80)

# Validate & Score
from sklearn.model_selection import cross_val_score
from sklearn.metrics import classification_report, confusion_matrix

# Random Forest
# 50%
rfc_cv_score_50 = cross_val_score(rfc_50, X, y, cv=20, scoring='roc_auc')
print('=== Random Forest Confusion Matrix 50% ===')                                
print(confusion_matrix(y_test_50, rfc_50_predictions))
print('\n')
print("=== Random Forest Classification Report 50% ===")
print(classification_report(y_test_50, rfc_50_predictions))
print('\n')
print("=== Random Forest Mean AUC Score 50% ===")
print("Mean AUC Score - Random Forest 50%: ", rfc_cv_score_50.mean())
print('\n')
# 65%
rfc_cv_score_65 = cross_val_score(rfc_65, X, y, cv=20, scoring='roc_auc')
print('=== Random Forest Confusion Matrix 65% ===')                                
print(confusion_matrix(y_test_65, rfc_65_predictions))
print('\n')
print("=== Random Forest Classification Report 65% ===")
print(classification_report(y_test_65, rfc_65_predictions))
print('\n')
print("=== Random Forest Mean AUC Score 65% ===")
print("Mean AUC Score - Random Forest 65%: ", rfc_cv_score_65.mean())
print('\n')
# 80%
rfc_cv_score_80 = cross_val_score(rfc_80, X, y, cv=20, scoring='roc_auc')
print('=== Random Forest Confusion Matrix 80% ===')                                
print(confusion_matrix(y_test_80, rfc_80_predictions))
print('\n')
print("=== Random Forest Classification Report 80% ===")
print(classification_report(y_test_80, rfc_80_predictions))
print('\n')
print("=== Random Forest Mean AUC Score 80% ===")
print("Mean AUC Score - Random Forest 80%: ", rfc_cv_score_80.mean())
print('\n')
print('\n')

# SVM
svm_cv_score_50 = cross_val_score(clf_50, X, y, cv=20, scoring='roc_auc')
print('=== SVM Confusion Matrix 50% ===')                                
print(confusion_matrix(y_test_50, clf_50_predictions))
print('\n')
print("=== SVM Classification Report 50% ===")
print(classification_report(y_test_50, clf_50_predictions))
print('\n')
print("=== SVM Mean AUC Score 50% ===")
print("Mean AUC Score - SVM 50%: ", svm_cv_score_50.mean())
print('\n')

svm_cv_score_65 = cross_val_score(clf_65, X, y, cv=20, scoring='roc_auc')
print('=== SVM Confusion Matrix 65% ===')                                
print(confusion_matrix(y_test_65, clf_65_predictions))
print('\n')
print("=== SVM Classification Report 65% ===")
print(classification_report(y_test_65, clf_65_predictions))
print('\n')
print("=== SVM Mean AUC Score 65% ===")
print("Mean AUC Score - SVM 65%: ", svm_cv_score_65.mean())
print('\n')

svm_cv_score_80 = cross_val_score(clf_80, X, y, cv=20, scoring='roc_auc')
print('=== SVM Confusion Matrix 80% ===')                                
print(confusion_matrix(y_test_80, clf_80_predictions))
print('\n')
print("=== SVM Classification Report 80% ===")
print(classification_report(y_test_80, clf_80_predictions))
print('\n')
print("=== SVM Mean AUC Score 80% ===")
print("Mean AUC Score - SVM 80%: ", svm_cv_score_80.mean())
print('\n')
print('\n')

# Naive Bayes 
nb_cv_score_50 = cross_val_score(model_50, X, y, cv=20, scoring='roc_auc')
print('=== Naive Bayes Confusion Matrix 50% ===')                                
print(confusion_matrix(y_test_50, y_pred_50))
print('\n')
print("=== Naive Bayes Classification Report 50% ===")
print(classification_report(y_test_50, y_pred_50))
print('\n')
print("=== Naive Bayes Mean AUC Score 50% ===")
print("Mean AUC Score - Naive Bayes 50%: ", nb_cv_score_50.mean())
print('\n')

nb_cv_score_65 = cross_val_score(model_65, X, y, cv=20, scoring='roc_auc')
print('=== Naive Bayes Confusion Matrix 65% ===')                                
print(confusion_matrix(y_test_65, y_pred_65))
print('\n')
print("=== Naive Bayes Classification Report 65% ===")
print(classification_report(y_test_65, y_pred_65))
print('\n')
print("=== Naive Bayes Mean AUC Score 65% ===")
print("Mean AUC Score - Naive Bayes 65%: ", nb_cv_score_65.mean())
print('\n')

nb_cv_score_80 = cross_val_score(model_80, X, y, cv=20, scoring='roc_auc')
print('=== Naive Bayes Confusion Matrix 80% ===')                                
print(confusion_matrix(y_test_80, y_pred_80))
print('\n')
print("=== Naive Bayes Classification Report 80% ===")
print(classification_report(y_test_80, y_pred_80))
print('\n')
print("=== Naive Bayes Mean AUC Score 80% ===")
print("Mean AUC Score - Naive Bayes 80%: ", nb_cv_score_80.mean())
print('\n')
print('\n')

print(rfc_cv_score_50.std())
print(rfc_cv_score_65.std())
print(rfc_cv_score_80.std())

print(svm_cv_score_50.std())
print(svm_cv_score_65.std())
print(svm_cv_score_80.std())

print(nb_cv_score_50.std())
print(nb_cv_score_65.std())
print(nb_cv_score_80.std())
