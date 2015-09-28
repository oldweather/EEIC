# Make a histogram showing the number of ships per year
# and a list plot showing the years of operation of each ship

# Find the years of operation for each ship
list_ship_years.perl ../../imma/*/*.imma > ship_years.out

# Make the histogram (ship_count.ps)
R --no-save < ship_count_hist.R
epstopdf ship_count.ps

# Make the list plot (ship_years.ps)
R --no-save < plot_ship_list.R
epstopdf ship_years.ps

