ndvi_r <- leaflet() %>% 
  addTiles(
    urlTemplate = "https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}",
    options = tileOptions(minZoom = 0, maxZoom = 19),
    attribution = 'Tiles &copy; Esri &mdash; Source: Esri, i-cubed, USDA, USGS, AEX, GeoEye, Getmapping, Aerogrid, IGN, IGP, UPR-EGP, and the GIS User Community',
    group = "Esri World Imagery (WGS84)"
  ) %>%
  addScaleBar(options = list(imperial = FALSE), position = "topright") %>%
  addLayersControl(overlayGroups = c("Subcounty and Parish Boundaries"), position = "topleft", options = layersControlOptions(collapsed = FALSE)) %>%
  addMapPane(name = "data", zIndex = 410) %>% 
  addMapPane(name = "borders", zIndex = 420) %>%
  addMapPane(name = "borders2", zIndex = 430) %>%
  #htmlwidgets::onRender("
    #function(el, x) {
      #var initialLegend = 'Mean EVI by Village (2000-2024)' // Set the initial legend to be displayed by layerId
      #var myMap = this;
      #for (var legend in myMap.controls._controlsById) {
        #var el = myMap.controls.get(legend.toString())._container;
        #if(legend.toString() === initialLegend) {
          #el.style.display = 'block';
        #} else {
          #el.style.display = 'none';
        #};
      #};
    #myMap.on('baselayerchange',
      #function (layer) {
        #for (var legend in myMap.controls._controlsById) {
          #var el = myMap.controls.get(legend.toString())._container;
          #if(legend.toString() === layer.name) {
            #el.style.display = 'block';
          #} else {
            #el.style.display = 'none';
          #};
        #};
      #});
    #}") %>%
  
  addMiniMap(width = 150, height = 150) %>%
  
  addLegend(layerId= "Mean NDVI Raster (2000-2024)",
            data = nras,
            position = "topright",
            pal = npal2,
            values = values(nras),
            na.label = "Water",
            title = "Mean NDVI Raster 2000-2024",
            opacity = 1) %>%
  
  addRasterImage(nras, group = "Mean NDVI Raster (2000-2024)", options = leafletOptions(pane = "data"), colors = npal2, opacity = 0.8) %>%
  
  addPolygons(data = srs, options = leafletOptions(pane = "borders"), weight = 1.5, stroke = TRUE, fill = FALSE, color = "gray") %>%
  
  setView( lng = 33.22921, lat = 0.5724458, zoom = 11)

ndvi_r <- borders(ndvi_r)


