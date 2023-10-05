
# Se på en enkel produktfunksjon med 1 faktor y=Zx^a

#slett minne

rm(list = ls())

# Beregn grenseproduktivitet vha mosaic og mosaicCalc

library(mosaic)
library(mosaicCalc)

# Grenseproduktivitet mp


mp <- D(Z*x^a ~ x)
mp

# Legg merke til at dette er positivt mp=Z*a*x^(a-1)>0

# Endring i grenseprodukutiviteten

Endring_mp <- D(mp(x)~x)
Endring_mp

# Legg merke til at dette er negativt ettersom 1>a
# Endring_mp = Z*a*(a-1)*x^(a-2)

  
#Plott grenseproduktivitet for Z=2, a=.7 - blå linje
  
plotFun(mp(x,Z=2,a=.7)~x, xlim=range(0,10),
          xlab=list(label="Arbeidskraft", cex=1.5),
          ylab=list(label="MP", cex=1.5), main= "Grenseproduktivitet",
          ylim=c(0,5), col="blue") 

# Det er tydelig at grenseproduktiviteten faller!


  # plot mp for Z=2, a=.4 - rød linje

  plotFun(mp(x,Z=2,a=.4)~x, xlim=range(0,10),
          
          ylim=c(0,5), col="red", add=TRUE)

# Gjennomsnittsproduktivitet

ap <- makeFun((Z*x^a)/x ~ Z & x & a)
ap

# Hvordan endres ap når vi øker x?

Endring_ap <- D((Z*x^a)/x ~ x)
Endring_ap

# Dette kommer ut som Z * (x^(a - 1) * a)/x - (Z * x^a)/x^2
# Men kan forenkles til Z*(a-1)x^(a-2)
# som vi vet er negativ ettersom 1>a

# Tegn ap

plotFun(ap(x,Z=2,a=.7)~x, xlim=range(0,10),
        xlab=list(label="Arbeidskraft", cex=1.5),
        ylab=list(label="AP", cex=1.5), main= "Gjennomsnittsproduktivitet",
        ylim=c(0,5), col="red")
  
  plotFun(ap(x,Z=2,a=.4)~x, xlim=range(0,10),
        
        ylim=c(0,5), col="blue", add=TRUE)




# Dette faller når x øker som forventet.

# mp og ap på samme figur

plotFun(mp(x,Z=2,a=.7)~x, xlim=range(0,10),
        xlab=list(label="Arbeidskraft", cex=1.5),
        ylab=list(label="MP, AP", cex=1.5), main= "MP (blå), AP (rød)",
        ylim=c(0,5), col="blue")

  plotFun(ap(x,Z=2,a=.7)~x, xlim=range(0,10),
        ylim=c(0,5), col="red", add=TRUE)



# Grenseproduktivitet ligger under gjennomsnittsproduktivitet
# Hver arbeider som tilføyes bidrar med mindre og mindre produksjon
# Derfor faller gjennomsnittsproduktiviteten!


  