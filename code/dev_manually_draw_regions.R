






library(sf)
library(mapedit)

data = mapedit::drawFeatures() %>% st_transform(crs = 4326)




# sf_sne = data %>% mutate(location = "Southern New England")
# sf_gom = data %>% mutate(location = "Gule of Maine")
# sf_sa = data %>% mutate(location = "South Atlantic")
# sf_njny = data %>% mutate(location = "New York/New Jersey Bight")
# sf_ma = data %>% mutate(location = "Mid Atlantic")
# sf_ = data %>% mutate(location = "")

bind_rows(
  sf_sne
  ,sf_gom
  ,sf_sa
  ,sf_njny
  ,sf_ma

) %>% write_sf(
  here::here("data", "regional_locations_polys.gpkg")
)


















