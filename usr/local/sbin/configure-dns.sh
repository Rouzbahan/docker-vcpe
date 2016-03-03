#!/bin/bash
# This script is used to set up "safe" browsing for CORD subscribers.
# It adds and removes iptables rules to /etc/ufw/before.rules.  The rules
# match clients by MAC address and forward matching DNS traffic to the resolver 
# on port 5353.

# Usage here
# ./configure-dns.sh <mac> open|safe

MACADDR=$1
MODE=$2
BEFORE_RULES="/etc/ufw/before.rules"
BASE="--dport 53 -i eth1 -m mac --mac-source $MACADDR -j REDIRECT --to-port 5353"

function add_rule {
  RULE=$1
  grep -q -e "$RULE" $BEFORE_RULES && return
  sed -i 's/# DNS safe browsing/&\n'"$RULE"'/' $BEFORE_RULES
}

function remove_rules {
  RULE=$1
  sed -i '/'"$MACADDR"'/ d' $BEFORE_RULES
}

case "$MODE" in
  "open")
    # Remove rules for MAC address
    remove_rules $MACADDR
    ;;
  "safe")
    # Add rules for MAC address
    add_rule "-A PREROUTING -p udp $BASE"
    add_rule "-A PREROUTING -p tcp $BASE"
    ;;
  *)
esac

ufw reload
