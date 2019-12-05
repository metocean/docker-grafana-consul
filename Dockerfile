FROM grafana/grafana:6.5.1-ubuntu
MAINTAINER Andre Lobato <andre@metocean.co.nz>

USER root

RUN apt-get -y update && apt-get -y install \
    unzip \
    wget

ENV CONSUL_VERSION=1.4.0
RUN echo "-----------------Install Consul-----------------" &&\
    cd /tmp &&\
    mkdir /consul &&\
    wget -q https://releases.hashicorp.com/consul/${CONSUL_VERSION}/consul_${CONSUL_VERSION}_linux_amd64.zip &&\
    unzip consul_${CONSUL_VERSION}_linux_amd64.zip &&\
    mv consul /usr/bin &&\
    rm -r consul_${CONSUL_VERSION}_linux_amd64.zip 


ENV CONTAINERPILOT_VERSION 3.8.0
RUN echo "-----------------Install Container-Pilot-----------------" \
    && export CP_SHA1=84642c13683ddae6ccb63386e6160e8cb2439c26 \
    && cd /tmp \
    && wget -q "https://github.com/joyent/containerpilot/releases/download/${CONTAINERPILOT_VERSION}/containerpilot-${CONTAINERPILOT_VERSION}.tar.gz" \
    && echo "${CP_SHA1}  /tmp/containerpilot-${CONTAINERPILOT_VERSION}.tar.gz" | sha1sum -c \
    && tar zxf containerpilot-${CONTAINERPILOT_VERSION}.tar.gz -C /bin \
    && rm containerpilot-${CONTAINERPILOT_VERSION}.tar.gz

ENV CONTAINERPILOT='/etc/containerpilot.json'

ADD containerpilot.json /etc/containerpilot.json

ENTRYPOINT []

CMD ["/bin/containerpilot"]