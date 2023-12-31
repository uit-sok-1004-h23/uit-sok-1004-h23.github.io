## ----setup, include=FALSE-----------------------------------------------------------------------------------------------------------------------
knitr::opts_chunk$set(echo = TRUE)
knitr::opts_chunk$set(comment=NA)


## -----------------------------------------------------------------------------------------------------------------------------------------------
library(PxWebApiData)
library(tidyverse)


## -----------------------------------------------------------------------------------------------------------------------------------------------
variabler <- ApiData("http://data.ssb.no/api/v0/no/table/09842", returnMetaFrames = TRUE)
names(variabler)


## -----------------------------------------------------------------------------------------------------------------------------------------------
verdier <- ApiData("https://data.ssb.no/api/v0/no/table/09842/", returnMetaData = TRUE)
verdier


## -----------------------------------------------------------------------------------------------------------------------------------------------
tabell <- ApiData("https://data.ssb.no/api/v0/no/table/09842/",
                Tid = paste(1970:2019),
                ContentsCode = "BNP")


## -----------------------------------------------------------------------------------------------------------------------------------------------
head(tabell[[1]])


## -----------------------------------------------------------------------------------------------------------------------------------------------
head(tabell[[2]])


## -----------------------------------------------------------------------------------------------------------------------------------------------
bnp <- tabell[[1]]
str(bnp)


## -----------------------------------------------------------------------------------------------------------------------------------------------
bnp <- bnp %>%
  mutate(år=parse_number(år)) %>% 
  rename(BNP=value)
str(bnp)
head(bnp)


## -----------------------------------------------------------------------------------------------------------------------------------------------
bnp %>%
  ggplot(aes(x=år, y=BNP)) +
  geom_line()


## -----------------------------------------------------------------------------------------------------------------------------------------------
bnp %>%
  ggplot(aes(x=år, y=BNP)) +
  geom_line(color="dark blue") +
  scale_y_continuous(labels = scales::comma) +
  labs(title="Bruttonasjonalprodukt - BNP \n (kr per innbygger)",
       x =" ",
       y = "kr per innbygger") +
  theme_bw()


## -----------------------------------------------------------------------------------------------------------------------------------------------
bnp %>% 
  mutate(BNP_L1=lag(BNP)) %>% 
  head()


## -----------------------------------------------------------------------------------------------------------------------------------------------
bnp %>% 
  mutate(BNP_L1=lag(BNP),
         dBNP=BNP-BNP_L1) %>% 
  head()


## -----------------------------------------------------------------------------------------------------------------------------------------------
bnp %>% 
  mutate(dBNP=BNP-lag(BNP)) %>% 
  head()


## -----------------------------------------------------------------------------------------------------------------------------------------------
bnp %>%
  mutate(prosBNP = 100*(BNP - lag(BNP))/lag(BNP)) %>%
  head()


## -----------------------------------------------------------------------------------------------------------------------------------------------
bnp %>%
  mutate(prosBNP = 100*(BNP - lag(BNP))/lag(BNP)) %>%
  ggplot(aes(x=år, y=prosBNP)) +
  geom_line()


## -----------------------------------------------------------------------------------------------------------------------------------------------
bnp %>%
  mutate(prosBNP = 100*(BNP - lag(BNP))/lag(BNP)) %>%
  filter(år >=1971) %>% 
  ggplot(aes(x=år, y=prosBNP)) +
  geom_line(color="dark red") +
  labs(title="Prosentvis endring i bruttonasjonalprodukt - BNP",
       x =" ",
       y = "prosent") +
  theme_bw()


## ---- eval=FALSE--------------------------------------------------------------------------------------------------------------------------------
bnp %>%
  mutate(prosBNP = 100*(BNP - lag(BNP))/lag(BNP)) %>%
  filter(år >=1971) %>% 
  ___(prosBNP)


## -----------------------------------------------------------------------------------------------------------------------------------------------
bnp %>%
  mutate(prosBNP = 100*(BNP - lag(BNP))/lag(BNP)) %>%
  filter(år >=1971) %>%
  mutate(tiår = år - år %% 10) %>%
  group_by(tiår) %>% 
  mutate(snittBNP=mean(prosBNP)) %>%
  ggplot(aes(x=år)) +
  geom_line(aes(y=prosBNP), color="dark red") +
  geom_step(aes(y=snittBNP), color="steelblue", linetype="dashed") +
  labs(title="Prosentvis endring i bruttonasjonalprodukt - BNP \n (gjennomsnitt per tiår)",
       x=" ",
       y="prosent") +
  theme_bw()


## ----echo=TRUE, eval=FALSE----------------------------------------------------------------------------------------------------------------------
getwd()
setwd("~/undervisning/SOK1004")
knitr::purl("case_1_bnp.Rmd")

