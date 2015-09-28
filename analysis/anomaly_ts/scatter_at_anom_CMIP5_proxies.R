# Compare Air temperatures as estimated by EIC obs, CMIP5 millennium runs,
#  and CMIP4 proxy reconstructions.

library(grid)
library(RColorBrewer)
# Ob anomalies
sts<-read.table('at_anoms.out',header=T)
x=rep(0,0)
y=rep(0,0)
for(i in seq(2,length(sts))) { 
   sety = paste(c("yd=sts$",names(sts)[i]),collapse="")
   eval(parse(text=sety))
   year = as.numeric(sub ('/.*','',sts$Date))
   month = as.numeric(substr(as.character(sts$Date),6,7))
#   x=append(x,year+(month-0.5)/12)
   x=append(x,year)
   y=append(y,yd)
}
ym<-rep(0.0,1836-1790)
#yy<-seq(1790+0.5/12,1835+11.5/12,1/12)
yy<-seq(1790,1835,1)
for(i in seq(1,length(yy))) {
 ym[i]<-mean(y[x==yy[i]],trim=0.1,na.rm=T)
}
#var(ym[15:35])
# CMIP5 millennium anomalies
hts<-read.table('../gcm_comparison/nh_ts.out',header=T,check.names=F)

pdf(file="scatter_at_anom_CMIP5_proxies.pdf",width=10,height=10,family='Helvetica',pointsize=16)

sgp = gpar(col=rgb(0,0,1,1),fill=rgb(0,0,1,1),lex=2)
hgp = gpar(col=rgb(1,0,0,1),fill=rgb(1,0,0,1),lex=2)
mgp = gpar(col=rgb(0.7,0.7,0.7,1),fill=rgb(0.7,0.7,0.7,1),lex=2)
tgp = gpar(col=rgb(0,0,0,1),fill=rgb(0,0,0,1),lex=1)

pushViewport(viewport(width=0.95,height=0.95,x=0.05,y=0.05,
                      just=c("left","bottom"),name="vp_map"))
pushViewport(plotViewport(margins=c(3,3,2,2)))
pushViewport(dataViewport(c(-2.5,0.6),c(-2.5,0.6)))
grid.xaxis(main=T)
grid.text('Year',y=unit(-3,"lines"))
grid.yaxis(main=T)
grid.text('AT anomaly (C)',x=unit(-3.5,"lines"), rot=90)
popViewport()
pushViewport(dataViewport(c(-2.5,0.6),c(-2.5,0.6),clip='on'))
grid.lines(x=unit(c(-2.5,6),'native'),
           y=unit(c(-2.5,6),'native'),
           gp=tgp)
# CMIP5 models v.EIC obs
for(i in seq(2,length(hts))) {
   grid.points(x=unit((ym-0.95)*sqrt(1.2),'native'),
              y=unit(hts[[i]],'native'),
              size=unit(0.01,'npc'),
              pch=20,
              gp=sgp)   
}

#Add the proxy series
files<-c('data/B2000','data/BOS..2001','data/DWJ2006',
         'data/HCA..2006','data/ECS2002','data/MJ2003',
         'data/MSH..2005','data/O2005','data/RMO..2005',
         'data/MBH1999','data/JBB..1998')
    for(i in seq_along(files)) {
       mi<-read.table(sprintf("../last-millennium/%s",files[i]),header=F)
       mean<-mean(mi$V2[mi$V1>1790 & mi$V1<1815])
   grid.points(x=unit((ym-0.95)*sqrt(1.2),'native'),
              y=unit(mi$V2[mi$V1>=1790 & mi$V1<=1835]-mean,'native'),
              size=unit(0.01,'npc'),
              pch=20,
              gp=hgp)   
     }
popViewport()
popViewport()
upViewport()
