# Make the summary figure for the Georgiana 1 in 1803-7

# Get the positions and anomalies fro the trip
../../../../scripts/obs_v_normals.perl < ../../../imma/7/Georgiana_1.1803-08-20.1807-01-14.imma > ovn.out

# Make the figure (Thomas_Grenville.ps)
R --no-save < Georgiana_figure.R
epstopdf Georgiana.ps

convert -rotate 90 -geometry 800x600 Georgiana.ps Georgiana.png
