### Homework 7 - Zoo 800 ###
## Cody Quiroz ##
## 20-October-2025 ##

#load packages
library(sf)
library(ggplot2)
library(dplyr)
library(rnaturalearth)
library(rnaturalearthdata)
library(rnaturalearthhires)

#make data frame of all sites & coordinates. The long way.........
dam_sites <- data.frame(
  Site = c("Pheasant Branch", "Turtle Creek", "Mill Creek", "Dog Lake", "Bark River", "Kickapoo River", "Crawfish River", "Pecatonica River", "Rock River"),
  Latitude = c(43.10297, 42.637271, 46.1569, 45.8724, 43.0562, 43.398, 43.322, 42.7019, 43.6378),
  Longitude = c(-89.51914, -88.657853, -89.2591, -89.5355, -88.4422, -90.8517, -88.953, -89.86921, -88.73176)
)

#convert to spatial obj
sites_sf <- st_as_sf(dam_sites, coords = c("Longitude", "Latitude"), crs = 4326) 

#get WI basemap
usa <- ne_states(country = "United States of America", returnclass = "sf") 
wi <- usa %>% filter(name == "Wisconsin")

#plot it
ggplot() +
  geom_sf(data = wi, fill = "gray90", color = "gray40") +
  geom_sf(data = sites_sf, color = "purple3", size = 2) +
  coord_sf(xlim = c(-93, -86), ylim = c(42, 47)) +  #zooms in on WI
  theme_minimal() +
  labs(x = "Longitude", y = "Latitude") +
  theme(axis.title = element_text(size = 14, margin = margin(t = 10, r = 10, b = 10, l = 10))) + 
  geom_text(data = dam_sites, aes(x = Longitude, y = Latitude, label = Site),
          nudge_y = -0.12, size = 2) #makes it so site labels dont overlap points

#save png of plot
ggsave("Dam_Sites.png",
       width = 6, height = 5, dpi = 300, bg = "white")

