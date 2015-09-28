# Plot figure showing relative frequencies for wind terms
library(grid)

# Read in the data
sts<-read.table('../../../analysis/winds/force_frequencies',header=F)
sts$V3<-sts$V3*100 # convert to %
terms = rep('a',0)  # Character array
y = rep(1,0)

max.length=50 # Don't clutter the plot with rare values

for(i in seq(1,min(length(sts$V1),max.length))) {
    if(is.na(sts$V4[i])) {
       terms<-append(terms,as.character(sts$V1[i]))
    }
    else {
       terms<-append(terms,paste(as.character(sts$V1[i]),
                       ' (',as.character(sts$V4[i]),')',sep=''))
    }
    y<-append(y,length(sts$V1)-i)
}
                    
pdf(file="wind_term_frequencies.pdf",paper='special',pointsize=10,
         width=6,height=9)
pushViewport(viewport(width=1.0,height=1.0,x=0.00,y=0.00,
                      just=c("left","bottom"),name="vp"))
pushViewport(plotViewport(margins=c(4,12,1,1)))
pushViewport(dataViewport(sts$V3,y))
grid.xaxis(main=T)
grid.text('Percent of observations',y=unit(-3,"lines"))
grid.yaxis(main=T,at=y,label=gsub('_',' ',terms))

bgp = gpar(col=rgb(1,0,0,1),fill=rgb(1,0,0,1))
ggp = gpar(col=rgb(0.5,0.5,0.5,1),fill=rgb(0.5,0.5,0.5,1))

# Add the data for each ship
for(i in seq(1,min(length(sts$V1),max.length))) {
    if(is.na(sts$V4[i])) {
        grid.points(x=unit(sts$V3[i],"native"),
                    y=unit(y[i],"native"),
                    pch=20,size=unit(0.5,"native"),gp=ggp)
    }
    else {
        grid.points(x=unit(sts$V3[i],"native"),
                    y=unit(y[i],"native"),
                    pch=20,size=unit(0.5,"native"),gp=bgp)
    }
}    
