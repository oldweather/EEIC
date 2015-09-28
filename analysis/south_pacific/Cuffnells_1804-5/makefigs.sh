# Make the summary figure for the Ceres 4 in 1804-5

# Get the positions and anomalies from the trip
../../../../scripts/obs_v_normals.perl < ../../../imma/9/Cuffnells.1804-06-10.1805-09-08.imma > ovn.all
grep -P '^1804' ovn.all > ovn.out
grep -P -v '^1804' ovn.all > ovn.back

# Make the figure
R --no-save < Cuffnells_figure.R
epstopdf Cuffnells.ps

