
# create subcounty and parish borders
jinja_sp_clean_merged <- read_sf("./Data/jinja_villages_2014_cleaned_26July2025.shp")
jinja_sp_clean_merged <- st_transform(jinja_sp_clean_merged, crs = '+proj=longlat +datum=WGS84')

usc <- unique(jinja_sp_clean_merged$Subcounty)
subcounty_borders <- list(1:length(usc))
for (i in 1:length(usc)){
  subcounty_borders[[i]] <- jinja_sp_clean_merged %>% 
    dplyr::filter(jinja_sp_clean_merged$Village %in% jinja_sp_clean_merged$Village[jinja_sp_clean_merged$Subcounty == usc[i]]) %>% 
    dplyr::summarise(Category="Subcounty Borders")
  names(subcounty_borders)[i] <- usc[i]
}
rm(usc)
up <- unique(jinja_sp_clean_merged$Parish)
parish_borders <- list(1:length(up))
for (i in 1:length(up)){
  parish_borders[[i]] <- jinja_sp_clean_merged %>% 
    dplyr::filter(jinja_sp_clean_merged$Village %in% jinja_sp_clean_merged$Village[jinja_sp_clean_merged$Parish == up[i]]) %>% 
    dplyr::summarise(Category="Parish Borders")
  names(parish_borders)[i] <- up[i]
}
rm(up)

# create function
borders <- function(lmap) {
  
  lmap %>%
    
    addPolygons(data=subcounty_borders[[1]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 6, label = paste("Subcounty: ", names(subcounty_borders)[1]), highlightOptions = highlightOptions(color = "red", weight = 8, bringToFront = TRUE)) %>%
    addPolygons(data=subcounty_borders[[2]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 6, label = paste("Subcounty: ", names(subcounty_borders)[2]), highlightOptions = highlightOptions(color = "red", weight = 8, bringToFront = TRUE)) %>%
    addPolygons(data=subcounty_borders[[3]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 6, label = paste("Subcounty: ", names(subcounty_borders)[3]), highlightOptions = highlightOptions(color = "red", weight = 8, bringToFront = TRUE)) %>%
    addPolygons(data=subcounty_borders[[4]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 6, label = paste("Subcounty: ", names(subcounty_borders)[4]), highlightOptions = highlightOptions(color = "red", weight = 8, bringToFront = TRUE)) %>%
    addPolygons(data=subcounty_borders[[5]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 6, label = paste("Subcounty: ", names(subcounty_borders)[5]), highlightOptions = highlightOptions(color = "red", weight = 8, bringToFront = TRUE)) %>%
    addPolygons(data=subcounty_borders[[6]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 6, label = paste("Subcounty: ", names(subcounty_borders)[6]), highlightOptions = highlightOptions(color = "red", weight = 8, bringToFront = TRUE)) %>%
    addPolygons(data=subcounty_borders[[7]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders2"), fill=F, color="black", opacity=1, weight = 6, label = paste("Subcounty: ", names(subcounty_borders)[7]), highlightOptions = highlightOptions(color = "red", weight = 8, bringToFront = TRUE)) %>%
    addPolygons(data=subcounty_borders[[8]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 6, label = paste("Subcounty: ", names(subcounty_borders)[8]), highlightOptions = highlightOptions(color = "red", weight = 8, bringToFront = TRUE)) %>%
    addPolygons(data=subcounty_borders[[9]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 6, label = paste("Subcounty: ", names(subcounty_borders)[9]), highlightOptions = highlightOptions(color = "red", weight = 8, bringToFront = TRUE)) %>%
    
    addPolygons(data=parish_borders[[1]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[2]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>%  
    addPolygons(data=parish_borders[[3]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>%  
    addPolygons(data=parish_borders[[4]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>%  
    addPolygons(data=parish_borders[[5]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>%  
    addPolygons(data=parish_borders[[6]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>%  
    addPolygons(data=parish_borders[[7]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>%  
    addPolygons(data=parish_borders[[8]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>%  
    addPolygons(data=parish_borders[[9]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[10]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[11]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[12]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[13]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[14]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[15]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[16]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[17]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[18]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[19]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[20]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[21]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[22]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[23]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[24]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[25]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[26]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[27]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[28]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[29]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[30]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[31]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[32]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[33]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[34]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[35]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[36]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[37]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[38]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[39]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[40]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[41]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[42]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[43]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[44]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[45]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[46]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[47]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[48]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[49]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[50]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[51]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[52]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[53]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[54]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[55]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[56]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[57]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[58]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[59]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2) %>% 
    addPolygons(data=parish_borders[[60]], group = "Subcounty and Parish Boundaries", options = leafletOptions(pane = "borders"), fill=F, color="black", opacity=1, weight = 2)
}