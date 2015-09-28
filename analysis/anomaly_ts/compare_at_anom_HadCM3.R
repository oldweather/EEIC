# Compare Air temperatures as estimated by EIC and HadCM3

library(grid)
# Ob anomalies
sts<-read.table('at_anoms.out',header=T)
x=rep(0,0)
y=rep(0,0)
for(i in seq(2,length(sts))) { 
   sety = paste(c("yd=sts$",names(sts)[i]),collapse="")
   eval(parse(text=sety))
   year = sub ('/.*','',sts$Date)
   month = as.numeric(substr(as.character(sts$Date),6,7))
   x=append(x,year+(month-0.5)/12)
   y=append(y,yd)
}
ym<-rep(0.0,1836-1790)
yy<-seq(1790+0.5/12,1835+11.5/12,1/12)
for(i in seq(1,length(yy))) {
 ym[i]<-mean(y[x==yy[i]],trim=0.1,na.rm=T)
}
# HadCM3 ALL anomalies
hts<-read.table('../tambora/at_anoms.all.out',header=T)
x=rep(0,0)
y=rep(0,0)
for(i in seq(2,length(hts))) { 
   sety = paste(c("yd=hts$",names(hts)[i]),collapse="")
   eval(parse(text=sety))
   year = sub ('/.*','',hts$Date)
   x=append(x,year)
   y=append(y,yd)
}
hm<-rep(0.0,1836-1790)
hy<-seq(1790,1835)
for(i in seq(1,length(hy))) {
 hm[i]<-mean(y[x==hy[i]],trim=0.1,na.rm=T)
}
# HadCM3 NAT anomalies
hts<-read.table('../tambora/at_anoms.nat.out',header=T)
x=rep(0,0)
y=rep(0,0)
for(i in seq(2,length(hts))) { 
   sety = paste(c("yd=hts$",names(hts)[i]),collapse="")
   eval(parse(text=sety))
   year = sub ('/.*','',hts$Date)
   x=append(x,year)
   y=append(y,yd)
}
nm<-rep(0.0,1836-1790)
ny<-seq(1790,1835)
for(i in seq(1,length(ny))) {
 nm[i]<-mean(y[x==ny[i]],trim=0.1,na.rm=T)
}

# Get the HadCM3 tropical mean temperature
tts<-read.table('../tambora/HadCM3_tropical_ts.out',header=F)

postscript(file="compare_at_anom_HadCM3.ps",paper="a4",family='Helvetica',pointsize=16)

sgp = gpar(col=rgb(0,0,1,1),fill=rgb(0,0,1,1))
hgp = gpar(col=rgb(1,0,0,1),fill=rgb(1,0,0,1),lex=2)
mgp = gpar(col=rgb(0.7,0.7,0.7,1),fill=rgb(0.7,0.7,0.7,1),lex=2)
tgp = gpar(col=rgb(0,0,0,1),fill=rgb(0,0,0,1),lex=2)

pushViewport(viewport(width=0.95,height=0.95,x=0.05,y=0.05,
                      just=c("left","bottom"),name="vp_map"))
pushViewport(plotViewport(margins=c(2,2,2,2)))
pushViewport(dataViewport(c(1790,1835),c(-1,0.6)))
grid.xaxis(main=T)
grid.text('Year',y=unit(-3,"lines"))
grid.yaxis(main=T)
grid.text('AT anomaly (C)',x=unit(-3,"lines"), rot=90)
popViewport()
pushViewport(dataViewport(c(1790,1835),c(-1,0.6),clip='on'))
grid.lines(x=unit(c(1809,1809),'native'),
           y=unit(c(-2,2),'native'),
           gp=mgp)
grid.lines(x=unit(c(1815,1815),'native'),
           y=unit(c(-2,2),'native'),
           gp=mgp)
grid.lines(x=unit(hy,'native'),
           y=unit(hm-0.1,'native'),
           gp=hgp)
grid.lines(x=unit(ny,'native'),
           y=unit(nm-0.1,'native'),
           gp=hgp)
grid.lines(x=unit(tts$V1,'native'),
           y=unit(tts$V2-0.1,'native'),
           gp=tgp)
grid.points(x=unit(yy,'native'),
           y=unit(ym-0.85,'native'),
           size=unit(0.03,'npc'),
           pch=20,
           gp=sgp)
grid.lines(x=unit(yy,'native'),
           y=unit(ym-0.85,'native'),
           gp=sgp)
popViewport()
popViewport()
upViewport()
