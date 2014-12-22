#!/bin/bash

DF="+%Y-%m-%d %H:%M:%S %Z"
while true; do

  echo "$(date "$DF") Testing..."

  R=$(speedtest-cli --simple 2>>/var/log/speedtest.err | tee -a /var/log/speedtest.out)
  if [ $? -eq 0 ]; then
    PING=$(echo $R | sed -n -e 's/.*Ping: \([0-9\.]*\).*/\1/p')
    DOWN=$(echo $R | sed -n -e 's/.*Download: \([0-9\.]*\).*/\1/p')
    UP=$(echo $R | sed -n -e 's/.*Upload: \([0-9\.]*\).*/\1/p')

    echo -n "$(date "$DF") "
    echo -n $R | tr '\n' ' '
    echo ""

    echo "speedtest.ping:$PING|g" > /dev/udp/$STATSD_HOST/$STATSD_PORT
    echo "speedtest.down:$DOWN|g" > /dev/udp/$STATSD_HOST/$STATSD_PORT
    echo "speedtest.up:$UP|g" > /dev/udp/$STATSD_HOST/$STATSD_PORT
  else 
    echo "$(date "$DF") Timeout occured"

    echo "speedtest.timeout:1|c" > /dev/udp/$STATSD_HOST/$STATSD_PORT
    echo "speedtest.down:0|g" > /dev/udp/$STATSD_HOST/$STATSD_PORT
    echo "speedtest.up:0|g" > /dev/udp/$STATSD_HOST/$STATSD_PORT
  fi

  echo "speedtest.completed:1|c" > /dev/udp/$STATSD_HOST/$STATSD_PORT
  echo "$(date "$DF") Pausing for $FREQUENCY seconds."
  sleep $FREQUENCY
done
