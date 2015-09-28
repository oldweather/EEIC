# R script to make an annual box and whisker plot of the AT anomalies

library(grid)
library(lattice)
sts<-read.table('pre_anoms.out',header=T)
x=rep(0,0)
y=rep(0,0)
for(i in seq(2,length(sts))) { 
   sety = paste(c("yd=sts$",names(sts)[i]),collapse="")
   eval(parse(text=sety))
   year = sub ('/.*','',sts$Date)
   x=append(x,rep(gsub('_',' ',names(sts)[i]),length(yd)))
   y=append(y,yd)
}
postscript(file="pre_anom_bwplot_byShip.ps",paper="special",horizontal=T,
           width=18,height=12)

trellis.par.set(list(fontsize=list(text=10)))
pushViewport(viewport(width=0.5,height=1.0,x=0.00,y=0.00,
                      just=c("left","bottom"),name="vp1"))
lp<-bwplot(x[1:length(x)/2]~y[1:length(x)/2],
           xlab='Pressure anomaly (hPa)',
           xlim=c(-40,40),
      )
print(lp,newpage=F)
upViewport()
pushViewport(viewport(width=0.5,height=1.0,x=0.50,y=0.00,
                      just=c("left","bottom"),name="vp2"))
lp<-bwplot(x[length(x)/2+1:length(x)]~y[length(x)/2+1:length(x)],
           xlab='Pressure anomaly (hPa)',
           xlim=c(-40,40),
      )
print(lp,newpage=F)
upViewport()
