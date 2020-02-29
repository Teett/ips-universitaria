library(tidyverse)
library(shiny)
library(shinydashboard)
library(shinyWidgets)
library(DT)
library(plotly)

raw_data <- readxl::read_excel("material_diplomado/FinaBD.xlsx")

# Define UI for application that draws a histogram
ui <- dashboardPage(
        dashboardHeader(title = "IPS Universitaria"),
        dashboardSidebar(
            sidebarMenu(
                id = "Tipos de accidente",
                menuItem(text = "Accidente vehicular", tabName = "primero", icon = icon("car-crash")),
                menuItem(text = "Accidente de tren", tabName = "segundo", icon = icon("train"))
            )
        ),
        dashboardBody(
            tabItems(
                tabItem(tabName = "primero",
                        selectInput(inputId = "month", 
                                    label = "Select the month", 
                                    choices = 1:12),
                        selectInput(inputId = "year", label = "Select the year",
                                    choices = c(2018, 2019)),
                        sliderInput(inputId = "day", 
                                    label = "Select the ííídays", 
                                    min = 1,
                                    max = 31,
                                    value = c(5, 10),
                                    animate = TRUE),
                        plotlyOutput("grafico1")),
                tabItem(tabName = "segundo",
                        infoBox(title = "Indicador",
                                value = 140,
                                color = "maroon",
                                icon = icon("refresh")),
                        tags$img(src = "Udea.png", width = 100)
                        )
            )
        )
        )

# Define server logic required to draw a histogram
server <- function(input, output) {
    output$grafico1 <- renderPlotly({
        ingreso_din <- raw_data %>% 
            filter(anoing == input$year, 
                   mesing == input$month,
                   diaing >= input$day[1],
                   diaing <= input$day[2])
        
        p <- ggplot(ingreso_din, aes(x = as_factor(diaing))) +
            geom_histogram(stat = "count") +
            labs(title = "Medical stay",
                 x = "Day of access", 
                 y = "Number of patients")
        ggplotly(p)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)