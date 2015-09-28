# Make a synthesis figure for the Georgiana
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
sts<-read.table('ovn.out',header=F)
sts$Date<-chron(dates=as.character(sts$V1),times=as.character(sts$V2),
                           format=c(dates = "y/m/d", times = "h:m:s"))
tics = dates(c('1803/06/01','1804/06/01','1805/06/01','1806/06/01','1807/06/01'),
      format="y/m/d")
ticl = c('1803','1804','1805','1806','1807')
      
postscript(file="Georgiana.ps",paper="a4",family="Helvetica",pointsize=12)
                    
# Only plot the route
pushViewport(viewport(width=0.95,height=0.94,x=0.025,y=0.025,
                      just=c("left","bottom"),name="vp_map"))
upViewport(0)

# Draw the map
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
downViewport("vp_map")
    pushViewport(plotViewport(margins=c(2,2,2,2)))
    pushViewport(dataViewport(c(-90,120),c(-60,65)))
    grid.xaxis(at=c(-90,-60,-30,0,30,60,90,120),main=T)
    grid.xaxis(at=c(-90,-60,-30,0,30,60,90,120),main=F)
    grid.text('Longitude',y=unit(-3,"lines"))
    grid.yaxis(at=c(-60,-30,0,30,60),main=T)
    grid.yaxis(at=c(-60,-30,0,30,60),main=F)
    grid.text('Latitude',x=unit(-3.5,"lines"), rot=90)
    grid.lines(x=unit(sr.map.internal.wm$x,"native"),
               y=unit(sr.map.internal.wm$y,"native"),gp=gp_grey)
    grid.points(x=unit(sts$V14,"native"),y=unit(sts$V13,'native'),pch=20,
               size=unit(3,"native"),gp=gp_red)
popViewport() 
popViewport() 
upViewport()

