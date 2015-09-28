# R script to plot anomaly map from PP fields

library(PP.map)
f=pp.ppa('anoms.pp')

postscript(file='pre_anomaly_map.ps',paper='a4',horizontal=T,pointsize=14)
pp.map(f[[1]],lon_range=c(-60,180),levels=c(-40,-30,-20,-10,-8,-6,-4,-2,-1,1,2,4,6,8,10,20,30,40))
