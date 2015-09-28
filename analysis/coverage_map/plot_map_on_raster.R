# Plot coverage map against a land-sea background

library(lattice)
library(PP)
library(PNG)

f=pp.ppa('nobs.pp')
bg<-readPNG('water_160k_gmc.png')
