# R script to plot anomaly time-series
library(grid)

# Read in the data
sts<-read.table('sst_anoms.out',header=T)
sts$Date<-as.Date(as.character(sts$Date))
start = sts$Date[1]
end = sts$Date[length(sts$Date)]
tics = as.Date(c("1790-01-01","1795-01-01","1800-01-01","1805-01-01","1810-01-01",
          "1815-01-01","1820-01-01","1825-01-01","1830-01-01","1835-01-01"))
ticsC = c("1790","1795","1800","1805","1810",
          "1815","1820","1825","1830","1835")
ships = rep('a',0)  # Character array
for(i in seq(2,length(names(sts)))) { ships<-append(ships,names(sts)[i]) }
                    
# Make the plot environment
postscript(file="sst_anom_ts.ps",paper="a4",family='Helvetica',pointsize=16)
pushViewport(viewport(width=0.95,height=0.95,x=0.05,y=0.05,
                      just=c("left","bottom"),name="vp_map"))
pushViewport(plotViewport(margins=c(2,2,2,2)))
pushViewport(dataViewport(as.numeric(c(start,end)),c(-10,10)))
grid.xaxis(at=as.numeric(tics),label=ticsC,main=T)
grid.text('Date',y=unit(-3,"lines"))
grid.yaxis(main=T)
grid.text('SST anomaly (C)',x=unit(-3,"lines"), rot=90)

# Colours to plot in
colours = c(rgb(1,0,0,1),
            rgb(0.2,0.7,0.1,1),
            rgb(0,0,1,1),
            rgb(0.7,0.7,0.7,1),
            rgb(0,0.7,0.7,1),
            rgb(0.7,0,0.7,1))

# Add the data for each ship
for(i in seq(1,length(ships))) {
   sety = paste(c("yd=unit(sts$",ships[i],",'native')"),collapse="")
   eval(parse(text=sety))
   colour = i-length(colours)*as.integer(i/length(colours))+1
   sgp = gpar(col=colours[colour],fill=colours[colour])
#   grid.lines(x=unit(sts$Date,"native"),y=yd,gp=sgp)
   grid.points(x=unit(sts$Date,"native"),y=yd,pch=20,
               size=unit(5,"native"),gp=sgp)
}
