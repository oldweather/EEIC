# Make the summary figure for the Walpole 4 in 1794-5

# Get the positions and anomalies from the trip
../../../../scripts/obs_v_normals.perl < ../../../imma/16/Walpole_4.1794-05-13.1795-12-09.imma > ovn.all
grep -P '^1794' ovn.all > ovn.out
grep -P -v '^1794' ovn.all > ovn.back

# Make the figure
R --no-save < Walpole_figure.R
epstopdf Walpole.ps

