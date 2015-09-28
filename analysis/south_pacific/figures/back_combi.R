# Make a synthesis figure for the main fleet on the voyage back
library(grid)
library(chron)
library(lattice)
library(maps)

# Load the map functions
source("../../../../scripts/sr.map.R")
gp_red   = gpar(col=rgb(1,0,0,1),fill=rgb(1,0,0,1))
gp_blue  = gpar(col=rgb(0,0,1,1),fill=rgb(0,0,1,1))
gp_black = gpar(col=rgb(0,0,0,1),fill=rgb(0,0,0,1),lex=1)
gp_green = gpar(col=rgb(0,0.6,0,1),fill=rgb(0,0.6,0,1))
gp_gold  = gpar(col=rgb(0,0.6,0.6,1),fill=rgb(0,0.6,0.6,1))
gp_grey  = gpar(col=rgb(0.3,0.3,0.3,1),fill=rgb(0.3,0.3,0.3,1),lex=1)

# Read in the data
sts.1<-read.table('../Alnwick_Castle_1804-5/ovn.back',header=F)
sts.1$Date<-chron(dates=as.character(sts.1$V1),times=as.character(sts.1$V2),
                           format=c(dates = "y/m/d", times = "h:m:s"))
sts.2<-read.table('../Arniston_1804-5/ovn.back',header=F)
sts.2$Date<-chron(dates=as.character(sts.2$V1),times=as.character(sts.2$V2),
                           format=c(dates = "y/m/d", times = "h:m:s"))
sts.3<-read.table('../Ceres_4_1804-5/ovn.back',header=F)
sts.3$Date<-chron(dates=as.character(sts.3$V1),times=as.character(sts.3$V2),
                           format=c(dates = "y/m/d", times = "h:m:s"))
sts.4<-read.table('../Cuffnells_1804-5/ovn.back',header=F)
sts.4$Date<-chron(dates=as.character(sts.4$V1),times=as.character(sts.4$V2),
                           format=c(dates = "y/m/d", times = "h:m:s"))
sts.5<-read.table('../Royal_Charlotte_5_1804-5/ovn.back',header=F)
sts.5$Date<-chron(dates=as.character(sts.5$V1),times=as.character(sts.5$V2),
                           format=c(dates = "y/m/d", times = "h:m:s"))
tics = dates(c('1805/3/01','1805/06/01','1805/09/01'),
      format="y/m/d")
ticl = c('1805/03','1805/06','1805/09')
      
postscript(file="back_combi.ps",paper="a4",family="Helvetica",pointsize=12)
                    
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
downViewport("vp_map")
    pushViewport(plotViewport(margins=c(2,2,2,2)))
    pushViewport(dataViewport(c(-90,180),c(-50,60)))
    grid.xaxis(at=c(-90,-60,-30,0,30,60,90,120,150,180),main=T)
    grid.xaxis(at=c(-90,-60,-30,0,30,60,90,120,150,180),main=F)
    grid.text('Longitude',y=unit(-3,"lines"))
    grid.yaxis(at=c(-50,-30,-10,10,30,50),main=T)
    grid.yaxis(at=c(-50,-30,-10,10,30,50),main=F)
    grid.text('Latitude',x=unit(-3.5,"lines"), rot=90)
    popViewport()
    pushViewport(dataViewport(c(-90,180),c(-50,60),clip='on'))
    grid.lines(x=unit(sr.map.internal.wm$x,"native"),
               y=unit(sr.map.internal.wm$y,"native"),gp=gp_grey)
    grid.points(x=unit(sts.1$V14,"native"),y=unit(sts.1$V13,'native'),pch=20,
               size=unit(2,"native"),gp=gp_red)
    grid.points(x=unit(sts.2$V14,"native"),y=unit(sts.2$V13,'native'),pch=20,
               size=unit(2,"native"),gp=gp_blue)
    grid.points(x=unit(sts.3$V14,"native"),y=unit(sts.3$V13,'native'),pch=20,
               size=unit(2,"native"),gp=gp_black)
    grid.points(x=unit(sts.4$V14,"native"),y=unit(sts.4$V13,'native'),pch=20,
               size=unit(2,"native"),gp=gp_green)
    grid.points(x=unit(sts.5$V14,"native"),y=unit(sts.5$V13,'native'),pch=20,
               size=unit(2,"native"),gp=gp_gold)
popViewport() 
popViewport() 
upViewport()

