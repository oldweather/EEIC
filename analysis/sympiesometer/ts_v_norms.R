# Plot Sympsieometer v normal timeseries
library(grid)
library(chron)
library(auto.tics)

gp_red   = gpar(col=rgb(1,0,0,1),fill=rgb(1,0,0,1))
gp_blue  = gpar(col=rgb(0,0,1,1),fill=rgb(0,0,1,1))
gp_black = gpar(col=rgb(0,0,0,1),fill=rgb(0,0,0,1),lex=1)
gp_grey  = gpar(col=rgb(0.7,0.7,0.7,1),fill=rgb(0.7,0.7,0.7,1),lex=1)

      
postscript(file="sym_v_normal_ts.ps",paper="a4",family="Helvetica",pointsize=8,horizontal=T)
                    
voyages<-c('George_the_Fourth.1832-02-11.1833-03-09',
           'Duke_of_Buccleugh_2.1831-06-13.1832-05-06',
           'Minerva_7.1827-05-14.1828-05-05',
           'Minerva_7.1829-05-11.1830-05-04',
           'Duchess_of_Athol.1826-02-24.1826-08-09',
           'Duchess_of_Athol.1828-02-23.1829-03-19',
           'Duchess_of_Athol.1830-01-06.1831-03-15',
           'Duchess_of_Athol.1832-01-26.1833-05-04',
           'Dunira.1830-01-05.1831-03-19',
           'Dunira.1832-02-11.1833-04-13',
           'Prince_Regent.1833-04-15.1834-05-17',
           'Royal_George_5.1822-12-11.1824-04-02'
           )
viewports<-list(list(width=0.25,height=0.33,x=0.00,y=0.00),
                list(width=0.25,height=0.33,x=0.25,y=0.00),
                list(width=0.25,height=0.33,x=0.50,y=0.00),
                list(width=0.25,height=0.33,x=0.75,y=0.00),
                list(width=0.25,height=0.33,x=0.00,y=0.33),
                list(width=0.25,height=0.33,x=0.25,y=0.33),
                list(width=0.25,height=0.33,x=0.50,y=0.33),
                list(width=0.25,height=0.33,x=0.75,y=0.33),
                list(width=0.25,height=0.33,x=0.00,y=0.66),
                list(width=0.25,height=0.33,x=0.25,y=0.66),
                list(width=0.25,height=0.33,x=0.50,y=0.66),
                list(width=0.25,height=0.33,x=0.75,y=0.66)
               )

Addplot<-function(voyage,vpt,split=NA) {
   sts<-read.table(sprintf("%s.ovn",voyage),header=F)
   sts$Date<-chron(dates=as.character(sts$V1),times=as.character(sts$V2),
                              format=c(dates = "y/m/d", times = "h:m:s"))
   if(!is.na(split)) {
      is.na(sts$V10[split])=T
    }
   pushViewport(viewport(width=vpt$width,
                         height=vpt$height,
                         x=vpt$x,
                         y=vpt$y,
                         just=c("left","bottom")))
   pushViewport(plotViewport(margins=c(4,4,2,2)))
   pushViewport(dataViewport(as.numeric(c(sts$Date[1],
                             sts$Date[length(sts$Date)])),c(950,1050)))
   tics<-auto.time.tics(sts$Date[1],sts$Date[length(sts$Date)])
   grid.xaxis(at=tics,main=T)
   title<-strsplit(voyage,'.',fixed=T)[[1]][1]
   grid.text(title,y=unit(-3,"lines"))
   grid.yaxis(main=T)
   grid.text('Pressure (hPa)',x=unit(-3.5,"lines"), rot=90)
      grid.lines(x=unit(sts$Date,"native"),y=unit(sts$V10,'native'),gp=gp_black)
      grid.points(x=unit(sts$Date,"native"),y=unit(sts$V15,'native'),pch=20,
                  size=unit(7,"native"),gp=gp_red)
      grid.points(x=unit(sts$Date,"native"),y=unit(sts$V9,'native'),pch=20,
                  size=unit(7,"native"),gp=gp_blue)
   popViewport() 
   popViewport() 
   popViewport()
}

for(i in seq(1,length(voyages))) {
   Addplot(voyages[i],viewports[[i]])
}


