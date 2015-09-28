# Make a temperature scatter figure for the main fleet On the voyage out
library(grid)
library(chron)
library(lattice)
library(maps)

# Load the map functions
source("../../../../scripts/sr.map.R")
gp_red   = gpar(col=rgb(1,0,0,1),fill=rgb(1,0,0,1),lex=1)
gp_blue  = gpar(col=rgb(0,0,1,1),fill=rgb(0,0,1,1),lex=1)
gp_black = gpar(col=rgb(0,0,0,1),fill=rgb(0,0,0,1),lex=1)
gp_green = gpar(col=rgb(0,0.6,0,1),fill=rgb(0,0.6,0,1),lex=1)
gp_gold  = gpar(col=rgb(0,0.6,0.6,1),fill=rgb(0,0.6,0.6,1),lex=1)
gp_grey  = gpar(col=rgb(0.3,0.3,0.3,1),fill=rgb(0.3,0.3,0.3,1),lex=1)
gp_back  = gpar(col=rgb(0.9,0.9,0.9,1),fill=rgb(0.9,0.9,0.9,1),lex=1)
gp_label = gpar(col=rgb(0,0,0,1),fill=rgb(0,0,0,1),cex=0.5)

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
                           
# Calculate the mean longitude for each day
for(d in unique(c(sts.1$Date,sts.2$Date,sts.3$Date,sts.4$Date,sts.5$Date))) {
   m<-mean(c(sts.1$V7[sts.1$Date==d],sts.2$V7[sts.2$Date==d],
               sts.3$V7[sts.3$Date==d],sts.4$V7[sts.4$Date==d],
               sts.5$V7[sts.5$Date==d]),na.rm=T)
   if(length(sts.1$V7[sts.1$Date==d])>0) {
      sts.1$V7[sts.1$Date==d]<-sts.1$V7[sts.1$Date==d]-m
      if(!is.na(sts.1$V7[sts.1$Date==d]) && 
         sts.1$V7[sts.1$Date==d]==0) is.na(sts.1$V7[sts.1$Date==d])<-T
   }  
   if(length(sts.2$V7[sts.2$Date==d])>0) {
      sts.2$V7[sts.2$Date==d]<-sts.2$V7[sts.2$Date==d]-m
      if(!is.na(sts.2$V7[sts.2$Date==d]) && 
         sts.2$V7[sts.2$Date==d]==0) is.na(sts.2$V7[sts.2$Date==d])<-T
   }  
   if(length(sts.3$V7[sts.3$Date==d])>0) {
      sts.3$V7[sts.3$Date==d]<-sts.3$V7[sts.3$Date==d]-m
      if(!is.na(sts.3$V7[sts.3$Date==d]) &&
         sts.3$V7[sts.3$Date==d]==0) is.na(sts.3$V7[sts.3$Date==d])<-T
   }  
   if(length(sts.4$V7[sts.4$Date==d])>0) {
      sts.4$V7[sts.4$Date==d]<-sts.4$V7[sts.4$Date==d]-m
      if(!is.na(sts.4$V7[sts.4$Date==d]) &&
         sts.4$V7[sts.4$Date==d]==0) is.na(sts.4$V7[sts.4$Date==d])<-T
   }  
   if(length(sts.5$V7[sts.5$Date==d])>0) {
      sts.5$V7[sts.5$Date==d]<-sts.5$V7[sts.5$Date==d]-m
      if(!is.na(sts.5$V7[sts.5$Date==d]) &&
         sts.5$V7[sts.5$Date==d]==0) is.na(sts.5$V7[sts.5$Date==d])<-T
   } 
}

tics = dates(c('1804/06/01','1804/08/01','1804/10/01','1804/12/01'),
      format="y/m/d")
ticl = c('1804/06','1804/08','1804/10','1804/12')

tics<-pretty(sts.1$Date)
ticl<-as.character(dates(tics))
      
pdf(file="temperature_v_time.pdf",paper="special",
        width=6,height=4,family="Helvetica",pointsize=10)


# Plot the Longitudes
pushViewport(viewport(width=1.0,height=1.0,x=0.0,y=0.0,
                      just=c("left","bottom"),name="vp_long"))
