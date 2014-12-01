FROM ubuntu
RUN sudo apt-get update
RUN sudo apt-get -y install python-pip
RUN pip install speedtest-cli
ADD test.sh /root/test.sh
ENV STATSD_HOST 192.168.59.103
ENV STATSD_PORT 8125
ENV FREQUENCY 300
CMD ["/root/test.sh"]
