# R script to plot a Nobs map from a PP field
library(grid)
library(lattice)
library(PP.map)

pdf(file='coverage.pdf',width=6,height=8,pointsize=12)

# Map of coverage
pushViewport(viewport(width=1.0,height=0.7,x=0.0,y=0.35,
                      just=c("left","bottom"),name="vp_map"))
   f=pp.ppa('../../../analysis/coverage_map/nobs.pp')
   m<-pp.map(f[[1]],lon_range=c(-60,180),
          draw=F,
          levels=c(1,2,5,10,20,50,100,150,200,250,300,350,
                             400,500,700,1000,1200,1500,1700))
   print(m,newpage=F)
upViewport()

# Number of logs/year
sts<-read.table('../../../analysis/ships_list/ship_years.out',header=T)
ships = rep('a',0)  # Character array
for(i in seq(2,length(names(sts)))) {
    ships<-append(ships,names(sts)[i])
}
y = rep(0,length(seq(1785,1835)))
# Add the data for each ship
for(i in seq(1,length(ships))) {
   sety = paste(c("yd=sts$",ships[i]),collapse="")
   eval(parse(text=sety))
   for(j in sts$Year) {
      if(yd[j-1784]==1) {
        y[j-1784]<-y[j-1784]+1
      }
   }
}
sgp = gpar(col=rgb(1,0,0,1),fill=rgb(1,0,0,1))
pushViewport(viewport(width=1.0,height=0.45,x=0.0,y=0,
                      just=c("left","bottom"),name="vp_ts"))
pushViewport(plotViewport(margins=c(4,4,1,1)))
pushViewport(dataViewport(c(1790,1835),c(0,65)))
grid.xaxis(main=T)
grid.text('Year',y=unit(-3,"lines"))
grid.yaxis(main=T)
grid.text('Number of ships',x=unit(-3,"lines"), rot=90)
popViewport()
pushViewport(dataViewport(c(1790,1835),c(-0,65),clip='on'))
grid.points(x=unit(seq(1785,1835),'native'),
           y=unit(y,'native'),
           size=unit(0.02,'npc'),
           pch=20,
           gp=sgp)
grid.lines(x=unit(seq(1785,1835),'native'),
           y=unit(y,'native'),
           gp=sgp)
popViewport()
popViewport()
upViewport()
