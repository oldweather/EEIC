# R script to make an annual box and whisker plot of the AT anomalies

library(lattice)
sts<-read.table('HadCM3_pseudo_obs_slp',header=F)
x=rep(0,0)
y=rep(0,0)
for(i in seq(2,length(sts))) { 
   sety = paste(c("yd=sts$",names(sts)[i]),collapse="")
   eval(parse(text=sety))
   year = sub ('/.*','',sts$V1)
   x=append(x,year)
   y=append(y,yd/100)
}
postscript(file="pre_pseudo_bwplot.ps",paper="a4",family='Helvetica',pointsize=16)
bwplot(y~x,xlab='Year',
           ylab='Pressure anomaly (hPa)',
           ylim=c(-30,30),
           xlim=c(0,43),
           scales=list(x=list(at=seq(3,43,5),
                              labels=as.character(seq(1795,1840,5))),
                       y=list(at=c(-25,-20,-15,-10,-5,0,5,10,15,20,25)))
      )
