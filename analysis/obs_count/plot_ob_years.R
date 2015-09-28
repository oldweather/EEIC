# R script to plot the annual observations
library(grid)

dat = read.table('annual_ob_count.out',header=F)
start = dat$V1[1]
end = dat$V1[length(dat$V1)]
tics = c(1790,1800,1810,1820,1830)
postscript(file="ob_years.ps",paper="a4",family='Helvetica',
                horizontal=F,pointsize=16)
pushViewport(viewport(width=1.0,height=0.4,x=0.0,y=0.05,
                      just=c("left","bottom"),name="at_plot"))
pushViewport(plotViewport(margins=c(3,3,1,1)))
pushViewport(dataViewport(dat$V1,dat$V2))
grid.xaxis(at=as.numeric(tics),label=as.character(tics),main=T)
grid.text('Date',y=unit(-3,"lines"))
grid.yaxis(main=T)

# AT first
rgp = gpar(col=rgb(0.1,0.1,0.1,1),fill=rgb(0.1,0.1,0.1,1),lex=2)
grid.lines(x=unit(dat$V1,"native"),y=unit(dat$V2,"native"),gp=rgp)
grid.text('Air Temperature',x=unit(0.05,"npc"),y=unit(0.8,"npc"),
           just=c("left","center"))
popViewport()
popViewport()
popViewport()

# SLP
pushViewport(viewport(width=1.0,height=0.3,x=0.00,y=0.40,
                      just=c("left","bottom"),name="pr_plot"))
pushViewport(plotViewport(margins=c(3,3,1,1)))
pushViewport(dataViewport(dat$V1,dat$V4))
grid.yaxis(main=T)
grid.lines(x=unit(dat$V1,"native"),y=unit(dat$V4,"native"),gp=rgp)
grid.text('Pressure',x=unit(0.05,"npc"),y=unit(0.8,"npc"),
           just=c("left","center"))
popViewport()
popViewport()
popViewport()

# SST
pushViewport(viewport(width=1.0,height=0.3,x=0.00,y=0.70,
                      just=c("left","bottom"),name="st_plot"))
pushViewport(plotViewport(margins=c(3,3,1,1)))
pushViewport(dataViewport(dat$V1,dat$V3))
grid.yaxis(main=T)
ggp = gpar(col=rgb(0.2,0.2,0.2,1),fill=rgb(0.2,0.2,0.2,1))
grid.lines(x=unit(dat$V1,"native"),y=unit(dat$V3,"native"),gp=rgp)
grid.text('Sea Temperature',x=unit(0.05,"npc"),y=unit(0.8,"npc"),
           just=c("left","center"))
popViewport()
popViewport()
popViewport()

