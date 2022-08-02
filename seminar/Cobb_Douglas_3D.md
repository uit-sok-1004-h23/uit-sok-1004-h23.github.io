#Plotte en Cobb-Douglas produktfunksjon med produksjonsfaktorer 
#arbeidskraft (L) og kapital (K)
#y=A*L^b*K^(1-b)

#bruk pakkene mosaic og manipulate (pga 3d tegning med slider)
#NB installer manipulate om du ikke har dette fra før

library(mosaic)
library(manipulate)


plotFun(A * (L ** b) * (K ** 1-b) ~ L & K,
        A = 5, b=.5, 
        xlim = range(0, 20), ylim = range(0, 20), 
        surface = TRUE, xlab="arbeidskraft", ylab="kapital", zlab="mengde")
