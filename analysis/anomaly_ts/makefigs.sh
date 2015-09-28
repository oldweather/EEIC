# Make time-series anomaly figures

# Extract the AT anomalies
make_AT_anomalies.perl ../../imma/*/*.imma > /data/cr2/hadpb/digitisation/EIC/analysis/at_anoms.out
ln -sf /data/cr2/hadpb/digitisation/EIC/analysis/at_anoms.out .

# Plot the AT anomalies (at_anom_ts.ps)
R --no-save < plot_at_anom_ts.R
epstopdf at_anom_ts.ps
#convert -rotate 90 -geometry 800x600 at_anom_ts.ps at_anom_ts.png
R --no-save < make_at_anom_bwplot.R
epstopdf at_anom_bwplot.ps
#convert -rotate 90 -geometry 800x600 at_anom_bwplot.ps at_anom_bwplot.png
R --no-save < make_at_anom_bwplot_byShip.R
epstopdf at_anom_bwplot_byShip.ps
#convert -rotate 90 -geometry 800x600 at_anom_bwplot_byShip.ps at_anom_bwplot_byShip.png
 
# Extract the SST anomalies
make_SST_anomalies.perl ../../imma/*/*.imma > /data/cr2/hadpb/digitisation/EIC/analysis/sst_anoms.out
ln -sf /data/cr2/hadpb/digitisation/EIC/analysis/sst_anoms.out .

# Plot the SST anomalies (sst_anom_ts.ps)
R --no-save < plot_sst_anom_ts.R
epstopdf sst_anom_ts.ps
#convert -rotate 90 -geometry 800x600 sst_anom_ts.ps sst_anom_ts.png
R --no-save < make_sst_anom_bwplot.R
epstopdf sst_anom_bwplot.ps
#convert -rotate 90 -geometry 800x600 sst_anom_bwplot.ps sst_anom_bwplot.png

# Extract the Pressure anomalies
make_PRE_anomalies.perl ../../imma/*/*.imma > /data/cr2/hadpb/digitisation/EIC/analysis/pre_anoms.out
ln -sf /data/cr2/hadpb/digitisation/EIC/analysis/sst_anoms.out .

# Plot the Pressure anomalies (pre_anom_ts.ps)
R --no-save < plot_pre_anom_ts.R
epstopdf pre_anom_ts.ps
#convert -rotate 90 -geometry 800x600 pre_anom_ts.ps pre_anom_ts.png
R --no-save < make_pre_anom_bwplot.R
epstopdf pre_anom_bwplot.ps
#convert -rotate 90 -geometry 800x600 pre_anom_bwplot.ps pre_anom_bwplot.png
R --no-save < make_pre_anom_bwplot_byShip.R
epstopdf pre_anom_bwplot_byShip.ps
#convert -rotate 90 -geometry 800x600 pre_anom_bwplot_byShip.ps pre_anom_bwplot_byShip.png

# Extract the Wind Speed anomalies
make_WS_anomalies.perl ../../imma/*/*.imma > /data/cr2/hadpb/digitisation/EIC/analysis/ws_anoms.out
ln -sf /data/cr2/hadpb/digitisation/EIC/analysis/ws_anoms.out .

# Plot the Wind Speed anomalies
R --no-save < plot_ws_anom_ts.R
epstopdf ws_anom_ts.ps
#convert -rotate 90 -geometry 800x600 ws_anom_ts.ps ws_anom_ts.png
R --no-save < make_ws_anom_bwplot.R
epstopdf ws_anom_bwplot.ps
#convert -rotate 90 -geometry 800x600 ws_anom_bwplot.ps ws_anom_bwplot.png
R --no-save < make_ws_anom_bwplot_byShip.R
epstopdf ws_anom_bwplot_byShip.ps
#convert -rotate 90 -geometry 800x600 ws_anom_bwplot_byShip.ps ws_anom_bwplot_byShip.png

