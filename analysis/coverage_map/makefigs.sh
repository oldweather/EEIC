# Make a gcoverage map (No. of obs)

# Make a PP field of No. of obs
make_nobs_field.perl ../../imma/*/*.imma > nobs.pp

# Plot a map of the PP field (coverage.ps)
R --no-save < plot_coverage_map.R
epstopdf coverage.ps

convert -geometry 800x600 -rotate 90 coverage.ps coverage.png
