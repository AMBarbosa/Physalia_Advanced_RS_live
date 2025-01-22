library(imageRy)
library(terra)

im.list()
grep("sentinel", im.list(), value = TRUE)

sendol <- im.import("sentinel.dolomites")

im.plotRGB(sendol)

ndvi <- im.ndvi(sendol, nir = 4, red = 3)

plot(ndvi)

library(imageRy)
library(terra)
library(colorblindcheck)
library(colorblindr)
library(patchwork)
library(cblindplot)


im.list()
grep("sentinel", im.list(), value = TRUE)

sendol <- im.import("sentinel.dolomites")

im.plotRGB(sendol)

ndvi <- im.ndvi(sendol, nir = 4, red = 3)

plot(ndvi)

clgr <- colorRampPalette(c("black","dark grey","light grey"))(100)
clbr <- colorRampPalette(c("blue","white","red"))(100)
clbg <- colorRampPalette(c("brown","yellow","green"))(100)

plot(ndvi, col = clgr)
plot(ndvi, col = clbr)
plot(ndvi, col = clbg)

par(mfrow = c(2, 2))
plot(ndvi, mar=c(1, 1, 1, 1))
plot(ndvi, col = clgr, mar=c(1, 1, 1, 1))
plot(ndvi, col = clbr, mar=c(1, 1, 1, 1))
plot(ndvi, col = clbg, mar=c(1, 1, 1, 1))


palraw <- colorRampPalette(c("red", "orange", "red", "chartreuse", "cyan",
                             "blue"))(100)
palraw_grey <- colorRampPalette(c("dark orange", "orange", "grey", "dark grey",
                                  "light grey", "blue"))(100)

par(mfrow = c(1, 2))
plot(ndvi, col = palraw, mar=c(1, 1, 1, 1))
plot(ndvi, col = palraw_grey, mar=c(1, 1, 1, 1))

vinicunca <- rast("~marcia/Downloads/vinicunca.jpg")

vinicunca <- flip(vinicunca)  # because my OS imported it upside down, as it is not georeferenced

plot(vinicunca)

par(mfrow = c(1, 1))

im.plotRGB(vinicunca, 1, 2, 3, title = "Standard vision")

# simulate how colorblind people see this image:

im.plotRGB(vinicunca, 2, 2, 3, title = "Protanopia")  # skip red

im.plotRGB(vinicunca, 1, 2, 2, title = "Protanopia")  # skip blue

im.plotRGB(vinicunca, 1, 2, 2, title = "Protanopia")  # skip blue


# simulation of color vision deficiencies ####

rainbow_pal <- rainbow(7)

colorblindcheck::palette_check(rainbow_pal, plot = TRUE)


# colorblindr ####

head(iris)

explot <- ggplot(iris, aes(Sepal.Length, fill=Species)) +
  geom_density(alpha=0.7)

explot


colorblindr::cvd_grid(explot)


explot2 <- ggplot(iris, aes(Sepal.Length, fill = Species)) + 
  geom_density(alpha=0.7) + scale_fill_OkabeIto()

explot2

explot + explot2

colorblindr::cvd_grid(explot2)


cblindplot::cblind.plot(vinicunca, cvd= "protanopia")


rainbow <- flip(rast("~marcia/Downloads/rainbow.jpg"))

plot(rainbow)

cblindplot::cblind.plot(rainbow, cvd= "protanopia")

cblindplot::cblind.plot(rainbow, cvd= "deuteranopia")

cblindplot::cblind.plot(rainbow, cvd= "tritanopia")

