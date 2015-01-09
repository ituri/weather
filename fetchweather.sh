#!/bin/bash
# Receive remote weather data from USB-WDE1 and store it into database

# Loop forever to read data from USB-WDE1
socat /dev/ttyUSB0,b9600 STDOUT | \
while read line
echo "Waiting for data..."
do
    if [[ "${line%%;*}" == '$1' ]] ; then
        echo "Parsing data ..."
	# format data
        tmp=`echo "${line#?1;1;}" | tr ';,' ':.'`
        data=`echo "N${tmp%%0}" | sed 's/::/:U:/g' | sed 's/::/:U:/g'`
        data=${data%%:}
	echo $data
        # update rrd
        rrdtool update weather.rrd $data
    fi
done
