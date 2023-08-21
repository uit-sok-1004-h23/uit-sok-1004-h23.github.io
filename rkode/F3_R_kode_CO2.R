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



###########################
### kommandoen filter() ### 
###########################

filter(co2data,iso_code == "SWE")

# beskriv hva kommandoen gjør

############################################################################
### Oppgave 2: Kan du lage en tabell som viser verdiene for Norge mellom ###
### årene 2018 og 2019? Bruk en pipe! Hint: kjør "1:3" i konsollen ;-)   ### 
############################################################################




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



# kommenter figuren. gir den en god sammenligning?

#############################################################################
### Oppgave 4: Kan du lage en figur med CO2 utslipp per person for Norge, ###
### Kina, Frankrike, USA og Saudi Arabia?                                 ###
#############################################################################

countries <- c("Norway", "China", "France", "United States", "Saudi Arabia")



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



##########################################################################
### Oppgave 8: Lag en vakker graf. Legg til ny farge, tittel, lag egne ###
### benevninger på aksene, skalering, tykkere linjer. prøv deg frem!   ### 
##########################################################################

# tips: bruk xlab(), ylab(), ggtitle()...


