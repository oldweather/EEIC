# R script to make annual mean Northern Hemisphere means from
# last-millenium model runs.

library(cmip5)
library(PP)
library(PP.util)

# Models and ensembles with millennium runs available
models<-cmip5.list.data(experiment='past1000',
                        variable='tas',
                        ensemble='all',
                        show='models')
ensemble.members<-list()
Mnames<-list()
count<-1
for(model in models) {
  ensembles<-cmip5.list.data(experiment='past1000',
                              variable='tas',
                              model=model,
                              ensemble='all',
                              show='ensembles')
  for(e in ensembles) {
    if(e=='r0i0p0') next
    ensemble.members[[count]]<-list(model=model,ensemble=e)
    Mnames[[count]]<-model
    count<-count+1
  }
}

# Calculate the mean NH anomaly for each ensemble
mts<-list()
for(member in ensemble.members) {
  m<-cmip5.read.pp(member$model,'past1000','tas',
                        ensemble=member$ensemble,
                        where=c('lbyr>1788','lbyr<1835'))
  c<-pp.make.monthly.climatology(m,start=1788,end=1808)
  a<-pp.make.monthly.anomalies(m,c)
  names(a)<-lapply(a,function(x){return(sprintf("%04d/%02d",x@lbyr,x@lbmon))})
  y<-pp.list.monthly.to.annual(a)
  nh<-pp.area.average(y,lat.range=c(0,90),lon.range=c(-180,360))
  names(nh)<-names(y)
  eName<-sprintf("%s:%s",member$model,member$ensemble)
  mts[[eName]]<-nh
}

# Output the results
cat("Year",names(mts),"\n")
for(year in seq(1789,1834)) {
   res<-sprintf("%04d",year)
   for(n in (names(mts))) {
     if(is.null(mts[[n]][[as.character(year)]])) {
       res<-sprintf("%s    NA",res)
     } else {
        res<-sprintf("%s %5.2f",res,mts[[n]][[as.character(year)]])
     }
   }
   cat(res,"\n")
 }
      
