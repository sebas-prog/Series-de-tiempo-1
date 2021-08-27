# Modelos de series de tiempo 


# Es ta funcion permite cargar y descargar los paquetes de forma automatica

ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

packages <- c("forecast","TSstudio","tseries","highcharter","TTR")
ipak(packages)


