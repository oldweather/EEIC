# R script to plot a Nobs map from a PP field

library(PP.map)
f=pp.ppa('nobs.pp')
postscript(file='coverage.ps',paper='a4',horizontal=T,pointsize=14)
pp.map(f[[1]],lon_range=c(-60,180),
       levels=c(1,2,5,10,20,50,100,150,200,250,300,350,400,500,700,1000,1200,1500,1700))
