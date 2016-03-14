

macleish <- etl("macleish") %>%
  etl_extract() %>%
  etl_transform() %>%
  etl_load()

whately_2015 <- macleish %>%
  tbl("whately") %>%
  mutate(the_year = strftime('%Y', when)) %>%
  collect() %>%
  filter(the_year == 2015)

orchard_2015 <- macleish %>%
  tbl("orchard") %>%
  mutate(the_year = strftime('%Y', when)) %>%
  collect() %>%
  filter(the_year == 2015)

save(whately_2015, file = "data/whately_2015.rda", compress = "xz")
save(orchard_2015, file = "data/orchard_2015.rda", compress = "xz")