# Make the comparison figures with transcription rate

# Get the positions and anomalies fro the trip
../../../../scripts/obs_v_normals.perl < ../../../imma/15/Farlie.1809-02-22.1811-03-01.imma > ovn.all
grep '^180' ovn.all > ovn.out
grep -v '^180' ovn.all > ovn.back

# Make the ship figure (Farlie.pdf)
R --no-save < Farlie_figure.R

# Make the transcription figure (Transcription.pdf)
R --no-save < Transcription_figure.R
