# Plot the last-millennium data
# Show effect of scaling to observed constraint of 0.06*1.2 variance 1805-25 

library(grid)
library(RColorBrewer)

pdf(file="Millennium+scaling.pdf",width=10,height=7,family="Helvetica",pointsize=14)
                    
addline<-function(x,y,gp,label=NULL,labx=NULL,laby=NULL,smooth=NA) {
    if(!is.na(smooth)) {
      y.l<-loess(y~x,span=smooth/length(y))
      y<-predict(y.l)
    }
    grid.lines(x=unit(x,"native"),
               y=unit(y,'native'),gp=gp)
    if(!is.null(label)) {
       grid.lines(x=unit(c(labx,labx+40),"native"),
                  y=unit(c(laby,laby),'native'),gp=gp)
       grid.text(label,x=unit(labx+45,"native"),y=unit(laby,'native'),
                                 just='left')
    }
}

files<-c('data/B2000','data/BOS..2001','data/DWJ2006','data/DWJ2006',
         'data/HCA..2006','data/ECS2002','data/MJ2003',
         'data/MSH..2005','data/O2005','data/RMO..2005')

c<-brewer.pal(8,'Dark2') # Colour palette
smooth=50

pushViewport(viewport(width=1.0,height=1.0,x=0.0,y=0.0,
                      just=c("left","bottom"),name="vp_instrumental"))
  pushViewport(plotViewport(margins=c(4,5,2,2)))
    pushViewport(dataViewport(c(1750,1850),c(-1,0.5)))
    grid.xaxis(main=T)
    grid.text('Year',y=unit(-3,"lines"))
    grid.yaxis(main=T)
    grid.text('Temperature anomaly (C)',x=unit(-3.5,"lines"), rot=90)
    popViewport()
    pushViewport(dataViewport(c(1750,1850),c(-1.1,0.4),clip='on'))
                         
    labx<-830
    laby<-0.45
    for(i in seq_along(files)) {
       mi<-read.table(files[i],header=F)
       label<-sub ('.*/','',files[i])
       laby<-laby-0.05
       if(laby<0.25) {
         laby<-0.45
         labx<-labx+300
       }
      colour<-c[(i)%%8+1]
      gp<-gpar(col=colour,fill=colour,lty=as.integer(i/8)+1,lwd=0.5)
      addline(mi$V1,mi$V2,gp,smooth=smooth)
      scale<-var(mi$V2[mi$V1>=1800 & mi$V1<=1830])/(0.06*1.2)
      gp<-gpar(col=colour,fill=colour,lty=as.integer(i/8)+1,lwd=2)
      #addline(mi$V1,mi$V2/scale,gp,label=label,labx=labx,laby=laby,
      #        smooth=smooth)
       
    }
                              
  # HadCRUT3
    mi<-read.table('/home/h04/hadobs/Monitoring.operational/hadcrut3/diagnostics/hemispheric/northern/annual',header=F)
    gp  = gpar(col=rgb(0,0,0,1),fill=rgb(0,0,0,1),lex=3)
    if(!is.na(smooth)) {
      y.l<-loess(mi$V2~mi$V1,span=smooth/length(mi$V2))
      mi$V2<-predict(y.l)
    }
    grid.lines(x=unit(mi$V1,"native"),
               y=unit(mi$V2,'native'),gp=gp)
    grid.lines(x=unit(c(1430,1470),"native"),
               y=unit(c(0.40,0.40),'native'),gp=gp)
    grid.text('HadCRUT3',
              x=unit(1475,"native"),y=unit(0.40,'native'),
                              just='left')
  
                    
upViewport(0)
