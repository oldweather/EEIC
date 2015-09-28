# Make a regional mean spaghetti plot of a selected variable,
# a selected experiment, a selected ensemble (might be 'all' ensembles)
# and all the CMIP5 models.

library(cmip5)
library(PP)
library(multicore)

experiment<-'past1000'
variable<-'tas'
ensemble<-'all'
anomalies<-T

lat.range<-c(-90,90)
lon.range<-c(-180,360)

# Which models have data for the selected variable, experiment and ensemble member
models<-cmip5.list.data(experiment=experiment,
                        variable=variable,
                        ensemble=ensemble,
                        show='models')
ensemble.members<-list()
Mnames<-list()
count<-1
for(model in models) {
  ensembles<-cmip5.list.data(experiment=experiment,
                              variable=variable,
                              model=model,
                              ensemble=ensemble,
                              show='ensembles')
  for(e in ensembles) {
    if(e=='r0i0p0') next
    ensemble.members[[count]]<-list(model=model,ensemble=e)
    Mnames[[count]]<-model
    count<-count+1
  }
}

# Global mean time-series for each ensemble member
get.mts<-function(ensM) {
  cat(paste(paste(ensM$model,ensM$ensemble," "),"\n"))
  if(anomalies) {
    c<-pp.ppa(sprintf("../../data/climatologies/%s/%s.pp",
                         variable,sub('/','\\.',ensM$model)))
    if(length(c)<12) {
      warning(paste("No climatology for",ensM$model))
      next
    }
  } 
  start.year<-NULL
  i<-cmip5.read.pp.iter(ensM$model,experiment,variable,
                        ensemble=ensM$ensemble)
  mts<-list()
  while(i$hasNext()) {
    m<-i$nextElem()
    if(anomalies) m@data<-m@data-c[[m@lbmon]]@data
    if(is.null(start.year)) start.year<-m@lbyr
    if(experiment=='piControl' ||
       experiment=='1pctCO2' ||
       experiment=='midHolocene' ||
       experiment=='lgm' ||
       experiment=='aquaControl') {
       date<-sprintf("%04d/%02d",m@lbyr-start.year+1000,m@lbmon)
     } else  date<-sprintf("%04d/%02d",m@lbyr,m@lbmon)
    mts[[date]]<-pp.area.average(m,lat.range=lat.range,
                                   lon.range=lon.range)
  }
  mts<-mts[sort(names(mts))] # ascending order by date
  return(mts)
}


mts<-mclapply(ensemble.members,get.mts)
names(mts)<-Mnames

# Make the plot
pdf(file=sprintf("../../data/spaghetti.plots/%s.%s.pdf",experiment,variable),
    width=11.7,height=8.3)
cmip5.splot(mts,smooth=100)
dev.off()    
