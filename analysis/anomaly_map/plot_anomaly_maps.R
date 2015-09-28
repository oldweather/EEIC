# R script to plot anomaly map from PP fields

library(PP.map)
f=pp.ppa('anoms.pp')

postscript(file='at_anomaly.ps',paper='a4',horizontal=T,pointsize=14)
pp.map(f[[1]],lon_range=c(-60,180),levels=c(-5,-4,-3,-2,-1,-.5,.5,1,2,3,4,5))

postscript(file='sst_anomaly.ps',paper='a4',horizontal=T,pointsize=14)
pp.map(f[[2]],lon_range=c(-60,180),levels=c(-5,-4,-3,-2,-1,-.5,.5,1,2,3,4,5))

postscript(file='pre_anomaly.ps',paper='a4',horizontal=T,pointsize=14)
pp.map(f[[3]],lon_range=c(-60,180),levels=c(-20,-10,-8,-6,-4,-2,-1,1,2,4,6,8,10,20))

postscript(file='ws_anomaly.ps',paper='a4',horizontal=T,pointsize=14)
pp.map(f[[4]],lon_range=c(-60,180),levels=c(-10,-8,-6,-4,-2,-1,1,2,4,6,8,10))
