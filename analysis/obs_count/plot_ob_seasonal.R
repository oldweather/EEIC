# R script to plot the annual cuycle of observation counts
library(grid)

dat = read.table('ob_count_seasonal.out',header=F)
tics = seq(1,12)
ticsC = c("Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec")
rgp = gpar(col=rgb(0.1,0.1,0.1,1),fill=rgb(0.1,0.1,0.1,1),lex=1)
postscript(file="ob_seasonal.ps",paper="a4",family='Helvetica',
                horizontal=F,pointsize=16)
# 1830-1840              
pushViewport(viewport(width=1.0,height=0.2,x=0.0,y=0.05,
                      just=c("left","bottom")))
pushViewport(plotViewport(margins=c(2,3,1,1)))
pushViewport(dataViewport(dat$V1,dat$V6))
grid.xaxis(at=tics,label=ticsC,main=T)
grid.yaxis(main=T)
grid.lines(x=unit(dat$V1,"native"),y=unit(dat$V6,"native"),gp=rgp)
grid.text('1830-1840',x=unit(0.8,"npc"),y=unit(0.8,"npc"),
           just=c("left","center"))
popViewport()
popViewport()
popViewport()

# 1820-1830              
pushViewport(viewport(width=1.0,height=0.2,x=0.0,y=0.2,
                      just=c("left","bottom")))
pushViewport(plotViewport(margins=c(2,3,1,1)))
pushViewport(dataViewport(dat$V1,dat$V5))
grid.yaxis(main=T)
grid.lines(x=unit(dat$V1,"native"),y=unit(dat$V5,"native"),gp=rgp)
grid.text('1820-1830',x=unit(0.8,"npc"),y=unit(0.8,"npc"),
           just=c("left","center"))
popViewport()
popViewport()
popViewport()

# 1810-1820              
pushViewport(viewport(width=1.0,height=0.2,x=0.0,y=0.4,
                      just=c("left","bottom")))
pushViewport(plotViewport(margins=c(2,3,1,1)))
pushViewport(dataViewport(dat$V1,dat$V4))
grid.yaxis(main=T)
grid.lines(x=unit(dat$V1,"native"),y=unit(dat$V4,"native"),gp=rgp)
grid.text('1810-1820',x=unit(0.8,"npc"),y=unit(0.8,"npc"),
           just=c("left","center"))
popViewport()
popViewport()
popViewport()

# 1800-1810              
pushViewport(viewport(width=1.0,height=0.2,x=0.0,y=0.6,
                      just=c("left","bottom")))
pushViewport(plotViewport(margins=c(2,3,1,1)))
pushViewport(dataViewport(dat$V1,dat$V3))
grid.yaxis(main=T)
grid.lines(x=unit(dat$V1,"native"),y=unit(dat$V3,"native"),gp=rgp)
grid.text('1800-1810',x=unit(0.8,"npc"),y=unit(0.8,"npc"),
           just=c("left","center"))
popViewport()
popViewport()
popViewport()

# 1790-1800              
pushViewport(viewport(width=1.0,height=0.2,x=0.0,y=0.8,
                      just=c("left","bottom")))
pushViewport(plotViewport(margins=c(2,3,1,1)))
pushViewport(dataViewport(dat$V1,dat$V2))
grid.yaxis(main=T)
grid.lines(x=unit(dat$V1,"native"),y=unit(dat$V2,"native"),gp=rgp)
grid.text('1790-1800',x=unit(0.8,"npc"),y=unit(0.8,"npc"),
           just=c("left","center"))
popViewport()
popViewport()
popViewport()

