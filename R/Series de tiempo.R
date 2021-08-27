# Modelos de series de tiempo 


# Es ta funcion permite cargar y descargar los paquetes de forma automatica

ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

packages <- c("forecast","TSstudio","tseries","highcharter","TTR","readxl","imputeTS")
ipak(packages)

DATOS_QUINUA <- read_excel("C:/Users/atita/Downloads/DATOS QUINUA.xlsx")
View(DATOS_QUINUA)

# Ejemplo de valores Vacios o NA

a<- c(0,4,3) # Guardar en una variable 

mean(a)

a<- c(NA,4,3) # Guardar en una variable

mean(a,na.rm = TRUE)

#### 2 paso ####

data<- DATOS_QUINUA

print(data)

# Como veo si mi data tiene valores  vacios:

is.na(data)

sum(is.na(data))

# Valores ausentes por columnas 

colSums(is.na(data))

# Cambiar el valor por un valor ausente (NA)

data$Producción==0 # que valores son iguales a 0 

## Recordar: que cuando quiero comparar dos valores o objetos uso esto "==="

sum(data$Producción==0)

# Reamplazo: 

data$Producción[data$Producción==0]<- NA

colSums(is.na(data))

help("imputeTS")

#### 3 paso ####

# Vamos a darle el formato de serie de tiempo 

quinua_ts<- ts(data$Producción,start = c(2000,1),frequency = 12) # Transformar la data en
                                                                # Formato de serie de tiempo


plot.ts(quinua_ts) # Graficamos la serie

# Interpolar valores

new_data<- na.interpolation(quinua_ts,option = "linear") # Aplicamos el metodo de interpolacion

# Ojo: El metodo de interpolacion cubica o spline arroja valores negativos, por este motivos usamos el metodo
# lineal u linear 

class(new_data)

# hacemos la comparacion de las dos bases de datos 

plot(new_data) # con interpolacion 
lines(quinua_ts,col="red") # sin ella

plot(decompose(new_data))

ts_decompose(new_data)

ts_seasonal(new_data, type = "all")

#### 4 Aplicar el metodod de holt-winter ####

etsmodel = ets(new_data)

plot(new_data,col="blue")
lines(etsmodel$fitted,col="red")

# Multiplicativa

etsmodmult = ets(new_data, model ="MMM")

plot(new_data,col="blue")
lines(etsmodmult$fitted,col="red")

autoplot(etsmodmult)

# Realizar una prediccion

prediction <- forecast(etsmodmult,h=48)

autoplot(prediction)