pushViewport(plotViewport(margins=c(4,4,0.75,0.75)))
pushViewport(dataViewport(as.numeric(sts.1$Date),c(-5,5)))
grid.xaxis(at=as.numeric(tics),label=ticl,main=T)
grid.text('Date',y=unit(-3,"lines"))
grid.yaxis(main=T)
grid.text('Air temperature variation (C)',x=unit(-3.5,"lines"), rot=90)
popViewport()
mDates <- dates(c('1805/09/15','1805/09/30'),format="y/m/d")
pushViewport(dataViewport(as.numeric(sts.1$Date),c(-5,5),clip='on'))

    grid.polygon(x=unit(dates(c('1804/08/17','1804/09/01',
                                '1804/09/01','1804/08/17'),format="y/m/d"),
                        'native'),
                 y=unit(c(-4.5,-4.5,4.5,4.5),'native'),gp=gp_back)
    grid.text('Rio de Janeiro',x=unit(dates('1804/08/24',format="y/m/d"),
                                      'native'),
                               y=unit(4.75,'native'),
                               just=c("center"),gp=gp_label)
    grid.polygon(x=unit(dates(c('1804/10/09','1804/10/09',
                                '1804/10/09','1804/10/09'),format="y/m/d"),
                        'native'),
                 y=unit(c(-4.5,-4.5,4.5,4.5),'native'),gp=gp_back)
    grid.text('St Paul',x=unit(dates('1804/10/09',format="y/m/d"),
                                      'native'),
                               y=unit(4.75,'native'),
                               just=c("center"),gp=gp_label)
    grid.polygon(x=unit(dates(c('1804/10/28','1804/10/29',
                                '1804/10/29','1804/10/28'),format="y/m/d"),
                        'native'),
                 y=unit(c(-4.5,-4.5,4.5,4.5),'native'),gp=gp_back)
    grid.text('Bass Strait',x=unit(dates('1804/10/29',format="y/m/d"),
                                      'native'),
                               y=unit(5.0,'native'),
                               just=c("center"),gp=gp_label)
    grid.polygon(x=unit(dates(c('1804/12/29','1805/03/07',
                                '1805/03/07','1804/12/29'),format="y/m/d"),
                        'native'),
                 y=unit(c(-4.5,-4.5,4.5,4.5),'native'),gp=gp_back)
    grid.text('Hong Kong',x=unit(dates('1805/02/04',format="y/m/d"),
                                      'native'),
                               y=unit(4.75,'native'),
                               just=c("center"),gp=gp_label)
    grid.polygon(x=unit(dates(c('1805/07/01','1805/07/11',
                                '1805/07/11','1805/07/01'),format="y/m/d"),
                        'native'),
                 y=unit(c(-4.5,-4.5,4.5,4.5),'native'),gp=gp_back)
    grid.text('St Helena',x=unit(dates('1805/07/05',format="y/m/d"),
                                      'native'),
                               y=unit(4.75,'native'),
                               just=c("center"),gp=gp_label)

    #grid.lines(x=unit(mDates,'native'),
    #           y=unit(rep(mean(sts.1$V7,na.rm=T),2),'native'),gp=gp_red)
    #grid.lines(x=unit(mDates,'native'),
    #           y=unit(rep(mean(sts.2$V7,na.rm=T),2),'native'),gp=gp_blue)
    #grid.lines(x=unit(mDates,'native'),
    #           y=unit(rep(mean(sts.3$V7,na.rm=T),2),'native'),gp=gp_black)
    #grid.lines(x=unit(mDates,'native'),
    #           y=unit(rep(mean(sts.4$V7,na.rm=T),2),'native'),gp=gp_green)
    #grid.lines(x=unit(mDates,'native'),
    #           y=unit(rep(mean(sts.5$V7,na.rm=T),2),'native'),gp=gp_gold)
    grid.points(y=unit(sts.1$V7,"native"),x=unit(sts.1$Date,'native'),pch=20,
               size=unit(2,"native"),gp=gp_red)
    grid.points(y=unit(sts.2$V7,"native"),x=unit(sts.2$Date,'native'),pch=20,
               size=unit(2,"native"),gp=gp_blue)
    grid.points(y=unit(sts.3$V7,"native"),x=unit(sts.3$Date,'native'),pch=20,
               size=unit(2,"native"),gp=gp_black)
    grid.points(y=unit(sts.4$V7,"native"),x=unit(sts.4$Date,'native'),pch=20,
               size=unit(2,"native"),gp=gp_green)
    grid.points(y=unit(sts.5$V7,"native"),x=unit(sts.5$Date,'native'),pch=20,
               size=unit(2,"native"),gp=gp_gold)
popViewport() 
popViewport() 
upViewport()
                   

