# R script to plot anomaly time-series
library(lattice)

# Add an x=y line to each plot
plotpanel<-function(x,y,...) {
      llines(c(800,1100),c(800,1100),col="grey")
      panel.xyplot(x,y,...)
}

# Read in the data
sts<-read.table('sym_v_pre.censored.out',header=F)
sts$V1<-gsub('_',' ',sts$V1)
pdf(file="sym_v_pre_censored.pdf",paper="special",
          width=10,height=6,
          family='Helvetica',pointsize=16)
xyplot(sts$V4~sts$V3|sts$V1,
       xlab='Barometer pressure (hPa)',
       xlim=c(950,1050),
       ylab='Sympiesometer pressure (hPa)',
       ylim=c(940,1060),
       panel=plotpanel,
       pch=20,cex=0.25
       )
