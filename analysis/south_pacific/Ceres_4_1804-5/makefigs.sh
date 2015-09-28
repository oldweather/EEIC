# Make the summary figure for the Ceres 4 in 1804-5

# Get the positions and anomalies from the trip
../../../../scripts/obs_v_normals.perl < ../../../imma/12/Ceres_4.1804-06-10.1805-09-09.imma > ovn.all
grep -P '^1804' ovn.all > ovn.out
grep -P -v '^1804' ovn.all > ovn.back

# Make the figure
R --no-save < Ceres_figure.R
epstopdf Ceres.ps

