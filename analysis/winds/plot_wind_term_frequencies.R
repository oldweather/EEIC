# Plot figure showing relative frequencies for wind terms
library(grid)

# Read in the data
sts<-read.table('force_frequencies',header=F)
terms = rep('a',0)  # Character array
y = rep(1,0)
for(i in seq(1,length(sts$V1))) {
    if(is.na(sts$V4[i])) {
       terms<-append(terms,as.character(sts$V1[i]))
    }
    else {
       terms<-append(terms,paste(as.character(sts$V1[i]),
                       ' (',as.character(sts$V4[i]),')',sep=''))
    }
    y<-append(y,length(sts$V1)-i)
}
                    
postscript(file="term_frequencies.ps",paper='a4',horizontal=F,pointsize=10)
pushViewport(viewport(width=1.0,height=1.0,x=0.00,y=0.00,
                      just=c("left","bottom"),name="vp"))
pushViewport(plotViewport(margins=c(4,12,1,1)))
pushViewport(dataViewport(sts$V3,y))
grid.xaxis(main=T)
grid.text('Fraction of observations',y=unit(-3,"lines"))
grid.yaxis(main=T,at=y,label=gsub('_',' ',terms))

bgp = gpar(col=rgb(0,0,0,1),fill=rgb(0,0,0,1))
ggp = gpar(col=rgb(0.5,0.5,0.5,1),fill=rgb(0.5,0.5,0.5,1))

# Add the data for each ship
for(i in seq(1,length(sts$V1))) {
    if(is.na(sts$V4[i])) {
        grid.points(x=unit(sts$V3[i],"native"),
                    y=unit(y[i],"native"),
                    pch=20,size=unit(0.003,"native"),gp=ggp)
    }
    else {
        grid.points(x=unit(sts$V3[i],"native"),
                    y=unit(y[i],"native"),
                    pch=20,size=unit(0.003,"native"),gp=bgp)
    }
}    
