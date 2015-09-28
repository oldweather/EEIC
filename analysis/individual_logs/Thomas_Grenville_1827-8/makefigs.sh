# Make the summary figure for the Thomas Grenville in 1827-8

# Get the positions and anomalies fro the trip
../../../../scripts/obs_v_normals.perl < ../../../imma/5/Thomas_Grenville.1827-06-24.1828-08-12.imma > ovn.out
grep '^1827' ovn.out > tg.ovn.out
grep '^1828' ovn.out > tg.ovn.back

# Make the figure (Thomas_Grenville.ps)
R --no-save < Thomas_Grenville_figure.R
epstopdf Thomas_Grenville.ps

convert -rotate 90 -geometry 800x600 Thomas_Grenville.ps Thomas_Grenville.png
