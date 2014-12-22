FROM ubuntu
RUN apt-get update
RUN apt-get -y install python
ADD https://raw.githubusercontent.com/kurtharriger/speedtest-cli/master/speedtest_cli.py /usr/local/bin/speedtest-cli
RUN chmod +x /usr/local/bin/speedtest-cli
ADD test.sh /usr/local/bin/test.sh
ENV STATSD_HOST 192.168.59.103
ENV STATSD_PORT 8125
ENV FREQUENCY 300
CMD ["test.sh"]
