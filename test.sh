#!/bin/bash

DF="+%Y-%m-%d %H:%M:%S %Z"
while true; do

  echo "$(date "$DF") Testing..."

  R=$(speedtest-cli --simple)
  PING=$(echo $R | sed -n -e 's/.*Ping: \([0-9\.]*\).*/\1/p')
  DOWN=$(echo $R | sed -n -e 's/.*Download: \([0-9\.]*\).*/\1/p')
  UP=$(echo $R | sed -n -e 's/.*Upload: \([0-9\.]*\).*/\1/p')

  echo -n "$(date "$DF") "
  echo $R | tr '\n' ' '

  echo "speedtest.ping:$PING|g" | nc -u -w0 $STATSD_HOST $STATSD_PORT
  echo "speedtest.down:$DOWN|g" | nc -u -w0 $STATSD_HOST $STATSD_PORT
  echo "speedtest.up:$UP|g" | nc -u -w0 $STATSD_HOST $STATSD_PORT

  sleep $FREQUENCY
done
