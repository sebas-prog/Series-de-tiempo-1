#### Modelo Sarima #### 

ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

packages <- c("forecast","TSstudio","tseries","highcharter","TTR","readxl","imputeTS")
ipak(packages)

DATOS_QUINUA <- read.csv("https://raw.githubusercontent.com/sebas-prog/Series-de-tiempo-1/main/Datos/Data_humberto.csv")
View(DATOS_QUINUA)

data<- DATOS_QUINUA

data$Producción[data$Producción==0]<- NA

quinua_ts<- ts(data$Producción,start = c(2000,1),frequency = 12)

new_data<- na.interpolation(quinua_ts,option = "linear")

modelo <- auto.arima(new_data)
summary(modelo)

plot(new_data)
lines(modelo$fitted,col="red")

predict <- forecast(modelo,12)
autoplot(predict)

