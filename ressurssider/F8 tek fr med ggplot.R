# Vi skal bruke ggplot til å tegne funksjoner som viser tek fremgang

#slett minne

rm(list = ls())

# last inn tidyverse og mosiac
# mosaic må installeres om du ikke har den fra før

library(tidyverse)
library(mosaic)

# vi lager oss noen tall for x-variablen (arbeidskraft)

x <- seq(0, 10, by = 0.1)

# gjør om til data frame

df <- data.frame(x)

#lag aksen for tegningen

axes_1 <- ggplot(df, aes(x))+
  labs(title="Teknologisk fremgang 1: y=ax^b med økning i a", 
    x="Arbeidskraft",
    y="Produksjon")

# vi angir våre produktfunksjoner

prod_1 <- function(x) 2*x^0.5
prod_2 <- function(x) 4*x^0.5

# Vi legger funksjonene på vår akse
# legger også på en linje som viser produksjon = 5

figur_a <- axes_1 + 
  stat_function(df,
        fun=prod_1,
        mapping = aes(color = "prod_1")
        ) +
  stat_function(df,
                fun=prod_2,
                mapping = aes(color = "prod_2")
  ) +
  scale_color_manual(name = "Produktfunksjoner",
                     values = c("blue", "red"),
                     labels = c("2x^0.5", "4x^0.5")
  ) +
  geom_hline(yintercept =5)
figur_a
          
# Vi bruker pakken mosaic til å beregne x (arbeidskraft) som gir produksjon = 5

løs_1 <- findZeros(prod_1(x)-5~x, xlim = range(0,10))
løs_2 <- findZeros(prod_2(x)-5~x, xlim = range(0,10))

# vi tegner vertikale linjer på løsningspunktet

figur_a +
  geom_segment(aes(x=as.numeric(løs_1), y=0, xend=as.numeric(løs_1),yend=5))+
  geom_segment(aes(x=as.numeric(løs_2), y=0, xend=as.numeric(løs_2),yend=5))

# alternativt med vline (gir en lang linje)
#  geom_vline(xintercept=as.numeric(løs_1))+
# geom_vline(xintercept=as.numeric(løs_2))

# løsningen 
løs_1
løs_2

# La oss se på effekten av å øke b

# tilpass koden ovenfor

axes_b <- ggplot(df, aes(x))+
  labs(title="Teknologisk fremgang 2: y=ax^b med økning i b", 
       x="Arbeidskraft",
       y="Produksjon")

# vi angir våre produktfunksjoner


prod_2b <- function(x) 2*x^0.75

# Vi legger funksjonene på vår akse
# legger også på en linje som viser produksjon = 5

figur_b <- axes_b + 
  stat_function(df,
                fun=prod_1,
                mapping = aes(color = "prod_1")
  ) +
  stat_function(df,
                fun=prod_2b,
                mapping = aes(color = "prod_2b")
  ) +
  scale_color_manual(name = "Produktfunksjoner",
                     values = c("blue", "red"),
                     labels = c("2x^0.5", "2x^0.75")
  ) +
  geom_hline(yintercept =5)
figur_b

# Vi bruker pakken mosaic til å beregne x (arbeidskraft) som gir produksjon = 5


løs_2b <- findZeros(prod_2b(x)-5~x, xlim = range(0,10))

# vi tegne vertikale linjer på løsningspunktet

figur_b +
  geom_segment(aes(x=as.numeric(løs_1), y=0, xend=as.numeric(løs_1),yend=5))+
  geom_segment(aes(x=as.numeric(løs_2b), y=0, xend=as.numeric(løs_2b),yend=5))

# løsningen 
løs_1
løs_2b



