#Plotte nivåkurver (produksjonsisokvanter) til Cobb-Douglas produktfunksjon med produksjonsfaktorer 
#arbeidskraft (L) og kapital (K)
#y=A*L^b*K^(1-b)

#bruk mosaic 
library(mosaic)



#Plot isokvanter for A=5, b=0.5

plotFun(A * (L ^ b) * (K ^ (1-b)) ~ L & K,
        A = 5, b=0.5, filled=FALSE,
        xlim = range(0, 20),
        ylim = range(0, 20), 
        xlab="arbeidskraft", ylab="kapital", main="Produksjonsisokvanter Cobb-Douglas")
