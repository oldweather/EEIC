# Plot the last-millennium data

library(grid)
library(RColorBrewer)

pdf(file="Millennium.pdf",width=7,height=10,family="Helvetica",pointsize=12)
                    
lsmooth<-function(x,y,smooth=NA) {
    x<-x[!is.na(y)]
    y<-y[!is.na(y)]
    if(!is.na(smooth)) {
      y.l<-loess(y~x,span=smooth/length(y))
      y<-predict(y.l)
    }
    return(list(x=x,y=y))
  }

addline<-function(x,y,gp,label=NULL,labx=NULL,laby=NULL,smooth=NA) {
    l<-lsmooth(x,y,smooth=smooth)
    grid.lines(x=unit(l$x,"native"),
               y=unit(l$y,'native'),gp=gp)
    if(!is.null(label)) {
       grid.lines(x=unit(c(labx,labx+40),"native"),
                  y=unit(c(laby,laby),'native'),gp=gp)
       grid.text(label,x=unit(labx+55,"native"),y=unit(laby,'native'),
                                 just='left')
    }
}
  

files<-c('data/B2000','data/BOS..2001','data/DWJ2006',
         'data/HCA..2006','data/ECS2002','data/MJ2003',
         'data/MSH..2005','data/O2005','data/RMO..2005',
         'data/MBH1999','data/JBB..1998')

c<-brewer.pal(8,'Dark2') # Colour palette
smooth=50

# Top frame with proxies
pushViewport(viewport(width=1.0,height=0.5,x=0.0,y=0.5,
                      just=c("left","bottom"),name="vp_instrumental"))
  pushViewport(plotViewport(margins=c(1,5,3,2)))
    pushViewport(dataViewport(c(850,2000),c(-1.2,0.5)))
    grid.yaxis(main=T)
    grid.text('Temperature anomaly (C)',x=unit(-3.5,"lines"), rot=90)
    popViewport()
    pushViewport(dataViewport(c(850,2000),c(-1.2,0.5),clip='on'))
                         

    labx<-830
    laby<-0.5
    offset<-numeric(0)
    for(i in seq_along(files)) {
       mi<-read.table(files[i],header=F)
       label<-sub ('.*/','',files[i])
       laby<-laby-0.08
       if(laby<0.25) {
         laby<-0.45
         labx<-labx+300
       }
      colour<-c[(i)%%8+1]
      gp<-gpar(col=colour,fill=colour,lty=as.integer(i/8)+1,lwd=3)
      addline(mi$V1,mi$V2,gp,label=label,labx=labx,laby=laby,smooth=smooth)
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
  
popViewport()                    
popViewport()                    
upViewport(0)

# Bottom frame with GCMs
pushViewport(viewport(width=1.0,height=0.5,x=0.0,y=0.0,
                      just=c("left","bottom"),name="vp_instrumental"))
  pushViewport(plotViewport(margins=c(5,5,2,0)))
    pushViewport(dataViewport(c(850,2000),c(-1.2,0.5)))
    grid.xaxis(main=T)
    grid.text('Year',y=unit(-3,"lines"))
    grid.yaxis(main=T)
    grid.text('Temperature anomaly (C)',x=unit(-3.5,"lines"), rot=90)
    popViewport()
    pushViewport(dataViewport(c(850,2000),c(-1.2,0.5),clip='on'))
                         
    # Add the GCMs
    hts<-read.table('../gcm_comparison/nh_ts.millennium.out',header=T,check.names=F)
    labx<-950
    laby<-0.5
    idx<-1
    for(i in seq(2,length(hts))) {
       if(i>1 && names(hts)[i] != names(hts)[i-1]) {
       idx<-idx+1
       laby<-laby-0.08
       if(laby<0.25) {
         laby<-0.45
         labx<-labx+400
       }
     }
   colour<-c[(idx-1)%%8+1]
   gp<-gpar(col=colour,fill=colour,lty=as.integer((idx-1)/8)+1,lwd=3)
#   if(names(hts)[i]=='MIROC-ESM') hts[[i]]<-hts[[i]]-0.7
#   if(names(hts)[i]=='FGOALS-gl') hts[[i]]<-hts[[i]]-0.1
   addline(hts$Year,hts[[i]]-0.2,gp,label=names(hts)[i],
           labx=labx,laby=laby,smooth=smooth)   
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
  
popViewport()                    
popViewport()                    
upViewport()
