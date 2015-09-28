# R script to collect pseudo-obs from a last-millenium model run
#  and convert them into an annual mean series.

library(cmip5)
library(PP)
library(PP.util)

# Dates and locations of observations
obs<-read.table('ymll.out',header=F)

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

# Calculate the mean pseudo-ob for each month in each run
mts<-list()
for(member in ensemble.members) {
  m<-cmip5.read.pp(member$model,'past1000','tas',
                        ensemble=member$ensemble,
                        where=c('lbyr>1788','lbyr<1835'))
  c<-pp.make.monthly.climatology(m,start=1788,end=1808)
  a<-pp.make.monthly.anomalies(m,c)
  names(a)<-lapply(a,function(x){return(sprintf("%04d/%02d",x@lbyr,x@lbmon))})
  eName<-sprintf("%s:%s",member$model,member$ensemble)
  mts[[eName]]<-list()
  count<-list()
  for(i in seq_along(obs$V1)) {
    dName<-sprintf("%04d/%02d",obs$V1[i],obs$V2[i])
    year<-as.character(obs$V1[i])
    if(is.null(a[[dName]])) next
    if(is.null(mts[[eName]][[year]])) {
      mts[[eName]][[year]]<-0
      count[[year]]=0
    }
    pseudo<-pp.get.point.ll(a[[dName]],obs$V3[i],obs$V4[i])
    if(!is.na(pseudo)) {
       mts[[eName]][[year]]<-mts[[eName]][[year]]+pseudo
       count[[year]]<-count[[year]]+1
     }
  }
  for(n in names(mts[[eName]])) {
    mts[[eName]][[n]]<-mts[[eName]][[n]]/count[[n]]
  }
}

# Output the results
cat("Year",names(mts),"\n")
for(year in seq(1789,1834)) {
   res<-sprintf("%04d",year)
   for(n in (names(mts))) {
     res<-sprintf("%s %5.2f",res,mts[[n]][[as.character(year)]])
   }
   cat(res,"\n")
 }
      
