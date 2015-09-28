# R script to plot the monthly observations
library(grid)

dat = read.table('ob_count.out',header=F)
dat$V1 = as.Date(paste(dat$V1,"/01",sep=''))
start = dat$V1[1]
end = dat$V1[length(dat$V1)]
tics = as.Date(c("1790-01-01","1795-01-01","1800-01-01","1805-01-01",
                 "1810-01-01","1815-01-01","1820-01-01","1825-01-01",
                 "1830-01-01","1835-01-01"))
ticsC = c("1790","1795","1800","1805","1810","1815","1820","1825","1830","1835")
postscript(file="ob_months.ps",paper="a4",family='Helvetica',pointsize=16)
pushViewport(viewport(width=0.95,height=0.95,x=0.05,y=0.05,
                      just=c("left","bottom"),name="vp_plot"))
pushViewport(plotViewport(margins=c(3,3,1,1)))
pushViewport(dataViewport(as.numeric(c(start,end)),c(0,400)))
grid.xaxis(at=as.numeric(tics),label=ticsC,main=T)
grid.text('Date',y=unit(-3,"lines"))
grid.yaxis(main=T)
grid.text('Monthly number of observations',x=unit(-4,"lines"), rot=90)

# AT first
rgp = gpar(col=rgb(1,0,0,1),fill=rgb(1,0,0,1))
grid.lines(x=unit(dat$V1,"native"),y=unit(dat$V2,"native"),gp=rgp)
grid.lines(x=unit(c(0.15,0.2),"npc"),y=unit(c(0.90,0.90),"npc"),gp=rgp)
grid.text('Air Temperature',x=unit(0.22,"npc"),y=unit(0.9,"npc"),
           just=c("left","center"))

# SLP
bgp = gpar(col=rgb(0,0,1,1),fill=rgb(0,0,1,1))
grid.lines(x=unit(dat$V1,"native"),y=unit(dat$V4,"native"),gp=bgp)
grid.lines(x=unit(c(0.15,0.2),"npc"),y=unit(c(0.85,0.85),"npc"),gp=bgp)
grid.text('Pressure',x=unit(0.22,"npc"),y=unit(0.85,"npc"),
           just=c("left","center"))

# SST
ggp = gpar(col=rgb(0.2,0.2,0.2,1),fill=rgb(0.2,0.2,0.2,1))
grid.lines(x=unit(dat$V1,"native"),y=unit(dat$V3,"native"),gp=ggp)
grid.lines(x=unit(c(0.15,0.2),"npc"),y=unit(c(0.80,0.80),"npc"),gp=ggp)
grid.text('Sea Temperature',x=unit(0.22,"npc"),y=unit(0.8,"npc"),
           just=c("left","center"))

