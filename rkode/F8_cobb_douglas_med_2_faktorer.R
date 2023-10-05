# Plotte en Cobb-Douglas produktfunksjon med produksjonsfaktorer 
# arbeidskraft (L) og kapital (K)
# y=A*L^b*K^(1-b)

#slett minne

rm(list = ls())

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

  
  # ChatGPT for å tegne i forskjellige farger
  #vanskelig i mosaic
  
  
  L_vals <- seq(0, 20, length.out = 100)
  K_vals <- seq(0, 20, length.out = 100)
  grid <- expand.grid(L = L_vals, K = K_vals)
  
  f1_vals <- with(grid, 5 * (L ^ 0.7) * (K ^ 0.3))
  f2_vals <- with(grid, 5 * (L ^ 0.5) * (K ^ 0.5))
  
  z1_matrix <- matrix(f1_vals, nrow = 100)
  z2_matrix <- matrix(f2_vals, nrow = 100)
  
  desired_levels <- seq(10, 80, by = 10)
  
  contour(L_vals, K_vals, z1_matrix, levels = desired_levels, col = "blue", xlab = "arbeidskraft", ylab = "kapital", main = "Nivåkurver")
  contour(L_vals, K_vals, z2_matrix, levels = desired_levels, col = "red", add = TRUE, labels="")
  