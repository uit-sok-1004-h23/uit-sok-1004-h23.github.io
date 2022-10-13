#Plotte nivåkurver (produksjonsisokvanter) til Cobb-Douglas produktfunksjon
#med produksjonsfaktorer #arbeidskraft (L) og kapital (K) #y=AL^bK^(1-b)

#bruk mosaic

library(mosaic)

#Plot isokvanter for A=5, b=0.5

plotFun (5 * (L ^ .5) * (K ^ .5) ~ L & K, 
        filled=FALSE, K.lim = range(0, 20), L.lim = range(0, 20), 
        xlab="arbeidskraft", ylab="kapital", 
        main="Produksjonsisokvanter Cobb-Douglas")
