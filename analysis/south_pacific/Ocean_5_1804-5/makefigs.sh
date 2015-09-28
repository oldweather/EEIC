# Make the summary figure for the Ocean 5 in 1804-5

# Get the positions and anomalies from the trip
../../../../scripts/obs_v_normals.perl < ../../../imma/13/Ocean_5.1804-08-26.1805-09-09.imma > ovn.all
grep -P '^1804' ovn.all > ovn.out
grep -P -v '^1804' ovn.all > ovn.back

# Make the figure
R --no-save < Ocean_figure.R
epstopdf Ocean.ps

