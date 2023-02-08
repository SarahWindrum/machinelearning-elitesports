# -*- coding: utf-8 -*-
"""
Created on Fri Aug 12 09:47:29 2022

@author: SarahWindrum
"""
import numpy as np
data = [0.80, 0.73, 0.72, 0.52]
F1_scores = np.array(data)
print(F1_scores.mean())
print(F1_scores.std())

data2 = [0.80, 0.50, 0.51, 0.50, 0.51]
AUC_scores = np.array(data2)
print(AUC_scores.mean())
print(AUC_scores.std())

data = [0.77, 0.73, 0.77, 0.70]
F1_scores = np.array(data)
print(F1_scores.mean())
print(F1_scores.std())

data2 = [0.76, 0.72, 0.78, 0.73, 0.72]
AUC_scores = np.array(data2)
print(AUC_scores.mean())
print(AUC_scores.std())

data = [0.83, 0.8, 0.77, 0.78]
F1_scores = np.array(data)
print(F1_scores.mean())
print(F1_scores.std())

data2 = [0.78, 0.80, 0.74, 0.79, 0.74]
AUC_scores = np.array(data2)
print(AUC_scores.mean())
print(AUC_scores.std())