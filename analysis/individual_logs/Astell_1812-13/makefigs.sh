# Make the summary figure for the Astell in 1812-13

# Get the positions and anomalies fro the trip
../../../../scripts/obs_v_normals.perl < ../../../imma/p/Astell.1812-02-03.1813-05-13.imma > ovn.all
grep '^1812/0' ovn.all > ovn.out
grep -v '^1812/0' ovn.all > ovn.back

# Make the figure (Astell.ps)
R --no-save < Astell_figure.R
epstopdf Astell.ps

convert -rotate 90 -geometry 800x600 Astell.ps Astell.png
