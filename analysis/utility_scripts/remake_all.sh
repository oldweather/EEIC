# Regenerate all the figures from the IMMA records
echo 'Making anomaly maps'
cd ../anomaly_map
./makefigs.sh

echo 'Making anonamy time-series'
cd ../anomaly_ts
./makefigs.sh

echo 'Making coverage map'
cd ../coverage_map
./makefigs.sh

echo 'Making individual plots'
cd ../individual_logs
./makefigs.sh

echo 'Making observations count plots'
cd ../obs_count
./makefigs.sh

echo 'Making ship list plot'
cd ../ships_list
./makefigs.sh

echo 'Making wind plots'
cd ../winds
./makefigs.sh

echo 'Making sympiesometer plots'
cd ../sympiesometer
./makefigs.sh
