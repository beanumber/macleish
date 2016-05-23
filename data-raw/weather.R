# Creates 2015 data for Whately and Orchard

macleish <- etl("macleish", dir = "~/dumps/macleish/") %>%
  etl_extract() %>%
  etl_transform() %>%
  etl_load()

# Do the date computations in SQLite to save memory
whately_2015 <- macleish %>%
  tbl("whately") %>%
  mutate(the_datetime = datetime(when)) %>%
  mutate(the_year = as.numeric(strftime('%Y', when))) %>%
  filter(the_year == 2015) %>%
  collect() %>%
  mutate(when = lubridate::ymd_hms(the_datetime)) %>%
  select(-the_datetime, -the_year)

# collect first and do the date computations in R
orchard_2015 <- macleish %>%
  tbl("orchard") %>%
  collect() %>%
  mutate(when = lubridate::ymd_hms(when)) %>%
  filter(lubridate::year(when) == 2015)

save(whately_2015, file = "data/whately_2015.rda", compress = "xz")
save(orchard_2015, file = "data/orchard_2015.rda", compress = "xz")

# check duplicate times in whately
library(ggplot2)
whately_test <- macleish %>%
  tbl("whately") %>%
  collect() %>%
  mutate(when = lubridate::ymd_hms(when)) %>%
  filter(lubridate::year(when) == 2012 & lubridate::month(when) == 12 & lubridate::day(when) == 20)
ggplot(data = whately_test, aes(x = when, y = temperature)) + geom_line()
