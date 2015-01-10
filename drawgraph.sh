#!/bin/sh
# Drawgraph.sh - Philipp (2014)
cd /home/pi/wetter

# Generate graphs for temperatures
# temperatures of the last hour
rrdtool graph 't-1h.png' \
	--width '400' \
	--height '108' \
	--start end-1h \
	'DEF:Wohnzimmer=weather.rrd:temps1:AVERAGE' \
	'LINE1:Wohnzimmer#CC0000:Straßenseite'

# temperatures of the last 4 hours
rrdtool graph 't-4h.png' \
	--width '400' \
	--height '108' \
	--start end-4h \
	'DEF:Wohnzimmer=weather.rrd:temps1:AVERAGE' \
	'LINE1:Wohnzimmer#CC0000:Straßenseite'

# temperatures of the last day
rrdtool graph 't-1d.png' \
	--width '400' \
	--height '108' \
	--start end-1d \
	'DEF:Wohnzimmer=weather.rrd:temps1:AVERAGE' \
	'LINE1:Wohnzimmer#CC0000:Straßenseite'

# temperatures of the last week
rrdtool graph 't-1w.png' \
	--width '400' \
	--height '108' \
	--start end-7d \
	'DEF:Wohnzimmer=weather.rrd:temps1:AVERAGE' \
	'LINE1:Wohnzimmer#CC0000:Straßenseite'

# temperatures of the last month
rrdtool graph 't-1m.png' \
	--width '400' \
	--height '108' \
	--start end-1m \
	'DEF:Wohnzimmer=weather.rrd:temps1:AVERAGE' \
	'LINE1:Wohnzimmer#CC0000:Straßenseite'

# Generate graphs for humidity
# hourly humidity
rrdtool graph 'h-1h.png' \
	--width '400' \
	--height '108' \
	--start end-1h \
	'DEF:Wohnzimmer=weather.rrd:hums1:AVERAGE' \
	'LINE1:Wohnzimmer#33CCFF:Straßenseite'

# humidity of the last 4 hours
rrdtool graph 'h-4h.png' \
	--width '400' \
	--height '108' \
	--start end-4h \
	'DEF:Wohnzimmer=weather.rrd:hums1:AVERAGE' \
	'LINE1:Wohnzimmer#33CCFF:Straßenseite'

# humidity of the last day
rrdtool graph 'h-1d.png' \
	--width '400' \
	--height '108' \
	--start end-1d \
	'DEF:Wohnzimmer=weather.rrd:hums1:AVERAGE' \
	'LINE1:Wohnzimmer#33CCFF:Straßenseite'

# humidity of the last week
rrdtool graph 'h-1w.png' \
	--width '400' \
	--height '108' \
	--start end-7d \
	'DEF:Wohnzimmer=weather.rrd:hums1:AVERAGE' \
	'LINE1:Wohnzimmer#33CCFF:Straßenseite'

# humidity of the last month
rrdtool graph 'h-1m.png' \
	--width '400' \
	--height '108' \
	--start end-1m \
	'DEF:Wohnzimmer=weather.rrd:hums1:AVERAGE' \
	'LINE1:Wohnzimmer#33CCFF:Straßenseite'

# Generate the html-file for the current temperature
#rrdtool lastupdate weather.rrd | tail -1 | sed 's/^.\{,12\}//' | sed 's/\ U//g' | sed 's/ /,/' |  sed 's/^/Aktuelle Temperatur: /' | sed 's/,/°C\ <\/br>Aktuelle\ Luftfeuchtigkeit\ /' | sed 's/$/%/' > aktuell.html
rrdtool lastupdate weather.rrd | tail -1 | sed 's/^.\{,12\}//' | sed 's/\ U//g' | awk '{print $1}' | sed 's/$/°C/' > temp.html
rrdtool lastupdate weather.rrd | tail -1 | sed 's/^.\{,12\}//' | sed 's/\ U//g' | sed 's/^.*\ //' | sed 's/$/%/' > humid.html


# Transfer the graphs to my webserver and clean up aterwards 
scp *png phil@95.143.172.12:~/html/wetter/
scp *html phil@95.143.172.12:~/html/wetter
rm *.png
rm *.html
