# Make the wind figures for the EIC data

# Get the wind descriptors and make the frequency table
get_wind_descriptors_frequency.perl ../../imma/*/*.imma > wind_forces
make_descriptors_frequency_table.perl < wind_forces > force_frequencies

# Make the term frequency figure (term_frequencies.ps)
R --no-save < plot_wind_term_frequencies.R
epstopdf term_frequencies.ps

# Get the climatological wind speeds associated with each term
wind_climate_by_descriptor.perl ../../imma/*/*.imma > climate_v_descriptor

# Make the BW scatter plot of descriptors v. climatology
R --no-save < climate_v_descriptor_bwplot.R
epstopdf climate_v_descriptor.ps

