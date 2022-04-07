## ----setup, include=FALSE----------------------------------------------------------------------------------
#knitr::opts_chunk$set(echo = TRUE)
#knitr::opts_chunk$set(comment=NA)


## ----------------------------------------------------------------------------------------------------------
library(data.table)
kpi_csv <- fread("http://data.ssb.no/api/v0/dataset/1086.csv?lang=no")
kpi_csv


## ----------------------------------------------------------------------------------------------------------
library(rjstat)
url <- "http://data.ssb.no/api/v0/dataset/1086.json?lang=no"
kpi_json <- fromJSONstat(url)
str(kpi_json)


## ----------------------------------------------------------------------------------------------------------
tabell <- kpi_json[[1]]
str(tabell)
head(tabell)


## ----------------------------------------------------------------------------------------------------------
suppressPackageStartupMessages(library(tidyverse))

tabell %>%
  group_by(statistikkvariabel) %>%
  summarise(n=n())


## ----------------------------------------------------------------------------------------------------------
kpi <- 
  tabell %>%
  filter(statistikkvariabel=="Konsumprisindeks (2015=100)") %>% 
  as_tibble()

kpi


## ----------------------------------------------------------------------------------------------------------
library(lubridate)
kpi <-
  kpi %>%
  separate(måned, into=c("år", "måned"), sep="M") %>% 
  mutate(dato=ymd(paste(år, måned, "1"))) %>% 
  select(dato, konsumgruppe, statistikkvariabel, value)

kpi


## ----------------------------------------------------------------------------------------------------------
kpi %>%
  ggplot(aes(x=dato, y=value)) + 
  geom_line()


## ----------------------------------------------------------------------------------------------------------
kpi %>%
  ggplot(aes(x=dato, y=value)) + 
  geom_line(col="dark blue") +
  labs(title="Konsumprisindeks - KPI \n Totalindeks (2015=100)",
       x =" ",
       y = "Totalindeks") +
  theme_bw()


## ----------------------------------------------------------------------------------------------------------
kpi %>%
  filter(dato >= "2015-01-01" & dato <= "2015-12-01")


## ----------------------------------------------------------------------------------------------------------
kpi %>%
  mutate(year=year(dato)) %>% 
  filter(year==2015) %>%
  summarise(mean(value))


## ----------------------------------------------------------------------------------------------------------
kpi %>%
  mutate(year=year(dato)) %>% 
  filter(year==2010) %>%
  summarise(mean(value))


## ----------------------------------------------------------------------------------------------------------
b2010 <- 
  kpi %>%
  mutate(year=year(dato)) %>% 
  filter(year==2010) %>%
  summarise(ny_basis_2010=mean(value))

kpi <- 
  kpi %>%
  mutate(KPI_2010=100*value/b2010$ny_basis_2010)


## ----------------------------------------------------------------------------------------------------------
kpi %>%
  rename(KPI_2015=value) %>%
  select(dato, KPI_2010, KPI_2015) %>% 
  pivot_longer(-dato,
               names_to = "KPI",
               values_to = "indeks") %>% 
  ggplot(aes(x=dato, y=indeks, col=KPI)) +
           geom_line() +
  labs(title="Konsumprisindeks - KPI",
       x =" ",
       y = "Totalindeks") +
  theme_bw()


## ----------------------------------------------------------------------------------------------------------
tabell2 <-
  tabell %>%
  filter(statistikkvariabel != "12-måneders endring (prosent)") %>% 
  separate(måned, into = c("år", "måned"), sep="M") %>% 
  mutate(dato = ymd(paste(år, måned, "1"))) %>% 
  select(dato, statistikkvariabel, value) %>% 
  pivot_wider(names_from = "statistikkvariabel") %>% 
  rename(KPI = "Konsumprisindeks (2015=100)",
         SSB_dp ="Månedsendring (prosent)") %>% 
  mutate(dp  = 100*(KPI - lag(KPI))/lag(KPI),
         lndp.v1 = 100*(log(KPI) - log(lag(KPI))),
         lndp.v2 = c(NA, 100*diff(log(KPI))))

head(tabell2)


## ----------------------------------------------------------------------------------------------------------
tabell2 %>%
  filter(dato >= "1979-02-01") %>%
  mutate(positiv=lndp.v2 >= 0) %>% 
  ggplot(aes(x=dato, y=lndp.v2, fill=positiv)) +
  geom_col(position = "identity") +
  scale_fill_manual(values = c("dark red", "dark blue"), guide = FALSE) +
  labs(title="Prosentvis endring i konsumprisindeksen \n Totalindeks (2015=100)",
       x = " ",
       y = "Prosent") +
  theme_bw()


## ----------------------------------------------------------------------------------------------------------
tabell2 %>%
  filter(dato >= "1979-02-01") %>%
  select(dato, lndp.v2) %>% 
  mutate(kumulativKPI=cumsum(lndp.v2)) %>% 
  ggplot(aes(x=dato, y=kumulativKPI)) +
  geom_line(col="dark green") +
  labs(title="Kumulativ endring i konsumprisindeksen \n Totalindeks (2015=100)",
       x = " ",
       y = "Prosent") +
  theme_bw()



