# Make the summary figure for the Bridgewater in 1791-3
#  This ship has two logs for much of its journey.

# Get the positions and anomalies fro the trip
../../../../scripts/obs_v_normals.perl < ../../../imma/20/Bridgewater_3.1791-05-07.1793-04-21.imma > ovn.k.all
../../../../scripts/obs_v_normals.perl < ../../../imma/20/Bridgewater_3.1791-02-06.1792-09-16.imma > ovn.l.all
grep '^1791' ovn.k.all > ovn.k.out
grep -v '^1791' ovn.k.all > ovn.k.back
grep '^1791' ovn.l.all > ovn.l.out
grep -v '^1791' ovn.l.all > ovn.l.back

# Make the figure (Bridgewater_3.ps)
R --no-save < Bridgewater_figure.R
epstopdf Bridgewater_3.ps

convert -rotate 90 -geometry 800x600 Bridgewater_3.ps Bridgewater_3.png