# Plot the AIR temperatures
downViewport("vp_at")
pushViewport(plotViewport(margins=c(2,2,2,2)))
pushViewport(dataViewport(as.numeric(c(tics[1],tics[3])),c(5,30)))
grid.xaxis(at=as.numeric(tics),label=ticl,main=T)
grid.text('Date',y=unit(-3,"lines"))
grid.yaxis(main=T)
grid.text('Air Temperature (C)',x=unit(-3.5,"lines"), rot=90)
popViewport()
pushViewport(dataViewport(as.numeric(c(tics[1],tics[3])),c(5,30),clip='on'))
   grid.lines(x=unit(sts.1$Date,"native"),y=unit(sts.1$V8,'native'),gp=gp_black)
   grid.points(x=unit(sts.1$Date,"native"),y=unit(sts.1$V7,'native'),pch=20,
               size=unit(2,"native"),gp=gp_red)
   grid.points(x=unit(sts.2$Date,"native"),y=unit(sts.2$V7,'native'),pch=20,
               size=unit(2,"native"),gp=gp_blue)
   grid.points(x=unit(sts.3$Date,"native"),y=unit(sts.3$V7,'native'),pch=20,
               size=unit(2,"native"),gp=gp_black)
   grid.points(x=unit(sts.4$Date,"native"),y=unit(sts.4$V7,'native'),pch=20,
               size=unit(2,"native"),gp=gp_green)
   grid.points(x=unit(sts.5$Date,"native"),y=unit(sts.5$V7,'native'),pch=20,
               size=unit(2,"native"),gp=gp_gold)
popViewport() 
popViewport() 
upViewport()

# Plot the Wind Speeds
downViewport("vp_sst")
pushViewport(plotViewport(margins=c(2,2,2,2)))
pushViewport(dataViewport(as.numeric(c(tics[1],tics[3])),c(0,30)))
grid.xaxis(at=as.numeric(tics),label=ticl,main=T)
grid.text('Date',y=unit(-3,"lines"))
grid.yaxis(main=T)
grid.text('Wind Speed (m/s)',x=unit(-3.5,"lines"), rot=90)
popViewport()
pushViewport(dataViewport(as.numeric(c(tics[1],tics[3])),c(0,30),clip='on'))
   grid.lines(x=unit(sts.1$Date,"native"),y=unit(sts.1$V12,'native'),gp=gp_black)
   grid.points(x=unit(sts.1$Date,"native"),y=unit(sts.1$V11,'native'),pch=20,
               size=unit(2,"native"),gp=gp_red)
   grid.points(x=unit(sts.2$Date,"native"),y=unit(sts.2$V11,'native'),pch=20,
               size=unit(2,"native"),gp=gp_blue)
   grid.points(x=unit(sts.3$Date,"native"),y=unit(sts.3$V11,'native'),pch=20,
               size=unit(2,"native"),gp=gp_black)
   grid.points(x=unit(sts.4$Date,"native"),y=unit(sts.4$V11,'native'),pch=20,
               size=unit(2,"native"),gp=gp_green)
   grid.points(x=unit(sts.5$Date,"native"),y=unit(sts.5$V11,'native'),pch=20,
               size=unit(2,"native"),gp=gp_gold)
popViewport() 
popViewport() 
upViewport()

# Plot the SLPs
downViewport("vp_slp")
pushViewport(plotViewport(margins=c(2,2,2,2)))
pushViewport(dataViewport(as.numeric(c(tics[1],tics[3])),c(990,1030)))
grid.xaxis(at=as.numeric(tics),label=ticl,main=T)
grid.text('Date',y=unit(-3,"lines"))
grid.yaxis(main=T)
grid.text('Pressure (hPa)',x=unit(-3.5,"lines"), rot=90)
popViewport()
pushViewport(dataViewport(as.numeric(c(tics[1],tics[3])),c(990,1030),clip='on'))
   grid.lines(x=unit(sts.1$Date,"native"),y=unit(sts.1$V10,'native'),gp=gp_black)
   grid.points(x=unit(sts.1$Date,"native"),y=unit(sts.1$V9,'native'),pch=20,
               size=unit(2,"native"),gp=gp_red)
   grid.points(x=unit(sts.2$Date,"native"),y=unit(sts.2$V9,'native'),pch=20,
               size=unit(2,"native"),gp=gp_blue)
   grid.points(x=unit(sts.3$Date,"native"),y=unit(sts.3$V9,'native'),pch=20,
               size=unit(2,"native"),gp=gp_black)
   grid.points(x=unit(sts.4$Date,"native"),y=unit(sts.4$V9,'native'),pch=20,
               size=unit(2,"native"),gp=gp_green)
   grid.points(x=unit(sts.5$Date,"native"),y=unit(sts.5$V9,'native'),pch=20,
               size=unit(2,"native"),gp=gp_gold)
popViewport() 
popViewport() 
upViewport()



