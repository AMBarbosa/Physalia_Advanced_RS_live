library(terra)
library(imageRy)
library(viridis)
library(ggplot2)
library(patchwork)


im.list()

b2 <- im.import("sentinel.dolomites.b2.tif")


# try other palettes:

?viridis

plot(b2, col = inferno(100))

plot(b2, col = rocket(100))

plot(b2, col = mako(100))


sent <- im.import("sentinel.dolomites")

sent
# b2 = blue, layer 1
# b3 = green, layer 2
# b4 = red, layer 3
# b8 = nir, layer 4  # (near infrared)

im.plotRGB(sent, r=3, g=2, b=1, title = "natural color")

im.plotRGB(sent, r=4, g=3, b=2, title = "false color")

im.plotRGB(sent, r=3, g=4, b=2, title = "false color")

im.plotRGB(sent, r=3, g=2, b=4, title = "false color")


# 8 bit image
# 0-255 (2^8=256 values)
# nir - red = 255 - 0 = 255

dvisent <- im.dvi(sent, 4, 3)

plot(dvisent)

# 4 bit image
# 0-15 (2^4 = 16 potential values)
# nir - red = 15 - 0 = 15

ndvisent <- im.ndvi(sent, 4, 3)

plot(ndvisent)


# multitemporal viz

im.list()[grep("mato", im.list())]

m1992 <- im.import("matogrosso_l5_1992219_lrg.jpg")

# nir = 1
# red = 2

im.plotRGB(m1992, 2, 1, 3)

m2006 <- im.import("matogrosso_ast_2006209_lrg.jpg")

ndvi1992 <- im.ndvi(m1992, 1, 2)
ndvi2006 <- im.ndvi(m2006, 1, 2)

plot(ndvi1992)
plot(ndvi2006)


# correlation among bands:

pairs(sent)
pairs(m1992)
pairs(m2006)

# 3 bands - 3*2/2 N(N-1)/2
# 4 bands - 6 correlations


# import data from outside R

setwd("~/Downloads")

sun <- rast("flare_las_2006347_lrg.jpg")

ext <- c(100, 1500, 100, 1500)

sunc <- crop(sun, ext)

plot(sunc)


# classifying data

im.classify(m2006, num_clusters = 2)

m1992c <- im.classify(m1992, num_clusters = 2)

plot(m1992c)

f1992c <- freq(m1992c)

f1992c

p1992 <- f1992c * 100 / ncell(m1992c)

p1992


# build data frame

class <- c("Forest", "Human")
y1992 <- c(83, 17)
y2006 <- c(45, 55)
tabout <- data.frame(class, y1992, y2006)


p1 <- ggplot(tabout, aes(x=class, y=y1992, color = class)) +
  geom_bar(stat = "identity", fill = "white") + 
  ylim(c(0, 100))

p2 <- ggplot(tabout, aes(x=class, y=y2006, color = class)) +
  geom_bar(stat = "identity", fill = "white") + 
  ylim(c(0, 100))


p1 + p2


# PCA ####

sentdol <- im.import("sentinel.dolomites")

im.pca(sentdol)
