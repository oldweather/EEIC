library(grid)
library(RColorBrewer)

nh<-read.table('nh_ts.out',header=T,check.names=F)
pt<-read.table('mts.out',header=T,check.names=F)

pdf(file="NH_v_obs_region.pdf",width=10,height=10,family='Helvetica',pointsize=16)

pushViewport(viewport(width=1,height=1,x=0.,y=0.,
                      just=c("left","bottom"),name="vp_map"))
pushViewport(plotViewport(margins=c(5,5,1,1)))
pushViewport(dataViewport(c(-2.2,0.6),c(-2.2,0.6)))
grid.xaxis(main=T)
grid.text('Temperature of observed region (C)',y=unit(-3,"lines"))
grid.yaxis(main=T)
grid.text('Northern Hemisphere temperature (C)',x=unit(-3.5,"lines"), rot=90)
c<-brewer.pal(8,'Dark2')
for(i in seq(2,length(nh))) {
   colour<-c[(i-1)%%8+1]
   gp<-gpar(col=colour,fill=colour,lty=as.integer((i-1)/8)+1,lwd=2)
   grid.points(x=unit(pt[[i]],'native'),
           y=unit(nh[[i]],'native'),
           size=unit(0.02,'npc'),
           pch=20,
           gp=gp)
 }
# Make a combined linear fit
x<-numeric(0)
y<-numeric(0)
for(i in seq(2,length(nh))) {
  x<-c(x,pt[[i]])
  y<-c(y,nh[[i]])
}
lm<-lm(y~x)
tgp = gpar(col=rgb(0,0,0,1),fill=rgb(0,0,0,1),lex=2)
grid.lines(x=unit(c(-2.2/lm$coefficients[2],0.6/lm$coefficients[2]),'native'),
           y=unit(c(-2.2-lm$coefficients[1],0.6-lm$coefficients[1]),'native'),
           gp=tgp)
popViewport()
popViewport()
upViewport()
