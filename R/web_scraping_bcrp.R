ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

packages <- c("tidyverse","XML","httr")
ipak(packages)





extraccion<- function(codigo=NULL,start=NULL,end=NULL){
  vector<- vector()
  datos<- NULL
  for(i in 1:length(codigo)){
    ex<-  paste0("https://estadisticas.bcrp.gob.pe/estadisticas/series/api/", 
                 codigo[i], "/xml/",start,"/",end)
    
    
    ObjXML <- httr::GET(ex)
    L_parseXML <- XML::xmlParse(ObjXML)
    
    L_XML <- XML::xmlToList(L_parseXML)
    
    dt_BCRP <- data.table::data.table()
    for (a in 1:length(L_XML$periods)){
      dt_temp <- data.table(
        serie= L_XML$periods[[a]]$v)
      dt_BCRP <- rbind(dt_BCRP,dt_temp)
    }
    vector[i]<- dt_BCRP[,serie:=as.numeric(serie)] 
  }
  for(i in  1: length(codigo)){
    datos<- cbind(datos,vector[[i]])
  }
  datos<- as.data.frame(datos)
  names(datos)<- codigo
  return(datos)
}