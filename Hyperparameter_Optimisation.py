# -*- coding: utf-8 -*-
"""
Created on Fri Aug 12 10:22:58 2022

@author: SarahWindrum
"""
# https://machinelearningmastery.com/hyperparameter-optimization-with-random-search-and-grid-search/

import pandas as pd
from sklearn.ensemble import RandomForestClassifier
from sklearn.model_selection import RepeatedStratifiedKFold
from sklearn.model_selection import RandomizedSearchCV
from sklearn.model_selection import GridSearchCV
import numpy as np
from time import time 

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

# Build Random Forest model 
model = RandomForestClassifier()

# Method of evaluation
cv = RepeatedStratifiedKFold(n_splits=10, n_repeats=3, random_state=1)

# Define search space for RandomizedSearchCV
# https://towardsdatascience.com/hyperparameter-tuning-with-grid-search-and-random-search-6e1b5e175144
space = {
'n_estimators': list(range(50, 300, 10)),
'min_samples_leaf': list(range(1, 50)),
'max_depth': list(range(2, 20)),
'bootstrap': [True, False]}

# Record time search takes
start = time()
# Run Search 
search = RandomizedSearchCV(model, space, n_iter=50, scoring='accuracy', n_jobs=-1, cv=cv, random_state=1)
result = search.fit(X, y)

# Print Results 
print('Best Score: %s' % result.best_score_)
print('Best Hyperparameters: %s' % result.best_params_)
print("RandomizedSearchCV took %.2f seconds for %d candidate parameter settings." % ((time() - start), len(search.cv_results_['params'])))
print('\n')
# Define grid for GridSearchCV
param_grid = {
'n_estimators': [50, 100, 200, 300],
'min_samples_leaf': [1, 5, 10],
'max_depth': [2, 4, 6, 8, 10],
'bootstrap': [True, False]}

start = time()
# Print the time spend and number of models ran

# Run GridSearchCV
model_gridsearch = GridSearchCV(estimator=model, param_grid=param_grid, scoring='accuracy', n_jobs=4, cv=cv, refit=True,
return_train_score=True)
grid_result = model_gridsearch.fit(X, y)

# Print Results 
print('Best Score: %s' % grid_result.best_score_)
print('Best Hyperparameters: %s' % grid_result.best_params_)
print("RandomizedSearchCV took %.2f seconds for %d candidate parameter settings." % ((time() - start), len(model_gridsearch.cv_results_['params'])))
print('/n')

# Test improvements
from sklearn.model_selection import train_test_split
from sklearn.model_selection import cross_val_score
from sklearn.metrics import classification_report, confusion_matrix

# 50%
X_train_50, X_test_50, y_train_50, y_test_50 = train_test_split(X, y, test_size=0.5,
random_state=0)

# 65%
X_train_65, X_test_65, y_train_65, y_test_65 = train_test_split(X, y, test_size=0.35,
random_state=0)

# 80%
X_train_80, X_test_80, y_train_80, y_test_80 = train_test_split(X, y, test_size=0.2,
random_state=0)

from sklearn.ensemble import RandomForestClassifier
rfc_50 = RandomForestClassifier(n_estimators = 300, min_samples_leaf = 1, max_depth = 6, bootstrap = True)
# 50%
rfc_50.fit(X_train_50, y_train_50)
rfc_50_predictions = rfc_50.predict(X_test_50)

# 65%
rfc_65 = RandomForestClassifier(n_estimators = 300, min_samples_leaf = 1, max_depth = 6, bootstrap = True)
rfc_65.fit(X_train_65, y_train_65)
rfc_65_predictions = rfc_65.predict(X_test_65)

# 80%
rfc_80 = RandomForestClassifier(n_estimators = 300, min_samples_leaf = 1, max_depth = 6, bootstrap = True)
rfc_80.fit(X_train_80, y_train_80)
rfc_80_predictions = rfc_80.predict(X_test_80)

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

print(rfc_cv_score_50.std())
print(rfc_cv_score_65.std())
print(rfc_cv_score_80.std())