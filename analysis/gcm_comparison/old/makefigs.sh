# Make the HadCM3 pseudo-obs equivalents of the time-series plots

# Extract the pseudo obs
get_GCM_obs_equivalents_at.perl ../../imma/*/*.imma > HadCM3_pseudo_obs_at
get_GCM_obs_equivalents_slp.perl ../../imma/*/*.imma > HadCM3_pseudo_obs_slp

# Make the box and whisker plots
R --no-save < make_at_pseudo_bwplot.R
epstopdf at_pseudo_bwplot.ps
R --no-save < make_pre_pseudo_bwplot.R
epstopdf pre_pseudo_bwplot.ps
