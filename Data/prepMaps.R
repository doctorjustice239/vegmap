# -------------------------------
# Prep Data for Maps
# -------------------------------


# source("./Data/read.R") # read in shapefiles from model outputs
source("./Data/Borders.R") # Function to create borders for leaflet maps

# -------------------------------
# Create Color Palettes
# -------------------------------

# Read in srs shapefile again - this time including outside villages
srs <- st_read("./Data/srs.shp")
srs <- st_transform(srs, crs = '+proj=longlat +datum=WGS84')

# Vegetation

# Read in 20 year mean EVI and NDVI rasters
eras <- terra::rast("./Data/eras.tif")
eras <- terra::project(eras,"EPSG:4326")
nras <- terra::rast("./Data/nras.tif")
nras <- terra::project(nras,"EPSG:4326")

# EVI and NDVI

my_palette_func <- colorRampPalette(c("orange", "yellow", "white", "cyan3", "purple4"))

# mean EVI by village
evi_df <- as.data.frame(srs$evi[!is.na(srs$evi)])
data_min <- min(evi_df)
data_max <- max(evi_df)
center_value <- 0.2
num_colors <- 100
neg_range_prop <- abs(center_value - data_min) / (data_max - data_min)
pos_range_prop <- abs(data_max - center_value) / (data_max - data_min)
num_neg_colors <- round(num_colors * neg_range_prop)
num_pos_colors <- round(num_colors * pos_range_prop)
colors_neg <- colorRampPalette(c("orange", "yellow","white"))(num_neg_colors + 1)[1:num_neg_colors]
colors_pos <- colorRampPalette(c("white", "cyan3", "purple4"))(num_pos_colors + 1)[2:(num_pos_colors + 1)]
final_palette <- c(colors_neg, colors_pos)

pal_evi_2 <- colorNumeric(palette = final_palette, domain = srs$evi)

# mean NDVI by village
ndvi_df <- as.data.frame(srs$ndvi[!is.na(srs$ndvi)])
data_min <- min(ndvi_df)
data_max <- max(ndvi_df)
center_value <- 0.2
num_colors <- 100
neg_range_prop <- abs(center_value - data_min) / (data_max - data_min)
pos_range_prop <- abs(data_max - center_value) / (data_max - data_min)
num_neg_colors <- round(num_colors * neg_range_prop)
num_pos_colors <- round(num_colors * pos_range_prop)
colors_neg <- colorRampPalette(c("orange", "yellow","white"))(num_neg_colors + 1)[1:num_neg_colors]
colors_pos <- colorRampPalette(c("white", "cyan3", "purple4"))(num_pos_colors + 1)[2:(num_pos_colors + 1)]
final_palette <- c(colors_neg, colors_pos)

pal_ndvi_2 <- colorNumeric(palette = final_palette, domain = srs$ndvi)

# EVI raster
eras_df <- as.data.frame(eras)
data_min <- min(eras_df)
data_max <- max(eras_df)
center_value <- 0.2
num_colors <- 100
neg_range_prop <- abs(center_value - data_min) / (data_max - data_min)
pos_range_prop <- abs(data_max - center_value) / (data_max - data_min)
num_neg_colors <- round(num_colors * neg_range_prop)
num_pos_colors <- round(num_colors * pos_range_prop)
colors_neg <- colorRampPalette(c("orange", "yellow","white"))(num_neg_colors + 1)[1:num_neg_colors]
colors_pos <- colorRampPalette(c("white", "cyan3", "purple4"))(num_pos_colors + 1)[2:(num_pos_colors + 1)]
final_palette <- c(colors_neg, colors_pos)

epal2 <- colorNumeric(palette = final_palette, domain = eras_df)

# NDVI raster
nras_df <- as.data.frame(nras)
data_min <- min(nras_df)
data_max <- max(nras_df)
center_value <- 0.2
num_colors <- 100
neg_range_prop <- abs(center_value - data_min) / (data_max - data_min)
pos_range_prop <- abs(data_max - center_value) / (data_max - data_min)
num_neg_colors <- round(num_colors * neg_range_prop)
num_pos_colors <- round(num_colors * pos_range_prop)
colors_neg <- colorRampPalette(c("orange", "yellow","white"))(num_neg_colors + 1)[1:num_neg_colors]
colors_pos <- colorRampPalette(c("white", "cyan3", "purple4"))(num_pos_colors + 1)[2:(num_pos_colors + 1)]
final_palette <- c(colors_neg, colors_pos)

npal2 <- colorNumeric(palette = final_palette, domain = nras_df)

# Above ground biodensity (AGBD)

#gedi_ras <- project(gedi_ras,"EPSG:4326")
srs <- srs[!is.na(srs$agbd),]
srs$agbd[is.nan(srs$agbd)] <- NA
agbd_pal <- colorNumeric(palette = "Greens", domain = as.data.frame(srs$agbd, na.rm=TRUE))
