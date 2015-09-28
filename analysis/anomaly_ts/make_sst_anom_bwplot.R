# R script to make an annual box and whisker plot of the AT anomalies

library(lattice)
sts<-read.table('sst_anoms.out',header=T)
x=rep(0,0)
y=rep(0,0)
for(i in seq(2,length(sts))) { 
   sety = paste(c("yd=sts$",names(sts)[i]),collapse="")
   eval(parse(text=sety))
   year = sub ('/.*','',sts$Date)
   x=append(x,year)
   y=append(y,yd)
}
postscript(file="sst_anom_bwplot.ps",paper="a4",family='Helvetica',pointsize=16)
bwplot(y~x,xlab='Year',
           ylab='Temperature anomaly (C)',
           ylim=c(-7,7),
           xlim=c(0,43),
           scales=list(x=list(at=seq(3,43,5),
                              labels=as.character(seq(1795,1840,5))),
                       y=list(at=c(-7,-6,-5,-4,-3,-2,-1,0,1,2,3,4,5,6,7)))
      )
