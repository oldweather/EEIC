# Make a route plot for the main fleet
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
sts.1<-read.table('../Alnwick_Castle_1804-5/ovn.all',header=F)
sts.1$Date<-chron(dates=as.character(sts.1$V1),times=as.character(sts.1$V2),
                           format=c(dates = "y/m/d", times = "h:m:s"))
sts.2<-read.table('../Arniston_1804-5/ovn.all',header=F)
sts.2$Date<-chron(dates=as.character(sts.2$V1),times=as.character(sts.2$V2),
                           format=c(dates = "y/m/d", times = "h:m:s"))
sts.3<-read.table('../Ceres_4_1804-5/ovn.all',header=F)
sts.3$Date<-chron(dates=as.character(sts.3$V1),times=as.character(sts.3$V2),
                           format=c(dates = "y/m/d", times = "h:m:s"))
sts.4<-read.table('../Cuffnells_1804-5/ovn.all',header=F)
sts.4$Date<-chron(dates=as.character(sts.4$V1),times=as.character(sts.4$V2),
                           format=c(dates = "y/m/d", times = "h:m:s"))
sts.5<-read.table('../Royal_Charlotte_5_1804-5/ovn.all',header=F)
sts.5$Date<-chron(dates=as.character(sts.5$V1),times=as.character(sts.5$V2),
                           format=c(dates = "y/m/d", times = "h:m:s"))
tics = pretty(sts.1$Date)
ticl = as.character(dates(tics))
      
pdf(file="all_route.pdf",paper="special",
           width=8,height=4,
           family="Helvetica",pointsize=12)
                    
pushViewport(viewport(width=1.0,height=1.0,x=0.0,y=0.0,
                      just=c("left","bottom"),name="vp_map"))

# Draw the map
   sr.map.internal.wm <- map('world',interior=FALSE,plot=FALSE)
   is.na(sr.map.internal.wm$x[8836])=T  # Remove Antarctic bug
    pushViewport(plotViewport(margins=c(3,3,1,1)))
    pushViewport(dataViewport(c(-90,180),c(-55,60)))
    grid.xaxis(at=c(-90,-60,-30,0,30,60,90,120,150,180),main=T)
    grid.yaxis(at=c(-50,-30,-10,10,30,50),main=T)
    popViewport()
    pushViewport(dataViewport(c(-90,180),c(-55,60),clip='on'))
    grid.lines(x=unit(sr.map.internal.wm$x,"native"),
               y=unit(sr.map.internal.wm$y,"native"),gp=gp_black)
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

