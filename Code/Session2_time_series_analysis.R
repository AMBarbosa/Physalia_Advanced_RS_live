library(terra)
library(imageRy)

grep("sentinel", im.list(), value = T)

grep("EN_", im.list(), value = T)

EN <- im.import("EN_")
EN  # 39 layers... each image has 3

EN01 <- im.import("EN_01")
EN13 <- im.import("EN_13")

par(mfrow = c(1, 2))
plot(EN01)
plot(EN13)

diffEN <- EN01[[1]] - EN13[[1]]
par(mfrow = c(1, 1))
plot(diffEN)

# plot(countries, add = TRUE)



gr <- im.import("greenland")

grt <- c(gr[[1]], gr[[4]])
plot(grt, nc = 1)


# biomass

grep("NDVI_", im.list(), value = T)

ndvi <- im.import("Sentinel2_NDVI_")


# ridge line plots

im.ridgeline(im = ndvi, scale = 1)

names(ndvi) <- c("02_Feb", "05_May", "08_Aug", "11_Nov")

im.ridgeline(im = ndvi, scale = 2, palette = "rocket")


# RGB scheme

im.plotRGB(ndvi, r=1, g=2, b=3)

im.plotRGB(ndvi, r=3, g=2, b=1)
