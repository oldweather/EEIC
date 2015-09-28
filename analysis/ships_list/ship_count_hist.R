# Plot histogram of number of ships per year
library(lattice)

# Read in the data
sts<-read.table('ship_years.out',header=T)
ships = rep('a',0)  # Character array
for(i in seq(2,length(names(sts)))) { 
    ships<-append(ships,names(sts)[i])
}
                    
#png(file="ship_count.png",width=600,height=800,pointsize=8)
postscript(file="ship_count.ps",paper='a4',horizontal=T,pointsize=12)

y = rep(1,0)
# Add the data for each ship
for(i in seq(1,length(ships))) {
   sety = paste(c("yd=sts$",ships[i]),collapse="")
   eval(parse(text=sety))
   for(j in sts$Year) {
      if(yd[j-1784]==1) {
        y<-append(y,j)
      }
   }
}

# Plot the histogram
hist(y,breaks=seq(1785,1840),col='grey',main='',xlab='Year',ylab='Number of ships')
