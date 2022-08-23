############################
### R-kode forelesning 3 ###
############################

# rydd opp
rm(list=ls())

# last inn tidyverse
library(tidyverse)

############################
### data i tibble-format ### 
############################


# les CO2 data i .csv fra OWID
co2data <- read_csv("https://raw.githubusercontent.com/owid/co2-data/master/owid-co2-data.csv")

# se: https://github.com/owid/co2-data
# se en beskrivelse av data her: https://github.com/owid/co2-data/blob/master/owid-co2-codebook.csv

# se på dataene i konsollen
co2data

###########################
### kommandoen select() ### 
###########################

select(co2data,year)

# beskriv hva kommandoen gjør

###########################################################
### Oppgave 1: Kan du skrive om kommandoen med en pipe? ### 
###########################################################

co2data %>% 
  select(year)

###########################
### kommandoen filter() ### 
###########################

filter(co2data,iso_code == "SWE")

# beskriv hva kommandoen gjør

############################################################################
### Oppgave 2: Kan du lage en tabell som viser verdiene for Norge mellom ###
### årene 2018 og 2019? Bruk en pipe! Hint: kjør "1:3" i konsollen ;-)   ### 
############################################################################

co2data %>%
  filter(iso_code == "NOR") %>%
  filter(year == 2018:2020)


# lager en figur med  Norge
co2data %>%
  filter(country =="Norway") %>% 
  ggplot(aes(x=year, y=co2)) %>%
  + geom_line() %>%
  + theme_minimal()

######################
### Kommandoen c() ###
######################

# c() er kort for "concatenate" -- et fancy begrep for å koble sammen
# nyttig for å lage lister
liste <- c("Ola", "Geir")

##########################################################################
### Oppgave 3: Kan du lage en figur med CO2 utslipp for Norge og Kina? ###
##########################################################################

### Tips: Bruk filter(var %in% c("verdi1", "verdi2))
### Tips: Bruk color = country i aes()

co2data %>%
  filter(country %in% c("Norway","China")) %>% 
  ggplot(aes(x=year, y=co2, color=country)) %>%
  + geom_line() %>%
  + theme_minimal()

# kommenter figuren. gir den en god sammenligning?

#############################################################################
### Oppgave 4: Kan du lage en figur med CO2 utslipp per person for Norge, ###
### Kina, Frankrike, USA og Saudi Arabia?                                 ###
#############################################################################

countries <- c("Norway", "China", "France", "United States", "Saudi Arabia")

co2data %>%
  filter(country %in% countries) %>% 
  filter(year >= 1990) %>%
  ggplot(aes(x=year, y=consumption_co2_per_capita, color=country)) %>%
  + geom_line() %>%
  + theme_minimal()

# beskriv figuren. hva er det vi ser? hva legger du merke til? 
# hva tror du ligger bak forskjellene? 

############################
### kommandoen arrange() ### 
############################

# vi bruker arrange til å lage en uordnet tabell
df <- co2data %>%
  arrange(gdp,methane,co2)

# skriver den ut i konsollen. 
df

##########################################################################
### Oppgave 5: Beskriv hvordan var co2data arrangert i utgangspunktet. ###
### Kan du bruke arrange() til å transformere df tilbake og lagre?     ###
##########################################################################

df <- df %>%
  arrange(country,year)

###########################
### kommandoen mutate() ### 
###########################

# Variabelen co2 viser utslipp i millioner tonn. For å få den i tonn:

co2data %>%
  mutate(co2_tonn=1e6*co2) %>% 
  filter(country =="Norway") %>% 
  ggplot(aes(x=year, y=co2_tonn)) %>%
  + geom_line() %>%
  + theme_minimal()

# variabelen consumption_co2_per_capita måler utslipp knyttet til konsum.
# variabelen co2_per_capita måler

##############################################################################
### Oppgave 6: Variabelen consumption_co2_per_capita måler utslipp knyttet ###
### til konsum. Bruk mutate() til å lage en variabel som viser utslipp per ###
### capita utenom konsum. Gjenskap figuren med Norge, USA, Kina, Frankrike ###
### og Saudi Arabia. Kommenter. Ble du overrasket?                         ###
##############################################################################

countries <- c("Norway", "China", "France", "United States", "Saudi Arabia")

co2data %>%
  mutate(non_consumption_co2_per_capita = co2_per_capita - consumption_co2_per_capita) %>% 
  filter(country %in% countries) %>% 
  filter(year >= 1990) %>% 
  ggplot(aes(x=year, y=non_consumption_co2_per_capita, color = country)) %>%
  + geom_line() %>%
  + theme_minimal()

##############################
### kommandoen summarise() ### 
##############################

# n() gir antall observasjoner
co2data %>%
  group_by(year) %>% 
  summarise(sum = sum(co2), n=n())

###################################################################
### Oppgave 7: Lag en figur med totale globale utslipp over tid ### 
###################################################################

# tips, bruk na.rm = TRUE i summarise() for å fjerne manglende observasjoner

co2data %>%
  group_by(year) %>% 
  summarise(co2=sum(co2, na.rm = TRUE)) %>% 
  ggplot(aes(x=year, y=co2)) %>% 
  + geom_line() %>%
  + theme_minimal()

##########################################################################
### Oppgave 8: Lag en vakker graf. Legg til ny farge, tittel, lag egne ###
### benevninger på aksene, skalering, tykkere linjer. prøv deg frem!   ### 
##########################################################################

# tips: bruk xlab(), ylab(), ggtitle()...

co2data %>%
  group_by(year) %>% 
  summarise(co2=sum(co2, na.rm = TRUE)) %>% 
  filter(year >= 1800) %>%
  ggplot(aes(x=year, y=log(co2))) %>% 
  + geom_line(color = "red", lwd=1) %>%
  + theme_minimal() %>%
  + xlab("År") %>%
  + ylab("Log av millioner tonn CO2") %>%
  +  ggtitle("Globale CO2 utslipp per år, logaritmisk skala, 1800 - 2020") 


co2data %>%
  filter(country %in% c("Norway", "Sweden"), year >= 1950) %>% 
  ggplot(aes(x=year, y=co2, color = country)) %>% 
  + geom_line(lwd=1) %>%
  + theme_minimal() %>%
  + xlab("År") %>%
  + ylab("Log av millioner tonn CO2") %>%
  + scale_fill_discrete(name = "Land", labels = c("Norge", "Sverige")) %>%
  +  ggtitle("CO2 utslipp per år, logaritmisk skala, 1950-2020") 
