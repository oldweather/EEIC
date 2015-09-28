# Make figures showing the monthly variation and seasonal
#  cycle in number of observations.

# Extract the ob counts
list_ob_months.perl ../../imma/*/*.imma > ob_count.out
list_ob_years.perl ../../imma/*/*.imma > annual_ob_count.out

# Plot the monthly counts (ob_months.ps)
R --no-save < plot_ob_months.R
epstopdf ob_months.ps

# Make the seasonal cycle counts
make_seasonal_cycle.perl < ob_count.out > ob_count_seasonal.out

# Plot the seasonal counts (ob_seasonal.ps)
R --no-save < plot_ob_seasonal.R
epstopdf ob_seasonal.ps

# Plot the annual counts
R --no-save < plot_ob_years.R
epstopdf ob_years.ps
