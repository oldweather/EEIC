# Plot a map showing the identified waypoints
library(grid)
library(maps)

# Load the map functions
source("../../../scripts/sr.map.R")
gp_red   = gpar(col=rgb(1,0,0,1),fill=rgb(1,0,0,1))
gp_blue  = gpar(col=rgb(0,0,1,1),fill=NA)
gp_black = gpar(col=rgb(0,0,0,1),fill=rgb(0,0,0,1),lex=2)
gp_grey  = gpar(col=rgb(0.7,0.7,0.7,1),fill=rgb(0.7,0.7,0.7,1),lex=1)
sts<-read.table('waypoints.out',header=F)

postscript(file="Waypoints.ps",paper="a4",family="Helvetica",pointsize=12)

pushViewport(viewport(width=0.95,height=0.95,x=0.025,y=0.025,
                      just=c("left","bottom"),name="vp_map"))
upViewport(0)

sr.map.internal.wm <- map('world',interior=FALSE,plot=FALSE)
is.na(sr.map.internal.wm$x[8836])=T  # Remove Antarctic bug
# Prune everything outside the viewport
for(i in seq(1,length(sr.map.internal.wm$x))) {
    if ( is.na(sr.map.internal.wm$x[i]) 
        || (is.na(sr.map.internal.wm$y[i]))
        || (sr.map.internal.wm$x[i]< -90)
        || (sr.map.internal.wm$x[i]> 150)
        || (sr.map.internal.wm$y[i]< -60)
        || (sr.map.internal.wm$y[i]> 65)) {
         is.na(sr.map.internal.wm$x[i]) = T
         is.na(sr.map.internal.wm$y[i]) = T
    }    
}
downViewport("vp_map")
    pushViewport(plotViewport(margins=c(2,2,2,2)))
    pushViewport(dataViewport(c(-90,150),c(-60,65)))
    grid.xaxis(at=c(-90,-60,-30,0,30,60,90,120,150),main=T)
    grid.xaxis(at=c(-90,-60,-30,0,30,60,90,120,150),main=F)
    grid.text('Longitude',y=unit(-3,"lines"))
    grid.yaxis(at=c(-60,-30,0,30,60),main=T)
    grid.yaxis(at=c(-60,-30,0,30,60),main=F)
    grid.text('Latitude',x=unit(-3.5,"lines"), rot=90)
    grid.lines(x=unit(sr.map.internal.wm$x,"native"),
               y=unit(sr.map.internal.wm$y,"native"),gp=gp_grey)
    grid.points(x=unit(sts$V4,"native"),y=unit(sts$V3,'native'),pch=20,
               size=unit(1,"native"),gp=gp_red)
   # Mark the selected waypoints
    grid.circle(x=unit(c(72),"native"),y=unit(c(18),"native"),
                r=unit(c(4),"native"),gp=gp_blue)
    grid.text('Mumbai',x=unit(c(58),"native"),y=unit(c(18),"native"),gp=gp_blue)
    grid.circle(x=unit(c(81),"native"),y=unit(c(12),"native"),
                r=unit(c(4),"native"),gp=gp_blue)
    grid.text('Chennai',x=unit(c(67),"native"),y=unit(c(12),"native"),
                                                       gp=gp_blue)
    grid.circle(x=unit(c(88),"native"),y=unit(c(20),"native"),
                r=unit(c(4),"native"),gp=gp_blue)
    grid.text('Kolkata',x=unit(c(91),"native"),y=unit(c(26),"native"),
                                                       gp=gp_blue)
    grid.circle(x=unit(c(115),"native"),y=unit(c(21),"native"),
                r=unit(c(4),"native"),gp=gp_blue)
    grid.text('Hong Kong',x=unit(c(132),"native"),y=unit(c(21),"native"),
                                                       gp=gp_blue)
    grid.circle(x=unit(c(19),"native"),y=unit(c(-34),"native"),
                r=unit(c(4),"native"),gp=gp_blue)
    grid.text('The Cape',x=unit(c(35),"native"),y=unit(c(-34),"native"),
                                                       gp=gp_blue)
    grid.circle(x=unit(c(-4),"native"),y=unit(c(-17),"native"),
                r=unit(c(4),"native"),gp=gp_blue)
    grid.text('St Helena',x=unit(c(-19),"native"),y=unit(c(-17),"native"),
                                                       gp=gp_blue)
    grid.circle(x=unit(c(-41),"native"),y=unit(c(-24),"native"),
                r=unit(c(4),"native"),gp=gp_blue)
    grid.text('Rio',x=unit(c(-50),"native"),y=unit(c(-23),"native"),
                                                       gp=gp_blue)
    grid.circle(x=unit(c(-16),"native"),y=unit(c(33),"native"),
                r=unit(c(4),"native"),gp=gp_blue)
    grid.text('Madeira',x=unit(c(-29),"native"),y=unit(c(33),"native"),
                                                       gp=gp_blue)
    grid.circle(x=unit(c(-4),"native"),y=unit(c(50),"native"),
                r=unit(c(6),"native"),gp=gp_blue)
    grid.text('UK',x=unit(c(5),"native"),y=unit(c(53),"native"),
                                                       gp=gp_blue)
popViewport() 
popViewport() 
upViewport()
