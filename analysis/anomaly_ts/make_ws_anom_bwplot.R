# R script to make an annual box and whisker plot of the WS anomalies

library(lattice)
sts<-read.table('ws_anoms.out',header=T)
x=rep(0,0)
y=rep(0,0)
for(i in seq(2,length(sts))) { 
   sety = paste(c("yd=sts$",names(sts)[i]),collapse="")
   eval(parse(text=sety))
   year = sub ('/.*','',sts$Date)
   x=append(x,year)
   y=append(y,yd)
}
postscript(file="ws_anom_bwplot.ps",paper="a4",family='Helvetica',pointsize=16)
bwplot(y~x,xlab='Year',
           ylab='Speed anomaly (m/s)',
           ylim=c(-20,20),
           xlim=c(0,43),
           scales=list(x=list(at=seq(3,43,5),
                              labels=as.character(seq(1795,1840,5))),
                       y=list(at=c(-20,-15,-10,-5,0,5,10,15,20)))
      )
