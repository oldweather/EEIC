# R script to plot map and time-series of wind speeds
library(grid)
library(lattice)
library(PP.map)

pdf(file='wind_speeds.pdf',width=6,height=8,pointsize=12)

# Map of coverage
pushViewport(viewport(width=1.0,height=0.7,x=0.0,y=0.35,
                      just=c("left","bottom"),name="vp_map"))
   f=pp.ppa('../../../analysis/anomaly_map/anoms.pp')
   m<-pp.map(f[[4]],lon_range=c(-60,180),
          draw=F,
          levels=c(-10,-8,-6,-4,-2,-1,1,2,4,6,8,10))
   print(m,newpage=F)
upViewport()

# Mean speed in each year
sts<-read.table('../../../analysis/anomaly_ts/ws_anoms.out',header=T)
x=rep(0,0)
y=rep(0,0)
for(i in seq(2,length(sts))) { 
   sety = paste(c("yd=sts$",names(sts)[i]),collapse="")
   eval(parse(text=sety))
   year = as.numeric(sub('/.*','',sts$Date))
   month = as.numeric(substr(as.character(sts$Date),6,7))
   #x=append(x,year+(month-0.5)/12)
   x=append(x,year)
   y=append(y,yd)
}
ym<-rep(0.0,1836-1790)
#yy<-seq(1790+0.5/12,1835+11.5/12,1/12)
yy<-seq(1790,1835,1)
for(i in seq(1,length(yy))) {
 ym[i]<-mean(y[x==yy[i]],trim=0.1,na.rm=T)
}

sgp = gpar(col=rgb(1,0,0,1),fill=rgb(1,0,0,1))
pushViewport(viewport(width=1.0,height=0.45,x=0.0,y=0,
                      just=c("left","bottom"),name="vp_ts"))
pushViewport(plotViewport(margins=c(4,4,1,1)))
pushViewport(dataViewport(c(1790,1835),c(-2,2)))
grid.xaxis(main=T)
grid.text('Year',y=unit(-3,"lines"))
grid.yaxis(main=T)
grid.text('Speed anomaly (m/s)',x=unit(-3,"lines"), rot=90)
popViewport()
pushViewport(dataViewport(c(1790,1835),c(-2,2),clip='on'))
grid.points(x=unit(yy,'native'),
           y=unit(ym-0.85,'native'),
           size=unit(0.02,'npc'),
           pch=20,
           gp=sgp)
grid.lines(x=unit(yy,'native'),
           y=unit(ym-0.85,'native'),
           gp=sgp)
popViewport()
popViewport()
upViewport()
