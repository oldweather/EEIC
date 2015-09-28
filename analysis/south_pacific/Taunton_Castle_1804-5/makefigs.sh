# Make the summary figure for the Taunton Castle in 1804-5

# Get the positions and anomalies fro the trip
../../../../scripts/obs_v_normals.perl < ../../../imma/5/Taunton_Castle.1804-05-14.1805-09-12.imma > ovn.all
grep -P '^1804|^1805/01' ovn.all > ovn.out
grep -P -v '^1804|^1805/01' ovn.all > ovn.back

# Make the figure
R --no-save < TC_figure.R
epstopdf TC.ps

