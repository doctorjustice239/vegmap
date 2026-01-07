Total <- st_read("./Data/Total.shp") # read in shapefile with model outputs
Total <- st_transform(Total, crs = '+proj=longlat +datum=WGS84')
Early <- st_read("./Data/Early.shp") # read in shapefile with model outputs
Early <- st_transform(Early, crs = '+proj=longlat +datum=WGS84')
Late <- st_read("./Data/Late.shp") # read in shapefile with model outputs
Late <- st_transform(Late, crs = '+proj=longlat +datum=WGS84')