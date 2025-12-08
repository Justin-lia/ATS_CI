FROM ubuntu:20.04

ENV DEBIAN_FRONTEND=noninteractive
ENV TZ=UTC

RUN apt-get update && apt-get install -y \
    kmod \
    ntp \
    iptables \
    lighttpd \
    radvd \
    isc-dhcp-server \
    bind9 \
    bind9utils \
    bind9-doc \
    php-cgi \
    ppp \
    pppoe \
    pppoeconf \
    iproute2 \
    net-tools \
    iputils-ping \
    dnsutils \
    vim \
    curl \
    wget \
    tshark \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

