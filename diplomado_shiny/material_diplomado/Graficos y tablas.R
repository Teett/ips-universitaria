#Grafica 1 ---------------------------------------

p <- ggplot(data = data2, aes(x = as.factor(diaing)))+
       geom_bar(stat = "count", position = "dodge", fill = "blue") + 
       ylab("Pacientes") + xlab("Día del mes") + 
       theme(axis.text.x = element_text(angle = 90, hjust = 1)) + 
       ggtitle("Pacientes por día")


#Gráfica 2 ---------------------------------------

p <- ggplot(data = data2) + 
  geom_histogram(binwidth = 1,
                 aes(x = as.double(data2$estotal)), 
                 fill = color, 
                 color = "white") + 
  ylab("Pacientes") + 
  xlab("Días de estancia") + 
  ggtitle("Histograma estancia")

#Gráfica 3 ---------------------------------------

p <- ggplot (Datos) + geom_histogram(bins = 50, 
                                     aes(x = Datos$estotal, fill = Datos$edadc ), 
                                     color = 'black') + 
  facet_grid(Datos$edadc~., scales = 'free') +
  xlim(c(0,80)) +
  xlab("Estancia UCI") + 
  ylab("Frecuencia") + 
  ggtitle("Distribución de la variable Estancia para los distintos Segmentos") + 
  theme(legend.position = "none")

#Tabla 1 -----------------------------------------

tabla <- as.data.frame(table(data2$esp))
colnames(tabla) <- c("Especialidad","N. Pacientes")
datatable({tabla},
          options = list(pageLength = 5),
          filter = "top",
          selection = 'multiple',
          style = 'bootstrap',
          class = 'cell-border stripe',
          fillContainer = T,
          rownames = FALSE)
