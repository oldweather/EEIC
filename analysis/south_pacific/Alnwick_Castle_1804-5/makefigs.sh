# Make the summary figure for the Alnwick Castle in 1804-5

# Get the positions and anomalies from the trip
../../../../scripts/obs_v_normals.perl < ../../../imma/10/Alnwick_Castle.1804-05-17.1805-09-17.imma > ovn.all
grep -P '^1804' ovn.all > ovn.out
grep -P -v '^1804' ovn.all > ovn.back

# Make the figure
R --no-save < AC_figure.R
epstopdf AC.ps

