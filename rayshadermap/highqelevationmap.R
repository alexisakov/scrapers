library(GADMTools)
library(rayshader)
library(elevatr)
library(raster)
library(sf)
library(rgl)

setwd(getSrcDirectory()[1])

ru <- gadm_sf_import_shp(dir = "./gadm40_RUS_shp"
                         , name = "gadm40_RUS_1"
                         , level = 1
                         , keepall = TRUE)
listNames(ru, level = 1)

thisregion = "Dagestan";

reg = gadm_subset(ru, level = 1, regions = c(thisregion))
  
gadm_plot(reg)

unlink("reg/*",recursive=TRUE, force=TRUE)
gadm_exportToShapefile(reg, "reg")
reg <- st_read("./reg")

get_elev_raster(reg, z = 10, clip = "location") -> demc

raster_to_matrix(demc) -> mat

# optional
# (mat[mat < -15] <- 0)

# window sizing
w <- nrow(mat)
h <- ncol(mat)
wr <- w / max(c(w,h))
hr <- h / max(c(w,h))
if (min(c(wr, hr)) < .75) {
  if (wr < .75) {
    wr <- .75
  } else {
    hr <- .75
  }
}

# we set to our color palet - should be changed
colors3 = grDevices::colorRampPalette(
  c("#386a8e","#4da6b6","#f8deae","#d44439")
  , bias = 6 # bias 0.5 is too low, 1.5 better but no read
  , space = c("rgb"),
  , interpolate = c("linear")
)(256)

rgl::rgl.close()
mat %>%
  height_shade(
    texture = colors3
    #, range = c(40, max(mat, na.rm = TRUE) )
    ) %>%
  plot_3d(mat
          , windowsize = c(800*wr,800*hr) 
          , solid = FALSE
          , zscale = 40
          , phi = 90
          , zoom = .9
          , theta = 0)


# get this file and save in the dir
# https://dl.polyhaven.org/file/ph-assets/HDRIs/hdr/4k/phalzer_forest_01_4k.hdr


# if previous plot looks ok - render it - takes some time
render_highquality(
  "gcnp_highres.png"
  , parallel = TRUE
  , samples = 300
  , light = FALSE
  , interactive = FALSE
  , environment_light = "phalzer_forest_01_4k.hdr"
  , intensity_env = 1.5
  , rotate_env = 180
  , width = round(6000 * wr)
  , height = round(6000 * hr)
)