# Docker Speedtest

Run a speedtest periodically and report the metrics to statsd.

## Usage
```
docker run --name speedtest -d -e STATSD_HOST=192.168.59.103 -e FREQUENCY=600 -e TZ=America/Denver kurtharriger/speedtest

```

### Stop/Start
```
docker stop speedtest
docker start speedtest
```
### View log
```
docker logs speedtest
```

### Remove container
docker rm speedtest

## Need a statsd server?
```
docker run -d  -p 80:80 -p 8125:8125/udp -p 8126:8126 --restart=always --name kamon-grafana-dashboard kamon/grafana_graphite
```

## TODO: 

* Perhaps preconfigure kamon-grafana-dashboard to display metrics.

## Related Projects
* https://github.com/sivel/speedtest-cli
* https://github.com/kamon-io/docker-grafana-graphite

### License

Creative Commons.

Copyright &copy; 2014 Kurt Harriger
