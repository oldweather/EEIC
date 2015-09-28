# Make the summary figure for the Buckinghamshire in 1823-4
#  This ship has two logs for much of its journey.

# Get the positions and anomalies fro the trip
../../../../scripts/obs_v_normals.perl < ../../../imma/9/Buckinghamshire.1823-07-27.1824-06-15.imma > ovn.all
grep '^1823' ovn.all > ovn.out
grep -v '^1823' ovn.all > ovn.back

# Make the figure (Buckinghamshire.pdf)
R --no-save < Buckinghamshire_figure.R
