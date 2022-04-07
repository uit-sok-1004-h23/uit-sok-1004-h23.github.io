## ----setup, include=FALSE-----------------------------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
knitr::opts_chunk$set(comment=NA)


## -----------------------------------------------------------------------------------------------------------------------------------------------
library(WDI)
library(tidyverse)


## -----------------------------------------------------------------------------------------------------------------------------------------------
imports <- WDIsearch('imports') %>% as_tibble()
imports


## -----------------------------------------------------------------------------------------------------------------------------------------------
df_import <- WDI(indicator = "NE.IMP.GNFS.CD", country = "all")
head(df_import)


## -----------------------------------------------------------------------------------------------------------------------------------------------
df_import %>%
  filter(country=="Norway") %>% 
  rename(import=NE.IMP.GNFS.CD,
         år=year) %>%
  mutate(import=import/1e9) %>% 
  ggplot(aes(x=år, y=import)) +
  geom_line(col="dark blue") +
  labs(title="Norsk import av varer og tjenester \n (nominelle tall)",
       x =" ",
       y = "milliarder US$") +
  theme_bw()


## -----------------------------------------------------------------------------------------------------------------------------------------------
exports <- WDIsearch('exports') %>% as_tibble()
exports


## -----------------------------------------------------------------------------------------------------------------------------------------------
df_export <- WDI(indicator = "NE.EXP.GNFS.CD", country = "all")
head(df_export)


## -----------------------------------------------------------------------------------------------------------------------------------------------
df_export %>%
  filter(country=="Norway") %>% 
  rename(eksport=NE.EXP.GNFS.CD,
         år=year) %>%
  mutate(eksport=eksport/1e9) %>% 
  ggplot(aes(x=år, y=eksport)) +
  geom_line(col="dark red") +
  labs(title="Norsk eksport av varer og tjenester \n (nominelle tall)",
       x =" ",
       y = "milliarder US$") +
  theme_bw()


## -----------------------------------------------------------------------------------------------------------------------------------------------
dframe <- left_join(df_import, df_export, by = c("iso2c", "country", "year"))
head(dframe)


## -----------------------------------------------------------------------------------------------------------------------------------------------
dframe %>%
  filter(country=="Norway") %>% 
  rename(import=NE.IMP.GNFS.CD,
         eksport=NE.EXP.GNFS.CD,
         år=year) %>%
  mutate(import=import/1e9,
         eksport=eksport/1e9) %>% 
  select(år, import, eksport) %>% 
  pivot_longer(-år, names_to="aktivitet", values_to="verdi") %>% 
  ggplot(aes(x=år, y=verdi, col=aktivitet)) +
  geom_line() +
  scale_color_manual(values=c("dark red", "dark blue")) +
  labs(title="Norsk eksport og import av varer og tjenester \n (nominelle tall)",
       x =" ",
       y = "milliarder US$") +
  theme_bw()


## -----------------------------------------------------------------------------------------------------------------------------------------------
df_export %>%
  filter(country %in% c("Norway","Sweden")) %>% 
  rename(eksport=NE.EXP.GNFS.CD,
         land=country,
         år=year) %>%
  mutate(eksport=eksport/1e9) %>% 
  ggplot(aes(x=år, y=eksport, col=land)) +
  geom_line() +
  labs(title="Eksport av varer og tjenester \n (nominelle tall)",
       x =" ",
       y = "milliarder US$") +
  theme_bw()


## ----echo=TRUE, eval=FALSE----------------------------------------------------------------------------------------------------------------------
getwd()
setwd("~/undervisning/SOK1004")
knitr::purl("case_4_global_handel.Rmd")

