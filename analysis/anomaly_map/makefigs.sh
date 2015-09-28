# Plot maps of AT, SST and pressure anomaly

# Make PP fields of the anomalies from the IMMA records.
make_anomaly_fields.perl ../../imma/*/*.imma > anoms.pp
make_anomaly_fields_monthly.perl ../../imma/*/*.imma

# Plot maps of the PP fields
R --no-save < plot_anomaly_maps.R
epstopdf at_anomaly.ps
convert -rotate 90 -geometry 800x600 at_anomaly.ps at_anomaly.png
epstopdf sst_anomaly.ps
convert -rotate 90 -geometry 800x600 sst_anomaly.ps sst_anomaly.png
epstopdf pre_anomaly.ps
convert -rotate 90 -geometry 800x600 pre_anomaly.ps pre_anomaly.png
epstopdf ws_anomaly.ps
convert -rotate 90 -geometry 800x600 ws_anomaly.ps ws_anomaly.png
