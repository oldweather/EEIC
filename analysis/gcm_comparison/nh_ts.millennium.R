# Make time-series for the CMIP5 models


load('/net/home/h03/hadpb/tasks/cmip5/scripts/ts_modelling/series/past1000.tas.Rdata')   # mts.past1000 and mts.past1000.dedrift

# Annualise
for(i in seq_along(mts.past1000.dedrift)) {
   model<-attr(mts.past1000.dedrift[[i]],'model')
   results<-list()
   count<-list()
   for(dt in names(mts.past1000.dedrift[[i]])) {
     year<-substr(dt,1,4)
     if(is.null(results[[year]])) {
       results[[year]]<-mts.past1000.dedrift[[i]][[dt]]
       count[[year]]<-1
     } else {
       results[[year]]<-results[[year]]+mts.past1000.dedrift[[i]][[dt]]
       count[[year]]<-count[[year]]+1
    }   
  }
  for(yr in names(results)) { results[[yr]]<-results[[yr]]/count[[yr]] }
  mts.past1000.dedrift[[i]]<-results[sort(names(results))] # ascending order by date
  attr(mts.past1000.dedrift[[i]],'model')<-model
}

# Output the results
cat("Year"," ")
for(i in seq_along(mts.past1000.dedrift)) {
  cat(attr(mts.past1000.dedrift[[i]],'model')," ")
}
cat("\n")
for(year in sprintf("%04d",seq(850,2000))) {
   res<-year
   for(n in (seq_along(mts.past1000.dedrift))) {
     if(is.null(mts.past1000.dedrift[[n]][[year]])) {
       res<-sprintf("%s    NA",res)
     } else {
        res<-sprintf("%s %5.2f",res,mts.past1000.dedrift[[n]][[year]])
     }
   }
   cat(res,"\n")
 }
