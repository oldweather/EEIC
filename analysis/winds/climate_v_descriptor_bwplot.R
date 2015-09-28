# Box and whisker plot scatter plot of climatological wind speed v. ob descriptor

library(lattice)
sts<-read.table('climate_v_descriptor',header=F)
sts$V1 = sub('_',' ',sts$V1)
postscript(file="climate_v_descriptor.ps",paper="a4",family='Helvetica',pointsize=16)
bwplot(sts$V1~sts$V2,xlab='Climatological wind Speed (m/s)')
