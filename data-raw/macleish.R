whately <- get_whately()
orchard <- get_orchard()

save(whately, file = "data/whately.rda", compress = "xz")
save(orchard, file = "data/orchard.rda", compress = "xz")
