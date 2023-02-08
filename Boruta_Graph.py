# -*- coding: utf-8 -*-
"""
Created on Tue Aug  9 14:45:37 2022

@author: SarahWindrum
"""

import scipy as sp
import matplotlib.pyplot as plt

trials = 20
pmf = [sp.stats.binom.pmf(x, trials, .5) for x in range(trials + 1)]
plt.scatter(x =[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21], y=pmf)
