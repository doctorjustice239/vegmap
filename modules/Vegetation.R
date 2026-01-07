
vegetation <- leaflet() %>% 
  addTiles(
    urlTemplate = "https://server.arcgisonline.com/ArcGIS/rest/services/World_Imagery/MapServer/tile/{z}/{y}/{x}",
    options = tileOptions(minZoom = 0, maxZoom = 19),
    attribution = 'Tiles &copy; Esri &mdash; Source: Esri, i-cubed, USDA, USGS, AEX, GeoEye, Getmapping, Aerogrid, IGN, IGP, UPR-EGP, and the GIS User Community',
    group = "Esri World Imagery (WGS84)"
  ) %>%
  addScaleBar(options = list(imperial = FALSE), position = "topright") %>%
  addLayersControl(baseGroups = c("Mean EVI by Village (2000-2024)","Mean NDVI by Village (2000-2024)","Mean Above Ground Biodensity by Village (2019-2024)","Mean EVI Raster (2000-2024)","Mean NDVI Raster (2000-2024)","Basemap Only"), overlayGroups = c("Subcounty and Parish Boundaries"), position = "topleft", options = layersControlOptions(collapsed = TRUE)) %>%
  addMapPane(name = "data", zIndex = 410) %>% 
  addMapPane(name = "borders", zIndex = 420) %>%
  addMapPane(name = "borders2", zIndex = 430) %>%
  htmlwidgets::onRender("
    function(el, x) {
      var initialLegend = 'Mean EVI by Village (2000-2024)' // Set the initial legend to be displayed by layerId
      var myMap = this;
      for (var legend in myMap.controls._controlsById) {
        var el = myMap.controls.get(legend.toString())._container;
        if(legend.toString() === initialLegend) {
          el.style.display = 'block';
        } else {
          el.style.display = 'none';
        };
      };
    myMap.on('baselayerchange',
      function (layer) {
        for (var legend in myMap.controls._controlsById) {
          var el = myMap.controls.get(legend.toString())._container;
          if(legend.toString() === layer.name) {
            el.style.display = 'block';
          } else {
            el.style.display = 'none';
          };
        };
      });
    }") %>%
  
  addMiniMap(width = 150, height = 150) %>%
  
  addLegend(layerId= "Mean EVI by Village (2000-2024)",
            data = srs,
            position = "topright",
            pal = pal_evi_2,
            values = ~evi,
            na.label = "No Data",
            title = "Mean EVI by Village 2000-2024",
            opacity = 1) %>%
  
  addLegend(layerId= "Mean NDVI by Village (2000-2024)",
            data = srs,
            position = "topright",
            pal = pal_ndvi_2,
            values = ~ndvi,
            na.label = "No Data",
            title = "Mean NDVI by Village 2000-2024",
            opacity = 1) %>%
  
  addLegend(layerId= "Mean Above Ground Biodensity by Village (2019-2024)",
            data = srs,
            position = "topright",
            pal = agbd_pal,
            values = ~agbd,
            title = "Mean AGBD (metric tons per hectare)",
            opacity = 1) %>%
  
  addLegend(layerId= "Mean EVI Raster (2000-2024)",
            data = eras,
            position = "topright",
            pal = epal2,
            values = values(eras),
            na.label = "Water",
            title = "Mean EVI Raster 2000-2024",
            opacity = 1) %>%
  
  addLegend(layerId= "Mean NDVI Raster (2000-2024)",
            data = nras,
            position = "topright",
            pal = npal2,
            values = values(nras),
            na.label = "Water",
            title = "Mean NDVI Raster 2000-2024",
            opacity = 1) %>%
  
  addPolygons(data = srs, group = "Mean EVI by Village (2000-2024)", options = leafletOptions(pane = "data"), fillOpacity = 1, weight = 0, stroke = TRUE, fillColor = pal_evi_2(srs$evi), popup = paste
              (#"Subcounty Name:", srs$Subcounty, "<br>",
                "Parish Name:", srs$Parish, "<br>",
                "Village Name:", srs$Village, "<br>",
                "Mean EVI:", srs$evi),
              label = paste("Parish:", srs$Parish)) %>%
  
  addPolygons(data = srs, group = "Mean NDVI by Village (2000-2024)", options = leafletOptions(pane = "data"), fillOpacity = 1, weight = 0, stroke = TRUE, fillColor = pal_ndvi_2(srs$ndvi), popup = paste
              (#"Subcounty Name:", srs$Subcounty, "<br>",
                "Parish Name:", srs$Parish, "<br>",
                "Village Name:", srs$Village, "<br>",
                "Mean NDVI:", srs$ndvi),
              label = paste("Parish:", srs$Parish)) %>%
  
  addPolygons(data = srs, group = "Mean Above Ground Biodensity by Village (2019-2024)", options = leafletOptions(pane = "data"), fillOpacity = 1, weight = 0, stroke = TRUE, fillColor = agbd_pal(srs$agbd), popup = paste
              (#"Subcounty Name:", srs$Subcounty, "<br>",
                "Parish Name:", srs$Parish, "<br>",
                "Village Name:", srs$Village, "<br>",
                "Mean AGBD:", srs$agbd),
              label = paste("Parish:", srs$Parish)) %>%
  
  addRasterImage(eras, group = "Mean EVI Raster (2000-2024)", options = leafletOptions(pane = "data"), colors = epal2, opacity = 0.8) %>%
  
  addRasterImage(nras, group = "Mean NDVI Raster (2000-2024)", options = leafletOptions(pane = "data"), colors = npal2, opacity = 0.8) %>%
  
  addPolygons(data = srs, options = leafletOptions(pane = "borders"), weight = 1.5, stroke = TRUE, fill = FALSE, color = "gray") %>%
  
  setView( lng = 33.22921, lat = 0.5724458, zoom = 11)

vegetation <- borders(vegetation)


