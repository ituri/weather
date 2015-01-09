rrdtool graph tempweek.png \
  -s 'now - 1 day' -e 'now' \
  DEF:temps1=weather.rrd:temps1:AVERAGE \
  LINE2:temps1#000000:Fenster
