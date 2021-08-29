#### mANUEL #### 

# valores atipicos 

library(anomalize)
library(tidyverse)
library(quantmod)
library(readxl)
library(TSstudio)
MangoN <- read_excel("C:/Users/atita/Downloads/MangoN.xlsx")

serie_ts<- ts(MangoN$Producción,start = c(2000,1),frequency = 12)
serie_ts<- as.xts(serie_ts)
plot(serie_ts)

data= data.frame(fecha=index(serie_ts),precios=as.numeric(serie_ts))
data1<- data %>% as_tibble()
data1

data1 %>%
  time_decompose(precios, method = "stl",  frequency = "auto", trend = "auto") %>%  
  anomalize(remainder, method = "gesd", alpha = 0.05, max_anoms = 0.1) %>% 
  plot_anomaly_decomposition()

data1 %>% 
  time_decompose(precios) %>% 
  anomalize(remainder) %>% 
  time_recompose() %>%  
  plot_anomalies(time_recomposed = TRUE, ncol = 3, alpha_dots = 0.5)

data1 %>% 
  time_decompose(precios) %>%
  anomalize(remainder) %>%
  time_recompose() %>%
  filter(anomaly == 'Yes') 



ts_seasonal(as.ts(serie_ts),type = "all")