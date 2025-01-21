library(terra)
library(terra)
library(viridis)
library(rasterdiv)


im.list()
grep("sentinel", im.list(), value = TRUE)

sent <- im.import("sentinel.png")

# 1 NIR
# 2 red
# 3 green

plot(sent)

im.plotRGB(sent, 1, 2, 3)

im.plotRGB(sent, 3, 2, 1)

im.plotRGB(sent, 3, 2, 1)

im.plotRGB(sent, 1, 3, 2)


# focal

nir <- sent[[1]]

focal(nir)

sd3 <- focal(nir, matrix(1/9, 3, 3), fun = sd)

var3 <- focal(nir, matrix(1/9, 3, 3), fun = var)

plot(sd3)

plot(var3)


# Shannon entropy

ext <- c(0, 20, 0, 20)

cropnir <- crop(nir, ext)

plot(cropnir)

shan3 <- rasterdiv::Shannon(cropnir, window = 3)

plot(shan3)

# blue = 0.8  green = 0.2

H = -(0.8*log(0.8) + 0.2*log(0.2))

H


rao3 <- rasterdiv::Rao(cropnir, window = 3)

plot(rao3[[1]][[1]])


rao3 <- rasterdiv::paRao(cropnir, window = 3, alpha = 2)

plot(rao3[[1]][[1]])
