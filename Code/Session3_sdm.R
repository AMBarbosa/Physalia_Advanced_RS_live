library(sdm)
# library(raster)  # no longer needed - use terra instead
library(terra)
# library(viridis)  # not needed here - viridis is now the default terra palette


file <- system.file("external/species.shp", package="sdm") 


# species <- shapefile(file)
species <- vect(file)

plot(species)


# plot(species[species$Occurrence == 1,],col='blue',pch=16)
# points(species[species$Occurrence == 0,],col='red',pch=16)

head(species)  # see first rows of attributes table

plot(species, "Occurrence", col = c("orange", "blue"))  # color according to values in specified column


path <- system.file("external", package="sdm") 

lst <- list.files(path=path,pattern='asc$',full.names = T) #



# stack

# preds <- stack(lst)
preds <- rast(lst)



# plot predictors and occurrences

head(species)

occ <- subset(species, species$Occurrence == 1)


names(preds)


plot(preds$elevation, main="elevation")
points(occ)

plot(preds$temperature, main="temperature")
points(occ)

plot(preds$precipitation, main="precipitation")
points(occ)

plot(preds$vegetation, main="vegetation")
points(occ)


# model

# set the data for the sdm
datasdm <- sdmData(train=species, predictors=preds)

datasdm


m1 <- sdm(Occurrence ~ elevation + precipitation + temperature + vegetation, data=datasdm, methods = "glm")

m1


# make the raster output layer

p1 <- predict(m1, newdata=preds) 


# plot the output

plot(p1)

points(occ)
