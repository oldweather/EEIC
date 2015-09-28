# Compare Air temperatures as estimated by EIC and CMIP5 millennium runs

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
var(ym[15:35])
# CMIP5 millennium anomalies
hts<-read.table('../gcm_comparison/mts.out',header=T,check.names=F)

pdf(file="compare_at_anom_CMIP5.pdf",width=10,height=7,family='Helvetica',pointsize=16)

sgp = gpar(col=rgb(0,0,1,1),fill=rgb(0,0,1,1))
hgp = gpar(col=rgb(1,0,0,1),fill=rgb(1,0,0,1),lex=2)
mgp = gpar(col=rgb(0.7,0.7,0.7,1),fill=rgb(0.7,0.7,0.7,1),lex=2)
tgp = gpar(col=rgb(0,0,0,1),fill=rgb(0,0,0,1),lex=2)

pushViewport(viewport(width=0.95,height=0.95,x=0.05,y=0.05,
                      just=c("left","bottom"),name="vp_map"))
pushViewport(plotViewport(margins=c(3,3,2,2)))
pushViewport(dataViewport(hts$Year,c(-2.2,0.6)))
grid.xaxis(main=T)
grid.text('Year',y=unit(-3,"lines"))
grid.yaxis(main=T)
grid.text('AT anomaly (C)',x=unit(-3.5,"lines"), rot=90)
popViewport()
pushViewport(dataViewport(hts$Year,c(-2.2,0.6),clip='on'))
# Mark the volcano years
grid.lines(x=unit(c(1809,1809),'native'),
           y=unit(c(-3,3),'native'),
           gp=mgp)
grid.lines(x=unit(c(1815,1815),'native'),
           y=unit(c(-3,3),'native'),
           gp=mgp)
# Draw the lines for CMIP5 models
c<-brewer.pal(8,'Dark2')
for(i in seq(2,length(hts))) {
   colour<-c[(i-1)%%8+1]
   gp<-gpar(col=colour,fill=colour,lty=as.integer((i-1)/8)+1,lwd=2)
   grid.lines(x=unit(hts$Year,'native'),
              y=unit(hts[[i]],'native'),
              gp=gp)
   grid.lines(x=unit(c(1820,1822),'native'),
              y=unit(rep(-1-0.15*i,2),'native'),
              gp=gp)
   grid.text(names(hts)[i],
             x=unit(1824,'native'),
             y=unit(-1-0.15*i,'native'),just='left')
   
}
# Add the EIC observations
grid.points(x=unit(yy,'native'),
           y=unit(ym-0.95,'native'),
           size=unit(0.02,'npc'),
           pch=20,
           gp=tgp)
grid.lines(x=unit(yy,'native'),
           y=unit(ym-0.95,'native'),
           gp=tgp)
popViewport()
popViewport()
upViewport()
