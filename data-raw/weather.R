# Creates 2015 data for Whately and Orchard

macleish <- etl("macleish") %>%
  etl_extract() %>%
  etl_transform() %>%
  etl_load()

# Do the date computations in SQLite to save memory
whately_2015 <- macleish %>%
  tbl("whately") %>%
  mutate(the_datetime = datetime(when, 'unixepoch')) %>%
  mutate(the_year = as.numeric(strftime('%Y', when, 'unixepoch'))) %>%
  filter(the_year == 2015) %>%
  collect() %>%
  mutate(when = as.POSIXct(the_datetime)) %>%
  select(-the_datetime, -the_year)

# collect first and do the date computations in R
orchard_2015 <- macleish %>%
  tbl("orchard") %>%
  collect() %>%
  mutate(when = as.POSIXct(when, origin = "1970-01-01")) %>%
  filter(lubridate::year(when) == 2015)

save(whately_2015, file = "data/whately_2015.rda", compress = "xz")
save(orchard_2015, file = "data/orchard_2015.rda", compress = "xz")
