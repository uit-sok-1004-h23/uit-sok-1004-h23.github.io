{% include navbar.html %}
# dette er en kommentar
# husk cheatsheets på rstudio.com

# kan starte nettleser fra RStudio
#browseURL("https://ourworldindata.org/co2-and-other-greenhouse-gas-emissions")

# lese CO2 data fra csv
library(readr)
co2data <- read_csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

# se på data i konsoll
co2data

# husk å sjekk kodeboka, hva er det variablene måler?

# lese data fra xlsx
# library(readxl)
# url <- "https://github.com/owid/co2-data/raw/master/owid-co2-data.xlsx"
# destfile <- "owid_co2_data.xlsx"
# curl::curl_download(url, destfile)
# co2data2 <- read_excel(destfile)

# $ velger en kolonne (variabel) i dataene
unique(co2data$country)

# hvor mange country kategorier er det?
length(unique(co2data$country))

# nå kan vi benytte "piping" %>% 
library(tidyverse)

# samme som unique over, men i tidyverse
co2data %>% select(country) %>% distinct()

# samme som length over, men i tidyverse
co2data %>% select(country) %>% n_distinct()

# pivotabell på land, n() gir antall observasjoner
co2data %>%
  group_by(country) %>% 
  summarise(n())

# lagrer som land data, og kaller antall obsevasjoner n
land <-
  co2data %>%
  group_by(country) %>% 
  summarise(n=n())

# sorterer på antall observasjoner
land %>% arrange(n)

# lager et plot av Norge
co2data %>%
  filter(country =="Norway") %>% 
  ggplot(aes(x=year, y=co2)) + geom_line()

# mutate: fra co2 målt i millioner av tonn til tonn ( x 1000000 eller 1e6)
co2data %>%
  mutate(co2_tonn=1e6*co2) %>% 
  filter(country =="Norway") %>% 
  ggplot(aes(x=year, y=co2_tonn)) + geom_line()
# merk hvordan aksen endrer seg, millioner tonn er bedre

# lager et plot av Norge og Sverige
co2data %>%
  filter(country %in% c("Norway", "Sweden")) %>% 
  ggplot(aes(x=year, y=co2, color=country)) + geom_line()

# Oppgave: co2, lag et plot av Norge og Kina
co2data %>%
  filter(country %in% c("Norway", "China")) %>% 
  ggplot(aes(x=year, y=co2, color=country)) + geom_line()
# dette funker ikke

# Oppgave: co2_per_capita, lag et plot av Norge og Kina per capita
co2data %>%
  filter(country %in% c("Norway", "China")) %>% 
  ggplot(aes(x=year, y=co2_per_capita, color=country)) + geom_line() 
  
# Legg til ny farge, tittel og lag nye labler på aksen + theme
co2data %>%
  filter(country %in% c("Norway", "China")) %>% 
  ggplot(aes(x=year, y=co2_per_capita, color=country)) + geom_line() +
  scale_color_manual(values=c("#56B4E9", "#E69F00")) +
  theme_bw() + 
  ggtitle("CO2 utslipp per år") + 
  xlab("År") +
  ylab("Tonn per capita")
  
# + Matematisk notasjon og tykkere linjer
co2data %>%
  filter(country %in% c("Norway", "China")) %>% 
  ggplot(aes(x=year, y=co2_per_capita, color=country)) + geom_line(lwd=2) +
  scale_color_manual(values=c("#56B4E9", "#E69F00")) +
  theme_bw() + 
  ggtitle(expression(CO[2]~utslipp~per~år)) + 
  xlab("År") +
  ylab("Tonn per capita")

# + endre fra engelsk til norsk variabler
# og gir variabel nytt navn og rekoder
co2data %>%
  rename(land=country) %>% 
  mutate(land=recode(land,
                     'Norway'="Norge",
                     'China'="Kina")) %>% 
  filter(land %in% c("Norge", "Kina")) %>% 
  ggplot(aes(x=year, y=co2_per_capita, color=land)) + geom_line(lwd=2) +
  scale_color_manual(values=c("#56B4E9", "#E69F00")) +
  theme_bw() + 
  ggtitle(expression(CO[2]~utslipp~per~år)) + 
  xlab("År") +
  ylab("Tonn per capita")

# vil finne totale globale utslipp (i milliarder tonn) - summarise
co2data %>%
  group_by(year) %>% 
  summarise(co2=sum(co2, na.rm = TRUE)) %>% 
  ggplot(aes(x=year, y=co2/1000)) + geom_line()
