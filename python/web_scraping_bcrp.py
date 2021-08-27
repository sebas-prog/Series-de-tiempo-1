# -*- coding: utf-8 -*-
"""
Created on Fri Aug 27 14:21:12 2021

@author: atita
"""

# Esta funcion permite realizar un web scraping 

from bs4 import BeautifulSoup
import requests as rq
import pandas as pd 
import pickle


def scraping(codigo,start,end):
    url=("https://estadisticas.bcrp.gob.pe/estadisticas/series/api/"+codigo+"/"+"html/"+start+"/"+end)
    pagina= rq.get(url)
    btl = BeautifulSoup(pagina.content,"html.parser")
    datos= btl.find_all("td",class_="dato")
    codigo1= []
    for i in datos:
        codigo1.append(i.text)
    dt=pd.DataFrame({"Codigo":codigo1})
    dt["Codigo"]=dt["Codigo"].astype("float64")
    def src(url):
        url=url
        pagina= rq.get(url)
        btl = BeautifulSoup(pagina.text,"lxml")    
        datos= btl.find("table",{"class":"series"})    
        datos.findAll("tr")[1:]    
        da= []    
        for i in datos.findAll("tr")[1:]:
            da.append(i.findAll("td")[0].text)
        with open("src.pickle","wb") as f:
            pickle.dump(da,f)
        return(da)
    daffy = src(url)
    def take_data():
      with open("src.pickle","rb") as f:
        daffy = pickle.load(f)
        res = [] 
        for sub in daffy: 
          res.append(sub.replace("\n", ""))
        return res
    res = take_data()
    ds=pd.DataFrame({"fecha":res})
    data=pd.concat((ds,dt),axis=1)
    return data

