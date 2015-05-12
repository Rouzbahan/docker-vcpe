FROM       phusion/baseimage:0.9.16
MAINTAINER Andy Bavier <acb@cs.princeton.edu>

RUN apt-get update
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y ufw dnsmasq

### Dnsmasq setup
ADD vcpe.conf /etc/dnsmasq.d/
ADD resolv.conf /var/run/dnsmasq/

### Firewall and NAT setup
ADD before.rules /etc/ufw/
ADD rc.local /etc/rc.local
RUN chmod +x /etc/rc.local



