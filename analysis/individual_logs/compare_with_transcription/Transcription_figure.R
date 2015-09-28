# Compare transcription and voyage time-scales
library(grid)
library(chron)

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
tics = pretty(dates(c('08/12/1808','03/31/1811')))
ticl=attr(tics,'labels')
if(is.null(ticl)) ticl<-as.character(dates(tics))
      
pdf(file="Transcription.pdf",
    width=10,height=5,family='Helvetica',
    paper='special',pointsize=12)
                    
# Two seperate plots - AT and logs transcribed - each in its own viewport
pushViewport(viewport(width=1.0,height=0.5,x=0.0,y=0.5,
                      just=c("left","bottom"),name="vp_transcription"))
upViewport(0)
pushViewport(viewport(width=1.0,height=0.5,x=0.0,y=0.0,
                      just=c("left","bottom"),name="vp_at"))
upViewport(0)

# Plot the AIR temperatures
downViewport("vp_at")
pushViewport(plotViewport(margins=c(4,4,1,1)))
pushViewport(dataViewport(as.numeric(dates(c('08/12/1808','03/31/1811'))),c(10,30)))
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

# Logs transcribed
TDates = c('2008/09/25',
           '2009/03/20',
           '2009/05/06',
           '2009/06/26',
           '2009/08/13',
           '2009/09/11',
           '2009/09/28',
           '2009/11/30',
           '2010/01/11',
           '2010/04/07',
           '2010/04/14',
           '2010/07/12',
           '2010/08/30',
           '2010/09/14',
           '2010/10/04',
           '2010/12/23',
           '2011/01/18',
           '2011/02/17',
           '2011/02/23',
           '2011/03/31')
TDates<-chron(dates=as.character(TDates),times=rep("12:00:00",length(TDates)),
                           format=c(dates = "y/m/d", times = "h:m:s"))
TCountc = c(34,38,38,40,39,40,40,40,40,40,40,40,40,40,40,119,40,40,39,66)

# Plot the transcriptions

downViewport("vp_transcription")
pushViewport(plotViewport(margins=c(4,4,1,1)))
pushViewport(dataViewport(as.numeric(dates(c('08/12/2008','03/31/2011'))),c(0,900)))
grid.yaxis(main=T)
grid.text('Logs transcribed',x=unit(-3.5,"lines"), rot=90)
count=0
for(i in seq(1,20)) {
    grid.points(x=unit(TDates[i],"native"),y=unit(count+TCountc[i],'native'),pch=20,
               size=unit(10,"native"),gp=gp_black)
    grid.lines(x=unit(c(TDates[i],TDates[i]),"native"),
               y=unit(c(count,count+TCountc[i]),'native'),gp=gp_black)
    if(i>1) {
       grid.lines(x=unit(c(TDates[i-1],TDates[i]),"native"),
                  y=unit(c(count,count),'native'),gp=gp_black)
    }
    count<-count+TCountc[i]
}
popViewport() 
popViewport() 
upViewport()



