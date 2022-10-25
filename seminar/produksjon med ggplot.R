# Vi skal bruke ggplot til å tegne funksjoner som viser produsentens tilpasning

# Produktfunksjon Y=5*L^0.5*K^0.5
# Prisen på K er r=1, prisen på L er w=2



#slett minne

rm(list = ls())

# last inn tidyverse


library(tidyverse)


# vi lager oss noen tall for x-variabelen (L)

x <- seq(0, 21, by = .1)

# gjør om til data frame

df <- data.frame(x)

#lag aksen for tegningen

axes_1 <- ggplot(df, aes(x))+
  labs(title="Produsentens tilpasning", 
       x="Arbeidskraft (L)",
       y="Kapital (K)")+
  theme(axis.title = element_text(size = 20),
        plot.title = element_text(size = 20),
        panel.background = element_blank(),  # få hvit bakgrunn
        axis.line = element_line(colour = "black"))+  # tegne linjer for aksene
  coord_fixed(ratio = 1)+ # sikre at x og y har samme skala
  scale_x_continuous(limits = c(0, 22), expand = c(0, 0))+
  scale_y_continuous(limits = c(0, 22), expand = c(0, 0)) # begrense aksene
# samt sikre at akselinjene begynner i (0,0)

# vi angir noen isokvanter

Y_20 <- function(x) (20^2)/(25*x)
Y_40 <- function(x) (40^2)/(25*x)
Y_60 <- function(x) (60^2)/(25*x)

figur_1 <- axes_1 + 
  stat_function(df,
                fun=Y_20,
                mapping = aes()
  ) +
  stat_function(df,
                fun=Y_40,
                mapping = aes()
  ) +
  stat_function(df,
                fun=Y_60,
                mapping = aes()
  )+
  annotate("text",x=20,y=2, label="Y_20")+
  annotate("text",x=20,y=4.5, label="Y_40")+
  annotate("text",x=20,y=8.5, label="Y_60")

figur_1

