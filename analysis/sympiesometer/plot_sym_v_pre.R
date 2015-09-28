# R script to plot anomaly time-series
library(lattice)

# Add an x=y line to each plot
plotpanel<-function(x,y,...) {
      llines(c(800,1100),c(800,1100),col="grey")
      panel.xyplot(x,y,...)
}

# Read in the data
sts<-read.table('sym_v_pre.out',header=F)
postscript(file="sym_v_pre.ps",paper="a4",family='Helvetica',pointsize=16)
xyplot(sts$V4~sts$V3|sts$V1,
       xlab='Barometer',
       xlim=c(950,1050),
       ylab='Sympiesometer',
       ylim=c(950,1050),
       panel=plotpanel,
       )
