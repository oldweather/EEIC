# R script to make an annual box and whisker plot of the Sympiesompeter anomalies

library(lattice)
sts<-read.table('sym_anoms.out',header=T)
x=rep(0,0)
y=rep(0,0)
for(i in seq(2,length(sts))) { 
   sety = paste(c("yd=sts$",names(sts)[i]),collapse="")
   eval(parse(text=sety))
   year = sub ('/.*','',sts$Date)
   x=append(x,rep(gsub('_',' ',names(sts)[i]),length(yd)))
   y=append(y,yd)
}
postscript(file="sym_anom_bwplot_byShip.ps",paper="a4",family='Helvetica',pointsize=16,horizontal=T)
bwplot(x~y,xlab='Pressure anomaly (hPa)',
           xlim=c(-60,40),
      )
