# ------------------------------------------------
# Load Libraries
# ------------------------------------------------
library(dplyr)
library(leaflet)
library(leaflet.extras)
library(leaflet.extras2)
library(leaflegend)
library(leafpop)
library(leafsync)
library(geojsonsf)
library(stringr)
library(shiny)
library(htmlwidgets)
library(sf)
library(shinymanager)
library(config)
library(shinyWidgets)
library(mapview)
library(RColorBrewer)
library(terra)
library(raster)
library(ggplot2)
library(tidyr)
library(lubridate)
library(DT)
library(argonR)
library(argonDash)
library(waiter)
library(purrr)
library(bslib)
library(shinyjs)

# -----------------------------------------------
# UI
# -----------------------------------------------

ui <- argonDashPage(
  title = "Busoga Project",
  sidebar = argonDashSidebar(
    size = "md",background = "default",
    vertical = FALSE,skin = "light",
    id="my_sidebar",
    brand_logo = "Busoga Project logo.png"
  ),
  body = argonDashBody(
    
    useWaiter(),
    
    useShinyjs(),
    
    waiterShowOnLoad(html = tags$div(
      tags$h1("Busoga Project Dashboard",style="color:white; font-size: 3.2rem !important;  font-weight: bold !important;")
      ,spin_flower(),tags$div("Loading...")),color = "#172b4d"),
    autoWaiter(html =spin_loaders(39,color = "#172b4d"),fadeout = TRUE,color = "white" ),
    
                   argonCard(width = 12,shadow = TRUE,status = 'default', background_color = 'default',
                             
                             argonCard(width = 12,shadow = TRUE,status = 'default', background_color = 'Light',
                                       argonRow(
                                         argonColumn(width = 12,
                                                     tags$head(tags$style(".btn-default {
    width: 49%; display: inline-block; margin-top: 5px; }")),
                                                     
                                                     tags$div(
                                                       div(
                                                         actionButton("agbd", label = "AGBD", style = "color: #5970FF; background-color: white;", class = "beveled-button", icon = icon("map"), width = "12.5%"),
                                                         actionButton("evi", label = "EVI", style = "color: #5970FF; background-color: white;", class = "beveled-button", icon = icon("map"), width = "12.5%"),
                                                         actionButton("ndvi", label = "NDVI", style = "color: #5970FF; background-color: white;", class = "beveled-button", icon = icon("map"), width = "12.5%"),
                                                         actionButton("evi_r", label = "EVI Raster", style = "color: #5970FF; background-color: white;", class = "beveled-button", icon = icon("map"), width = "15%"),
                                                         actionButton("ndvi_r", label = "NDVI Raster", style = "color: #5970FF; background-color: white;", class = "beveled-button", icon = icon("map"), width = "17.5%"),
                                                         actionButton("basemap", label = "Base Map", style = "color: #5970FF; background-color: white;", class = "beveled-button", icon = icon("map"), width = "15%")
                                                         
                                                       )
                                                     )
                                                     
                                         )
                                       )
                             ),
                             
                             #************ AGBD ***************# 
                             
                             shinyjs::hidden(div(id = "map1", 
                                                 
                                                 tagList(
                                                   
                                                   argonRow(
                                                     argonColumn(width = 12,
                                                                 tags$div(
                                                                   style = "text-align: center; border: 1px solid white; padding: 10px; border-radius: 5px;",
                                                                   h4("Mean Above Ground Biodensity (AGBD) by Village 2019-2024", style = "color: white; font-size: 24px;"),
                                                                   div(
                                                                     leafletOutput("agbd", height = 700)
                                                                   ))
                                                                 
                                                     )
                                                   )
                                                   
                                                   
                                                   
                                                 )
                                                 
                             )),
                             
                             #************ EVI ***************# 
                             
                             shinyjs::hidden(div(id = "map2", 
                                                 
                                                 tagList(
                                                   
                                                   argonRow(
                                                     argonColumn(width = 12,
                                                                 tags$div(
                                                                   style = "text-align: center; border: 1px solid white; padding: 10px; border-radius: 5px;",
                                                                   h4("Mean Enhanced Vegetation Index (EVI) by Village 2000-2024", style = "color: white; font-size: 24px;"),
                                                                   div(
                                                                     leafletOutput("evi", height = 700)
                                                                   ))
                                                                 
                                                     )
                                                   )
                                                   
                                                   
                                                   
                                                 )
                                                 
                             )),
                             
                             #************ NDVI ***************#
                             
                             shinyjs::hidden(div(id = "map3", 
                                                 
                                                 tagList(
                                                   
                                                   argonRow(
                                                     argonColumn(width = 12,
                                                                 tags$div(
                                                                   style = "text-align: center; border: 1px solid white; padding: 10px; border-radius: 5px;",
                                                                   h4("Mean Normalized Difference Vegetation Index (NDVI) by Village 2000-2024", style = "color: white; font-size: 24px;"),
                                                                   div(
                                                                     leafletOutput("ndvi", height = 700)
                                                                   ))
                                                                 
                                                     )
                                                   )
                                                   
                                                   
                                                   
                                                 )
                                                 
                             )),
                             
                             #************ EVI raster ***************#
                             
                             shinyjs::hidden(div(id = "map4", 
                                                 
                                                 tagList(
                                                   
                                                   argonRow(
                                                     argonColumn(width = 12,
                                                                 tags$div(
                                                                   style = "text-align: center; border: 1px solid white; padding: 10px; border-radius: 5px;",
                                                                   h4("EVI Raster", style = "color: white; font-size: 24px;"),
                                                                   div(
                                                                     leafletOutput("evi_r", height = 700)
                                                                   ))
                                                                 
                                                     )
                                                   )
                                                   
                                                   
                                                   
                                                 )
                                                 
                             )),
                             
                             #************ NDVI raster ***************#
                             
                             shinyjs::hidden(div(id = "map5", 
                                                 
                                                 tagList(
                                                   
                                                   argonRow(
                                                     argonColumn(width = 12,
                                                                 tags$div(
                                                                   style = "text-align: center; border: 1px solid white; padding: 10px; border-radius: 5px;",
                                                                   h4("NDVI Raster", style = "color: white; font-size: 24px;"),
                                                                   div(
                                                                     leafletOutput("ndvi_r", height = 700)
                                                                   ))
                                                                 
                                                     )
                                                   )
                                                   
                                                   
                                                   
                                                 )
                                                 
                             )),
                             
                             #************ Base Map ***************#
                             
                             shinyjs::hidden(div(id = "map6", 
                                                 
                                                 tagList(
                                                   
                                                   argonRow(
                                                     argonColumn(width = 12,
                                                                 tags$div(
                                                                   style = "text-align: center; border: 1px solid white; padding: 10px; border-radius: 5px;",
                                                                   h4("Base Map", style = "color: white; font-size: 24px;"),
                                                                   div(
                                                                     leafletOutput("basemap", height = 700)
                                                                   ))
                                                                 
                                                     )
                                                   )
                                                   
                                                   
                                                   
                                                 )
                                                 
                             ))
                             
                             
                   )
    
  )
  
)

ui <- secure_app(# customizations for login page
  tags_top = tags$div(
    h1("Welcome", style = "text-align:center; color:#2c3e50;"),
  ),
  
  theme = bs_theme(
    version = 5,
    bootswatch = "flatly",
    base_font = font_google("Poppins")
  ),ui)   


# ------------------------------------------------
# Server
# ------------------------------------------------

server <- function(input, output, session) {
  
  # Load credentials list
  conf <- config::get("credentials", file = "config.yml")
  # Convert list of lists -> data.frame
  credentials <- do.call(rbind, lapply(conf, as.data.frame, stringsAsFactors = FALSE))
  
  # check_credentials returns a function to authenticate users
  res_auth <- secure_server(
    check_credentials = check_credentials(credentials)
  )
  #hide the loading page 
  waiter_hide()
  
  source("utils.R")
  source("./Data/prepMaps.R")
  
  action_performed <- reactiveVal(FALSE) # use reactive values to avoid loading scripts more than once
  
  #************ AGBD ***************# 
  
  observeEvent(input$agbd, { # define what happens when you press this button
    
    # Change color of action buttons
    runjs('document.getElementById("agbd").style.backgroundColor = "#5970FF";')
    runjs('document.getElementById("agbd").style.color = "white";')
    runjs('document.getElementById("evi").style.backgroundColor = "white";')
    runjs('document.getElementById("evi").style.color = "#5970FF";')
    runjs('document.getElementById("ndvi").style.backgroundColor = "white";')
    runjs('document.getElementById("ndvi").style.color = "#5970FF";')
    runjs('document.getElementById("evi_r").style.backgroundColor = "white";')
    runjs('document.getElementById("evi_r").style.color = "#5970FF";')
    runjs('document.getElementById("ndvi_r").style.backgroundColor = "white";')
    runjs('document.getElementById("ndvi_r").style.color = "#5970FF";')
    runjs('document.getElementById("basemap").style.backgroundColor = "white";')
    runjs('document.getElementById("basemap").style.color = "#5970FF";')
    
    # hide other maps
    shinyjs::hide("map2") 
    shinyjs::hide("map3")
    shinyjs::hide("map4")
    shinyjs::hide("map5")
    shinyjs::hide("map6")
    
    shinyjs::show("map1") # show maps
    
    # only load scripts once
    if (!action_performed()) { 
      source("./modules/agbd.R")
    }
    
  })
  
  #************ EVI ***************# 
  
  observeEvent(input$evi, { # define what happens when you press this button
    
    # Change color of action buttons
    runjs('document.getElementById("evi").style.backgroundColor = "#5970FF";')
    runjs('document.getElementById("evi").style.color = "white";')
    runjs('document.getElementById("agbd").style.backgroundColor = "white";')
    runjs('document.getElementById("agbd").style.color = "#5970FF";')
    runjs('document.getElementById("ndvi").style.backgroundColor = "white";')
    runjs('document.getElementById("ndvi").style.color = "#5970FF";')
    runjs('document.getElementById("evi_r").style.backgroundColor = "white";')
    runjs('document.getElementById("evi_r").style.color = "#5970FF";')
    runjs('document.getElementById("ndvi_r").style.backgroundColor = "white";')
    runjs('document.getElementById("ndvi_r").style.color = "#5970FF";')
    runjs('document.getElementById("basemap").style.backgroundColor = "white";')
    runjs('document.getElementById("basemap").style.color = "#5970FF";')
    
    # hide other maps
    shinyjs::hide("map1") 
    shinyjs::hide("map3")
    shinyjs::hide("map4")
    shinyjs::hide("map5")
    shinyjs::hide("map6")
    
    shinyjs::show("map2") # show map
  
    # only load scripts once
    if (!action_performed()) { 
      source("./modules/evi.R")
    }
    
  })
  
  
  #************ NDVI ***************# 
  
  observeEvent(input$ndvi, { # define what happens when you press this button
    
    # Change color of action buttons
    runjs('document.getElementById("ndvi").style.backgroundColor = "#5970FF";')
    runjs('document.getElementById("ndvi").style.color = "white";')
    runjs('document.getElementById("evi").style.backgroundColor = "white";')
    runjs('document.getElementById("evi").style.color = "#5970FF";')
    runjs('document.getElementById("agbd").style.backgroundColor = "white";')
    runjs('document.getElementById("agbd").style.color = "#5970FF";')
    runjs('document.getElementById("evi_r").style.backgroundColor = "white";')
    runjs('document.getElementById("evi_r").style.color = "#5970FF";')
    runjs('document.getElementById("ndvi_r").style.backgroundColor = "white";')
    runjs('document.getElementById("ndvi_r").style.color = "#5970FF";')
    runjs('document.getElementById("basemap").style.backgroundColor = "white";')
    runjs('document.getElementById("basemap").style.color = "#5970FF";')
    
    # hide other map
    shinyjs::hide("map1") 
    shinyjs::hide("map2")
    shinyjs::hide("map4")
    shinyjs::hide("map5")
    shinyjs::hide("map6")
    
    shinyjs::show("map3") # show map
    
    # only load scripts once
    if (!action_performed()) { 
      source("./modules/ndvi.R")
    }
    
  })
  
  #************ EVI Raster ***************# 
  
  observeEvent(input$evi_r, { # define what happens when you press this button
    
    # Change color of action buttons
    runjs('document.getElementById("evi_r").style.backgroundColor = "#5970FF";')
    runjs('document.getElementById("evi_r").style.color = "white";')
    runjs('document.getElementById("evi").style.backgroundColor = "white";')
    runjs('document.getElementById("evi").style.color = "#5970FF";')
    runjs('document.getElementById("ndvi").style.backgroundColor = "white";')
    runjs('document.getElementById("ndvi").style.color = "#5970FF";')
    runjs('document.getElementById("agbd").style.backgroundColor = "white";')
    runjs('document.getElementById("agbd").style.color = "#5970FF";')
    runjs('document.getElementById("ndvi_r").style.backgroundColor = "white";')
    runjs('document.getElementById("ndvi_r").style.color = "#5970FF";')
    runjs('document.getElementById("basemap").style.backgroundColor = "white";')
    runjs('document.getElementById("basemap").style.color = "#5970FF";')
    
    # hide other maps
    shinyjs::hide("map1") 
    shinyjs::hide("map2")
    shinyjs::hide("map3")
    shinyjs::hide("map5")
    shinyjs::hide("map6")
    
    shinyjs::show("map4") # show map
    
    # only load scripts once
    if (!action_performed()) { 
      source("./modules/evi_r.R")
    }
    
  })
  
  #************ NDVI Raster ***************# 
  
  observeEvent(input$ndvi_r, { # define what happens when you press this button
    
    # Change color of action buttons
    runjs('document.getElementById("ndvi_r").style.backgroundColor = "#5970FF";')
    runjs('document.getElementById("ndvi_r").style.color = "white";')
    runjs('document.getElementById("evi").style.backgroundColor = "white";')
    runjs('document.getElementById("evi").style.color = "#5970FF";')
    runjs('document.getElementById("ndvi").style.backgroundColor = "white";')
    runjs('document.getElementById("ndvi").style.color = "#5970FF";')
    runjs('document.getElementById("evi_r").style.backgroundColor = "white";')
    runjs('document.getElementById("evi_r").style.color = "#5970FF";')
    runjs('document.getElementById("agbd").style.backgroundColor = "white";')
    runjs('document.getElementById("agbd").style.color = "#5970FF";')
    runjs('document.getElementById("basemap").style.backgroundColor = "white";')
    runjs('document.getElementById("basemap").style.color = "#5970FF";')
    
    # hide other maps
    shinyjs::hide("map1") 
    shinyjs::hide("map2")
    shinyjs::hide("map3")
    shinyjs::hide("map4")
    shinyjs::hide("map6")
    
    shinyjs::show("map5") # show map
    
    # only load scripts once
    if (!action_performed()) { 
      source("./modules/ndvi_r.R")
    }
    
  })
  
  #************ Base Map ***************# 
  
  observeEvent(input$basemap, { # define what happens when you press this button
    
    # Change color of action buttons
    runjs('document.getElementById("basemap").style.backgroundColor = "#5970FF";')
    runjs('document.getElementById("basemap").style.color = "white";')
    runjs('document.getElementById("evi").style.backgroundColor = "white";')
    runjs('document.getElementById("evi").style.color = "#5970FF";')
    runjs('document.getElementById("ndvi").style.backgroundColor = "white";')
    runjs('document.getElementById("ndvi").style.color = "#5970FF";')
    runjs('document.getElementById("evi_r").style.backgroundColor = "white";')
    runjs('document.getElementById("evi_r").style.color = "#5970FF";')
    runjs('document.getElementById("agbd").style.backgroundColor = "white";')
    runjs('document.getElementById("agbd").style.color = "#5970FF";')
    runjs('document.getElementById("ndvi_r").style.backgroundColor = "white";')
    runjs('document.getElementById("ndvi_r").style.color = "#5970FF";')
    
    # hide other maps
    shinyjs::hide("map1") 
    shinyjs::hide("map2")
    shinyjs::hide("map3")
    shinyjs::hide("map4")
    shinyjs::hide("map5")
    
    shinyjs::show("map6") # show map
    
    # only load scripts once
    if (!action_performed()) { 
      source("./modules/basemap.R")
    }
    
  })
  
  #************ Map Outputs ***************# 
  
  output$agbd <- renderLeaflet({
    
   agbd
    
  })
  
  output$evi <- renderLeaflet({
    
    evi
    
  })
  
  output$ndvi <- renderLeaflet({
    
    ndvi
    
  })
  
  output$evi_r <- renderLeaflet({
    
    evi_r
    
  })
  
  output$ndvi_r <- renderLeaflet({
    
    ndvi_r
    
  })
  
  output$basemap <- renderLeaflet({
    
    basemap
    
  })
  
}


# ------------------------------------------------
# Run App
# ------------------------------------------------
shinyApp(ui, server)

