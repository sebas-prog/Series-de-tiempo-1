#### Grafico ####

data(co2)

plot(co2)

library(ggplot2) # Los graficos mas elegantes 
library(forecast) # para generar graficos de st de forma automatica

# Para graficar

autoplot(co2)

## Para poner etiquetas 

autoplot(co2)+labs(title = "Emición de CO2",subtitle = "Semillero de investigación",
                   x="Tiempo",y="Cantidad de CO2",caption = "Fuente: Rstudio")+
  theme_minimal()

# title: Es el titulo
# subtitle: es el subtitulo
# x: Es el nombre del eje x
# y: Es el nombre del eje y
# Caption: El pie de pagina

library(ggthemes)
library(hrbrthemes)

autoplot(co2)+labs(title = "Emición de CO2",subtitle = "Semillero de investigación",
                   x="Tiempo",y="Cantidad de CO2",caption = "Fuente: Rstudio")+
  theme_economist()



autoplot(co2)+labs(title = "Emición de CO2",subtitle = "Semillero de investigación",
                   x="Tiempo",y="Cantidad de CO2",caption = "Fuente: Rstudio")+
  theme_economist_white()



autoplot(co2)+labs(title = "Emición de CO2",subtitle = "Semillero de investigación",
                   x="Tiempo",y="Cantidad de CO2",caption = "Fuente: Rstudio")+
  theme_stata()



autoplot(co2)+labs(title = "Emición de CO2",subtitle = "Semillero de investigación",
                   x="Tiempo",y="Cantidad de CO2",caption = "Fuente: Rstudio")+
  theme_modern_rc()

library(ggThemeAssist)

a<- autoplot(co2)+labs(title = "Emición de CO2",subtitle = "Semillero de investigación",
                     x="Tiempo",y="Cantidad de CO2",caption = "Fuente: Rstudio")+
  theme_minimal()
a

ggThemeAssistGadget(a)

a + theme(plot.subtitle = element_text(family = "mono", 
    size = 10, face = "bold", colour = "green1"), 
    plot.caption = element_text(family = "AvantGarde", 
        face = "bold", colour = "lightblue1", 
        hjust = 0.75), axis.title = element_text(family = "AvantGarde", 
        face = "italic", colour = "bisque2"), 
    plot.title = element_text(family = "Bookman", 
        size = 14, face = "italic", hjust = 0.5, 
        vjust = 1.25), panel.background = element_rect(fill = "gray90"), 
    plot.background = element_rect(fill = "azure1"))

autoplot(acf(co2))+labs(title = "Grafico ACF de CO2")+theme_minimal()
autoplot(pacf(co2))+labs(title = "Grafico PACF de CO2")+theme_elegante()

a<- a+theme_elegante()

modelo<- auto.arima(co2)
modelo$coef

#### Agregando una tabla ####

b<- t(as.data.frame(modelo$coef))
b

rownames(b)<- "Valor"
b

library(ggpubr)

table<-ggtexttable(b, rows = NULL, theme = ttheme("mBlue")) 

ggarrange(a,table,ncol = 1, nrow = 2,
          heights = c(1, 0.5))

# Agregando eñ acf y el pacf

a1<-autoplot(acf(co2))+labs(title = "Grafico ACF de CO2")+theme_minimal()
a2<-autoplot(pacf(co2))+labs(title = "Grafico PACF de CO2")+theme_elegante()


ggarrange(a,a1,table,a2,ncol = 2, nrow = 2,
          heights = c(1, 0.5))






