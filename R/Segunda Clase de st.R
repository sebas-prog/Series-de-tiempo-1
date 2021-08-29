library(readxl)
DATA_KIWICHA <- read_excel("C:/Users/atita/Downloads/DATA-KIWICHA.xlsx")

View(DATA_KIWICHA)

DATA_KIWICHA$Producción<- gsub(" ","",DATA_KIWICHA$Producción)

library(forecast) # Series de tiempo
library(imputeTS)

kiwichua_ts<- ts(as.numeric(DATA_KIWICHA$Producción),start = c(2001,1),frequency = 121)

plot.ts(kiwichua_ts)

kiwichua_ts[kiwichua_ts==0]<- NA

plot.ts(kiwichua_ts)

# Cuantos valores vacios

sum(is.na(kiwichua_ts))

kiwichua_tsi<- na_interpolation(kiwichua_ts,option = "linear")
plot.ts(kiwichua_tsi)
lines(kiwichua_ts,col="red")

sum(kiwichua_tsi<0)

kiwichua_tsi



