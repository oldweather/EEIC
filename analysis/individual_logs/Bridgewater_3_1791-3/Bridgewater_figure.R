# Make a synthesis figure for the Bridgewater 3
library(grid)
library(chron)
library(lattice)
library(maps)

# Load the map functions
source("../../../../scripts/sr.map.R")
gp_red   = gpar(col=rgb(1,0,0,1),fill=rgb(1,0,0,1))
gp_red2   = gpar(col=rgb(.5,0,0,1),fill=rgb(.5,0,0,1))
gp_blue  = gpar(col=rgb(0,0,1,1),fill=rgb(0,0,1,1))
gp_blue2  = gpar(col=rgb(0,0,.5,1),fill=rgb(0,0,.5,1))
gp_black = gpar(col=rgb(0,0,0,1),fill=rgb(0,0,0,1),lex=2)
gp_grey  = gpar(col=rgb(0.7,0.7,0.7,1),fill=rgb(0.7,0.7,0.7,1),lex=1)

# Read in the data
sts.k<-read.table('ovn.k.out',header=F)
sts.k$Date<-chron(dates=as.character(sts.k$V1),times=as.character(sts.k$V2),
                           format=c(dates = "y/m/d", times = "h:m:s"))
sts2.k<-read.table('ovn.k.back',header=F)
sts2.k$Date<-chron(dates=as.character(sts2.k$V1),times=as.character(sts2.k$V2),
                           format=c(dates = "y/m/d", times = "h:m:s"))
sts.l<-read.table('ovn.l.out',header=F)
sts.l$Date<-chron(dates=as.character(sts.l$V1),times=as.character(sts.l$V2),
                           format=c(dates = "y/m/d", times = "h:m:s"))
sts2.l<-read.table('ovn.l.back',header=F)
sts2.l$Date<-chron(dates=as.character(sts2.l$V1),times=as.character(sts2.l$V2),
                           format=c(dates = "y/m/d", times = "h:m:s"))
tics = dates(c('1791/06/01','1791/12/01','1792/06/01','1792/12/01','1793/06/01'),
      format="y/m/d")
ticl = c('1791/06','1791/12','1792/06','1792/12','1793/06')
      
postscript(file="Bridgewater_3.ps",paper="a4",family="Helvetica",pointsize=12)
                    
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
        || (sr.map.internal.wm$x[i]> 120)
        || (sr.map.internal.wm$y[i]< -60)
        || (sr.map.internal.wm$y[i]> 65)) {
         is.na(sr.map.internal.wm$x[i]) = T
         is.na(sr.map.internal.wm$y[i]) = T
    }    
}
downViewport("vp_map")
    pushViewport(plotViewport(margins=c(2,2,0,0)))
    pushViewport(dataViewport(c(-90,120),c(-60,65)))
    grid.xaxis(at=c(-90,-60,-30,0,30,60,90,120),main=T)
#    grid.xaxis(at=c(-90,-60,-30,0,30,60,90,120),main=F)
    grid.text('Longitude',y=unit(-3,"lines"))
    grid.yaxis(at=c(-60,-30,0,30,60),main=T)
#    grid.yaxis(at=c(-60,-30,0,30,60),main=F)
    grid.text('Latitude',x=unit(-3.5,"lines"), rot=90)
    grid.lines(x=unit(sr.map.internal.wm$x,"native"),
               y=unit(sr.map.internal.wm$y,"native"),gp=gp_grey)
    grid.points(x=unit(sts.k$V14,"native"),y=unit(sts.k$V13,'native'),pch=20,
               size=unit(3,"native"),gp=gp_red)
    grid.points(x=unit(sts2.k$V14,"native"),y=unit(sts2.k$V13,'native'),pch=20,
               size=unit(3,"native"),gp=gp_blue)
    grid.points(x=unit(sts.l$V14,"native"),y=unit(sts.l$V13,'native'),pch=20,
               size=unit(3,"native"),gp=gp_red2)
    grid.points(x=unit(sts2.l$V14,"native"),y=unit(sts2.l$V13,'native'),pch=20,
               size=unit(3,"native"),gp=gp_blue2)
popViewport() 
popViewport() 
upViewport()

