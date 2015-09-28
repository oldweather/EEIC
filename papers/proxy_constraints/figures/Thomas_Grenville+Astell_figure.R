# Show the routes followed by the thomas Grenville and Astell
library(grid)
library(chron)
library(lattice)
library(maps)

# Load the map functions
source("../../../../scripts/sr.map.R")
gp_red   = gpar(col=rgb(1,0,0,1),fill=rgb(1,0,0,1))
gp_blue  = gpar(col=rgb(0,0,1,1),fill=rgb(0,0,1,1))
gp_black = gpar(col=rgb(0,0,0,1),fill=rgb(0,0,0,1),lex=2)
gp_grey  = gpar(col=rgb(0.7,0.7,0.7,1),fill=rgb(0.7,0.7,0.7,1),lex=1)

# Read in the data
tgd<-read.table('../../../analysis/individual_logs/Thomas_Grenville_1827-8/tg.ovn.out',header=F)
tgd2<-read.table('../../../analysis/individual_logs/Thomas_Grenville_1827-8/tg.ovn.back',header=F)
ad<-read.table('../../../analysis/individual_logs/Astell_1812-13/ovn.out',header=F)
ad2<-read.table('../../../analysis/individual_logs/Astell_1812-13/ovn.back',header=F)
      
pdf(file="TG+A_routes.pdf",paper="special",
    width=21/2, height=12.5/2,
    family="Helvetica",pointsize=12)
                    

sr.map.internal.wm <- map('world',interior=FALSE,plot=FALSE)
is.na(sr.map.internal.wm$x[8836])=T  # Remove Antarctic bug
# Prune everything outside the viewport
for(i in seq(1,length(sr.map.internal.wm$x))) {
    if ( is.na(sr.map.internal.wm$x[i]) 
        || (is.na(sr.map.internal.wm$y[i]))
        || (sr.map.internal.wm$x[i]< -90)
        || (sr.map.internal.wm$x[i]> 120)
        || (sr.map.internal.wm$y[i]< -60)
        || (sr.map.internal.wm$y[i]> 65)) {
         is.na(sr.map.internal.wm$x[i]) = T
         is.na(sr.map.internal.wm$y[i]) = T
    }    
}

pushViewport(viewport(width=1.0,height=1.0,x=0.0,y=0,
                      just=c("left","bottom"),name="vp_map"))
    pushViewport(plotViewport(margins=c(1,1,1,1)))
    pushViewport(dataViewport(c(-90,120),c(-60,65)))
    #grid.xaxis(at=c(-90,-60,-30,0,30,60,90,120),main=T)
    grid.text('Longitude',y=unit(-3,"lines"))
    #grid.yaxis(at=c(-60,-30,0,30,60),main=T)
    grid.text('Latitude',x=unit(-3.5,"lines"), rot=90)
    grid.lines(x=unit(sr.map.internal.wm$x,"native"),
               y=unit(sr.map.internal.wm$y,"native"),gp=gp_black)
    grid.points(x=unit(tgd$V14,"native"),y=unit(tgd$V13,'native'),pch=20,
               size=unit(3,"native"),gp=gp_red)
    grid.points(x=unit(tgd2$V14,"native"),y=unit(tgd2$V13,'native'),pch=20,
               size=unit(3,"native"),gp=gp_blue)
    grid.points(x=unit(ad$V14,"native"),y=unit(ad$V13,'native'),pch=22,
               size=unit(2,"native"),gp=gp_red)
    grid.points(x=unit(ad2$V14,"native"),y=unit(ad2$V13,'native'),pch=22,
               size=unit(2,"native"),gp=gp_blue)
    popViewport() 
    popViewport() 
upViewport()

