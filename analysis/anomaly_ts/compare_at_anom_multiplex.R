# Compare Air temperatures as estimated by EIC obs
#  CMIP4 proxy reconstructions, and CMIP5 GCM reconstructions

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
   x=append(x,year)
   y=append(y,yd)
}
ym<-rep(0.0,1836-1790)
yy<-seq(1790,1835,1)
for(i in seq(1,length(yy))) {
 ym[i]<-mean(y[x==yy[i]],trim=0.1,na.rm=T)
}
# get rid of the observed points where the number of ships is very low
is.na(ym[1:4])<-T
is.na(ym[44:45])<-T

pdf(file="compare_at_anom_multiplex.pdf",width=7,height=10,family='Helvetica',pointsize=12)

sgp = gpar(col=rgb(0,0,1,1),fill=rgb(0,0,1,1),lex=2)
hgp = gpar(col=rgb(1,0,0,1),fill=rgb(1,0,0,1),lex=2)
mgp = gpar(col=rgb(0.7,0.7,0.7,1),fill=rgb(0.7,0.7,0.7,1),lex=2)
tgp = gpar(col=rgb(0,0,0,1),fill=rgb(0,0,0,1),lex=2)

c<-brewer.pal(8,'Dark2') # Colour palette
pushViewport(viewport(width=1.0,height=0.5,x=0.0,y=0.0,
                      just=c("left","bottom"),name="vp_map"))
pushViewport(plotViewport(margins=c(5,5,0,2)))
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

#Add the proxy series
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
       mean<-mean(mi$V2[mi$V1>1790 & mi$V1<1805])
       grid.lines(x=unit(mi$V1,'native'),
                  y=unit(mi$V2-mean,'native'),
                  gp=gp)
       label<-sub ('.*/','',files[i])
       laby<-laby-0.05
       if(laby<0.25) {
         laby<-0.60
         labx<-labx+13
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

# Add the GCM simulations
hts<-read.table('../gcm_comparison/mts.out',header=T,check.names=F)
pushViewport(viewport(width=1.0,height=0.5,x=0.0,y=0.5,
                      just=c("left","bottom"),name="vp_map"))
pushViewport(plotViewport(margins=c(0,5,2,2)))
pushViewport(dataViewport(c(1790,1835),c(-2.2,0.6)))
grid.yaxis(main=T)
grid.text('AT anomaly (C)',x=unit(-3.5,"lines"), rot=90)
popViewport()
pushViewport(dataViewport(c(1790,1835),c(-2.2,0.6),clip='on'))
# Mark the volcano years
grid.lines(x=unit(c(1809,1809),'native'),
           y=unit(c(-3,3),'native'),
           gp=mgp)
grid.lines(x=unit(c(1815,1815),'native'),
           y=unit(c(-3,3),'native'),
           gp=mgp)
# Draw the lines for CMIP5 models
c<-brewer.pal(8,'Dark2')
    idx<-1
for(i in seq(2,length(hts))) {
   if(i>2 && names(hts)[i] != names(hts)[i-1]) idx<-idx+1
   colour<-c[(idx-1)%%8+1]
   gp<-gpar(col=colour,fill=colour,lty=as.integer((idx-1)/8)+1,lwd=2)
   grid.lines(x=unit(hts$Year,'native'),
              y=unit(hts[[i]],'native'),
              gp=gp)
   grid.lines(x=unit(c(1820,1822),'native'),
              y=unit(rep(-0.6-0.1*idx,2),'native'),
              gp=gp)
   grid.text(names(hts)[i],
             x=unit(1824,'native'),
             y=unit(-0.6-0.1*idx,'native'),just='left')
   
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

# Add the inset - NH v obs coverage temperatures
nh<-read.table('../gcm_comparison/nh_ts.out',header=T,check.names=F)
pushViewport(viewport(width=0.4,height=0.4*7/10,x=0.09,y=0.475,
                      just=c("left","bottom"),name="vp_map"))
pushViewport(plotViewport(margins=c(5,5,1,1)))
pushViewport(dataViewport(c(-2.2,0.6),c(-2.2,0.6)))
grid.xaxis(main=T,at=c(-2,-1,0))
#grid.text('Temperature of observed region (C)',y=unit(-3,"lines"))
grid.yaxis(main=T,at=c(-2,-1,0))
#grid.text('Northern Hemisphere temperature (C)',x=unit(-3.5,"lines"), rot=90)
c<-brewer.pal(8,'Dark2')
idx<-1
for(i in seq(2,length(nh))) {
   if(i>2 && names(hts)[i] != names(hts)[i-1]) idx<-idx+1
   colour<-c[(idx-1)%%8+1]
   gp<-gpar(col=colour,fill=colour,lty=as.integer((idx-1)/8)+1,lwd=2)
   grid.points(x=unit(hts[[i]],'native'),
           y=unit(nh[[i]],'native'),
           size=unit(0.03,'npc'),
           pch=20,
           gp=gp)
 }
# Make a combined linear fit
x<-numeric(0)
y<-numeric(0)
for(i in seq(2,length(nh))) {
  x<-c(x,hts[[i]])
  y<-c(y,nh[[i]])
}
lm<-lm(y~x)
tgp = gpar(col=rgb(0,0,0,1),fill=rgb(0,0,0,1),lex=2)
grid.lines(x=unit(c(-2.2/lm$coefficients[2],0.6/lm$coefficients[2]),'native'),
           y=unit(c(-2.2-lm$coefficients[1],0.6-lm$coefficients[1]),'native'),
           )
popViewport()
popViewport()
upViewport()

