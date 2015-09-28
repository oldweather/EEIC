# Compare Air temperatures as estimated by EIC obs
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
var(ym[15:35])

pdf(file="compare_at_anom_proxies.pdf",width=10,height=7,family='Helvetica',pointsize=16)

sgp = gpar(col=rgb(0,0,1,1),fill=rgb(0,0,1,1),lex=2)
hgp = gpar(col=rgb(1,0,0,1),fill=rgb(1,0,0,1),lex=2)
mgp = gpar(col=rgb(0.7,0.7,0.7,1),fill=rgb(0.7,0.7,0.7,1),lex=2)
tgp = gpar(col=rgb(0,0,0,1),fill=rgb(0,0,0,1),lex=2)

c<-brewer.pal(8,'Dark2') # Colour palette
pushViewport(viewport(width=0.95,height=0.95,x=0.05,y=0.05,
                      just=c("left","bottom"),name="vp_map"))
pushViewport(plotViewport(margins=c(3,3,2,2)))
pushViewport(dataViewport(c(1790,1835),c(-0.7,0.6)))
grid.xaxis(main=T)
grid.text('Year',y=unit(-3,"lines"))
grid.yaxis(main=T)
grid.text('AT anomaly (C)',x=unit(-3.5,"lines"), rot=90)
popViewport()
pushViewport(dataViewport(c(1790,1835),c(-0.7,0.6),clip='on'))
# Mark the volcano years
grid.lines(x=unit(c(1809,1809),'native'),
           y=unit(c(-3,3),'native'),
           gp=mgp)
grid.lines(x=unit(c(1815,1815),'native'),
           y=unit(c(-3,3),'native'),
           gp=mgp)

#Add the proxiy series
    labx<-1810.5
    laby<-0.65
files<-c('data/B2000','data/BOS..2001','data/DWJ2006',
         'data/HCA..2006','data/ECS2002','data/MJ2003',
         'data/MSH..2005','data/O2005','data/RMO..2005',
         'data/MBH1999','data/JBB..1998')
    for(i in seq_along(files)) {
      colour<-c[(i)%%8+1]
      gp<-gpar(col=colour,fill=colour,lty=as.integer(i/8)+1,lwd=2)
       mi<-read.table(sprintf("../last-millennium/%s",files[i]),header=F)
       mean<-mean(mi$V2[mi$V1>1790 & mi$V1<1815])
       grid.lines(x=unit(mi$V1,'native'),
                  y=unit(mi$V2-mean,'native'),
                  gp=gp)
       label<-sub ('.*/','',files[i])
       laby<-laby-0.05
       if(laby<0.25) {
         laby<-0.60
         labx<-labx+15
       }
       grid.lines(x=unit(c(labx,labx+4),"native"),
                  y=unit(c(laby,laby),'native'),gp=gp)
       grid.text(label,x=unit(labx+5,"native"),y=unit(laby,'native'),
                                 just='left')
     }
# Add the EIC observations
grid.points(x=unit(yy,'native'),
           y=unit((ym-0.95)*sqrt(1.2),'native'),
           size=unit(0.02,'npc'),
           pch=20,
           gp=tgp)
grid.lines(x=unit(yy,'native'),
           y=unit((ym-0.95)*sqrt(1.2),'native'),
           gp=tgp)
popViewport()
popViewport()
upViewport()
