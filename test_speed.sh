#!/bin/bash

./speedtest.exe > results.txt

date=$(date +%Y-%m-%dT%H:%M:%S)
dl_speed=$(cat results.txt | awk '{}/Download:/{print $3}{}')
ul_speed=$(cat results.txt | awk '{}/Upload:/{print $3}{}')
ping=$(cat results.txt | awk '{}/Latency:/{print $2}{}')
packet_loss=$(cat results.txt | awk '{}/Packet/{print $3}{}')
server=$(cat results.txt | awk '{}/Server/{for(i=2;i<=NF;++i)print $i}{}')
isp=$(cat results.txt | awk '{}/ISP/{print $2}{}')

echo -e $date$'\t'$dl_speed$'\t'$ul_speed$'\t'$ping$'\t'$packet_loss$'\t'$server >> log.tsv
echo -e $date$'\t'$dl_speed$'\t'$ul_speed$'\t'$ping$'\t'$packet_loss$'\t'$server
# Rscript analyze.R

pushd ..
scp -r ./speedtest alecsalc@alecsalces.com:/home2/alecsalc/public_html/
