# Plot figure showing ships active in each year
library(grid)

# Read in the data
sts<-read.table('ship_years.out',header=T)
xtics = c(1790,1795,1800,1805,1810,1815,1820,1825,1830,1835,1840)
ships = rep('a',0)  # Character array
y = rep(1,0)
for(i in seq(2,length(names(sts)))) { 
    ships<-append(ships,names(sts)[i])
    y<-append(y,i-1)
}
                    
#png(file="ship_years.png",width=600,height=800,pointsize=8)
#postscript(file="ship_years.ps",paper='special',horizontal=F,width=30,height=20)
postscript(file="ship_years.ps",paper='special',horizontal=T,pointsize=7,
           width=12,height=10)

# Too many ships for one graph - so split into two columns
pushViewport(viewport(width=0.5,height=1.0,x=0.00,y=0.00,
                      just=c("left","bottom"),name="vp1"))
pushViewport(plotViewport(margins=c(4,12,1,1)))
pushViewport(dataViewport(c(1787,1825),y[1:length(ships)/2]))
xtics = c(1790,1795,1800,1805,1810,1815,1820,1825)
grid.xaxis(at=as.numeric(xtics),label=as.character(xtics),main=T)
grid.text('Date',y=unit(-3,"lines"))
grid.yaxis(main=T,at=y[1:length(ships)/2],
                  label=gsub('_',' ',ships[1:length(ships)/2]))

ggp = gpar(col=rgb(0.25,0.25,0.25,1),fill=rgb(0.25,0.25,0.25,1))

# Add the data for each ship
for(i in seq(1,length(ships)/2)) {
   sety = paste(c("yd=sts$",ships[i]),collapse="")
   eval(parse(text=sety))
   for(j in seq(1787,1825)) {
      if(yd[j-1784]==1) {
         grid.points(x=unit(sts$Year[j-1784],"native"),
                     y=unit(i,"native"),
                     pch=20,size=unit(0.7,"native"),gp=ggp)
      }
      else {
         grid.points(x=unit(sts$Year[j-1784],"native"),
                     y=unit(i,"native"),
                     pch=20,size=unit(0.2,"native"),gp=ggp)
      }
   }
}
popViewport()
popViewport()
popViewport()

pushViewport(viewport(width=0.5,height=1.0,x=0.50,y=0.00,
                      just=c("left","bottom"),name="vp2"))
pushViewport(plotViewport(margins=c(4,12,1,1)))
pushViewport(dataViewport(c(1803,1835),y[length(ships)/2+1:length(ships)]))
xtics = c(1805,1810,1815,1820,1825,1830,1835)
grid.xaxis(at=as.numeric(xtics),label=as.character(xtics),main=T)
grid.text('Date',y=unit(-3,"lines"))
grid.yaxis(main=T,at=y[length(ships)/2+1:length(ships)],
                  label=gsub('_',' ',ships[length(ships)/2+1:length(ships)]))

ggp = gpar(col=rgb(0.25,0.25,0.25,1),fill=rgb(0.25,0.25,0.25,1))

# Add the data for each ship
for(i in seq(length(ships)/2+1,length(ships))) {
   sety = paste(c("yd=sts$",ships[i]),collapse="")
   eval(parse(text=sety))
   for(j in seq(1803,1835)) {
      if(yd[j-1784]==1) {
         grid.points(x=unit(sts$Year[j-1784],"native"),
                     y=unit(i,"native"),
                     pch=20,size=unit(0.6,"native"),gp=ggp)
      }
      else {
         grid.points(x=unit(sts$Year[j-1784],"native"),
                     y=unit(i,"native"),
                     pch=20,size=unit(0.2,"native"),gp=ggp)
      }
   }
}
