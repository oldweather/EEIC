# Make the summary figure for the Arniston in 1804-5

# Get the positions and anomalies fro the trip
../../../../scripts/obs_v_normals.perl < ../../../imma/7/Arniston.1804-05-08.1805-09-10.imma > ovn.all
grep '^1804' ovn.all > ovn.out
grep -v '^1804' ovn.all > ovn.back

# Make the figure
R --no-save < Arniston_figure.R
epstopdf Arniston.ps