# Plot the AIR temperatures
downViewport("vp_at")
pushViewport(plotViewport(margins=c(2,2,0,0)))
pushViewport(dataViewport(as.numeric(c(tics[1],tics[5])),c(10,30)))
grid.xaxis(at=as.numeric(tics),label=ticl,main=T)
grid.text('Date',y=unit(-3,"lines"))
grid.yaxis(main=T)
grid.text('Air Temperature (C)',x=unit(-3.5,"lines"), rot=90)
   grid.lines(x=unit(sts.k$Date,"native"),y=unit(sts.k$V8,'native'),gp=gp_black)
   grid.points(x=unit(sts.k$Date,"native"),y=unit(sts.k$V7,'native'),pch=20,
               size=unit(10,"native"),gp=gp_red)
   grid.points(x=unit(sts.l$Date,"native"),y=unit(sts.l$V7,'native'),pch=20,
               size=unit(10,"native"),gp=gp_red2)
   grid.lines(x=unit(sts2.k$Date,"native"),y=unit(sts2.k$V8,'native'),gp=gp_black)
   grid.points(x=unit(sts2.k$Date,"native"),y=unit(sts2.k$V7,'native'),pch=20,
               size=unit(10,"native"),gp=gp_blue)
   grid.points(x=unit(sts2.l$Date,"native"),y=unit(sts2.l$V7,'native'),pch=20,
               size=unit(10,"native"),gp=gp_blue2)
popViewport() 
popViewport() 
upViewport()

# Plot the Wind Speeds
downViewport("vp_sst")
pushViewport(plotViewport(margins=c(2,2,0,0)))
pushViewport(dataViewport(as.numeric(c(tics[1],tics[5])),c(0,30)))
grid.xaxis(at=as.numeric(tics),label=ticl,main=T)
grid.text('Date',y=unit(-3,"lines"))
grid.yaxis(main=T)
grid.text('Wind Speed (m/s)',x=unit(-3.5,"lines"), rot=90)
   grid.lines(x=unit(sts.k$Date,"native"),y=unit(sts.k$V12,'native'),gp=gp_black)
   grid.points(x=unit(sts.k$Date,"native"),y=unit(sts.k$V11,'native'),pch=20,
               size=unit(10,"native"),gp=gp_red)
   grid.points(x=unit(sts.l$Date,"native"),y=unit(sts.l$V11,'native'),pch=20,
               size=unit(10,"native"),gp=gp_red2)
   grid.lines(x=unit(sts2.k$Date,"native"),y=unit(sts2.k$V12,'native'),gp=gp_black)
   grid.points(x=unit(sts2.k$Date,"native"),y=unit(sts2.k$V11,'native'),pch=20,
               size=unit(10,"native"),gp=gp_blue)
   grid.points(x=unit(sts2.l$Date,"native"),y=unit(sts2.l$V11,'native'),pch=20,
               size=unit(10,"native"),gp=gp_blue2)
popViewport() 
popViewport() 
upViewport()

# Plot the SLPs
downViewport("vp_slp")
pushViewport(plotViewport(margins=c(2,2,0,0)))
pushViewport(dataViewport(as.numeric(c(tics[1],tics[5])),c(990,1030)))
grid.xaxis(at=as.numeric(tics),label=ticl,main=T)
grid.text('Date',y=unit(-3,"lines"))
grid.yaxis(main=T)
grid.text('Pressure (hPa)',x=unit(-3.5,"lines"), rot=90)
   grid.lines(x=unit(sts.k$Date,"native"),y=unit(sts.k$V10,'native'),gp=gp_black)
   grid.points(x=unit(sts.k$Date,"native"),y=unit(sts.k$V9,'native'),pch=20,
               size=unit(10,"native"),gp=gp_red)
   grid.points(x=unit(sts.l$Date,"native"),y=unit(sts.l$V9,'native'),pch=20,
               size=unit(10,"native"),gp=gp_red2)
   grid.lines(x=unit(sts2.k$Date,"native"),y=unit(sts2.k$V10,'native'),gp=gp_black)
   grid.points(x=unit(sts2.k$Date,"native"),y=unit(sts2.k$V9,'native'),pch=20,
               size=unit(10,"native"),gp=gp_blue)
   grid.points(x=unit(sts2.l$Date,"native"),y=unit(sts2.l$V9,'native'),pch=20,
               size=unit(10,"native"),gp=gp_blue2)
popViewport() 
popViewport() 
upViewport()



