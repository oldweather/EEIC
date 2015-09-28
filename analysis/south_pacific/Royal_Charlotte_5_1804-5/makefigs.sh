# Make the summary figure for the Royal Charlotte in 1804-5

# Get the positions and anomalies from the trip
../../../../scripts/obs_v_normals.perl < ../../../imma/7/Royal_Charlotte_5.1804-06-10.1805-09-15.imma > ovn.all
grep -P '^1804' ovn.all > ovn.out
grep -P -v '^1804' ovn.all > ovn.back

# Make the figure
R --no-save < RC_figure.R
epstopdf RC.ps

