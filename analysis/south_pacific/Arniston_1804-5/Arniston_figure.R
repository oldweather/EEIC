# Make a synthesis figure for the Arniston
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
sts2<-read.table('ovn.back',header=F)
sts2$Date<-chron(dates=as.character(sts2$V1),times=as.character(sts2$V2),
                           format=c(dates = "y/m/d", times = "h:m:s"))
tics = dates(c('1804/06/01','1804/09/01','1804/12/01','1805/03/01','1805/06/01','1805/09/01'),
      format="y/m/d")
ticl = c('1804/06','1804/09','1804/12','1805/03','1805/06','1805/09')
      
postscript(file="Arniston.ps",paper="a4",family="Helvetica",pointsize=12)
                    
# Four seperate plots - route, AT, SLP, WS - each in its own viewport
pushViewport(viewport(width=0.4,height=0.4,x=0.05,y=0.6,
                      just=c("left","bottom"),name="vp_map"))
upViewport(0)
pushViewport(viewport(width=0.4,height=0.4,x=0.55,y=0.6,
                     just=c("left","bottom"),name="vp_slp"))
upViewport(0)
pushViewport(viewport(width=0.4,height=0.4,x=0.55,y=0.1,
                      just=c("left","bottom"),name="vp_at"))
upViewport(0)
pushViewport(viewport(width=0.4,height=0.4,x=0.05,y=0.1,
                      just=c("left","bottom"),name="vp_sst"))
upViewport(0)

# Draw the map
sr.map.internal.wm <- map('world',interior=FALSE,plot=FALSE)
is.na(sr.map.internal.wm$x[8836])=T  # Remove Antarctic bug
# Prune everything outside the viewport
for(i in seq(1,length(sr.map.internal.wm$x))) {
    if ( is.na(sr.map.internal.wm$x[i]) 
        || (is.na(sr.map.internal.wm$y[i]))
        || (sr.map.internal.wm$x[i]< -90)
        || (sr.map.internal.wm$x[i]> 180)
        || (sr.map.internal.wm$y[i]< -60)
        || (sr.map.internal.wm$y[i]> 65)) {
         is.na(sr.map.internal.wm$x[i]) = T
         is.na(sr.map.internal.wm$y[i]) = T
    }    
}
downViewport("vp_map")
    pushViewport(plotViewport(margins=c(2,2,2,2)))
    pushViewport(dataViewport(c(-90,180),c(-60,65)))
    grid.xaxis(at=c(-90,-60,-30,0,30,60,90,120,150,180),main=T)
    grid.xaxis(at=c(-90,-60,-30,0,30,60,90,120,150,180),main=F)
    grid.text('Longitude',y=unit(-3,"lines"))
    grid.yaxis(at=c(-60,-30,0,30,60),main=T)
    grid.yaxis(at=c(-60,-30,0,30,60),main=F)
    grid.text('Latitude',x=unit(-3.5,"lines"), rot=90)
    grid.lines(x=unit(sr.map.internal.wm$x,"native"),
               y=unit(sr.map.internal.wm$y,"native"),gp=gp_grey)
    grid.points(x=unit(sts$V14,"native"),y=unit(sts$V13,'native'),pch=20,
               size=unit(3,"native"),gp=gp_red)
    grid.points(x=unit(sts2$V14,"native"),y=unit(sts2$V13,'native'),pch=20,
               size=unit(3,"native"),gp=gp_blue)
popViewport() 
popViewport() 
upViewport()

# Plot the AIR temperatures
downViewport("vp_at")
pushViewport(plotViewport(margins=c(2,2,2,2)))
pushViewport(dataViewport(as.numeric(c(tics[1],tics[5])),c(5,30)))
grid.xaxis(at=as.numeric(tics),label=ticl,main=T)
grid.text('Date',y=unit(-3,"lines"))
grid.yaxis(main=T)
grid.text('Air Temperature (C)',x=unit(-3.5,"lines"), rot=90)
   grid.lines(x=unit(sts$Date,"native"),y=unit(sts$V8,'native'),gp=gp_black)
   grid.points(x=unit(sts$Date,"native"),y=unit(sts$V7,'native'),pch=20,
               size=unit(10,"native"),gp=gp_red)
   grid.lines(x=unit(sts2$Date,"native"),y=unit(sts2$V8,'native'),gp=gp_black)
   grid.points(x=unit(sts2$Date,"native"),y=unit(sts2$V7,'native'),pch=20,
               size=unit(10,"native"),gp=gp_blue)
popViewport() 
popViewport() 
upViewport()

# Plot the Wind Speeds
downViewport("vp_sst")
pushViewport(plotViewport(margins=c(2,2,2,2)))
pushViewport(dataViewport(as.numeric(c(tics[1],tics[5])),c(0,30)))
grid.xaxis(at=as.numeric(tics),label=ticl,main=T)
grid.text('Date',y=unit(-3,"lines"))
grid.yaxis(main=T)
grid.text('Wind Speed (m/s)',x=unit(-3.5,"lines"), rot=90)
   grid.lines(x=unit(sts$Date,"native"),y=unit(sts$V12,'native'),gp=gp_black)
   grid.points(x=unit(sts$Date,"native"),y=unit(sts$V11,'native'),pch=20,
               size=unit(10,"native"),gp=gp_red)
   grid.lines(x=unit(sts2$Date,"native"),y=unit(sts2$V12,'native'),gp=gp_black)
   grid.points(x=unit(sts2$Date,"native"),y=unit(sts2$V11,'native'),pch=20,
               size=unit(10,"native"),gp=gp_blue)
popViewport() 
popViewport() 
upViewport()

# Plot the SLPs
downViewport("vp_slp")
pushViewport(plotViewport(margins=c(2,2,2,2)))
pushViewport(dataViewport(as.numeric(c(tics[1],tics[5])),c(990,1030)))
grid.xaxis(at=as.numeric(tics),label=ticl,main=T)
grid.text('Date',y=unit(-3,"lines"))
grid.yaxis(main=T)
grid.text('Pressure (hPa)',x=unit(-3.5,"lines"), rot=90)
   grid.lines(x=unit(sts$Date,"native"),y=unit(sts$V10,'native'),gp=gp_black)
   grid.points(x=unit(sts$Date,"native"),y=unit(sts$V9,'native'),pch=20,
               size=unit(10,"native"),gp=gp_red)
   grid.lines(x=unit(sts2$Date,"native"),y=unit(sts2$V10,'native'),gp=gp_black)
   grid.points(x=unit(sts2$Date,"native"),y=unit(sts2$V9,'native'),pch=20,
               size=unit(10,"native"),gp=gp_blue)
popViewport() 
popViewport() 
upViewport()



