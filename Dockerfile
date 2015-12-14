FROM       phusion/baseimage:0.9.16
MAINTAINER Andy Bavier <acb@cs.princeton.edu>

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y ufw dnsmasq tcpdump

### Dnsmasq setup
RUN mkdir /etc/service/dnsmasq
ADD etc/service/dnsmasq/run /etc/service/dnsmasq/
RUN mkdir /etc/service/dnsmasq-safe
ADD etc/service/dnsmasq-safe/run /etc/service/dnsmasq-safe/

### Firewall and NAT setup
ADD etc/ufw/before.rules /etc/ufw/
ADD etc/rc.local /etc/rc.local
RUN chmod +x /etc/rc.local
