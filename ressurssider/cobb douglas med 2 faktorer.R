# Plotte en Cobb-Douglas produktfunksjon med produksjonsfaktorer 
# arbeidskraft (L) og kapital (K)
# y=A*L^b*K^(1-b)

#bruk pakkene mosaic og manipulate (pga 3d tegning med slider)

library(mosaic)
library(manipulate)


plotFun(A * (L ** b) * (K ** 1-b) ~ L & K,
        A = 5, b=.5, 
        xlim = range(0, 20), ylim = range(0, 20),
        surface = TRUE, xlab="arbeidskraft", ylab="kapital", zlab="mengde" )


# Endre b

plotFun(A * (L ** b) * (K ** 1-b) ~ L & K,
        A = 5, b=.8, 
        xlim = range(0, 20), ylim = range(0, 20),
        surface = TRUE, xlab="arbeidskraft", ylab="kapital", zlab="mengde")

# Endre A

plotFun(A * (L ** b) * (K ** 1-b) ~ L & K,
        A = 10, b=.8, 
        xlim = range(0, 20), ylim = range(0, 20),
        surface = TRUE, xlab="arbeidskraft", ylab="kapital", zlab="mengde")



# Plot nivåkurver



plotFun(A * (L ^ 0.7) * (K ^ 0.3) ~ L & K,
        A = 5, filled=FALSE,
        xlim = range(0, 20),
        ylim = range(0, 20), 
        xlab="arbeidskraft", ylab="kapital", main="Nivåkurver")



# Endre elastisiteten

plotFun(A * (L ^ 0.7) * (K ^ 0.3) ~ L & K,
        A = 5, filled=FALSE, labels = FALSE,
        xlim = range(0, 20),
        ylim = range(0, 20), 
        xlab="arbeidskraft", ylab="kapital", main="Nivåkurver")
  
  plotFun(A * (L ^ 0.5) * (K ^ 0.5) ~ L & K,
          A = 5, filled=FALSE, 
          xlim = range(0, 20),
          ylim = range(0, 20),  
          labels=FALSE, add = TRUE)         

