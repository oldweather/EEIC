# Make the summary figure for the Marquis of Wellington 1
#  Two outward voyages - examples of longitude problems.

# Get the positions and anomalies fro the trip
../../../../scripts/obs_v_normals.perl < ../../../imma/22/Marquis_of_Wellington_1.1819-05-24.1820-05-29.imma > ovn.k.all
../../../../scripts/obs_v_normals.perl < ../../../imma/22/Marquis_of_Wellington_1.1813-01-30.1814-08-06.imma > ovn.l.all
grep '^1819/0' ovn.k.all > ovn.k.out
grep -v '^1819/0' ovn.k.all > ovn.k.back
grep '^1813' ovn.l.all > ovn.l.out
grep -v '^1813' ovn.l.all > ovn.l.back

# Make the figure (MW_1.ps)
R --no-save < MW_figure.R
epstopdf MW_1.ps

convert -rotate 90 -geometry 800x600 MW_1.ps MW_1.png
