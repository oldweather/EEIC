# Make the sympiesometer figures

# Get the sympiesometer aniomalies
make_SYM_anomalies.perl ../../imma/*/*.imma > sym_anoms.out

# Anomaly map
make_anomaly_fields.perl ../../imma/*/*.imma > anoms.pp
R --no-save < plot_anomaly_maps.R
epstopdf pre_anomaly_map.ps

# Time-series and by-ship figures
R --no-save < plot_symp_anom_ts.R
epstopdf sym_anom_ts.ps
R --no-save < make_sym_anom_bwplot_byShip.R
epstopdf sym_anom_bwplot_byShip.ps

# Sympiesometer v. barometer
get_SYM_v_PRE.perl ../../imma/*/*.imma > sym_v_pre.out
R --no-save < plot_sym_v_pre.R
epstopdf sym_v_pre.ps

# Make individual ship series
../../../scripts//obs_v_normals.perl < ../../imma/1-4/George_the_Fourth.1832-02-11.1833-03-09.imma > George_the_Fourth.1832-02-11.1833-03-09.ovn
../../../scripts//obs_v_normals.perl < ../../imma/6/Duke_of_Buccleugh_2.1831-06-13.1832-05-06.imma > Duke_of_Buccleugh_2.1831-06-13.1832-05-06.ovn
../../../scripts//obs_v_normals.perl < ../../imma/6/Minerva_7.1827-05-14.1828-05-05.imma > Minerva_7.1827-05-14.1828-05-05.ovn
../../../scripts//obs_v_normals.perl < ../../imma/6/Minerva_7.1829-05-11.1830-05-04.imma > Minerva_7.1829-05-11.1830-05-04.ovn
../../../scripts//obs_v_normals.perl < ../../imma/10/Duchess_of_Athol.1826-02-24.1826-08-09.imma > Duchess_of_Athol.1826-02-24.1826-08-09.ovn
../../../scripts//obs_v_normals.perl < ../../imma/10/Duchess_of_Athol.1828-02-23.1829-03-19.imma > Duchess_of_Athol.1828-02-23.1829-03-19.ovn
../../../scripts//obs_v_normals.perl < ../../imma/10/Duchess_of_Athol.1830-01-06.1831-03-15.imma > Duchess_of_Athol.1830-01-06.1831-03-15.ovn
../../../scripts//obs_v_normals.perl < ../../imma/10/Duchess_of_Athol.1832-01-26.1833-05-04.imma > Duchess_of_Athol.1832-01-26.1833-05-04.ovn
../../../scripts//obs_v_normals.perl < ../../imma/12/Dunira.1830-01-05.1831-03-19.imma > Dunira.1830-01-05.1831-03-19.ovn
../../../scripts//obs_v_normals.perl < ../../imma/12/Dunira.1832-02-11.1833-04-13.imma > Dunira.1832-02-11.1833-04-13.ovn
../../../scripts//obs_v_normals.perl < ../../imma/14/Prince_Regent.1833-04-15.1834-05-17.imma > Prince_Regent.1833-04-15.1834-05-17.ovn
../../../scripts//obs_v_normals.perl < ../../imma/8/Royal_George_5.1822-12-11.1824-04-02.imma > Royal_George_5.1822-12-11.1824-04-02.ovn

# Plot the collective sympsieometer series
R --no-save < ts_v_norms.R
epstopdf sym_v_normal_ts.ps
