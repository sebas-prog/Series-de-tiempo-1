# -*- coding: utf-8 -*-
"""
Created on Fri Aug 27 14:12:36 2021

@author: atita
"""

# Series de tiempo

# Cargar las siguientes librerias 

import pandas as pd # Es para leer los datos 
import numpy as np  # Es para arreglos de matrices y operaciones matematicas
import matplotlib.pyplot as plt # Es para la generacion graficos 

data= pd.read_excel("C:/Users/atita/Downloads/DATOS QUINUA.xlsx",header=1)

data.columns # Es para ver el nombre de las columnas 

data.head()

quinua= data["Producción"]

quinua.plot()

a= quinua.values

a=a.reshape(len(quinua),1)

data= pd.DataFrame(a)

data.columns= ["Produccion"]

# Los valores ausentes

data_new=data.replace(0,np.nan)

data_new.head()

n= len(data)
data_new.index= pd.date_range(start="2001-01-01",periods=n,freq="M")

data_new.plot()

# El metodo spline:

data_new= data_new.interpolate()

data_new.head()

# El metodo de holt-wintter

from statsmodels.tsa.seasonal import seasonal_decompose # trabajo con series de tiempo

dc =seasonal_decompose(data_new)

dc.plot()

from statsmodels.tsa.holtwinters import ExponentialSmoothing

data_new['TESadd12'] = ExponentialSmoothing(data_new,trend='add',seasonal='add',seasonal_periods=12).fit().fittedvalues
data_new.plot(figsize=(10,8))

modelo = ExponentialSmoothing(data_new["Produccion"],trend='add',seasonal='add',seasonal_periods=12).fit()

prediction=modelo.forecast(36)

data_new['Produccion'].plot(figsize=(12,8))
prediction.plot(label='Forecast additive model');
plt.legend(loc='upper left')
